#lang racket
(require (planet neil/sicp))

; Since the notion of stream has been introduced,
; there is an abstraction shield between inner representation and usage.
; That is, we can use an object just as it has been constructed completely.
; This kind of mechanism even let us to create infinite!

;; example: N+ stream
;; note that integers is just a cons obj(pair)
(define (integers-starting-from n)
  (cons-stream n (integers-starting-from (+ n 1))))

(define integers (integers-starting-from 1))

;; example: prime stream
;; algorithm: Eeatosthese's sieve
(define (sieve stream)
  (cons-stream
   (stream-car stream)
   (sieve (stream-filter 
          (lambda (x)
            (not (divisible? x
                             (stream-car stream))))
          (stream-cdr stream)))))

(define primes (sieve (integers-starting-from 2)))


; another method is to define a stream implicitly, just like recursion.
;; example: infinite ones
(define ones (cons-stream 1 ones))

;; example: N+ stream
(define (add-stream s1 s2)
  (stream-map + s1 s2))

(define integers (cons-stream 1 (add-stream ones integers)))

;; example: fib number
(define fibs
  (cons-stream 0
               (cons-stream 1
                            (add-stream (stream-cdr fibs)
                                        fibs))))

;; another useful function to help us define a stream like previous is scale-stream
(define (scale-stream stream factor)
  (stream-map (lambda (x) (* x factor)) stream))

;; example: another method to define a prime stream
;; rely on the fact: p_{n+1} \leq p_n^2
(define primes
  (cons-stream 2
               (stream-filter prime? (integers-starting-from 3))))

(define (prime? n)
  (define (iter prime-stream)
    (cond ((> (square (stream-car prime-stream)) n) true)
          ((divisible? n (stream-car prime-stream)) false)
          (else (iter (stream-cdr prime-stream)))))
  (iter primes))
