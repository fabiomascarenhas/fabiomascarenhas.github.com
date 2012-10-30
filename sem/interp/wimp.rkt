#lang plai

;; IAE = <num> | {+ <IAE> <AE> } | {- <IAE> <IAE>} | <id>

(define-type IAE
  [num (n number?)]
  [add (left IAE?)
       (right IAE?)]
  [sub (left IAE?)
       (right IAE?)]
  [id (name symbol?)])

;; parse-exp: s-expr -> IAE
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
    [else (error 'parse "syntax error")]))

;; WIMP = {if <IAE> <WIMP> <WIMP>} | {while <IAE> <WIMP>} | {set <id> <IAE>}
;;       | {print <IAE>} | {<WIMP> <WIMP>...} | {skip} | {with {<id> <IAE>} <WIMP>}

(define-type WIMP
  [cif (cond IAE?)
       (true WIMP?)
       (false WIMP?)]
  [whl (cond IAE?)
       (body WIMP?)]
  [st (lval symbol?)
      (rval IAE?)]
  [prt (exp IAE?)]
  [skip]
  [seq (cmd1 WIMP?)
       (cmd2 WIMP?)]
  [with (var symbol?)
        (exp IAE?)
        (body WIMP?)])
  
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
     (st (second input)
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

;; interp-exp: IAE Env Mem -> num
(define (interp-exp iae env mem)
  (type-case IAE iae
    [num (n) n]
    [id (name) (lookup-mem (lookup-env name env) mem)]
    [add (left right) (+ (interp-exp left env mem)
                         (interp-exp right env mem))]
    [sub (left right) (- (interp-exp left env mem)
                         (interp-exp right env mem))]))

;; interp-cmd: WIMP Env Mem -> Mem
(define (interp-cmd imp env mem)
  (type-case WIMP imp
    [skip () mem]
    [st (lval rval)
        (mem-entry (lookup-env lval env)     ; endereço
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
               {print y}
               {if {- x 1}
                   {skip}
                   {print 42}}
               {set x {- x 1}}}}}
          {print y}} '(x y))
