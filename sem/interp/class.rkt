#lang plai

;; EXP = <num> | {+ <EXP> <EXP>} | {- <EXP> <EXP>} | <id> | 
;;       {if <EXP> <EXP> <EXP>} | {while <EXP> <EXP>...} |
;;       {set <EXP> <EXP>} | {print <EXP>} | {do <EXP>...} | {skip} |
;;       {with {<id> <EXP>} <EXP>...} | {throw <tag> <EXP>} |
;;       {catch <tag> <EXP>} | {ret <EXP>} | {<id> <EXP> ...}
;;       {new <id>}

(define-type EXP
  [num (n number?)]
  [add (left EXP?)
       (right EXP?)]
  [sub (left EXP?)
       (right EXP?)]
  [id (name symbol?)]
  [cif (cond EXP?)
       (true EXP?)
       (false EXP?)]
  [with (var symbol?)
        (exp EXP?)
        (body EXP?)]
  [whl (cond EXP?)
       (body EXP?)]
  [st (lval symbol?)
      (rval EXP?)]
  [prt (exp EXP?)]
  [seq (exp1 EXP?)
       (exp2 EXP?)]
  [skip]
  [thr (tag symbol?)
       (val EXP?)]
  [cth (tag symbol?)
       (exp EXP?)]
  [ret (val EXP?)]
  [snd (rec EXP?)
        (sel symbol?)
        (args list?)]
  [fget (field number?)]
  [fset (field number?)
        (val EXP?)]
  [make (name symbol?)])

;; parse: s-expr -> EXP
;; (parse '{+ 3 4}) -> (add (num 3) (num 4))

(define (parse input)
  (cond
    [(number? input) (num input)]
    [(symbol? input) (id input)]
    [(eq? (first input) '+)
     (foldl (lambda (exp exps) (add exps exp))
            (parse (first (rest input))) 
            (map parse (rest (rest input))))]
    [(eq? (first input) '-)
     (foldl (lambda (exp exps) (sub exps exp))
            (parse (first (rest input))) 
            (map parse (rest (rest input))))]
    [(eq? (first input) 'if)
     (cif (parse (second input))
          (parse (third input))
          (parse (fourth input)))]
    [(eq? (first input) 'while)
     (whl (parse (second input))
          (parse `(do ,@(rest (rest input)))))]
    [(eq? (first input) 'catch)
     (cth (second input)
          (parse (third input)))]
    [(eq? (first input) 'set)
     (st (second input) (parse (third input)))]
    [(eq? (first input) 'print)
     (prt (parse (second input)))]
    [(eq? (first input) 'skip)
     (skip)]
    [(eq? (first input) 'with)
     (with (first (second input))
           (parse (second (second input)))
           (parse `{do ,@(rest (rest input))}))]
    [(eq? (first input) 'ret)
     (ret (parse (second input)))]
    [(eq? (first input) 'throw)
     (thr (second input) (parse (third input)))]
    [(eq? (first input) 'do)
     (foldl (lambda (cmd cmds) (seq cmds cmd))
            (skip) (map parse (rest input)))]
    [(eq? (first input) 'fget)
     (fget (second input))]
    [(eq? (first input) 'fset)
     (fset (second input)
           (parse (third input)))]
    [(eq? (first input) 'new)
     (make (second input))]
    [(symbol? (first input))
     (snd (parse (second input))
           (first input)
           (map parse (rest (rest input))))]))

  
(define-type Value
  [voidV]
  [numV (n number?)]
  [objV (fields number?)
        (class Class?)])

(define-type Class
  [klass (fields number?)
         (vtable hash?)])

(define (make-class nf methods)
  (local [(define ht (make-hash))]
    (begin
      (map (lambda (method) 
             (hash-set! ht (first method) (list (second method)
                                                (parse (third method)))))
           methods)
      (klass nf ht))))

(define-type RetValue
  [retV  (tag symbol?)
         (val Value?)])

(define-type Env
  [env-empty]
  [env-entry (name symbol?)
             (loc number?)
             (next Env?)])

(define-type Mem
  [mem-empty]
  [mem-entry (loc number?)
             (val number?)
             (next Mem?)])

;; lookup-env : ID Env -> Loc
(define (lookup-env name env)
  (type-case Env env
    [env-empty () 0]
    [env-entry (id val next) (if (symbol=? id name)
                                 val
                                 (lookup-env name next))])) 

;; lookup-mem : Loc Mem -> Value
(define (lookup-mem loc mem)
  (type-case Mem mem
    [mem-empty () 0]
    [mem-entry (l val next) (if (= loc l)
                                val
                                (lookup-mem loc next))])) 

;; mget : loc -> (Mem -> Value Mem)
(define (mget loc)
  (lambda (mem)
    (list (vector-ref mem loc) mem)))
    ;;    (list (lookup-mem loc mem) mem)))

;; mset : loc num -> (Mem -> void Mem)
(define (mset loc val)
  (lambda (mem)
    (vector-set! mem loc val)
    (list (voidV) mem)))
    ;;    (list (void) (mem-entry loc val mem))))

;; unit : Value -> (Mem -> Value Mem)
(define (unit val)
  (lambda (mem)
    (list val mem)))

;; return : Value -> (Mem -> RetVal Mem)
(define (return val)
  (throw 'retval val))

;; throw : symbol Value -> (Mem -> RetVal Mem)
(define (throw tag val)
  (lambda (mem)
    (list (retV tag val) mem)))

;; bind : (Mem -> ? Mem) (? -> (Mem -> ? Mem)) -> (Mem -> ? Mem)
(define (bind op1 op2)
  (lambda (mem)
    (local [(define val/mem (op1 mem))
            (define val (first val/mem))]
      (if (RetValue? val)
          val/mem
          ((op2 val) (second val/mem))))))

;; catch : (Mem -> RetValue Mem) -> (Mem -> Value Mem)
(define (catch tag op)
  (lambda (mem)
    (local [(define val/mem (op mem))
            (define val (first val/mem))]
      (if (and (RetValue? val) (eq? (retV-tag val) tag))
          (list (retV-val val) (second val/mem))
          (list val (second val/mem))))))
    
(define-syntax mdo
  (syntax-rules (<-)
    [(mdo op) op]
    [(mdo (var <- op) ops ...) (bind op
                                     (lambda (var)
                                       (mdo ops ...)))]
    [(mdo op ops ...) (bind op
                            (lambda (dummy)
                              (mdo ops ...)))]))

;; alloc : Mem -> loc Mem 
;; free = *0;
;; *0 = free + 1;
;; return free;
(define alloc
  (mdo (free <- (mget 0))
       (mset 0 (numV (+ (numV-n free) 1)))
       (unit (numV-n free))))

(define (allocn x)
  (mdo (free <- (mget 0))
       (mset 0 (numV (+ (numV-n free) x)))
       (unit (numV-n free))))

;; pop : Mem -> void Mem
(define pop
  (mdo (free <- (mget 0))
       (mset 0 (numV (- (numV-n free) 1)))))

(define (zip l1 l2)
  (if (null? l1)
      '()
      (cons (list (first l1) (first l2))
            (zip (rest l1) (rest l2)))))

;; interp: EXP FunDefs Env Classes -> (Mem -> num Mem)
(define (interp exp env cls)
  (type-case EXP exp
    [num (n) (unit (numV n))]
    [id (name) (mget (lookup-env name env))]
    [add (left right)
         (mdo (val1 <- (interp left env cls))
              (val2 <- (interp right env cls))
              (unit (numV (+ (numV-n val1) (numV-n val2)))))]
    [sub (left right)
         (mdo (val1 <- (interp left env cls))
              (val2 <- (interp right env cls))
              (unit (numV (- (numV-n val1) (numV-n val2)))))]
    [skip () (unit (voidV))]
    [st (lval rval)
        (mdo (val <- (interp rval env cls))
             (mset (lookup-env lval env) val))]
    [fget (field)
          (mdo (obj <- (mget (lookup-env 'self env)))
               (mget (+ (objV-fields obj) field)))]
    [fset (field rval)
          (mdo (obj <- (mget (lookup-env 'self env)))
               (val <- (interp rval env cls))
               (mset (+ (objV-fields obj) field) val))]
    [make (name)
         (let [(clsv (hash-ref cls name))]
           (mdo (base <- (allocn (klass-fields clsv)))
                (unit (objV base clsv))))]     
    [cif (cond true false)
         (mdo (cval <- (interp cond env cls))
              (if (= 0 (numV-n cval))
                  (interp false env cls)
                  (interp true env cls)))]
    [whl (cond body)
         (local [(define dowhile (mdo (cval <- (interp cond env cls))
                                      (if (= 0 (numV-n cval))
                                          (unit (voidV))
                                          (mdo (interp body env cls)
                                               dowhile))))]
           dowhile)]
    [prt (exp)
         (mdo (val <- (interp exp env cls))
              (begin
                (print val)
                (newline)
                (unit (voidV))))]
    [ret (exp)
         (mdo (vret <- (interp exp env cls))
              (return vret))]
    [thr (tag exp)
         (mdo (vret <- (interp exp env cls))
              (throw tag vret))]
    [cth (tag exp)
         (mdo (vret <- (catch tag (interp exp env cls)))
              (unit vret))]
    [seq (exp1 exp2)
         (mdo (interp exp1 env cls)
              (interp exp2 env cls))]
    [with (var exp body)
          (mdo (val <- (interp exp env cls))
               (pval <- alloc)
               (mset pval val)
               (interp body (env-entry var pval env) cls))]
    [snd (rec sel args)
          (mdo (pself <- alloc)
               (self <- (interp rec env cls))
               (mset pself self)
               (base <- (allocn (length args)))
               (vret <- (catch 'retval (let [(method (find-method self sel (length args)))]
                                         (second (foldr (lambda (arg loc/comp)
                                                          (list (- (first loc/comp) 1)
                                                                (mdo (varg <- (interp arg env cls))
                                                                     (mset (first loc/comp) varg)
                                                                     (second loc/comp))))
                                                        (list (+ base (- (length args) 1))  ; endereço do último argumento
                                                              (interp (second method) (make-env (env-entry 'self pself (env-empty)) 
                                                                                                (first method) base) cls))
                                                        args)))))
               (unit vret))]))

(define (find-method self sel arity)
  (hash-ref (klass-vtable (objV-class self)) sel
            (lambda () (hash-ref (klass-vtable (objV-class self)) 
                                 (string->symbol (string-append "dnu" (number->string arity)))))))

(define (make-env init-env vars base)
  (if (null? vars)
      init-env
      (env-entry (first vars)
                 base
                 (make-env init-env (rest vars) (+ base 1)))))

(define (init-env vars count env)
  (if (null? vars)
      (list env count)
      (init-env (rest vars) 
                (+ count 1)
                (env-entry (first vars)
                           count
                           env))))
                

(define (eval cmd vars cls)
  (local [(define env/count (init-env vars 1 (env-empty)))
          (define env (first env/count))
          (define free (numV (second env/count)))
          (define hcls (make-hash))]
    (begin (map (lambda (classdef) 
                  (hash-set! hcls (first classdef) (second classdef)))
                cls)
           (first ((mdo (mset 0 free)
                        (interp (parse cmd) env hcls)) ;;(mem-empty)))))
                   (make-vector 5000 (numV 0)))))))

(eval '{do {set x 3}
         {set y 2}
         {while x
                {set y {+ y y}}
                {if {- x 1}
                    {skip}
                    {print 42}}
                {set x {- x 1}}}
         {print {ret 5}}
         {print y}} '(x y) '())

#|
(eval '{with {x 3}
           {with {y 2}
             {{while x
                {{set y {+ y y}}
                 {if {- x 1}
                     {skip}
                     {print 42}}
                 {set x {- x 1}}}}
              {print y}}}} '())

(eval '{{set x 3}
          {set y 2}
          {while x
            {with {y 5}
              {{set y {+ y y}}
               {set z {ref y}}
               {print y}
               {if {- x 1}
                   {skip}
                   {print 42}}
               {set x {- x 1}}}}}
          {with {a 2} {skip}}
          {print y}
          {print {deref z}}} '(x y z))

(eval '{{set x 3}
          {set y {ref x}}
          {while {deref y}
            {{if {- x 1}
                 {skip}
                 {print 42}}
             {set {deref y} {- x 1}}}}
          {print {deref y}}
          {print {deref {- y 1}}}} '(x y))

(eval '{{set x 10}
          {set y 0}
          {while {- 10 y}
                 {{set {deref {+ x y}} {+ y y}}
                  {set y {+ y 1}}}}
          {while y
                 {{print {deref {+ x {- y 1}}}}
                  {set y {- y 1}}}}} '(x y))

(eval '{with {dec {fun {x}
                         {ret {- x 1}}}}
               {{set x 3}
                {set y {ref x}}
                {while {deref y}
                       {{if {dec x}
                            {skip}
                            {print 42}}
                        {set {deref y} {- x 1}}}}
                {print {deref y}}
                {print {deref {- y 1}}}}} '(x y))

|#

  #|
(eval '{with {dec {fun {x} {if x
                               {do {set {deref x} 
                                        {- {deref x} 1}}
                                 {ret {deref x}}}
                               {throw err -1}}}} 
               {set x 3}
               {set y {ref x}}
               {while {deref y}
                      {if {- x 1}
                          {skip}
                          {print 42}}
                      {print {dec y}}}
               {print {catch err {print {dec 0}}}}
               {print {deref y}}
               {print {deref {- y 1}}}} '(x y))

|#
#|
(eval '{with {inc 0}
               {with {dec 0}
                     {{with {c 0}
                            {{set inc {fun {dummy}
                                           {{set c {+ c 1}}
                                            {ret c}}}}
                             {set dec {fun {dummy}
                                           {{set c {- c 1}}
                                            {ret c}}}}
                             {print c}}}
                      {inc 0}
                      {inc 0}
                      {inc 0}
                      {print {dec 20}}}}} '())

(print "vtable") (newline)

|#

(define Counter (make-class 1
                            '((init () {fset 0 0})
                              (inc (x) {do 
                                           {fset 0 {+ {fget 0} x}}
                                         {ret {fget 0}}})
                              (dec (x) {inc self {- 0 x}})
                              (dnu1 (x) {print x}))))

(define Nil (make-class 0
                        '((first () {throw nil 0})
                          (rest () {throw nil 0})
                          (null () {ret 1})
                          (for (f) {skip}))))

(define Cons (make-class 2 
                         '((init (x y) {do 
                                         {fset 0 x}
                                         {fset 1 y}
                                         {ret self}})
                           (first () {ret {fget 0}})
                           (rest () {ret {fget 1}})
                           (null () {ret 0})
                           (for (f) {do
                                      {call f {fget 0}}
                                      {for {fget 1} f}}))))

(define Plus (make-class 1
                         '((init (n) {do 
                                       {fset 0 n}
                                       {ret self}})
                           (call (x) {print {+ {fget 0} x}}))))
  
(define Range (make-class 2
                          '((init (x y z) {do
                                            {fset 0 x}
                                            {fset 1 y}
                                            {fset 2 z}
                                            {ret self}})
                            (first () {ret {fget 0}})
                            (rest () {if {- {fget 1} {fget 0}}
                                         {ret {init {new Range}
                                                    {+ {fget 0} {fget 2}}
                                                    {fget 1}
                                                    {fget 2}}}
                                         {throw nil 0}})
                            (null () {if {- {fget 1} {fget 0}} {ret 1} {ret 0}})
                            (for (f) {with {x {fget 0}}
                                           {call f x}
                                           {while {- {fget 1} x}
                                                  {set x {+ x {fget 2}}}
                                                  {call f x}}}))))
                                           
(eval '{with {nil {new Nil}}
             {with {l {init {new Cons} 1 {init {new Cons} 2 nil}}}
                   {print {+ {first {rest l}} 10}}
                   {for l {init {new Plus} 10}}}} '() 
                                                     `((Nil ,Nil)
                                                       (Cons ,Cons)
                                                       (Plus ,Plus)))

(eval '{with {l {init {new Cons} 1 {init {new Range} 3 7 2}}}
             {print {+  {first {rest {rest l}}} 10}}
             {for l {init {new Plus} 10}}} '() 
                                           `((Nil ,Nil)
                                             (Cons ,Cons)
                                             (Range ,Range)
                                             (Plus ,Plus)))

(eval '{with {c1 {new Counter}}
             {with {c2 {new Counter}}
                   {with {c3 c1}
                         {init c1}
                         {init c2}
                         {inc c1 2}
                         {inc c2 4}
                         {call c2 10}
                         {print {dec c3 1}}
                         {print {dec c2 1}}}}} '() `((Counter ,Counter)))
                                         
#|
(eval '{with {sum 42}
               {{set sum {fun {x}
                              {if x
                                  {ret {+ x {sum {- x 1}}}}
                                  {ret x}}}}
                {print {sum 5}}}} '())


|#

#|

{rec {func {fun {x} <bodyf>}} <bodyr>} => {with {func 42}
                                                {{set func {fun {x} <bodyf>}}
                                                 <bodyr>}}

|#
