#lang planet neil/sicp

; in last chapter, all of our functions are pure, hence the data construction is based on "creation"
; once the set! action is brought, we can use it to change an existing data object to another one, which is, alteration-data
; those actions contain : set-car!, set-cdr! ..

; this is different from function append, because the first list is changed
(define (append! x y)
  (set-cdr! (last-pair x) y) x)

(define (last-pair x)
  (if (null? (cdr x)) x
      (last-pair (cdr x))))

; example in ex. 3.13
; construct eternity
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

; the example of sharing
(define x '(a b))
(define z1 (cons x x))
(define z2 (cons '(a b) '(a b)))

; to describe the behavior of alteration data, all we need is assignment
; in previous chapter, we know that the cons method can be implemented purely as function
(define (cons-1 x y)
  (define (dispatch m)
    (cond ((eqv? m 'car-1) x)
          ((eqv? m 'cdr-1) y)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)

(define (car-1 z) (z 'car-1))
(define (cdr-1 z) (z 'cdr-1))

; once we treat this structure as alteration data, set! method should be defined
(define (cons-a x y)
  (define (set-x! v) (set! x v))
  (define (set-y! v) (set! y v))
  (define (dispatch m)
    (cond ((eqv? m 'car-a) x)
          ((eqv? m 'cdr-a) y)
          ((eqv? m 'set-car-a!) set-x!)
          ((eqv? m 'set-cdr-a!) set-y!)
          (else (error "Undefined operation -- CONS" m))))
  dispatch)

(define (car-a z) (z  'car-a))
(define (cdr-a z) (z 'cdr-a))
(define (set-car-a! z x)
  ((z 'set-car-a!) x)
  z)
(define (set-cdr-a! z x)
  ((z 'set-cdr-a!) x)
  z)
; --------------------------------------------- test code ------------------------------------------------------

; test append!
(define lst1 '(a b c))
(define lst2 '(k k k))
(begin (append! lst1 lst2) lst1 lst2)

; test ex. 3.13
(define z (make-cycle '(a b c)))

; test sharing
(set-car! x 'c)
(begin z1 z2)