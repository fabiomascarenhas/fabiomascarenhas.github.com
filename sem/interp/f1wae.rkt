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
  [app (func symbol?)
       (arg F1WAE?)])

(define-type FunDef
  [fundef (name symbol?)
          (param symbol?)
          (body F1WAE?)])

;; parse: s-expr -> WAE
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
    [else (error 'parse "syntax error")]))

(test (parse '1) (num 1))
(test (parse '{+ 1 2}) (add (num 1) (num 2)))
(test (parse '{+ {- 5 2} {+ 2 1}}) (add (sub (num 5) (num 2))
                                        (add (num 2) (num 1))))
(test (parse 'x) (id 'x))
(test (parse '{with {x {+ 1 2}} {- x 8}})
      (with 'x (add (num 1) (num 2))
        (sub (id 'x) (num 8))))

;; subst: symbol * num * WAE -> WAE
(define (subst name val wae)
  (type-case F1WAE wae
    [num (n) (num n)]
    [add (left right) (add (subst name val left)
                           (subst name val right))]
    [sub (left right) (sub (subst name val left)
                           (subst name val right))]
    [id (name-id) (if (symbol=? name name-id)
                      (num val)
                      (id name-id))]
    [with (name-def expr body)
          (with name-def
                (subst name val expr)
                (if (symbol=? name name-def)
                    body
                    (subst name val body)))]
    [app (func arg)
         (app func  
              (subst name val arg))]))

(test (subst 'x 19 (parse '{+ 1 {f x}}))
      (parse '{+ 1 {f 19}}))
(test (subst 'x 10 (add (num 1) (id 'x)))
      (add (num 1) (num 10)))
(test (subst 'x 10 (id 'x))
      (num 10))
(test (subst 'x 10 (id 'y))
      (id 'y))
(test (subst 'y 10 (sub (id 'x) (num 1)))
      (sub (id 'x) (num 1)))

(test (subst 'x 10 (with 'y (num 17) (id 'x)))
      (with 'y (num 17) (num 10)))
(test (subst 'x 10 (with 'y (id 'x) (id 'y)))
      (with 'y (num 10) (id 'y)))
(test (subst 'x 10 (with 'x (id 'y) (id 'x)))
      (with 'x (id 'y) (id 'x)))
(test (subst 'x 10 (parse '{with {x y} x}))
      (parse '{with {x y} x}))

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

;; interp: F1WAE * [FunDef] -> num

(define (interp f1wae fundefs)
  (type-case F1WAE f1wae
    [num (n) n]
    [add (left right) (+ (interp left fundefs)
                         (interp right fundefs))]
    [sub (left right) (- (interp left fundefs)
                         (interp right fundefs))]
    [id (name) (error 'interp "unbound identifier")]
    [with (name expr body) 
      (interp (subst name
                     (interp expr fundefs)
                     body)
              fundefs)]
    [app (func arg)
         (local [(define fun (lookup-fundef func fundefs))]
           (interp (subst (fundef-param fun)
                          (interp arg fundefs)
                          (fundef-body fun))
                   fundefs))]))

(test (interp (num 5) (list))
      5)
(test (interp (add (num 8) (num 9)) (list))
      17)
(test (interp (sub (num 9) (num 8)) (list))
      1)
(test (interp (with 'x (add (num 1) (num 17))
                (add (id 'x) (num 12)))
              (list))
      30)
(test/exn (interp (id 'x) (list)) "unbound indentifier")
(test (interp (parse '{f {+ 5 5}})
              (list (fundef 'f 'x (parse '{+ x x}))))
      20)


