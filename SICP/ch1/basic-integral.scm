(define (integral f a b dx)
  (* (sum f 
		  (+ a (/ dx 2.0))
		  (lambda (x) (+ x dx))
		  b)
     dx))

(define (sum term a next b)
  (if (> a b)
      0
	  (+ (term a)
	     (sum term (next a) next b))))

(define (cube x) (* x x x))

(define (simpson f a b n)
  (define h (/ (- b a) n))
  (define (factor k)
    (cond ((or (= k 0) (= k n)) 1.0)
	      ((even? k) 2.0)
		  (else 4.0)))
  (* (/ h 3.0)
	 (sum (lambda (k) (* (f (+ a (* h k))) (factor k)))
	      0
	      (lambda (x) (+ x 1))
		  n)))

  
