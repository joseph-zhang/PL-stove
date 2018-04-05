;first we consider the definition of those three list a,b,c 
;list a = (1 3 (5 7) 9)
(define a
  (list 1 3 (list 5 7) 9))
;list b = ((7))
(define b
  (list (list 7)))
;list c = (1 (2 (3 (4 (5 (6 7))))))
(define c
  (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
  
;then the method to get number 7 is easy.
;for list a:
(car (cdr (car (cdr (cdr a)))))
;for list b:
(car (car b))
;for list c:
(cadr (cadr (cadr (cadr (cadr (cadr c))))))