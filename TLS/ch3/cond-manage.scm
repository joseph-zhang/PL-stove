; this chapter show some examples about cond and cons
; As before, the book give a detailed explain  

; remover an atom from a lat
(define rember
  (lambda (x lat)
    (cond ((null? lat) '()) 
          ((eq? x (car lat)) (cdr lat))
          (else (cons (car lat)
                      (rember x (cdr lat)))))))

; here we use cons to build a list, as the second commandment
; of course, we have been familiar with it in SICP.

; then, the book gives a func named firsts, which builds another list 
; composed of the first s-expression of each internal list.
; note that, "if" is better in those (cond (<exps>) (else <exp>)) 
(define firsts 
  (lambda (lst)
    (cond ((null? lst) '())
          (else (cons (caar lst) 
                      (firsts (cdr lst)))))))
        
; the procedure insertR builds a lat with new 
; inserted to the right of the first occurrence of old 
(define insertR
  (lambda (new old lat) 
    (if (null? lat) '()
      (cond ((eq? old (car lat)) (cons old
                                       (cons new (cdr lat)))) 
            (else (cons (car lat)
                  (insertR new old (cdr lat))))))))
        
; the procedure insertR builds a lat with new 
; inserted to the left of the first occurrence of old  
(define insertL
    (lambda (new old lat) 
      (if (null? lat) '()
        (cond ((eq? old (car lat)) (cons new
                                         (cons old (cdr lat)))) 
              (else (cons (car lat)
                    (insertL new old (cdr lat))))))))
