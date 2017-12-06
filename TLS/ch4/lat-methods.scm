; we know that a lat is a list of atoms
; here are some basic method for getting lat informations

(define (length-of-lat lat)
  (if (null? lat) 0
      (1+ (length-of-lat (cdr lat)))))

(define pick
  (lambda (n lat)
    (if (zero? (sub1 n)) (car lat)
        (pick (sub1 n) (cdr lat)))))

(define (rempick n lat)
  (if (zero? (sub1 n)) (cdr lat)
      (cons (car lat) (rempick (sub1 n) (cdr lat)))))

; filtering all numbers in a lat
(define (no-nums lat)
  (if (null? lat) '()
      (if (number? (car lat)) (no-nums (cdr lat)) 
          (cons (car lat) (no-nums (cdr lat))))))

(define (all-nums lat)
  (if (null? lat) '()
      (if (number? (car lat))
            (cons (car lat) (all-nums (cdr lat))) 
          (all-nums (cdr lat)))))
    
; eqan? check if the two atoms are equal
(define (eqan? a b)
  (cond ((and (number? a) (number? b)) (= a b)) 
        ((or (number? a) (number? b)) false) 
        (else (eq? a b))))
    
; occur counts the number of an atom appears in a lat
(define (occur a lat)
  (if (null? lat) 0
      (if (eq? a (car lat)) (1+ (occur a (cdr lat)))
          (occur a (cdr lat)))))


