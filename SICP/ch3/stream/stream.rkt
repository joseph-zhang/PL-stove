; This file show the basic idea of stream.
; Stream is a kind of structure, represented as a kind of sequence.
; This sequence is not the same as normal table, but a delayed table
; so that we can use it to do lazy evaluation,
; it can even let us construct unlimited sequence like [1..] in Haskell.
; That is, we are going to implement lazy~~

; In Haskell, lazy is default, but how can we do that?
; give an example of prime summation
; 1). iteration
;(define (sum-primes a b)
;  (define (iter count acc)
;    (cond ((> count b) acc)
;          ((prime? count) (iter (+ 1 count) (+ acc count)))
;          (else (iter (+ count 1) acc))))
;  (iter a 0))

; 2). recursion 
;(define (sum-primes a b)
;  (accumulate +
;              0
;              (filter prime? (enumerate-interval a b))))

; the fact is that the second proc is not so effecive as the first one
; for it must construct the whole sequence before filter.

; However, the second one is more elegant (more fp) than the first one.
; Lazy evaluation can conbine their advantages better!
; The implementation of stream is constructing a kind of table with delay.

; some operators of delayed table
(define stream-null? null?)

(define the-empty-stream '())

(define (cons-stream a b)
  (cons a
        (delay b)))

(define (stream-ref s n)
  (if (= n 0) (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc s)
  (if (stream-null? s) the-empty-stream
      (cons-stream (proc (stream-car s))
                   (stream-map proc (stream-cdr s)))))

(define (stream-for-each proc s)
  (if (stream-null? s) 'done
      (begin (proc (stream-car s))
             (stream-for-each proc (stream-cdr s)))))

; basic operators
(define stream-car car)

(define (stream-cdr stream) (force (cdr stream)))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter pred (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))

; implement native-delay and force
(define (native-delay expression)
  (lambda ()
    (expression)))

(define (force delayed-obj)
  (delayed-obj))

; in fact, delay is memoric
(define (memo-proc proc)
  (let ((already-run? false)
        (result false))
    (lambda ()
      (if (not already-run?)
          (begin (set! result (proc))
                 (set! already-run? true)
                 result)
          result))))

(define (delay expression)
  (memo-proc (lambda () expression)))
