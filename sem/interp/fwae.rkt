#lang plai

;; FWAE = <num> | {+ <FWAE> <FWAE> } | {- <FWAE> <FWAE>}
;;       | {with {<id> <FWAE>} <FWAE>} | <id> | {<FWAE> FWAE}
;;       | {if0 <FWAE> <FWAE> <FWAE>} | {fun {<id>} <FWAE>}

(define-type FWAE
  [num (n number?)]
  [add (left FWAE?)
       (right FWAE?)]
  [sub (left FWAE?)
       (right FWAE?)]
  [id (name symbol?)]
  [with (name symbol?)
        (expr FWAE?)
        (body FWAE?)]
  [if0  (cond FWAE?)
        (true_block FWAE?)
        (false_block FWAE?)]
  [app (func FWAE?)
       (arg FWAE?)]
  [fun (param symbol?)
       (body FWAE?)]
  [clos (param symbol?)
        (body FWAE?)])

;; parse: s-expr -> FWAE
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
    [(= 2 (length input))
     (app (parse (first input))
          (parse (second input)))]
    [(and (= 4 (length input))
          (eq? (first input) 'if0))
     (if0 (parse (second input))
          (parse (third input))
          (parse (fourth input)))]
    [(and (= 3 (length input))
          (eq? (first input) 'fun)
          (= 1 (length (second input)))
          (symbol? (first (second input))))
     (fun (first (second input))
          (parse (third input)))]
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

(test (parse '{fun {x} x}) (fun 'x (id 'x)))
(test (parse '{1 2}) (app (num 1) (num 2)))

;; subst: symbol * FWAE-Val * FWAE -> FWAE
(define (subst name val exp)
  (type-case FWAE exp
    [num (n) exp]
    [add (left right) (add (subst name val left)
                           (subst name val right))]
    [sub (left right) (sub (subst name val left)
                           (subst name val right))]
    [id (name-id) (if (symbol=? name name-id)
                      val
                      (id name-id))]
    [with (name-def expr body)
          (with name-def
                (subst name val expr)
                (if (symbol=? name name-def)
                    body
                    (subst name val body)))]
    [if0 (cond true_block false_block)
         (if0
          (subst name val cond)
          (subst name val true_block)
          (subst name val false_block))]
    [app (func arg)
         (app (subst name val func)  
              (subst name val arg))]
    [fun (param body)
         (fun param
              (if (symbol=? name param)
                  body
                  (subst name val body)))]
    [clos (param body) exp]))

(test (subst 'x (num 19) (parse '{+ 1 {f x}}))
      (parse '{+ 1 {f 19}}))
(test (subst 'x (num 10) (add (num 1) (id 'x)))
      (add (num 1) (num 10)))
(test (subst 'x (num 10) (id 'x))
      (num 10))
(test (subst 'x (num 10) (id 'y))
      (id 'y))
(test (subst 'y (num 10) (sub (id 'x) (num 1)))
      (sub (id 'x) (num 1)))

(test (subst 'x (num 10) (with 'y (num 17) (id 'x)))
      (with 'y (num 17) (num 10)))
(test (subst 'x (num 10) (with 'y (id 'x) (id 'y)))
      (with 'y (num 10) (id 'y)))
(test (subst 'x (num 10) (with 'x (id 'y) (id 'x)))
      (with 'x (id 'y) (id 'x)))
(test (subst 'x (num 10) (parse '{with {x y} x}))
      (parse '{with {x y} x}))

;; interp: FWAE -> FWAE-Val

(define (interp exp)
  (type-case FWAE exp
    [num (n) exp]
    [clos (param body) exp]
    [fun (param body) 
         (clos param body)]
    [add (left right) (num (+ (num-n (interp left))
                              (num-n (interp right))))]
    [sub (left right) (num (- (num-n (interp left))
                              (num-n (interp right))))]
    [id (name) (error 'interp "unbound identifier")]
    [with (name expr body) 
      (interp (subst name
                     (interp expr)
                     body))]
    [if0 (cond true_block false_block)
         (if
           (= 0 (num-n (interp cond)))
           (interp true_block)
           (interp false_block))]
    [app (func arg)
         (local [(define clos (interp func))]
           (interp (subst (clos-param clos)
                          (interp arg)
                          (clos-body clos))))]))

(test (interp (num 5))
      (num 5))
(test (interp (add (num 8) (num 9)))
      (num 17))
(test (interp (sub (num 9) (num 8)))
      (num 1))
(test (interp (with 'x (add (num 1) (num 17))
                (add (id 'x) (num 12)))
              )
      (num 30))
(test/exn (interp (id 'x)) "unbound identifier")

(test (interp (parse '{if0 0 1 2})
                )
        (num 1))
(test (interp (parse '{if0 1 1 2})
                )
        (num 2))

(test (interp (parse '{{fun {x} {+ x 12}}
                       {+ 1 17}}))
      (num 30))

(test (interp (parse '{{fun {x}
                            {{fun {f}
                                  {+ {f 1}
                                     {{fun {x}
                                           {f 2}}
                                      3}}}
                             {fun {y} {+ x y}}}}
                       0}))
      (num 3))

