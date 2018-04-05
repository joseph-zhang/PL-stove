#lang planet neil/sicp

; here we are going to talk about the effect of introduction of assignment set!
; we know that the assignment action provide a easier method to simulate procedures with state
; however, this can be a big problem. A function with set! is not pure any more
; this means, the replacement mechanism will be lost, because those procedures are not mathematical
; problems of imperative style : referential transparency, the definition of same, parallel/concurrence ..
; now we implement the facorial fuction in both two styles

; imperative style
(define (factorial-imperative n)
  (let ((product 1)
        (counter 1))
    (define (iter)
      (if (> counter n) product
          (begin (set! product (* counter product)) ; here the order of assignment should be considered
                 (set! counter (+ counter 1))
                 (iter))))
    (iter)))

; recursion, bottom-up
(define factorial
  (lambda (n)
    (define (iter product counter)
      (if (> counter n) product
          (iter (* product counter)
                (+ counter 1))))
    (iter 1 1)))