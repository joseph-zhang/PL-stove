; this file will show an implementation of Horner rule

; folder: foldr		
(define (acc op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (acc op initial (cdr sequence)))))
		  
; main process
(define (horner-eval x coefficient-sequence)
  (acc (lambda (this-coeff higher-terms) (+ (* higher-terms x) this-coeff))
         0
		 coefficient-sequence))