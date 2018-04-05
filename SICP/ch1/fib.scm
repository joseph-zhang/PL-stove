(define (fib1 n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
		(else (+ (fib1 (- n 1)) (fib1 (- n 2))))))
		
		
(define (fib2 n)
  (fib-iter 0 1 n))
(define (fib-iter a b count)
  (if (= count 0) 
      a
	  (fib-iter b (+ a b) (- count 1))))