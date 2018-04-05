;advanced process, repeating a function n times
(define (repeated f n)
  (if (= n 1) 
      f
	  (compose (repeated f (- n 1)) f)))

(define (compose f g)
  (lambda(x) (f (g x))))

(define (inc x)
  (+ x 1))

;the value is 5^4 = 625, which is square(square(5)) = {5^2}^2  
((repeated square 2) 5)
