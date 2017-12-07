; this file contains dipper versions of previous procedures
; they can deal with nested lat, which are named as star methods 

(define (rember* a lat)
  (cond ((null? lat) '())
        ((atom? (car lat))
          (cond ((eq? a (car lat)) (rember* a (cdr lat)))
            (else (cons (car lat) (rember* a (cdr lat))))))
    (else (cons (rember* a (car lat))
                (rember* a (cdr lat))))))

(define (insertR* new old lat)
  (if (null? lat) '()
    (let ((fst (car lat))
          (resi (cdr lat)))
      (if (atom? fst) 
            (if (eq? old fst)
                  (cons old
                        (cons new 
                              (insertR* new old resi)))
              (cons fst (insertR* new old resi)))
        (cons (insertR* new old fst)
              (insertR* new old resi))))))

(define (occur* a lat)
  (if (null? lat) 0
    (let ((fst (car lat))
          (resi (cdr lat)))
      (if (atom? fst)
            (if (eq? a fst)
                  (1+ (occur* a resi))
              (occur* a resi))
        (+ (occur* a fst)
           (occur* a resi))))))

(define (member*? a lat)
  (if (null? lat) false
    (let ((fst (car lat))
          (resi (cdr lat)))
      (if (atom? fst)
            (if (eq? fst a) true
              (member*? a resi))
        (or (member*? a fst)
            (member*? a resi))))))

(define (leftmost lat)
  (if (null? lat)
        (error "the imput list is empty -- EMPTY" lat)
    (if (atom? (car lat)) (car lat)
      (leftmost (car lat)))))

; check if two lists are equal to each other     
(define (eqlist? lst1 lst2)
  (cond ((and (null? lst1) (null? lst2)) true)
        ((or (null? lst1) (null? lst2)) false)
        ((and (atom? (car lst1)) (atom? (car lst2)))
          (and (eqan? (car lst1) (car lst2))
               (eqlist? (cdr lst1) (cdr lst2))))
        ((or (atom? (car lst1)) (atom? (car lst2))) false)
    (else (and (eqlist? (car lst1) (car lst2))
               (eqlist? (cdr lst1) (cdr lst2))))))

; use thses eq-like methods to define equal? 
; equal? check if two s-expressions are same.
(define (equal? s1 s2)
  (cond ((and (atom? s1) (atom? s2))
          (eqan? s1 s2))
        ((or (atom? s1) (atom? s2)) false)
    (else (eqlist? s1 s2))))

