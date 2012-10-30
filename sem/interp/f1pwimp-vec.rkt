#lang plai

;; PIAE = <num> | {+ <PIAE> <PIAE> } | {- <PIAE> <PIAE>} | <id> | {deref <PIAE>} | {ref <id>}

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

;; Mem === vector num

;; unit : num -> (Mem -> num Mem)
(define (unit num)
  (lambda (mem)
    (list num mem)))

;; bind : (Mem -> num Mem) (num -> (Mem -> num Mem)) -> (Mem -> num Mem)
(define (bind op1 op2)
  (lambda (mem)
    (local ([define num/mem (op1 mem)]
            [define num (first num/mem)]
            [define newmem (second num/mem)])
      ((op2 num) newmem))))

;; mget : loc -> (Mem -> num Mem)
(define (mget loc)
  (lambda (mem)
    (list (vector-ref mem loc) mem)))

;; mset : loc num -> (Mem -> num Mem) 
(define (mset loc val)
  (lambda (mem)
    (list (vector-set! mem loc val) mem)))

;; alloc : mem -> loc Mem
(define alloc
  (bind (mget 0)
        (lambda (free)
          (bind (mset 0 (+ free 1))
                (lambda (dummy)
                  (unit free))))))

;; pop : mem -> void mem
(define pop
  (bind (mget 0)
        (lambda (free)
          (mset 0 (- free 1)))))
;(define pop (unit (void)))

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
         (bind (interp-exp left funs env)
               (lambda (val1)
                 (bind (interp-exp right funs env)
                       (lambda (val2)
                         (unit (+ val1 val2))))))]
    [sub (left right)
         (bind (interp-exp left funs env)
               (lambda (val1)
                 (bind (interp-exp right funs env)
                       (lambda (val2)
                         (unit (- val1 val2))))))]
    [ref (name) (unit (lookup-env name env))]
    [deref (exp)
           (bind (interp-exp exp funs env)
                 (lambda (val)
                   (mget val)))]
    [app (func arg)
         (local ([define f (lookup-fundef func funs)])
           (bind (interp-exp arg funs env)
                 (lambda (arg)
                   (bind alloc
                         (lambda (pret)
                           (bind (interp-cmd
                                  (with (fundef-param f)
                                        (num arg)
                                        (fundef-body f))
                                  funs (env-entry 'ret pret (env-empty)))
                                 (lambda (dummy)
                                   (bind (mget pret)
                                         (lambda (valret)
                                           (bind pop
                                                 (lambda (dummy)
                                                   (unit valret))))))))))))]))

;; interp-cmd: PWIMP Env -> (Mem -> void Mem)
(define (interp-cmd imp funs env)
  (type-case PWIMP imp
    [skip () (unit (void))]
    [st (lval rval)
        (bind (interp-exp rval funs env)
              (lambda (val)
                (bind (interp-exp lval funs env)
                      (lambda (loc)
                        (mset loc val)))))]
    [cif (cond true false)
         (bind (interp-exp cond funs env)
               (lambda (val)
                 (if (= 0 val)
                     (interp-cmd false funs env)
                     (interp-cmd true funs env))))]
    [whl (cond body)
         (local [(define dowhile (bind (interp-exp cond funs env)
                                       (lambda (val)
                                         (if (= 0 val)
                                             (unit (void))
                                             (bind (interp-cmd body funs env)
                                                   (lambda (dummy)
                                                     dowhile))))))]
           dowhile)]
    [prt (exp)
         (bind (interp-exp exp funs env)
               (lambda (val)
                 (begin
                   (print val)
                   (newline)
                   (unit (void)))))]
    [seq (cmd1 cmd2)
         (bind (interp-cmd cmd1 funs env)
               (lambda (dummy)
                 (interp-cmd cmd2 funs env)))]
    [with (var exp body)
          (bind (interp-exp exp funs env)
                (lambda (val)
                  (bind alloc
                        (lambda (free)
                          (bind (mset free val)
                                (lambda (dummy)
                                  (bind (interp-cmd body funs (env-entry var free env))
                                        (lambda (dummy)
                                          pop))))))))]
    [capp (func arg)
          (local [(define f (lookup-fundef func funs))]
            (bind (interp-exp arg funs env)
                  (lambda (arg)
                    (interp-cmd (with 'ret
                                      (num 0)
                                      (with (fundef-param f)
                                            (num arg)
                                            (fundef-body f)))
                                funs (env-empty)))))]
    [ret (exp)
         (bind (interp-exp exp funs env)
               (lambda (val)
                 (mset (lookup-env 'ret env) val)))]))

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
    (second ((bind (mset 0 free)
                  (lambda (dummy)
                    (interp-cmd (parse-cmd cmd) funs env))) (make-vector 25)))))

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

