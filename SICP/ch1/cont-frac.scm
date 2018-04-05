;recursion method
(define (cont-frac n d k)
  (define (recur i)
    (if (= i k) (/ (n k) (d k))
	    (/ (n i) (+ (d i) (recur (+ i 1))))))
  (recur 1))
 
 
;iteration method
(define (cont-frac n d k)
  (define (iter i result)
    (if (= i 0) result
	    (iter (- i 1)
		      (/ (n i) (+ (d i) result)))))
  (iter (- k 1)
        (/ (n k) (d k))))
  
(define (test k)
  (cont-frac (lambda (i) 1.0)
             (lambda (i) 1.0)
			 k))