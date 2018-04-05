;Note that the relationship and difference between list and cons is very important.
;consider results of two expression:
(define s1 (cons 1 2))

(define s2 (list 1 2))

;s1 must be (1 . 2) and s2 is (1 2)
;Then using method car and cdr to consider that.

(car s1) ;result=> 1
(cdr s1) ;result=> 2

(car s2) ;result=> 1
(cdr s2) ;result=> (2) 

;Thus we know that..
;the result of expression (list <a1> <a2> <a3> ... <an>)..
;is same as (cons <a1> (cons <a2> (cons <a3> (cons ... (cons <an> '()) ...)))) 

(define s3 (list 1 2 3 4))
(define s4 (cons 1 (cons 2 (cons 3 (cons 4 '())))) )