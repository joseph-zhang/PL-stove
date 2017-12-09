; this file will give some examples about basic FP thought 
; note that many of them rely on lambda

; in chapter5, a method named rember is implemented in two version
; the difference between them is just the choice of test methods, equal? or eq?
; using abstract method, it is obviously that the test methods can be passed as parameter.
; however, it is better to construct a mechanism, trying to produce different versions.

; now we give an example about currying.
; if we want to use eq? to check two objects(just atoms)  
(define (same? a x)
  (eq? a x))
; we write the two objects as parameters directly 
; it is interesting that the procedure can be written in another form
; it is also an example of closure
(define (eq-c? a)
  (lambda (x)
    (eq? a x)))
; throwing an atom in it will construct a new function
(define eq-salad? 
  (eq-c? 'salad))

; the method above show that we can construct higher-order functions
; now we can write a function naed rember-f 
(define (rember-f test?)
  (lambda (a l)
    (cond ((null? l) '())
          ((test? (car l) a) (cdr l))
          (else (cons (car l)
                      ((rember-f test?) a
                                        (cdr l)))))))

; then we can re-write previous methods
(define (rember-eq) (rember-f eq?))
(define (rember-equal) (rember-f equal?))

; use this method, we can write insertL-f or insertR-f easily
; hold on, astute as we should find that there is little difference between these two functions
; we don't want to rewrite the same block, just use abstraction like what we did on rember
(define (seqL new old l)
  (cons new (cons old l)))
(define (seqR new old l)
  (cons old (cons new l)))
; now write higher-order insert!!
(define (insert-g seq)
  (lambda (new old l)
    (cond ((null? l) '())
          ((eq? (car l) old)
            (seq new old (cdr l)))
          (else (cons (car l)
                      ((insert-g seq) new old
                        (cdr l)))))))
; then we can re-write previous methods
(define (insertL) (insert-g seqL))
(define (insertR) (insert-g seqR))