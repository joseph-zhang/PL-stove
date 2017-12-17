#lang racket
(require eopl)

; from the previous subsection, it is clear that
; the "follow the grammar" recipe is powerful
; however, some procedures are extending context-free
; in these circumstances, the auxiliary procedures are needed

; auxiliary procedure for main procedure number-elements(auxiliary procedure)
; the parameter n tells us the position of the sub list(context argument)
; number-elements-from : (SchemeVal) -> Int -> ((Int,SchemeVal))
(define number-elements-from
  (lambda (lst n)
    (if (null? lst) '()
        (cons (list n (car lst))
              (number-elements-from (cdr lst) (+ n 1))))))
; number-elements : (SchemeVal) -> ((Int,SchemeVal))
(define number-elements
  (lambda (lst)
    (number-elements-from lst 0)))

; another example
; list-sum : (Int) -> Int
(define list-sum
  (lambda (lst)
    (if (null? lst) 0
        (+ (car lst)
           (list-sum (cdr lst))))))

; however, some structures cannot be decomposed, just like vector
; here, we need context arguments
; note that we use [a] to sign VectorOf(a)
; partial-vector-sum : [Int] -> Int -> Int
(define partial-vector-sum
  (lambda (vec n)
    (if (zero? n)
          (vector-ref vec 0)
        (+ (vector-ref vec n)
           (partial-vector-sum vec (- n 1))))))
; vector-sum : [Int] -> Int
(define vector-sum
  (lambda (vec)
    (let ((len (vector-length vec)))
      (if (zero? len) 0
          (partial-vector-sum vec (- len 1))))))