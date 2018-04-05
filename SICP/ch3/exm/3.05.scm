#lang planet neil/sicp

; use previous monte-carlo method to implement integral
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trails-passed)
    (cond ((zero? trials-remaining)
             (/ trails-passed trials))
          ((experiment)
             (iter (- trials-remaining 1) (+ trails-passed 1)))
          (else
             (iter (- trials-remaining 1) trails-passed))))
  (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (experiment)
    (P (random-range x1 x2) (random-range y1 y2)))
  (monte-carlo trials experiment))

(define (random-range low high) 
  (let ((range (- high low))) 
    (+ low (random range)))) 

; --------------------------------------------- test code -----------------------------------------------------------
(define (P x y)
  (< (+ (expt (- x 5) 2)
        (expt (- y 7) 2))
     9))
; integral
(estimate-integral P 2 8 4 10 100)