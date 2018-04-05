;This file is a solution for exercise-2.4

(define (mycons x y)
  (lambda (m) (m x y)))

(define (mycar z)
  (z (lambda (p q) p)))

(define (mycdr z)
  (z (lambda (p q) q))) 

;This can be treated as another implementation of cons.
