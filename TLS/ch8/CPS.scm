; this file will give a little idea about CPS
; that is, continuation passing style

; first, let's see a block of code
(define multirember-co
  (lambda (a lat col)
    (cond ((null? lat)
            (col '() '()))
          ((eq? a (car lat))
            (multirember-co a (cdr lat)
              (lambda (newlat seen)
                (col newlat
                     (cons (car lat) seen)))))
          (else 
            (multirember-co a (cdr lat)
              (lambda (newlat seen)
                (col (cons (car lat) newlat) 
                     seen)))))))

; helper function
(define a-friend
  (lambda (x y)
    (null? y)))

; it's complicated, analysing step by step,
; note that the parameter like col is sometimes called "continuation"
; call (multirember-co 'tuna '() a-friend)
(multirember-co 'tuna '() a-friend)
; obviously, the result iss #t
; because (a-friend '() '()) is true

; then, call (multirember-co 'tuna '(tuna) a-friend)
(multirember-co 'tuna (list 'tuna) a-friend)
; just like
(define new-friend
  (lambda (newlat seen)
    (a-friend newlat
              (cons 'tuna seen))))
(multirember-co 'tuna '() new-friend)   
; the result is #f
; because (afriend '() '(tuna)) is false

; the if call (nultirember-co 'tuna '(and tuna) a-friend)
; the result is #f 
; actually, the last call is 
(a-friend '(and) '(tuna))

; now we can find what multirember-co do
; the atoms in lat which is not eq? to a are collected in lst1
; other atoms will be collected in lst2
; finally, it determines the value (helper lst1 lst2) 

; now realling the procedure multirember
(define (multirember x lat)
  (if (null? lat) '()
      (if (eq? x (car lat))
            (multirember x (cdr lat)) 
          (cons (car lat)
                (multirember x (cdr lat))))))

; compare it to multirember-co, then
; the CPS style is appeared!

