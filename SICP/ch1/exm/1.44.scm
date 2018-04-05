(define (repeated f n)
  (if (= n 1) 
      f
	  (compose (repeated f (- n 1)) f)))

(define (compose f g)
  (lambda(x) (f (g x))))
  
(define (average3 a b c)
  (/ 3 (+ a b c)))

(define (smooth f dx)
  (lambda (x) (average3 ((f (- x dx))
                         (f x) 
						 (f (+ x dx))))))