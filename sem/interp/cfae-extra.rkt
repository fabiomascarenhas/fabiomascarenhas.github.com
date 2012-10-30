#lang plai

;; CFAE = <num> | {+ <CFAE> <CFAE> } | {- <CFAE> <CFAE>}
;;       | {with {<id> <CFAE>} <CFAE>} | <id> | {<CFAE> CFAE}
;;       | {if0 <CFAE> <CFAE> <CFAE>} | {fun {<id>} <CFAE>}

(define-type CFAE
  [num (n number?)]
  [add (left CFAE?)
       (right CFAE?)]
  [sub (left CFAE?)
       (right CFAE?)]
  [id (name symbol?)]
  [if0  (cond CFAE?)
        (true_block CFAE?)
        (false_block CFAE?)]
  [app (func CFAE?)
       (arg CFAE?)]
  [fun (param symbol?)
       (body CFAE?)]
  [fix (func CFAE?)]
  [pair (first CFAE?)
        (second CFAE?)]
  [fst (pair CFAE?)]
  [snd (pair CFAE?)])

(define-type CFAE-Val
  [numV (n number?)]
  [clos (param symbol?)
        (body CFAE?)
        (env Env?)]
  [pairV (first CFAE-Val?)
         (second CFAE-Val?)])

(define-type Env
  [env-empty]
  [env-entry (name symbol?)
             (val CFAE-Val?)
             (next Env?)]
  [env-rec (name symbol?)
           (clos procedure?)
           (next Env?)])

;; parse: s-expr -> CFAE
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
     (parse `{{fun {,(first (second input))}
                   ,(third input)}
              ,(second (second input))})]
    [(and (= 4 (length input))
          (eq? (first input) 'if0))
     (if0 (parse (second input))
          (parse (third input))
          (parse (fourth input)))]
    [(and (= 3 (length input))
          (eq? (first input) 'fun))
     (foldr (lambda (name body) (fun name body))
            (parse (third input))
            (second input))]
    [(and (= 3 (length input))
          (eq? (first input) 'rec))
     (app (fun (first (second input))
               (parse (third input)))
          (fix (fun (first (second input))
                    (parse (second (second input))))))]
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

;; interp: CFAE -> CFAE-Val (num or clos)
(define (interp exp env)
  (type-case CFAE exp
    [num (n) (numV n)]
    [fun (param body) 
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

#|
(test (interp (num 5) (env-empty))
      (numV 5))
(test (interp (add (num 8) (num 9)) (env-empty))
      (numV 17))
(test (interp (sub (num 9) (num 8)) (env-empty))
      (numV 1))
(test (interp (parse '{with {x {+ 1 17}}
                            {+ x 12}}) (env-empty))
      (numV 30))
(test/exn (interp (id 'x) (env-empty)) "unbound identifier")

(test (interp (parse '{if0 0 1 2})
                (env-empty))
        (numV 1))
(test (interp (parse '{if0 1 1 2})
                (env-empty))
        (numV 2))

(test (interp (parse '{{fun {x} {+ x 12}}
                       {+ 1 17}}) (env-empty))
      (numV 30))

(test (interp (parse '{{fun {x}
                            {{fun {f}
                                  {+ {f 1}
                                     {{fun {x}
                                           {f 2}}
                                      3}}}
                             {fun {y} {+ x y}}}}
                       0}) (env-empty))
      (numV 3))
|#

(define MAP (parse '{fix {fun {map}
                              {fun {f l}
                                   {if0 l
                                        0
                                        {pair {f {first l}} {map f {rest l}}}}}}}))

(define (eval t)
  (interp (parse t) (env-entry 'map
                               (interp MAP (env-empty))
                               (env-empty))))

#|

; Usando fix
(eval '{{fix {fun {sum}
                 {fun {x}
                      {if0 x
                           0
                           {+ {sum {- x 1}} x}}}}} 5})

; sum sem o fix (repare no {sum sum})
(eval '{with {F {fun {sum}
                     {fun {x}
                          {if0 x
                               0
                               {+ {{sum sum} {- x 1}} x}}}}}
             {{F F} 5}})

; fazendo o with retornar a função sum e depois usando
(eval '{{with {F {fun {sum}
                      {fun {x}
                           {if0 x
                                0
                                {+ {{sum sum} {- x 1}} x}}}}}
              {F F}} 5})

;(eval '{{with {g {fun {sum}
;                      {fun {x}
;                           {if0 x
;                                0
;                                {+ {sum {- x 1}} x}}}}}
;        {with {F {fun {sum}
;                      {g {sum sum}}}}
;              {F F}}} 5})

; fatorando a parte específica de sum pra fora do "recursor"
; o fun em volta de {sum sum} é para não entrar em loop infinito
(eval '{{with {g {fun {sum}
                      {fun {x} {if0 x
                                    0
                                    {+ {sum {- x 1}} x}}}}}
              {with {F {fun {sum}
                            {g {fun {x} {{sum sum} x}}}
                            }}
                    {F F}}} 5})

; açúcar sintático do with
(eval '{{{fun {g}
              {with {F {fun {sum}
                            {g {fun {x} {{sum sum} x}}}
                            }}
                    {F F}}}
         {fun {sum}
              {fun {x} {if0 x
                            0
                            {+ {sum {- x 1}} x}}}}} 5})

; chamando a função anônima gerada no passo anterior de fix
(eval '{with {fix {fun {g}
                       {with {F {fun {sum}
                                     {g {fun {x} {{sum sum} x}}}
                                     }}
                             {F F}}}}
         {{fix {fun {sum}
                    {fun {x} {if0 x
                                  0
                                  {+ {sum {- x 1}} x}}}}} 5}})

; removendo o with de F via substituição
(eval '{with {fix {fun {g}
                       {{fun {sum}
                             {g {fun {x} {{sum sum} x}}}}
                        {fun {sum}
                             {g {fun {x} {{sum sum} x}}}}}}}
         {{fix {fun {sum}
                    {fun {x} {if0 x
                                  0
                                  {+ {sum {- x 1}} x}}}}} 5}})

; mudando os nomes para ficar igual ao fix derivado via
; {fun {x} {x x}}{fun {x} {x x}}
(eval '{with {fix {fun {f}
                       {{fun {x}
                             {f {fun {y} {{x x} y}}}}
                        {fun {x}
                             {f {fun {y} {{x x} y}}}}}}}
         {{fix {fun {sum}
                    {fun {x} {if0 x
                                  0
                                  {+ {sum {- x 1}} x}}}}} 5}})

; {{fun {x} {x x}} {fun {x} {x x}}}
;
; {fun {f}
;   {{fun {x} {f {x x}}}
;    {fun {x} {f {x x}}}}}
;
; {fun {f}
;    {{fun {x}
;          {f {fun {y} {{x x} y}}}}
;     {fun {x}
;          {f {fun {y} {{x x} y}}}}}}
;

|#