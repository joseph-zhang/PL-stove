#lang planet neil/sicp

; accumulator system, like what we have implemented in file bank-simulation
(define make-accumulator
  (lambda (money)
    (lambda (amount)
      (set! money (+ money amount))
      money)))

; -------------------------- test code ----------------------------------
(define A (make-accumulator 5))
(A 10)
(A 20)