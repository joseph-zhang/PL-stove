; use flodr and foldl to implement reverse  

; fold method: foldl
(define (foldl op init sequence)
  (define (iter result rest)
    (if (null? rest) result
	    (iter (op result (car rest))
		      (cdr rest))))
  (iter init sequence))
  
; fold method: foldr
(define (foldr op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (foldr op initial (cdr sequence)))))

; use foldr to implement reverse process 
(define (myreverse seq)
  (foldr (lambda (x y) (append y (list x)))
    '() seq))

;use foldl to implement reverse process
(define (myreverse-p seq)
  (foldl (lambda (x y) (cons y x)) 
    '() seq))
