#lang plai

;; The first line above is important. It tells DrRacket which
;;  variant of Racket you want to use. We use a variant that
;;  matches the textbook (even if the textbook calls the language
;;  "Scheme").

;; This is a comment that continues to the end of the line.
; One semi-colon is enough.

;; A common convention is to use two semi-colons for
;; multiple lines of comments, and a single semi-colon
;; when adding a comment on the same
;; line as code.

#| This is a block comment,
   which starts with "#|"
   and ends with a "|#". Block comments
   can be nested, which is why I can
   name the start and end tokens in this
   comment. |#

;; #; comments out a single form. We use #; below
;; to comment out error examples.
#;(/ 1 0)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Built-in atomic data

;; Booleans

true
false
#t ; another name for true, and the way it prints
#f ; ditto for false

;; Numbers

1
0.5
1/2  ; this is a literal fraction, not a division operation
1+2i ; complex number

;; Strings

"apple"
"banana cream pie"

;; Symbols

'apple
'banana-cream-pie
'a->b
'#%$^@*&?!

;; Characters (unlikely to be useful)

#\a
#\b
#\A
#\space  ; same as #\  (with a space after \)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Built-in functions on atomic data

not

+
-
* ; etc.

<
>
=
<=
>=

string-append
string=?
string-ref

eq?      ; mostly for symbols
equal?   ; most other things

char->integer
integer->char

number?
real?
symbol?
string?
char?

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Basic expression forms

;; Procedure application
;;  (<expr> <expr>*)

(not true)                ; => #f

(+ 1 2)                   ; => 3
(< 2 1)                   ; => #f
(= 1 1)                   ; => #t

(string-append "a" "b")   ; => "ab"
(string-ref "apple" 0)    ; => #\a

(eq? 'apple 'apple)       ; => #t
(eq? 'apple 'orange)      ; => #f
(eq? "apple" "apple")     ; => #f, probably

(equal? "apple" "apple")  ; => #t
(string=? "apple" "apple"); => #t

(char->integer #\a)       ; => 97
(integer->char 65)        ; => #\A

(empty? empty)            ; => #t

(number? empty)           ; => #f
(number? 12)              ; => #t
(real? 1+2i)              ; => #f

;; Conditionals
;;  (cond
;;    [<expr> <expr>]*)
;;  (cond
;;    [<expr> <expr>]*
;;    [else <expr>])

(cond                     ;
  [(< 2 1) 17]            ;
  [(> 2 1) 18])           ; => 18

(cond                     ; second expression not evaluated
  [true 8]                ;
  [false (* 'a 'b)])      ; => 8

(cond                     ; in fact, second test not evaluated
  [true 9]                ;
  [(+ 'a 'b) (* 'a 'b)])  ; => 9

(cond                     ; any number of cond-lines allowed
  [(< 3 1) 0]             ;
  [(< 3 2) 1]             ;
  [(< 3 3) 2]             ;
  [(< 3 4) 3])            ; => 3

(cond                     ; else allowed as last case
  [(eq? 'a 'b) 0]         ;
  [(eq? 'a 'c) 1]         ;
  [else 2])               ; => 2

(cond
  [(< 3 1) 1]
  [(< 3 2) 2])            ; => prints nothing

(void)                    ; => prints nothing

;; If
;;   (if <expr> <expr> <expr>)
  
(if (< 3 1)               ; simpler form for single test
    "apple"               ;
    "banana")             ; => "banana"

;; And and Or
;;  (and <expr>*)
;;  (or <expr>*)

(and true true)           ; => #t
(and true false)          ; => #f
(and (< 2 1) true)        ; => #f
(and (< 2 1) (+ 'a 'b))   ; => #f (second expression is not evaluated)

(or false true)           ; #t
(or false false)          ; #f
(or (< 1 2) (+ 'a 'b))    ; => #t (second expression is not evaluated)

(and true true true true) ; => #t
(or false false false)    ; => #f

(and true 1)              ; => 1, because only `false' is false

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Built-in compound data

;; Lists

empty                     ; => '()

(list 1 2 3)              ; => '(1 2 3)
(cons 0 (list 1 2 3))     ; => '(0 1 2 3)

(list 'a 'b)              ; => '(a b), because ' also distributes to elements

'1                        ; => 1, because numbers are self-quoting
'"a"                      ; => "a", ditto
(list "a" "b")            ; => '("a" "b")
'("a" "b")                ; => '("a" "b")
'((1 2) (3 4))            ; => (list (list 1 2) (list 3 4))

(cons 1 empty)            ; => '(1)
(cons 1 '())              ; => '(1)
(cons 'a (cons 2 empty))  ; => '(a 2)

(list 1 2 3 empty)        ; => '(1 2 3 ())

(append (list 1 2) empty) ; => '(1 2)
(append (list 1 2)
        (list 3 4))       ; => '(1 2 3 4)
(append (list 1 2)
        (list 'a 'b)
        (list true))      ; => '(1 2 a b #t)

(first (list 1 2 3))      ; => 1
(rest (list 1 2 3))       ; => '(2 3)
(first (rest (list 1 2))) ; => 2

(list-ref '(1 2 3) 2)     ; => 3

(cons 1 2)                ; => '(1 . 2), which is a non-list pair,
                          ;    and which you almost never want

;; Vectors

(vector 1 2 3 4)            ; => '#(1 2 3 4)
(vector-ref (vector 1 2) 0) ; => 1

; '#(...) creates a vector, and #(...) is self-quoting
'#(1 2)                   ; => '#(1 2)
#(1 (2 3))                ; => '#(1 (list 2 3))
#(a b)                    ; => '#(a b)

;; Boxes

(box 1)                   ; => '#&1
(unbox (box 1))           ; => 1

'#&1                      ; => '#&1
#&1                       ; => '#&1

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Definitions

;; Defining constants
;;  (define <id> <expr>)

(define PI 3.14159)
(* PI 10)                 ; => 31.4159

;; Defining functions
;;  (define (<id> <id>*) <expr>)

(define (circle-area r)
  (* PI r r))
(circle-area 10)          ; => 314.159

(define (is-odd? x)
  (if (zero? x)
      false
      (is-even? (- x 1))))
(define (is-even? x)
  (if (zero? x)
      true
      (is-odd? (- x 1))))
(is-odd? 12)              ; => #f

;; Defining datatypes
;;  (define-type <id>
;;    [<id> (<id> <expr>)*]*)

(define-type Animal
  [snake (name symbol?)
         (weight number?)
         (food symbol?)]
  [tiger (name symbol?)
         (stripe-count number?)])

(snake 'Slimey 10 'rats)  ; => (snake 'Slimey 10 'rats)
(tiger 'Tony 12)          ; => (tiger 'Tony 12)

(list (tiger 'Tony 12))   ; => (list (tiger 'Tony 12))
                          ;    since use of `tiger' cannot be quoted

#;(snake 10 'Slimey 5)    ; => error: 10 is not a symbol

(Animal? (snake 'Slimey 10 'rats)) ; => #t
(Animal? (tiger 'Tony 12)) ; => #t
(Animal? 10)               ; => #f

(snake-name (snake 'Slimey 10 'rats)) ; => 'Slimey
(tiger-name (tiger 'Tony 12)) ; => 'Tony

(snake? (snake 'Slimey 10 'rats)) ; => #t
(tiger? (snake 'Slimey 10 'rats)) ; => #f

;; A type can have any number of variants:
(define-type Shape
  [square (side number?)]
  [circle (radius number?)]
  [triangle (height number?)
            (width number?)])

(Shape? (triangle 10 12)) ; => #t

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Local binding forms

;; Local
;;  (local [<definition>*] <expr>)

(local [(define x 10)]
  (+ x x))                ; => 20

#;x                       ; => error: unbound identifier

(define (to-the-fourth x)
  (local [(define (squared n)
            (* n n))]
    (* (squared x) (squared x))))
(to-the-fourth 10)        ; => 10000

(local [(define (odd? x)
          (if (zero? x)
              false
              (even? (- x 1))))
        (define (even? x)
          (if (zero? x)
              true
              (odd? (- x 1))))]
  (odd? 12))              ; => #f

;; Let (more standard but less regular, so not used in this course)
;;  (let ([<id> <expr>]*) <expr>)

(let ([x 10]
      [y 11])
  (+ x y))                ; => 21

(let ([x 0])
  (let ([x 10]
        [y (+ x 1)])
    (+ x y)))             ; => 11

(let ([x 0])
  (let* ([x 10]
         [y (+ x 1)])
    (+ x y)))             ; => 21

;; Datatype case dispatch
;;  (type-case <id> <expr>
;;    [<id> (<id>*) <expr>]*)
;;  (type-case <id> <expr>
;;    [<id> (<id>*) <expr>]*
;;    [else <expr>])

(type-case Animal (snake 'Slimey 10 'rats)
  [snake (n w f) n]
  [tiger (n sc) n])      ; => 'Slimey

(define (animal-name a)
  (type-case Animal a
    [snake (n w f) n]
    [tiger (n sc) n]))

(animal-name (snake 'Slimey 10 'rats)) ; => 'Slimey
(animal-name (tiger 'Tony 12)) ; => 'Tony

#;(animal-name 10)        ; => error: 10 is not an Animal

#;(type-case Food ...)    ; => error: Food is not a defined type
  
#;(define (animal-weight a)
    (type-case Animal a
      [snake (n w f) w])) ; => error: missing tiger case
  
(define (animal-weight a)
  (type-case Animal a
    [snake (n w f) w]
    [else false]))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; First-class functions

;; Anonymous function:
;;  (lambda (<id>*) <expr>)

(lambda (x) (+ x 1))      ; => #<procedure>

((lambda (x) (+ x 1)) 10) ; => 11

(define add-one
  (lambda (x)
    (+ x 1)))
(add-one 10)              ; => 11

(define (make-adder n)
  (lambda (m)
    (+ m n)))
(make-adder 8)            ; => #<procedure>
(define add-five (make-adder 5))
(add-five 12)             ; => 17
((make-adder 5) 12)       ; => 17

(map (lambda (x) (* x x))
     '(1 2 3))            ; => (list 1 4 9)

(andmap (lambda (x) (< x 10))
        '(1 2 3))         ; => #t
(andmap (lambda (x) (< x 10))
        '(1 20 3))        ; => #f

(ormap (lambda (x) (< x 10))
       '(1 20 a))         ; => #t

;; The apply function may be useful eventually:

(define f (lambda (a b c) (+ a (- b c))))
(define l '(1 2 3))

#;(f l)                   ; => error: f expects 3 arguments
(apply f l)               ; => 0

;; apply is most useful with functions that accept any
;;  number of arguments:

(apply + '(1 2 3 4 5))    ; => 15

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Side-effects
;;  IMPORTANT: in this class using a side-effect is
;;             usually wrong; avoid all side-effects

;; set! and begin
;;  (set! <id> <expr>)
;;  (begin <expr>*)

(define count 0)

(set! count (+ count 1))  ; =>
count                     ; => 1

(begin
  (set! count (+ count 1))
  count)                  ; => 2

(local [(define x 0)]     ; note: demonstrates set! in local,
  (begin                  ;       but it's terrible style
    (set! x (list x))     ;
    (set! x (list x))     ;
    x))                   ; => '((0))

;; set-box! is a function:

(define B (box 10))
(set-box! B 12)           ; =>
B                         ; => '#&12
(unbox B)                 ; => 12

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Testing

;; test, test/pred, and test/exn functions:

(test (+ 5 5) 10)         ; => '(good 10 10 "...")
(test (+ 5 4) 10)         ; => '(bad 9 10 "...")

(test/pred (* 2 3) even?) ; => '(good 6 true "...")
(test/pred (* 3 3) even?) ; => '(bad 9 false "...")

(test/exn (+ 1 'a) "expects type <number>") ; => '(good ....)
(test/exn (+ 1 2) "expects type <number>")  ; => '(bad ....)
(test/exn (/ 1 0) "expects type <number>")  ; => '(bad ....)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; More information

;; Use the "Help Desk" item in DrRacket's "Help" menu
;;   See "Guide"
;;   and "Programming Languages: Application and Interpretation"
