#lang plai

;; F1WAE = <num> | {+ <F1WAE> <F1WAE> } | {- <F1WAE> <F1WAE>}
;;       | {with {<id> <F1WAE>} <F1WAE>} | <id> | {<id> F1WAE}
;;       | {if0 <F1WAE> <F1WAE> <F1WAE>}

(define-type F1WAE
  [num (n number?)]
  [add (left F1WAE?)
       (right F1WAE?)]
  [sub (left F1WAE?)
       (right F1WAE?)]
  [id (name symbol?)]
  [with (name symbol?)
        (expr F1WAE?)
        (body F1WAE?)]
  [if0  (cond F1WAE?)
        (true_block F1WAE?)
        (false_block F1WAE?)]
  [app (func symbol?)
       (arg F1WAE?)])

(define-type Env
    [env-empty]
    [env-entry (name symbol?)
               (val number?)
               (next Env?)])

;; parse: s-expr -> F1WAE
;; (parse '{+ 3 4}) -> (add (num 3) (num 4))

(define (parse input)
  (cond
    [(number? input) (num input)]
    [(symbol? input) (id input)]
    [(and (= 3 (length input))
          (eq? (first input) '+))
     (add (parse (second input))
          (parse (third input)))]
    [(and (= 3 (length input))
          (eq? (first input) '-))
     (sub (parse (second input))
          (parse (third input)))]
    [(and (= 3 (length input))
          (eq? (first input) 'with))
     (with (first (second input))  ; name
           (parse (second (second input))) ; expr
           (parse (third input)))] ; body
    [(and (= 2 (length input))
          (symbol? (first input)))
     (app (first input)
          (parse (second input)))]
    [(and (= 4 (length input))
          (eq? (first input) 'if0))
     (if0 (parse (second input))
          (parse (third input))
          (parse (fourth input)))]
    [else (error 'parse "syntax error")]))

(test (parse '1) (num 1))
(test (parse '{+ 1 2}) (add (num 1) (num 2)))
(test (parse '{+ {- 5 2} {+ 2 1}}) (add (sub (num 5) (num 2))
                                        (add (num 2) (num 1))))
(test (parse 'x) (id 'x))
(test (parse '{with {x {+ 1 2}} {- x 8}})
      (with 'x (add (num 1) (num 2))
        (sub (id 'x) (num 8))))

(test (parse '{if0 0 0 0}) (if0
                            (num 0)
                            (num 0)
                            (num 0)))

(test (parse '{if0 {- 1 1} {+ 0 0} {+ 0 0}}) (if0 
                                              (sub (num 1) (num 1)) 
                                              (add (num 0) (num 0)) 
                                              (add (num 0) (num 0))))


;; CF1WAE = <num> | {+ <CF1WAE> <CF1WAE> } | {- <CF1WAE> <CF1WAE>}
;;       | {with {<CF1WAE>} <F1WAE>} | <cid> | {<id> CF1WAE}
;;       | {if0 <CF1WAE> <CF1WAE> <CF1WAE>}

(define-type CF1WAE
  [cnum (n number?)]
  [cadd (left CF1WAE?)
        (right CF1WAE?)]
  [csub (left CF1WAE?)
        (right CF1WAE?)]
  [cid (pos number?)]
  [cwith (expr CF1WAE?)
         (body CF1WAE?)]
  [cif0  (cond CF1WAE?)
         (true_block CF1WAE?)
         (false_block CF1WAE?)]
  [capp (func symbol?)
        (arg CF1WAE?)])

;; compile: F1WAE * symbol list -> CF1WAE

(define (compile exp env)
  (type-case F1WAE exp
    [num (n) (cnum n)]
    [add (left right)
         (cadd (compile left env)
               (compile right env))]
    [sub (left right)
         (csub (compile left env)
               (compile right env))]
    [id (name)
        (local [(define (locate name env)
                  (if (null? env)
                      (error 'compile "unbound identifier")
                      (if (symbol=? (first env) name)
                          0
                          (+ 1 (locate name (rest env))))))]
          (cid (locate name env)))]
    [with (name expr body)
          (cwith (compile expr env)
                 (compile body (cons name env)))]
    [if0 (cond true false)
         (cif0 (compile cond env)
               (compile true env)
               (compile false env))]
    [app (func arg)
         (capp func
               (compile arg env))]))

(define (F1WAE/CF1WAE? exp)
  (or (F1WAE? exp)
      (CF1WAE? exp)))

(define-type FunDef
  [fundef (name symbol?)
          (param symbol?)
          (body F1WAE/CF1WAE?)])

;; lookup-fundef: symbol * [FunDef] -> FunDef

(define (lookup-fundef func fundefs)
  (if (empty? fundefs) 
      (error 'interp "function not found")
      (if (symbol=? func (fundef-name (first fundefs)))
              (first fundefs)
              (lookup-fundef func (rest fundefs)))))

(test/exn (lookup-fundef 'f (list)) "function not found")
(test (lookup-fundef 'f (list (fundef 'f 'x (parse 'x))))
      (fundef 'f 'x (parse 'x)))
(test (lookup-fundef 'f (list (fundef 'g 'y (parse 'y))
                              (fundef 'f 'x (parse 'x))))
       (fundef 'f 'x (parse 'x)))

(define (lookup-env name env)
  (type-case Env env
    [env-empty () (error 'interp "unbound identifier")]
    [env-entry (id val next) (if (symbol=? id name)
                                 val
                                 (lookup-env name next))])) 

;; interp: F1WAE * [FunDef] * Env -> num

(define (interp f1wae fundefs env)
  (type-case F1WAE f1wae
    [num (n) n]
    [add (left right) (+ (interp left fundefs env)
                         (interp right fundefs env))]
    [sub (left right) (- (interp left fundefs env)
                         (interp right fundefs env))]
    [id (name) (lookup-env name env)]
    [with (name expr body) 
      (interp body
              fundefs 
              (env-entry name
                         (interp expr fundefs env)
                         env))]
    [if0 (cond true_block false_block)
         (if
           (= 0 (interp cond fundefs env))
           (interp true_block fundefs env)
           (interp false_block fundefs env))]
    [app (func arg)
         (local [(define fun (lookup-fundef func fundefs))]
           (interp (fundef-body fun)
                   fundefs
                   (env-entry (fundef-param fun)
                              (interp arg fundefs env)
                              (env-empty))))]))

(define (eval exp fundefs) (interp exp fundefs (env-empty)))

(test (eval (num 5) (list))
      5)
(test (eval (add (num 8) (num 9)) (list))
      17)
(test (eval (sub (num 9) (num 8)) (list))
      1)
(test (eval (with 'x (add (num 1) (num 17))
                (add (id 'x) (num 12)))
              (list))
      30)
(test/exn (eval (id 'x) (list)) "unbound identifier")
(test (eval (parse '{f {+ 5 5}})
              (list (fundef 'f 'x (parse '{+ x x}))))
      20)

(test (eval (parse '{if0 0 1 2})
                (list))
        1)
(test (eval (parse '{if0 1 1 2})
                (list))
        2)

(test (eval (parse '{if0 {f 5} 1 2})
              (list (fundef 'f 'x (parse '{- x 5}))))
      1)

;; cinterp: CF1WAE * FunDef list * num list -> num

(define (cinterp cf1wae fundefs env)
  (type-case CF1WAE cf1wae
    [cnum (n) n]
    [cadd (left right) (+ (cinterp left fundefs env)
                          (cinterp right fundefs env))]
    [csub (left right) (- (cinterp left fundefs env)
                          (cinterp right fundefs env))]
    [cid (pos) (list-ref env pos)]
    [cwith (expr body) 
      (cinterp body
               fundefs
               (cons (cinterp expr fundefs env) env))]
    [cif0 (cond true_block false_block)
          (if
            (= 0 (cinterp cond fundefs env))
            (cinterp true_block fundefs env)
            (cinterp false_block fundefs env))]
    [capp (func arg)
          (local [(define fun (lookup-fundef func fundefs))]
            (cinterp (fundef-body fun)
                     fundefs
                     (list (cinterp arg fundefs env))))]))

(define (ceval exp fundefs)
  (local [(define cfundefs (map (lambda (fd)
                                  (fundef (fundef-name fd)
                                          'dummy 
                                          (compile (fundef-body fd)
                                                   (list (fundef-param fd)))))
                                fundefs))
          (define cexp (compile exp '()))]
    (cinterp cexp cfundefs '())))
  
(test (ceval (num 5) (list))
      5)
(test (ceval (add (num 8) (num 9)) (list))
      17)
(test (ceval (sub (num 9) (num 8)) (list))
      1)
(test (ceval (with 'x (add (num 1) (num 17))
                (add (id 'x) (num 12)))
              (list))
      30)
(test/exn (ceval (id 'x) (list)) "unbound identifier")
(test (ceval (parse '{f {+ 5 5}})
              (list (fundef 'f 'x (parse '{+ x x}))))
      20)

(test (ceval (parse '{if0 0 1 2})
                (list))
        1)
(test (ceval (parse '{if0 1 1 2})
                (list))
        2)

(test (ceval (parse '{if0 {f 5} 1 2})
              (list (fundef 'f 'x (parse '{- x 5}))))
      1)

         