#lang plai

;; PIAE = <num> | {+ <PIAE> <PIAE> } | {- <PIAE> <PIAE>} | <id> | 
;;        {deref <PIAE>} | {ref <id>} | {fun {<id>} <CMD>} | {<PIAE>...}

(define-type PIAE
  [num (n number?)]
  [add (left PIAE?)
       (right PIAE?)]
  [sub (left PIAE?)
       (right PIAE?)]
  [id (name symbol?)]
  [deref (exp PIAE?)]
  [ref (var symbol?)]
  [fun (param symbol?)
       (body PWIMP?)]
  [app (func PIAE?)
       (arg PIAE?)])

;; parse-exp: s-expr -> PIAE
;; (parse '{+ 3 4}) -> (add (num 3) (num 4))

(define (parse-exp input)
  (cond
    [(number? input) (num input)]
    [(symbol? input) (id input)]
    [(and (= 3 (length input))
          (eq? (first input) '+))
     (add (parse-exp (second input))
          (parse-exp (third input)))]
    [(and (= 3 (length input))
          (eq? (first input) '-))
     (sub (parse-exp (second input))
          (parse-exp (third input)))]
    [(eq? (first input) 'ref)
     (ref (second input))]
    [(eq? (first input) 'deref)
     (deref (parse-exp (second input)))]
    [(and (= 3 (length input))
          (eq? (first input) 'fun))
     (ret-val (foldr (lambda (name body) (ret (fun name body)))
                     (parse-cmd (third input))
                     (second input)))]
    [else
     (foldl (lambda (arg func) (app func arg))
            (parse-exp (first input))  ; função
            (map parse-exp (rest input)))]))

;; PWIMP = {if <PIAE> <PWIMP> <PWIMP>} | {while <PIAE> <PWIMP>} | {set <id> <PIAE>}
;;        | {print <PIAE>} | {<PWIMP> <PWIMP>...} | {skip} | {with {<id> <PIAE>} <PWIMP>}

(define-type PWIMP
  [cif (cond PIAE?)
       (true PWIMP?)
       (false PWIMP?)]
  [whl (cond PIAE?)
       (body PWIMP?)]
  [st (lval PIAE?)
      (rval PIAE?)]
  [prt (exp PIAE?)]
  [skip]
  [seq (cmd1 PWIMP?)
       (cmd2 PWIMP?)]
  [with (var symbol?)
        (exp PIAE?)
        (body PWIMP?)]
  [ret (val PIAE?)]
  [capp (func PIAE?)
        (arg PIAE?)])
  
(define (parse-cmd input)
  (cond
    [(eq? (first input) 'if)
     (cif (parse-exp (second input))
          (parse-cmd (third input))
          (parse-cmd (fourth input)))]
    [(eq? (first input) 'while)
     (whl (parse-exp (second input))
            (parse-cmd (third input)))]
    [(eq? (first input) 'set)
     (st (cond
           [(symbol? (second input)) (ref (second input))]
           [(eq? (first (second input)) 'deref) (parse-exp (second (second input)))]
           [else (error 'parse-cmd "syntax error")])
         (parse-exp (third input)))]
    [(eq? (first input) 'print)
     (prt (parse-exp (second input)))]
    [(eq? (first input) 'skip)
     (skip)]
    [(eq? (first input) 'with)
     (with (first (second input))
           (parse-exp (second (second input)))
           (parse-cmd (third input)))]
    [(eq? (first input) 'ret)
     (ret (parse-exp (second input)))]
    [(symbol? (first input))
     (let [(appl (foldl (lambda (arg func) (app func arg))
                        (parse-exp (first input))  ; função
                        (map parse-exp (rest input))))]
       (capp (app-func appl) (app-arg appl)))]
    [else (foldr seq (skip) (map parse-cmd input))]))

(define-type Value
  [numV (n number?)]
  [clos (param symbol?)
        (body PWIMP?)
        (env Env?)])

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

(define-type FunDef
  [fundef (name symbol?)
          (param symbol?)
          (body PWIMP?)])

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
    (list (vector-set! mem loc val) mem)))
    ;;    (list (void) (mem-entry loc val mem))))

;; unit : ? -> (Mem -> ? Mem)
(define (unit num)
  (lambda (mem)
    (list num mem)))

;; bind : (Mem -> ? Mem) (? -> (Mem -> ? Mem)) -> (Mem -> ? Mem)
(define (bind op1 op2)
  (lambda (mem)
    (let [(val/mem (op1 mem))]
      ((op2 (first val/mem)) (second val/mem)))))

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

(define (lookup-fundef func fundefs)
  (if (empty? fundefs) 
      (error 'interp "function not found")
      (if (symbol=? func (fundef-name (first fundefs)))
              (first fundefs)
              (lookup-fundef func (rest fundefs)))))

(define (zip l1 l2)
  (if (null? l1)
      '()
      (cons (list (first l1) (first l2))
            (zip (rest l1) (rest l2)))))

;; interp-exp: PIAE FunDefs Env -> (Mem -> num Mem)
(define (interp-exp iae env)
  (type-case PIAE iae
    [num (n) (unit (numV n))]
    [fun (param body) 
         (unit (clos param body env))]
    [id (name) (mget (lookup-env name env))]
    [add (left right)
         (mdo (val1 <- (interp-exp left env))
              (val2 <- (interp-exp right env))
              (unit (numV (+ (numV-n val1) (numV-n val2)))))]
    [sub (left right)
         (mdo (val1 <- (interp-exp left env))
              (val2 <- (interp-exp right env))
              (unit (numV (- (numV-n val1) (numV-n val2)))))]
    [ref (name) (unit (numV (lookup-env name env)))]
    [deref (exp)
           (mdo (loc <- (interp-exp exp env))
                (mget (numV-n loc)))]
    [app (func arg)
         (mdo (varg <- (interp-exp arg env))
              (parg <- alloc)
              (mset parg varg)
              (vclos <- (interp-exp func env))
              (vret <- (interp-cmd (clos-body vclos) (env-entry (clos-param vclos)
                                                                parg
                                                                (clos-env vclos))))
              (unit vret))]))

#|
(foldr (lambda (arg comp)
          (mdo (varg <- (interp-exp arg funs env))
               (parg <- alloc)
               (mset parg varg)
               comp)) (interp-cmd body (make-env ...)) args)
|#

;; interp-cmd: PWIMP Env -> (Mem -> (void | num) Mem)
(define (interp-cmd imp env)
  (type-case PWIMP imp
    [skip () (unit (void))]
    [st (lval rval)
        (mdo (loc <- (interp-exp lval env))
             (val <- (interp-exp rval env))
             (mset (numV-n loc) val))]
    [cif (cond true false)
         (mdo (cval <- (interp-exp cond env))
              (if (= 0 (numV-n cval))
                  (interp-cmd false env)
                  (interp-cmd true env)))]
    [whl (cond body)
         (local [(define dowhile (mdo (cval <- (interp-exp cond env))
                                      (if (= 0 (numV-n cval))
                                          (unit (void))
                                          (mdo (vret <- (interp-cmd body env))
                                               (if (void? vret)
                                                   dowhile
                                                   (unit vret))))))]
           dowhile)]
    [prt (exp)
         (mdo (val <- (interp-exp exp env))
              (begin
                (print val)
                (newline)
                (unit (void))))]
    [seq (cmd1 cmd2)
         (mdo (vret <- (interp-cmd cmd1 env))
              (if (void? vret)
                  (interp-cmd cmd2 env)
                  (unit vret)))]
    [with (var exp body)
          (mdo (val <- (interp-exp exp env))
               (free <- alloc)
               (mset free val)
               (vret <- (interp-cmd body (env-entry var free env)))
               (unit vret))]
    [capp (func arg)
          (mdo (varg <- (interp-exp arg env))
               (parg <- alloc)
               (mset parg varg)
               (vclos <- (interp-exp func env))
               (vret <- (interp-cmd (clos-body vclos) (env-entry (clos-param vclos)
                                                                 parg
                                                                 (clos-env vclos))))
               (unit (void)))]
    [ret (exp)
         (interp-exp exp env)]))

(define (init-env vars count env)
  (if (null? vars)
      (list env count)
      (init-env (rest vars) 
                (+ count 1)
                (env-entry (first vars)
                           count
                           env))))
                

(define (interp cmd vars)
  (local [(define env/count (init-env vars 1 (env-empty)))
          (define env (first env/count))
          (define free (numV (second env/count)))]
    (first ((mdo (mset 0 free)
                  (interp-cmd (parse-cmd cmd) env)) ;;(mem-empty)))))
             (make-vector 30 (numV 0))))))

(interp '{{set x 3}
          {set y 2}
          {while x
            {{set y {+ y y}}
             {if {- x 1}
                 {skip}
                 {print 42}}
             {set x {- x 1}}}}
          {print y}} '(x y))

(interp '{with {x 3}
           {with {y 2}
             {{while x
                {{set y {+ y y}}
                 {if {- x 1}
                     {skip}
                     {print 42}}
                 {set x {- x 1}}}}
              {print y}}}} '())

(interp '{{set x 3}
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

(interp '{{set x 3}
          {set y {ref x}}
          {while {deref y}
            {{if {- x 1}
                 {skip}
                 {print 42}}
             {set {deref y} {- x 1}}}}
          {print {deref y}}
          {print {deref {- y 1}}}} '(x y))

(interp '{{set x 10}
          {set y 0}
          {while {- 10 y}
                 {{set {deref {+ x y}} {+ y y}}
                  {set y {+ y 1}}}}
          {while y
                 {{print {deref {+ x {- y 1}}}}
                  {set y {- y 1}}}}} '(x y))

(interp '{with {dec {fun {x}
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

(interp '{with {dec {fun {x} {{set {deref x} 
                                   {- {deref x} 1}}
                              {ret {deref x}}}}} 
               {{set x 3}
                {set y {ref x}}
                {while {deref y}
                       {{if {- x 1}
                            {skip}
                            {print 42}}
                        {print {dec y}}}}
                {print {deref y}}
                {print {deref {- y 1}}}}} '(x y))

(interp '{with {inc 0}
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

(interp '{with {counter 42}
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

(interp '{with {sum 42}
               {{set sum {fun {x}
                              {if x
                                  {ret {+ x {sum {- x 1}}}}
                                  {ret x}}}}
                {print {sum 5}}}} '())

#|

{rec {func {fun {x} <bodyf>}} <bodyr>} => {with {func 42}
                                                {{set func {fun {x} <bodyf>}}
                                                 <bodyr>}}

|#
