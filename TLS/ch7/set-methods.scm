; this file contains some methods of set structure
; the set here is define as mathematics' notion

(define (member? a lat)
  (cond ((null? lat) false) 
        ((equal? a (car lat)) true) 
        (else (member? a (cdr lat)))))

; if a set?
(define (set? lat)
  (cond ((null? lat) true)
        ((member? (car lat) (cdr lat)) false)
        (else (set? (cdr lat)))))

; make a set from a lat
(define (makeset lat)
  (cond ((null? lat) '())
        ((member? (car lat) (cdr lat))
          (makeset (cdr lat)))
        (else (cons (car lat)
                (makeset (cdr lat))))))

; subset? check if the first set is a subset of the second one
(define (subset? set1 set2)
  (if (null? set1) true
    (and (member? (car set1) set2)
         (subset? (cdr set1) set2))))

; eqset? check if two set are equal to each other
(define (eqset? set1 set2)
  (and (subset? set1 set2)
       (subset? set2 set1)))
    
; intersect? check if there is an element in both two sets
(define (intersect? set1 set2)
  (cond ((null? set1) false)
        ((member? (car set1) set2) true)
        (else (intersect? (cdr set1) set2))))

; now implement intersect
; get intersection of two sets
(define (intersect set1 set2)
  (cond ((null? set1) '())
        ((member? (car set1) set2)
          (cons (car set1)
                (intersect (cdr set1) set2)))
        (else (intersect (cdr set1) set2))))

; union of two sets
(define (union set1 set2)
  (makeset (append set1 set2)))
