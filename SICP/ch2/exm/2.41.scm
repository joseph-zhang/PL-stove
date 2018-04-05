; a simple solution fopr exercise 2.41

; folder: foldr		
(define (foldr op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (foldr op initial (cdr sequence)))))
		  
; flatmap method 
(define (flatmap proc seq)
  (foldr append '() (map proc seq)))
  
; the method to construct ordered pair between interval (i,j)
(define (enumerp n)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j)) (enumerate-to (- i 1))))  
    (enumerate-to n)))		  
	
; the method to construct ordered triad between interval (i,j)
(define (enumert n)
  (flatmap (lambda (i)
             (map (lambda (x) (cons i x)) (enumerp (- i 1))))  
    (enumerate-to n)))

; contruct enumerlist
(define (enumerate-to n)
  (define (iter result num)
    (if (> num n) result
	    (iter (append result (list num)) (+ num 1))))
  (iter '() 1))
 
; filter function
(define (sum-s? s tup)
  (define (sum-of-s tup)
    (+ (car tup) (cadr tup) (caddr tup)))
  (= s (sum-of-s tup)))

; main process
(define (construct-target s n)
  (filter (lambda (x) (sum-s? s x)) (enumert n)))