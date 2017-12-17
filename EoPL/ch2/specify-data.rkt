#lang racket
(require eopl)

; data abstraction is a powerful way
; the representation of data can be complex, and we often want to rewrite it
; the key point is, we must be able to locate all parts of a program that
; are dependent on the representation, the method is data abstraction
; a data type that is abstract in this way is said to be an abstract data type(ADT)

; this file contains an example about natural number abstraction
; the implementation of this type can be various
; but the interface is fixed, and we use these interface to construct higher level procedures

; plus : Natural -> Natural
(define plus
  (lambda (x y)
    (if (is-zero? x) y
        (successor (plus (predecessor x) y)))))

; we can find some interfaces are used in previous procedure
; is-zero?
; successor
; predecessor
; the representation(implementation) can be various
; exam. unary representation
(define zero (lambda () '()))
(define is-zero?
  (lambda (n) (null? n)))
(define successor
  (lambda (n)
    (cons #t n)))
(define predecessor
  (lambda (n)
    (cdr n)))

; obviously, the arithmetic representation
(define zero (lambda () 0))
(define is-zero?
  (lambda (n) (zero? n)))
(define successor
  (lambda (n) (+ n 1)))
(define predecessor
  (lambda (n) (- n 1)))