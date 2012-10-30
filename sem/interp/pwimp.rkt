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
  [ref (var symbol?)])

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
        (body PWIMP?)])
  
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

;; essa versão de pop não desaloca a memória
;(define (pop mem) mem)

;; interp-exp: PIAE Env Mem -> num
(define (interp-exp iae env mem)
  (type-case PIAE iae
    [num (n) n]
    [id (name) (lookup-mem (lookup-env name env) mem)]
    [add (left right) (+ (interp-exp left env mem)
                         (interp-exp right env mem))]
    [sub (left right) (- (interp-exp left env mem)
                         (interp-exp right env mem))]
    [ref (name) (lookup-env name env)]
    [deref (exp) (lookup-mem (interp-exp exp env mem) mem)]))

;; interp-cmd: PWIMP Env Mem -> Mem
(define (interp-cmd imp env mem)
  (type-case PWIMP imp
    [skip () mem]
    [st (lval rval)
        (mem-entry (interp-exp lval env mem) ; endereço
                   (interp-exp rval env mem) ; valor 
                   mem)]
    [cif (cond true false)
         (if (= 0 (interp-exp cond env mem))
             (interp-cmd false env mem)
             (interp-cmd true env mem))]
    [whl (cond body)
         (if (= 0 (interp-exp cond env mem))
             mem
             (interp-cmd imp env (interp-cmd body env mem)))]
    [prt (exp) 
         (local () 
           (print (interp-exp exp env mem))
           (newline)
           mem)]
    [seq (cmd1 cmd2)
         (interp-cmd cmd2 env (interp-cmd cmd1 env mem))]
    [with (var exp body)
          (local [(define free/mem (alloc mem))
                  (define free (first free/mem))
                  (define newmem (second free/mem))]      
            (pop (interp-cmd body (env-entry var
                                             free
                                             env)
                             (mem-entry free
                                        (interp-exp exp env newmem)
                                        newmem))))]))

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
          (define free (second env/count))]
    (interp-cmd (parse-cmd cmd) env (mem-entry 0 free (mem-empty)))))

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

(interp '{{set x 100}
          {set y 0}
          {while {- 10 y}
                 {{set {deref {+ x y}} {+ y y}}
                  {set y {+ y 1}}}}
          {while y
                 {{print {deref {+ x {- y 1}}}}
                  {set y {- y 1}}}}} '(x y))
