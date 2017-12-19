#lang racket
(require eopl)

; Cartesian product of two symbol sets
; this kind of set is called set of symbols(sos)

; Auxiliary procedure, just like cons, but currying
; bind : a -> b -> pair
(define bind
  (lambda (a)
    (lambda (b)
      (list a b))))

; currying map
; apply-list : list -> func -> list
(define apply-list
  (lambda (lst)
    (lambda (func)
      (map func lst))))

; product : sos -> sos -> (pair)
(define product
  (lambda (sos1 sos2)
    (let ((func-list (map bind sos1))
          (applied-list (apply-list sos2)))
      (foldr append
             '()
             (map applied-list func-list)))))

; -------------------------------- test code -------------------------------
(product '(a b c) '(x y))