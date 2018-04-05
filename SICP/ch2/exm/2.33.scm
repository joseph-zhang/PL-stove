; this file will show a solution for exercise-2.33
; use "foldr" to implement basic list actions

; folder: foldr		
(define (acc op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (acc op initial (cdr sequence)))))
		  
; length of a list		  
(define (mylength sequence)
  (acc (lambda (x y) (+ y 1)) 0 sequence))
		  
; append method of list
(define (myappend seq1 seq2)
  (acc cons seq2 seq1))
  
; map method on list   
(define (mymap p sequence)
  (acc (lambda (x y) (cons (p x) y)) '() sequence))
  