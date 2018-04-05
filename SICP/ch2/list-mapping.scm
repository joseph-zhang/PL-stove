;a noraml thought is do an action on a list,
;an example, scaling a list. 
(define (scale-list items factor)
  (if (null? items) '()
    (cons (* (car items) factor) 
	  (scale-list (cdr items) factor))))

;This can be expressed as high-level abstraction,
;by using "map" high-level structure.
(define (scale-list1 items factor)
  (map (lambda (x) (* x factor))
    items))

;"map" is very important, it construct a high-level abstraction to process list,  
;Here I'll implement a mimic map method, note that it is incomplete compare with inner map implement. 
(define (mymap proc items)
  (if (null? items) '()
    (cons (proc (car items))
	  (mymap proc (cdr items)))))

