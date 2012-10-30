#lang plai

;; EXP = <num> | {+ <EXP> <EXP>} | {- <EXP> <EXP>} | <id> | 
;;       {deref <EXP>} | {ref <id>} | {fun {<id>} <EXP>...} | {<EXP> ...} |
;;       {if <EXP> <EXP> <EXP>} | {while <EXP> <EXP>...} | {set <EXP> <EXP>} |
;;       {print <EXP>} | {do <EXP>...} | {skip} | {with {<id> <EXP>} <EXP>...} |
;;       {throw <tag> <EXP>} | {catch <tag> <EXP>}

(define-type EXP
  [num (n number?)]
  [add (left EXP?)
       (right EXP?)]
  [sub (left EXP?)
       (right EXP?)]
  [id (name symbol?)]
  [deref (exp EXP?)]
  [ref (var symbol?)]
  [fun (param symbol?)
       (body EXP?)]
  [app (func EXP?)
       (arg EXP?)]
  [cif (cond EXP?)
       (true EXP?)
       (false EXP?)]
  [whl (cond EXP?)
       (body EXP?)]
  [st (lval EXP?)
      (rval EXP?)]
  [prt (exp EXP?)]
  [skip]
  [seq (cmd1 EXP?)
       (cmd2 EXP?)]
  [thr (tag symbol?)
       (val EXP?)]
  [cth (tag symbol?)
       (exp EXP?)]
  [ret (val EXP?)])

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
    [(eq? (first input) 'ref)
     (ref (second input))]
    [(eq? (first input) 'deref)
     (deref (parse (second input)))]
    [(eq? (first input) 'fun)
     (foldr (lambda (name body) (fun name body))
            (parse `(do ,@(rest (rest input))))
            (second input))]
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
     (st (cond
           [(symbol? (second input)) (ref (second input))]
           [(eq? (first (second input)) 'deref) 
            (parse (second (second input)))]
           [else (error 'parse-cmd "syntax error")])
         (parse (third input)))]
    [(eq? (first input) 'print)
     (prt (parse (second input)))]
    [(eq? (first input) 'skip)
     (skip)]
    [(eq? (first input) 'with)
     (app (parse `{fun {,(first (second input))} ,@(rest (rest input))})
          (parse (second (second input))))]
    [(eq? (first input) 'ret)
     (ret (parse (second input)))]
    [(eq? (first input) 'throw)
     (thr (second input) (parse (third input)))]
    [(eq? (first input) 'do)
     (foldl (lambda (cmd cmds) (seq cmds cmd))
            (skip) (map parse (rest input)))]
    [else
     (foldl (lambda (arg func) (app func arg))
            (parse (first input))  ; função
            (map parse (rest input)))]))

  
(define-type Value
  [voidV]
  [numV (n number?)]
  [expV (exp EXP?)
        (env Env?)]
  [clos (param symbol?)
        (body EXP?)
        (env Env?)])

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

;; pop : Mem -> void Mem
(define pop
  (mdo (free <- (mget 0))
       (mset 0 (numV (- (numV-n free) 1)))))

(define (zip l1 l2)
  (if (null? l1)
      '()
      (cons (list (first l1) (first l2))
            (zip (rest l1) (rest l2)))))

(define (force exp env)
  (mdo (val <- (interp exp env))
       (type-case Value val
         [expV (exp env)
               (force exp env)]
         [else (unit val)])))

(define (delay exp env)
  (unit (expV exp env)))

;; interp: EXP FunDefs Env -> (Mem -> num Mem)
(define (interp exp env)
  (type-case EXP exp
    [num (n) (unit (numV n))]
    [fun (param body) 
         (unit (clos param body env))]
    [id (name) (mget (lookup-env name env))]
    [add (left right)
         (mdo (val1 <- (force left env))
              (val2 <- (force right env))
              (unit (numV (+ (numV-n val1) (numV-n val2)))))]
    [sub (left right)
         (mdo (val1 <- (force left env))
              (val2 <- (force right env))
              (unit (numV (- (numV-n val1) (numV-n val2)))))]
    [ref (name) (unit (numV (lookup-env name env)))]
    [deref (exp)
           (mdo (loc <- (force exp env))
                (mget (numV-n loc)))]
    [skip () (unit (voidV))]
    [st (lval rval)
        (mdo (loc <- (force lval env))
             (val <- (force rval env))
             (mset (numV-n loc) val))]
    [cif (cond true false)
         (mdo (cval <- (force cond env))
              (if (= 0 (numV-n cval))
                  (delay false env)
                  (delay true env)))]
    [whl (cond body)
         (local [(define dowhile (mdo (cval <- (force cond env))
                                      (if (= 0 (numV-n cval))
                                          (unit (voidV))
                                          (mdo (force body env)
                                               dowhile))))]
           dowhile)]
    [prt (exp)
         (mdo (val <- (force exp env))
              (begin
                (print val)
                (newline)
                (unit (voidV))))]
    [seq (cmd1 cmd2)
         (mdo (force cmd1 env)
              (delay cmd2 env))]
    [ret (exp)
         (mdo (vret <- (delay exp env))
              (return vret))]
    [thr (tag exp)
         (mdo (vret <- (delay exp env))
              (throw tag vret))]
    [cth (tag exp)
         (mdo (vret <- (catch tag (force exp env)))
              (unit vret))]
    [app (func arg)
         (mdo (varg <- (delay arg env))
              (parg <- alloc)
              (mset parg varg)
              (vclos <- (force func env))
              (vret <- (catch 'retval
                         (force (clos-body vclos) 
                                (env-entry (clos-param vclos)
                                           parg
                                           (clos-env vclos)))))
              (unit vret))]))

(define (init-env vars count env)
  (if (null? vars)
      (list env count)
      (init-env (rest vars) 
                (+ count 1)
                (env-entry (first vars)
                           count
                           env))))
                

(define (eval cmd vars)
  (local [(define env/count (init-env vars 1 (env-empty)))
          (define env (first env/count))
          (define free (numV (second env/count)))]
    (first ((mdo (mset 0 free)
                 (force (parse cmd) env)) ;;(mem-empty)))))
            (make-vector 5000 (numV 0))))))


(eval '{do {set x 3}
         {set y 2}
         {while x
                {set y {+ y y}}
                {if {- x 1}
                    {skip}
                    {print 42}}
                {set x {- x 1}}}
         {print {ret 5}}
         {print y}} '(x y))

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

(eval '{{fun {x} 3} {throw err 0}} '())

(eval '{do {set pair {fun {x y}
                          {fun {z}
                               {if z y x}}}}
         {set uns {pair 1 uns}}
         {set l uns}
         {set x 10}
         {while x
                {print {l 0}}
                {set x {- x 1}}
                {set l {l 1}}}} '(pair uns l x))
         

(eval '{do {set pair {fun {x y}
                          {fun {z}
                               {if z y x}}}}
         {set apartir {fun {n}
                           {pair n {apartir {+ n 1}}}}}
         {set l {apartir 1}}
         {set x 10}
         {while x
                {print {l 0}}
                {set x {- x 1}}
                {set l {l 1}}}} '(pair apartir l x))

(eval '{do {set pair {fun {x y}
                          {fun {z}
                               {if z y x}}}}
         {set zipWith {fun {op l1 l2}
                           {pair {op {l1 0} {l2 0}}
                                 {zipWith op {l1 1} {l2 1}}}}}
         {set fibs {pair 1 
                         {pair 1 
                               {zipWith {fun {x y} {+ x y}}
                                        fibs {fibs 1}}}}}
         {set l fibs}
         {set x 10}
         {while x
                {print {l 0}}
                {set x {- x 1}}
                {set l {l 1}}}} '(pair zipWith fibs l x))

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

(eval '{with {counter 42}
               {{with {this 0}
                      {{set {deref 20} {fun {n}
                                            {{set this {- this n}}
                                             {ret this}}}}  ; dec
                       {set {deref 21} {fun {n}
                                            {{set this {+ this n}}
                                             {ret this}}}}  ; inc
                       {set counter {fun {meth n}
                                         {ret {{deref {+ 20 meth}} n}}}}}}
                {counter 1 2}
                {counter 1 2}
                {counter 1 2}
                {print {counter 0 3}}}} '())

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
