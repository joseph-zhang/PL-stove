(define tolerance 0.00001)
(define dx 0.00001)

;The method to find fixed-point
(define (fixed-point f first-guess)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ((next-value (f guess)))
	  (if (close-enough? next-value guess)
	    next-value
	    (try next-value))))
  (try first-guess))

;The method to find sqrt by finding fixed-point of y \mapsto x/y
(define (fixed-sqrt x)
  (fixed-point (average-damp (lambda (y) (/ x y)))
               1.0))
		
;average-damp method to help the convergence		
(define (average-damp f)
  (lambda (x) (average x (f x))))
  
(define (average x y)
  (/ (+ x y) 2))

;definition of deriv, \mathrm{d}g(x) = \frac{g(x + \mathrm{d}x) - g(x)}{\mathrm{d}x}
(define (deriv g)
  (lambda (x) (/ (- (g (+ x dx)) (g x))
              dx)))

;transform to newton function f(x) = x - \frac{g(x)}{\mathrm{d} g(x)}
(define (newton-transform g)
  (lambda (x) (- x (/ (g x) ((deriv g) x)))))

;Newton method, using fixed-point method x \mapsto f(x)
(define (newton-method g guess)
  (fixed-point (newton-transform g) guess)) 

(define (newton-sqrt x)
  (newton-method (lambda (y) (- (square y) x)) 
                  1.0))  
