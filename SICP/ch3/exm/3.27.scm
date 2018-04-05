#lang racket
(require (planet neil/sicp))
(require "./3.26.scm")

; this exercise show the mechanism of memoization
; recalling the previous recursion definition of fib
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

; recursive definition will run very costly, however we can modify it by using iteration
(define (iter-fib n)
  (define (iter t pre1 pre2)
    (cond  ((= t 0) pre1)
           ((= t 1) pre2)
           (else (iter (- t 1)
                       pre2
                       (+ pre1 pre2)))))
  (iter n 0 1))

; mediator of memoization
(define (memoize f)
  (let ((table (make-table)))
    (lambda (n)
      (let ((preRes (lookup n table)))
        (if preRes (cdr preRes)
            (let ((res (f n)))
              (insert! n res table)
              res))))))

; using memoization is another method
; this kind of method need not to design iteration, but push a recursive procedure in a mediator to produce a new function
(define memo-fib
  (memoize (lambda (n) ; just a recursive define
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))

