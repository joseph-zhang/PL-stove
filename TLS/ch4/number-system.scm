; this file will show a number system 
; note that the operands should be natural number

(define add1 1+)
(define sub1
  (lambda (x) (- x 1)))

; plus operation  
(define (plus m n)
  (if (zero? n) m
      (plus (add1 m) (sub1 n))))

; sub operation
(define (sub m n)
  (if (zero? n) m
      (sub (sub1 m) (sub1 n))))

; add up total list
(define (addtup lst) 
  (if (null? lst) 0
      (plus (car lst) (addtup (cdr lst)))))

; multiplication 
(define (multi m n)
  (if (zero? n) 0
      (plus m (multi m (sub1 n)))))

; add tups up one by one
(define (tup+ tup1 tup2)
  (cond ((null? tup1) tup2)
        ((null? tup2) tup1)
        (else (cons (plus (car tup1) (car tup2))
                    (tup+ (cdr tup1) (cdr tup2))))))

; partial order
(define (bigger-than? m n)
  (cond ((zero? m) false)
        ((zero? n) true)
        (else (bigger-than? (sub1 m) (sub1 n)))))

(define (less-than? m n)
  (cond ((zero? n) false)
        ((zero? m) true)
        (else (less-than? (sub1 m) (sub1 n)))))

(define (equal-to? m n)
  (cond ((bigger-than? m n) false)
        ((less-than? m n) false)
        (else true)))

; expt procedure
(define (power base expo)
  (if (zero? expo) 1
      (multi base (power base (sub1 expo)))))

; quotient procedure 
(define (div m n)
  (if (less-than? m n) 0
      (add1 (div (sub m n) n))))


