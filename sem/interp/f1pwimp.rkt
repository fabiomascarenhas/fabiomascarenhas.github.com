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

;; alloc : mem -> loc mem 
(define (alloc mem)
  (local [(define free (lookup-mem 0 mem))]
    (list free
          (mem-entry 0 (+ free 1) mem))))

;; pop : mem -> mem
(define (pop mem)
  (mem-entry 0 (- (lookup-mem 0 mem) 1) mem))
;(define (pop mem) mem)

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

;; interp-exp: PIAE FunDefs Env Mem -> num Mem
(define (interp-exp iae funs env mem)
  (type-case PIAE iae
    [num (n) (list n mem)]
    [id (name) (list (lookup-mem (lookup-env name env) mem) mem)]
    [add (left right) 
         (local ([define val1/mem1 (interp-exp left funs env mem)]
                 [define val2/mem2 (interp-exp right funs env (second val1/mem1))])
                   (list (+ (first val1/mem1)
                            (first val2/mem2)) (second val2/mem2)))]
    [sub (left right) 
         (local ([define val1/mem1 (interp-exp left funs env mem)]
                 [define val2/mem2 (interp-exp right funs env (second val1/mem1))])
                   (list (- (first val1/mem1)
                            (first val2/mem2)) (second val2/mem2)))]
    [ref (name) (list (lookup-env name env) mem)]
    [deref (exp) 
           (local ([define val/mem (interp-exp exp funs env mem)])
             (list (lookup-mem (first val/mem) 
                               (second val/mem)) (second val/mem)))]
    [app (func arg)
         (local ([define f (lookup-fundef func funs)]
                 [define arg/mem (interp-exp arg funs env mem)]
                 [define newmem (interp-cmd (with 'ret
                                                  (num 0)
                                                  (with (fundef-param f)
                                                        (num (first arg/mem))
                                                        (fundef-body f)))
                                            funs (env-empty) (second arg/mem))])
           (list (lookup-mem (lookup-mem 0 newmem) newmem) newmem))]))

;; interp-cmd: PWIMP Env Mem -> Mem
(define (interp-cmd imp funs env mem)
  (type-case PWIMP imp
    [skip () mem]
    [st (lval rval)
        (local ([define val/mem1 (interp-exp rval funs env mem)]
                [define loc/mem2 (interp-exp lval funs env (second val/mem1))])
          (mem-entry (first loc/mem2) ; endereço
                     (first val/mem1) ; valor 
                     (second loc/mem2)))]
    [cif (cond true false)
         (local ([define val/newmem (interp-exp cond funs env mem)])
           (if (= 0 (first val/newmem))
               (interp-cmd false funs env (second val/newmem))
               (interp-cmd true funs env (second val/newmem))))]
    [whl (cond body)
         (local ([define val/newmem (interp-exp cond funs env mem)])
         (if (= 0 (first val/newmem))
             (second val/newmem)
             (interp-cmd imp funs env 
                         (interp-cmd body funs env (second val/newmem)))))]
    [prt (exp) 
         (local ([define val/newmem (interp-exp exp funs env mem)]) 
           (print (first val/newmem))
           (newline)
           (second val/newmem))]
    [seq (cmd1 cmd2)
         (interp-cmd cmd2 funs env (interp-cmd cmd1 funs env mem))]
    [with (var exp body)
          (local [(define free/mem (alloc mem))
                  (define free (first free/mem))
                  (define newmem (second free/mem))]      
            (pop (interp-cmd body funs (env-entry var
                                                  free
                                                  env)
                             (local ([define val/mem 
                                       (interp-exp exp funs env newmem)])
                               (mem-entry free
                                          (first val/mem)
                                          (second val/mem))))))]
    [capp (func arg)
          (local ([define f (lookup-fundef func funs)]
                  [define arg/mem (interp-exp arg funs env mem)])
            (interp-cmd (with 'ret
                              (num 0)
                              (with (fundef-param f)
                                    (num (first arg/mem))
                                    (fundef-body f))) funs (env-empty) (second arg/mem)))]
    [ret (exp)
         (local ([define val/mem (interp-exp exp funs env mem)])
           (mem-entry (lookup-env 'ret env)
                      (first val/mem)
                      (second val/mem)))]))

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
    (interp-cmd (parse-cmd cmd) funs env (mem-entry 0 free (mem-empty)))))

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

(interp '{{set x 100}
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

