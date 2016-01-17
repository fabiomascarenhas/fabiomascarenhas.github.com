#lang plai

;; AE = <num> | {+ <AE> <AE> } | {- <AE> <AE>}

(define-type AE
  [num (n number?)]
  [add (left AE?)
       (right AE?)]
  [sub (left AE?)
       (right AE?)])

;; parse: s-expr -> AE
;; (parse '{+ 3 4}) -> (add (num 3) (num 4))

(define (parse input)
  (cond
    [(number? input) (num input)]
    [(and (= 3 (length input))
          (eq? (first input) '+))
     (add (parse (second input))
          (parse (third input)))]
    [(and (= 3 (length input))
          (eq? (first input) '-))
     (sub (parse (second input))
          (parse (third input)))]
    [else (error 'parse "syntax error")]))

(test (parse '1) (num 1))
(test (parse '{+ 1 2}) (add (num 1) (num 2)))
(test (parse '{+ {- 5 2} {+ 2 1}}) (add (sub (num 5) (num 2))
                                        (add (num 2) (num 1))))

;; interp: AE -> num

(define (interp ae)
  (type-case AE ae
    [num (n) n]
    [add (left right) (+ (interp left)
                         (interp right))]
    [sub (left right) (- (interp left)
                         (interp right))]))

(test (interp (num 1)) 1)
(test (interp (add (num 1) (num 2))) 3)
(test (interp (parse '{+ 1 1})) 2)
(test (interp (parse '{- 4 1})) 3)
