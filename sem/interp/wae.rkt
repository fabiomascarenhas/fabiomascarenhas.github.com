#lang plai

;; WAE = <num> | {+ <WAE> <WAE> } | {- <WAE> <WAE>}
;;       | {with {<id> <WAE>} <WAE>} | <id>

(define-type WAE
  [num (n number?)]
  [add (left WAE?)
       (right WAE?)]
  [sub (left WAE?)
       (right WAE?)]
  [id (name symbol?)]
  [with (name symbol?)
        (expr WAE?)
        (body WAE?)])

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
  (type-case WAE wae
    [num (n) (num n)]
    [add (left right) (add (subst name val left)
                           (subst name val right))]
    [sub (left right) (sub (subst name val left)
                           (subst name val right))]
    [id (name-id) (if (symbol=? name name-id)
                      (num val) ;; para lazy -> val
                      (id name-id))]
    [with (name-def expr body)
          (with name-def
                (subst name val expr)
                (if (symbol=? name name-def)
                    body
                    (subst name val body)))]))

(test (subst 'x 10 (add (num 1) (id 'x)))
      (add (num 1) (num 10)))
(test (subst 'x 10 (id 'x))
      (num 10))
(test (subst 'x 10 (id 'y))
      (id 'y))
(test (subst 'y 10 (sub (id 'x) (num 1)))
      (sub (id 'x) (num 1)))

(test (subst 'x 10  (with 'y (num 17) (id 'x)))
      (with 'y (num 17) (num 10)))
(test (subst 'x 10 (with 'y (id 'x) (id 'y)))
      (with 'y (num 10) (id 'y)))
(test (subst 'x 10 (with 'x (id 'y) (id 'x)))
      (with 'x (id 'y) (id 'x)))
(test (subst 'x 10 (parse '{with {x y} x}))
      (parse '{with {x y} x}))

;; interp: WAE -> num

(define (interp wae)
  (type-case WAE wae
    [num (n) n]
    [add (left right) (+ (interp left)
                         (interp right))]
    [sub (left right) (- (interp left)
                         (interp right))]
    [id (name) (error 'interp "unbound identifier")]
    [with (name expr body) 
          (interp (subst name
                         (interp expr) ; para lazy -> expr
                         body))]))

(test (interp (num 5))
      5)
(test (interp (add (num 8) (num 9)))
      17)
(test (interp (sub (num 9) (num 8)))
      1)
(test (interp (with 'x (add (num 1) (num 17))
                (add (id 'x) (num 12))))
      30)
(test/exn (interp (id 'x)) "unbound identifier")
