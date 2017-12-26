#lang racket
(require eopl)

; the eopl provide two macro used for date type related procedure
; one is used for algebraic datatype define => (define-datatype)
; another is used for pattern matching => (cases)
; if you are familiar with Haskell or ML, these two methods are easy to understand


; the first example is lambda calculus expression,
; recalling the grammar
; LcExp ::= Identifier
;       ::= (lambda (Identifier) LcExp)
;       ::= (LcExp LcExp)

(define-datatype lc-exp lc-exp?
  (var-exp
    (var identifier?))
  (lambda-exp
    (bound-var identifier?)
    (body lc-exp?))
  (app-exp
    (rator lc-exp?)
    (rand lc-exp?)))

(define occurs-free?
  (lambda (search-var exp)
    (cases lc-exp exp
      (var-exp (var)
        (eqv? var search-var))
      (lambda-exp (bound-var body)
        (and (not (eqv? search-var bound-var))
             (occurs-free? search-var body)))
      (app-exp (rator rand)
        (or (occurs-free? search-var rator)
            (occurs-free? search-var rand))))))

; another example is very usual, as example of recursive data types
; S-list ::= ({S-exp}*)
; S-exp  ::= Symbol | S-list

(define-datatype s-list s-list?
  (empty-s-list)
  (non-empty-s-list
    (first s-exp?)
    (rest s-list?)))

(define-datatype s-exp s-exp?
  (symbol-s-exp
    (sym symbol?))
  (s-list-sexp
    (slst s-list?)))


