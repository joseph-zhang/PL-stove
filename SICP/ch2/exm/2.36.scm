; a simple solution for 2.36

; folder: foldr		
(define (acc op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (acc op initial (cdr sequence)))))
		  
; the key method is map
(define (acc-n op init seqs)
  (if (null? (car seqs)) '() 
      (cons (acc op init (map car seqs))
	        (acc-n op init (map cdr seqs)))))

