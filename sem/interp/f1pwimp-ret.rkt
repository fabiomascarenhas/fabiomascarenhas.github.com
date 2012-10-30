#lang plai

;; PIAE = <num> | {+ <PIAE> <PIAE> } | {- <PIAE> <PIAE>} | <id> | 
;;        {deref <PIAE>} | {ref <id>}

(define-type PIAE
  [num (n number?)]
  [add (left PIAE?)
       (right PIAE?)]
  [sub (left PIAE?)
       (right PIAE?)]
  [id (name symbol?)]
  [deref (exp PIAE?)]
  [ref (var symbol?)]
  [app (func symbol?)
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
    [(symbol? (first input))
     (app (first input)
          (parse-exp (second input)))]
    [else (error 'parse "syntax error")]))

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
  [capp (func symbol?)
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
     (capp (first input)
          (parse-exp (second input)))]
    [else (foldr seq (skip) (map parse-cmd input))]))

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

;; lookup-mem : Loc Mem -> num
(define (lookup-mem loc mem)
  (type-case Mem mem
    [mem-empty () 0]
    [mem-entry (l val next) (if (= loc l)
                                val
                                (lookup-mem loc next))])) 

;; mget : loc -> (Mem -> num Mem)
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
       (mset 0 (+ free 1))
       (unit free)))

;; pop : Mem -> void Mem
(define pop
  (mdo (free <- (mget 0))
       (mset 0 (- free 1))))

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
(define (interp-exp iae funs env)
  (type-case PIAE iae
    [num (n) (unit n)]
    [id (name) (mget (lookup-env name env))]
    [add (left right)
         (mdo (val1 <- (interp-exp left funs env))
              (val2 <- (interp-exp right funs env))
              (unit (+ val1 val2)))]
    [sub (left right)
         (mdo (val1 <- (interp-exp left funs env))
              (val2 <- (interp-exp right funs env))
              (unit (- val1 val2)))]
    [ref (name) (unit (lookup-env name env))]
    [deref (exp)
           (mdo (loc <- (interp-exp exp funs env))
                (mget loc))]
    [app (func arg)
         (let [(f (lookup-fundef func funs))]
           (mdo (varg <- (interp-exp arg funs env))
                (parg <- alloc)
                (mset parg varg)
                (vret <- (interp-cmd (fundef-body f) funs (env-entry (fundef-param f)
                                                                    parg
                                                                    (env-empty))))
                pop
                (unit vret)))]))

;; interp-cmd: PWIMP Env -> (Mem -> (void | num) Mem)
(define (interp-cmd imp funs env)
  (type-case PWIMP imp
    [skip () (unit (void))]
    [st (lval rval)
        (mdo (loc <- (interp-exp lval funs env))
             (val <- (interp-exp rval funs env))
             (mset loc val))]
    [cif (cond true false)
         (mdo (cval <- (interp-exp cond funs env))
              (if (= 0 cval)
                  (interp-cmd false funs env)
                  (interp-cmd true funs env)))]
    [whl (cond body)
         (local [(define dowhile (mdo (cval <- (interp-exp cond funs env))
                                      (if (= 0 cval)
                                          (unit (void))
                                          (mdo (vret <- (interp-cmd body funs env))
                                               (if (void? vret)
                                                   dowhile
                                                   (unit vret))))))]
           dowhile)]
    [prt (exp)
         (mdo (val <- (interp-exp exp funs env))
              (begin
                (print val)
                (newline)
                (unit (void))))]
    [seq (cmd1 cmd2)
         (mdo (vret <- (interp-cmd cmd1 funs env))
              (if (void? vret)
                  (interp-cmd cmd2 funs env)
                  (unit vret)))]
    [with (var exp body)
          (mdo (val <- (interp-exp exp funs env))
               (free <- alloc)
               (mset free val)
               (vret <- (interp-cmd body funs (env-entry var free env)))
               pop
               (unit vret))]
    [capp (func arg)
          (let [(f (lookup-fundef func funs))]
            (mdo (varg <- (interp-exp arg funs env))
                 (parg <- alloc)
                 (mset parg varg)
                 (vret <- (interp-cmd (fundef-body f) funs (env-entry (fundef-param f)
                                                                      parg
                                                                      (env-empty))))
                 pop))]
    [ret (exp)
         (interp-exp exp funs env)]))

(define (init-env vars count env)
  (if (null? vars)
      (list env count)
      (init-env (rest vars) 
                (+ count 1)
                (env-entry (first vars)
                           count
                           env))))
                

(define (interp cmd vars funs)
  (local [(define env/count (init-env vars 1 (env-empty)))
          (define env (first env/count))
          (define free (second env/count))]
    (second ((mdo (mset 0 free)
                 (interp-cmd (parse-cmd cmd) funs env)) (make-vector 30)))))

(interp '{{set x 3}
          {set y 2}
          {while x
            {{set y {+ y y}}
             {if {- x 1}
                 {skip}
                 {print 42}}
             {set x {- x 1}}}}
          {print y}} '(x y) '())

(interp '{with {x 3}
           {with {y 2}
             {{while x
                {{set y {+ y y}}
                 {if {- x 1}
                     {skip}
                     {print 42}}
                 {set x {- x 1}}}}
              {print y}}}} '() '())

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
          {print {deref z}}} '(x y z) '())

(interp '{{set x 3}
          {set y {ref x}}
          {while {deref y}
            {{if {- x 1}
                 {skip}
                 {print 42}}
             {set {deref y} {- x 1}}}}
          {print {deref y}}
          {print {deref {- y 1}}}} '(x y) '())

(interp '{{set x 10}
          {set y 0}
          {while {- 10 y}
                 {{set {deref {+ x y}} {+ y y}}
                  {set y {+ y 1}}}}
          {while y
                 {{print {deref {+ x {- y 1}}}}
                  {set y {- y 1}}}}} '(x y) '())

(interp '{{set x 3}
          {set y {ref x}}
          {while {deref y}
            {{if {dec x}
                 {skip}
                 {print 42}}
             {set {deref y} {- x 1}}}}
          {print {deref y}}
          {print {deref {- y 1}}}} '(x y) (list (fundef 'dec
                                                        'x
                                                        (parse-cmd '{ret {- x 1}}))))

(interp '{{set x 3}
          {set y {ref x}}
          {while {deref y}
            {{if {- x 1}
                 {skip}
                 {print 42}}
             {print {dec y}}}}
          {print {deref y}}
          {print {deref {- y 1}}}} '(x y) (list (fundef 'dec
                                                        'x
                                                        (parse-cmd '{{set {deref x} 
                                                                         {- {deref x} 1}}
                                                                     {ret {deref x}}}))))

