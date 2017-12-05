; this file contains some useful list operation,
; most of them construct a new list by modifying old list. 

; change an atom in a list
(define subst-1
  (lambda (new old lat)
    (cond ((null? lat) '())
      (else (cond ((eq? old (car lat)) (cons new (cdr lat))) 
              (else (cons (car lat) (subst new old (cdr lat)))))))))
; a simplified version
(define (subst new old lat)
  (if (null? lat) '()
      (cond ((eq? old (car lat)) (cons new (cdr lat)))
            (else (cons (car lat) (subst new old (cdr lat)))))))

; replace either the first occurrence of o1 
; or the first occurrence of o2 by new
(define (subst-2 new o1 o2 lat)
  (if (null? lat) '()
      (cond ((eq? o1 (car lat)) (cons new (cdr lat))) 
            ((eq? o2 (car lat)) (cons new (cdr lat))) 
            (else (cons (car lat) (subst-2 new o1 o2 (cdr lat)))))))

; multirember for a list
(define (multirember x lat)
  (if (null? lat) '()
      (if (eq? x (car lat)) (multirember x (cdr lat)) 
          (cons (car lat) (multirember x (cdr lat))))))

; multi version for insert procedures
(define (multi-insertR new old lat)
  (if (null? lat) '()
      (if (eq? old (car lat)) 
            (cons old 
              (cons new 
                (multi-insertR new old (cdr lat)))) 
          (cons (car lat) (multi-insertR new old (cdr lat))))))
          
(define (multi-insertL new old lat)
  (if (null? lat) '()
      (if (eq? old (car lat))
            (cons new
              (cons old 
                (multi-insertL new old (cdr lat)))) 
          (cons (car lat) (multi-insertL new old (cdr lat))))))

