#lang planet neil/sicp

; the assignment operation give us a method to simulates the calculations
; which accompany the state => newstate-var = op state-var
; this method let us constrct a procedure with a better modularity

; just write (rand) to create random number successively
; just like (update-random (update-random x)) ...
; this block of code in sicp just show the mechanism of inner state 
;  (define rand
;    (let ((x random-init))
;      (lambda ()
;        (set! x (random-update x))
;        x)))
; actually, we should use the procedure random

(define (rand)
  (random 4294967087))

(define (estimate-pi trials)
  (sqrt (/ 6 (monte-carlo trials cesaro-test))))

(define (cesaro-test)
  (= (gcd (rand) (rand)) 1))

; monte-carlo method
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trails-passed)
    (cond ((zero? trials-remaining)
             (/ trails-passed trials))
          ((experiment)
             (iter (- trials-remaining 1) (+ trails-passed 1)))
          (else
             (iter (- trials-remaining 1) trails-passed))))
  (iter trials 0))

;---------------------------------------- test code ----------------------------------------
(estimate-pi 50000)