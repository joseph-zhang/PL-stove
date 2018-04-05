; some examples about nested mapping.

; folder: foldr		
(define (acc op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (acc op initial (cdr sequence)))))
		  
; the method to construct ordered pair between interval (i,j)
(define (enumer n)
  (foldr append '() 
    (map (lambda (i) 
	  (map (lambda (j) (list i j))(enumerate-to (- i 1))))
    (enumerate-to n))))	

; contruct enumerlist
(define (enumerate-to n)
  (define (iter result num)
    (if (> num n) result
	    (iter (append result (list num)) (+ num 1))))
  (iter '() 1))

(define (flatmap proc seq)
  (foldr append '() (map proc seq)))

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

; construct triple with pair
(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

;main process
(define (prime-sum-pairs n)
  (map make-pair-sum 
    (filter prime-sum? (enumer n))))
	
(define (smallest-divisor x)
  (find-divisor x 2))

(define (find-divisor x test-divisor)
  (cond ((> (square test-divisor) x) x)
        ((divides? test-divisor x) test-divisor)
		(else (find-divisor x (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? x)
  (= (smallest-divisor x) x))
