; this chapter will talk about some introductory notion about pl

; here is the first example
; function "looking" is a partial function  
; at the another end, total function has the property which make sure
; ther result can not be an undefined value(\perp in haskell)
(define (looking a lat)
  (keep-looking a (pick 1 lat) lat))

(define keep-looking
  (lambda (a sorn lat)
    (cond ((number? sorn) 
            (keep-looking a (pick sorn lat) lat))
          (else (eq? sorn a)))))

; here is another example of partial function
; and it is a most partial function
(define eternity
  (lambda (x)
    (eternity x)))

; the shift function takes a pair
; whose first component is a pair and builds a 
; pair by shifting the second part of the first component 
; into the second component
(define (shift pair)
  (build (first (first pair))
         (build (second (first pair))
                (second pair))))

; ackermann function is an example of total
(define A
  (lambda (n m)
    (cond ((zero? n) (1+ m))
          ((zero? m) (A (- n 1) 1))
          (else (A (- n 1)
                   (A n (- m 1)))))))

; here is an example of halting problem 
; suppose we can implement a function to check if a procedure will stop at a particulat time
; however, it is not the truth. there is a counter-example
(define (last-try)
  (lambda (x)
    (and (will-stop? last-try)
         (eternity x))))





