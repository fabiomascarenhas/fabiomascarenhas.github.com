#lang plai

;; TCFAE = <num> | {+ <TCFAE> <TCFAE> } | {- <TCFAE> <TCFAE>}
;;       | {with {<id> <TCFAE>} <TCFAE>} | <id> | {<TCFAE> TCFAE}
;;       | {if0 <TCFAE> <TCFAE> <TCFAE>} | {fun {<id>} <TCFAE>}

(define-type TYPE
  [numT]
  [funT (left TYPE?)
        (right TYPE?)]
  [pairT (left TYPE?)
         (right TYPE?)])

(define-type TCFAE
  [num (n number?)]
  [add (left TCFAE?)
       (right TCFAE?)]
  [sub (left TCFAE?)
       (right TCFAE?)]
  [id (name symbol?)]
  [if0  (cond TCFAE?)
        (true_block TCFAE?)
        (false_block TCFAE?)]
  [app (func TCFAE?)
       (arg TCFAE?)]
  [fun (ptype TYPE?)
       (param symbol?)
       (body TCFAE?)]
  [fix (func TCFAE?)]
  [pair (first TCFAE?)
        (second TCFAE?)]
  [fst (pair TCFAE?)]
  [snd (pair TCFAE?)])

(define-type TCFAE-Val
  [numV (n number?)]
  [clos (param symbol?)
        (body TCFAE?)
        (env Env?)]
  [pairV (first TCFAE-Val?)
         (second TCFAE-Val?)])

(define-type Env
  [env-empty]
  [env-entry (name symbol?)
             (val TCFAE-Val?)
             (next Env?)]
  [env-rec (name symbol?)
           (clos procedure?)
           (next Env?)])

;; parse: s-expr -> TCFAE
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
    [(and (= 4 (length input))
          (eq? (first input) 'if0))
     (if0 (parse (second input))
          (parse (third input))
          (parse (fourth input)))]
    [(eq? (first input) 'fun)
     (foldr (lambda (name body)
              (fun (parse-type (second name)) (first name) body))
            (parse (last input))
            (drop-right (rest input) 1))]
    [(and (= 3 (length input))
          (eq? (first input) 'rec))
     (local [(define func (parse (second (second input))))
             (define name (first (second input)))
             (define exp (parse (third input)))
             (define type (funT (fun-ptype func)
                                (parse-type (third (second input)))))]
       (app (fun type name exp)
            (fix (fun type name func))))]
    [(and (= 2 (length input))
          (eq? (first input) 'fix))
     (fix (parse (second input)))]
    [(eq? (first input) 'pair)
     (pair (parse (second input))
           (parse (third input)))]
    [(eq? (first input) 'first)
     (fst (parse (second input)))]
    [(eq? (first input) 'rest)
     (snd (parse (second input)))]
    [(eq? (first input) 'list)
     (foldr pair (num 0) (map parse (rest input)))]
    [else
     (foldl (lambda (arg func) (app func arg))
            (parse (first input))
            (map parse (rest input)))]))

(define (parse-type t)
  (cond
    [(eq? t 'num)
     (numT)]
    [(eq? (first t) 'fun)
     (funT (parse-type (second t))
           (parse-type (third t)))]
;    [(eq? (first t) 'list)
;     (listT (parse-type (second t)))]
    [(eq? (first t) 'pair)
     (pairT (parse-type (second t))
            (parse-type (third t)))]))

;(test (parse '1) (num 1))
;(test (parse '{+ 1 2}) (add (num 1) (num 2)))
;(test (parse '{+ {- 5 2} {+ 2 1}}) (add (sub (num 5) (num 2))
;                                        (add (num 2) (num 1))))
;(test (parse 'x) (id 'x))
;(test (parse '{with {x {+ 1 2}} {- x 8}})
;      (with 'x (add (num 1) (num 2))
;        (sub (id 'x) (num 8))))
;
;(test (parse '{if0 0 0 0}) (if0
;                            (num 0)
;                            (num 0)
;                            (num 0)))
;
;(test (parse '{if0 {- 1 1} {+ 0 0} {+ 0 0}}) (if0 
;                                              (sub (num 1) (num 1)) 
;                                              (add (num 0) (num 0)) 
;                                              (add (num 0) (num 0))))
;
;(test (parse '{fun {x} x}) (fun 'x (id 'x)))
;(test (parse '{1 2}) (app (num 1) (num 2)))

(define (lookup-env name env)
  (type-case Env env
    [env-empty () (error 'interp "unbound identifier ~a" name)]
    [env-entry (id val next) (if (symbol=? id name)
                                 val
                                 (lookup-env name next))]
    [env-rec (id box next) (if (symbol=? id name)
                               (box)
                               (lookup-env name next))])) 


(define-type TEnv
  [tenv-empty]
  [tenv-entry (id symbol?)
              (type TYPE?)
              (env TEnv?)])

(define (lookup-type name env)
  (type-case TEnv env
    [tenv-empty () (error 'typecheck "variável livre no programa")]
    [tenv-entry (id type next)
                (if (symbol=? id name)
                    type
                    (lookup-type name next))]))

;; typecheck: TCFAE x TEnv -> TYPE
(define (typecheck exp env)
  (type-case TCFAE exp
    [num (n) (numT)]
    [fun (ptype param body)
         (funT ptype (typecheck body (tenv-entry param ptype env)))]
    [add (left right)
         (local ([define tleft (typecheck left env)]
                 [define tright (typecheck right env)])
           (if (and (equal? tleft (numT))
                    (equal? tright (numT)))
               (numT)
               (error 'typecheck "tipo errado na soma")))]
    [sub (left right)
         (local ([define tleft (typecheck left env)]
                 [define tright (typecheck right env)])
           (if (and (numT? tleft)
                    (numT? tright))
               (numT)
               (error 'typecheck "tipo errado na soma")))]
    [if0 (cond then else)
         (local ([define tcond (typecheck cond env)]
                 [define tthen (typecheck then env)]
                 [define telse (typecheck else env)])
           (if (and (numT? tcond)
                    (equal? tthen telse))
               tthen
               (error 'typecheck "tipo errado no if0")))]
    [app (left right)
         (local ([define tleft (typecheck left env)]
                 [define tright (typecheck right env)])
           (if (and (funT? tleft)
                    (equal? (funT-left tleft) tright))
               (funT-right tleft)
               (error 'typecheck "tipo errado na aplicação")))]
    [id (name) (lookup-type name env)]
    [pair (left right)
          (pairT (typecheck left env)
                 (typecheck right env))]
    [fst (p)
         (let ((tp (typecheck p env)))
           (if (pairT? tp)
               (pairT-left tp)
               (error 'typecheck "tipo errado no first")))]
    [snd (p)
         (let ((tp (typecheck p env)))
           (if (pairT? tp)
               (pairT-right tp)
               (error 'typecheck "tipo errado no rest")))]
    [fix (func)
         (let ((tfix (typecheck (fun-body func)
                                (tenv-entry (fun-param func)
                                            (fun-ptype func)
                                            env))))
           (if (equal? tfix (fun-ptype func))
               tfix
               (error 'typecheck "tipo errado no fix")))]))

;; interp: TCFAE -> TCFAE-Val (num or clos)
(define (interp exp env)
  (type-case TCFAE exp
    [num (n) (numV n)]
    [fun (ptype param body) 
         (clos param body env)]
    [add (left right) (numV (+ (numV-n (interp left env))
                               (numV-n (interp right env))))]
    [sub (left right) (numV (- (numV-n (interp left env))
                               (numV-n (interp right env))))]
    [pair (fst snd) (pairV (interp fst env)
                           (interp snd env))]
    [fst (pair) (pairV-first (interp pair env))]
    [snd (pair) (pairV-second (interp pair env))]
    [id (name) (lookup-env name env)]
    [if0 (cond true_block false_block)
         (let [(n (interp cond env))]
           (if
            (and (numV? n) (= 0 (numV-n n)))
            (interp true_block env)
            (interp false_block env)))]
    [app (func arg)
         (local [(define clos (interp func env))]
           (interp (clos-body clos)
                   (env-entry (clos-param clos)
                              (interp arg env)
                              (clos-env clos))))]
    [fix (func)
         (local [(define newenv (env-rec (fun-param func)
                                         (lambda () closure)
                                         env))
                 (define closure (interp (fun-body func) newenv))]
           closure)]))

#|(define MAP (parse '{fix {fun {map}
                              {fun {f l}
                                   {if0 l
                                        0
                                        {pair {f {first l}} {map f {rest l}}}}}}}))

(define (teval t)
  (interp (parse t) (env-entry 'map
                               (interp MAP (env-empty))
                               (env-empty))))

|#

(define (teval t)
  (tc t)
  (interp (parse t) (env-empty)))

(define (tc t)
  (typecheck (parse t) (tenv-empty)))

(test (interp (num 5) (env-empty))
      (numV 5))
(test (interp (add (num 8) (num 9)) (env-empty))
      (numV 17))
(test (interp (sub (num 9) (num 8)) (env-empty))
      (numV 1))
(test (interp (parse '{if0 0 1 2})
                (env-empty))
        (numV 1))
(test (interp (parse '{if0 1 1 2})
                (env-empty))
        (numV 2))

(test (interp (parse '{{fun {x num} {+ x 12}}
                       {+ 1 17}}) (env-empty))
      (numV 30))

(teval '{{fun {x num} {y num} {+ x y}} 2 3})

(teval '{rec {sum {fun {x num}
                       {if0 x
                            x
                            {+ x {sum {- x 1}}}}} num}
          {sum 5}})

#|
(define MAP '{rec {map {fun {f {fun num num}}
                            {l {list num}}
                            {if0 l
                                 {nil num}
                                 {pair {f {first l}} {map f {rest l}}}}}} {list num}
               map})

(define CONCAT '{rec {concat {fun {l1 {list num}}
                                  {l2 {list num}}
                                  {if0 l1
                                       l2
                                       {pair {first l1} {concat {rest l1} l2}}}} {list num}}
                  concat})

(define FLATTEN '{rec {flatten {fun {l {list {list num}}}
                                    {if0 l
                                         l
                                         {concat {first l}
                                                 {flatten {rest l}}}}} {list num}}
                   flatten})
(define (meval t)
  (interp (parse t) (env-entry 'flatten
                               (teval FLATTEN)
                               (env-entry 'concat
                                          (teval CONCAT)
                                          (env-entry 'map
                                                     (teval MAP)
                                                     (env-empty))))))

(meval '{map {fun {x num} {+ x x}} {pair 1 {pair 2 {pair 3 {nil num}}}}})

(meval '{flatten {pair {pair 1 {pair 2 {nil num}}}
                       {pair {pair 3 {pair 4 {nil num}}}
                             {pair {pair 5 {pair 6 {nil num}}}
                                   {nil {list num}}}}}})

|#
