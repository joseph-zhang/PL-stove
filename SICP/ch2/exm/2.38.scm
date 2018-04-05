; this file is about the method of fold.
; we have implemented the method foldr, now we are going to implement fordl.

; iteration method 
(define (foldl op init sequence)
  (define (iter result rest)
    (if (null? rest) result
	    (iter (op result (car rest))
		      (cdr rest))))
  (iter init sequence))
  
; now rename acc as flodr
(define (foldr op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (foldr op initial (cdr sequence)))))
		  
; some examples
(foldr / 1 (list 1 2 3)) ; (/ (/ 3 2) 1) = 3/2
(foldl / 1 (list 1 2 3)) ; (/ (/ 1 2) 3) = 1/6
(foldl list '() (list 1 2 3)) ; (((() 1) 2) 3)

; when op has property: " a op b = b op a ", which means, monoid.