;In this file we will implement a process to construct a list,
;which is made up of the subsets of a given set.
;(as we know, a set can be seen as a list)  
(define (subsets s)
  (if (null? s) (list '())
      (let ((rest (subsets (cdr s))))
	       (append rest (map (lambda (val) 
		                       (cons (car s) val))		
				             rest)))))