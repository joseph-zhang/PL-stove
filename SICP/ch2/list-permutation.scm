; permutation method

; fold: foldr
(define (foldr op init seq)
  (if (null? seq) init
      (op (car seq)
	      (foldr op init (cdr seq))))) 
		  
; flatmap : mapping then append
(define (flatmap proc seq)
  (foldr append '() (map proc seq)))

; main process 
(define (permutations seq)
  (if (null? seq) (list '())
      (flatmap (lambda (x) 
	             (map (lambda (p) (cons x p)) 
				   (permutations (remove x seq)))) 
	           seq)))

; remove value from a list. Actually, construct a new list
(define (remove val seq)
  (filter (lambda (x) (not (= x val))) 
          seq))