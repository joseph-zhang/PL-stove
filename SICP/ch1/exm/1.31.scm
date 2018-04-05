;main functions we want to implement.
(define (sum-recur f a next b )
  (if ( > a b) 0
      (+ (f a) 
	     (sum-recur f (next a) next b))))

(define (sum-iter f a next b)
  (define (iter x result)
     (if (> x b) result
	     (iter (next x) (+ result (f x)))))
  (iter a 0))

(define (product-recur f a next b)
  (if (> a b) 1
      (* (f a)
	     (product-recur f (next a) next b))))

(define (product-iter f a next b)
  (define (iter x result)
    (if (> x b) result
	    (iter (next x) (* result (f x)))))
  (iter a 1))

;testing function.
;this part is for testing.
(define (cube x) (* x x x))

(define (fact n)
  (product-iter (lambda (x) x)
                1
				(lambda (x) (+ x 1))
				n))

(define (pi-test n) ;iter-cycle is n
  (define (numer-fuc k)
    (cond ((= k 1) 2) 
	      ((even? k) (+ k 2))
		  (else (+ k 2))))
  (define (denom-fuc k)
    (if (even? k) (+ k 1)
	    (+ k 2)))
  (define (iter map-func a b)
    (product-iter map-func 
	              a
                  (lambda (x) (+ x 1))
				  b))
  (* 4 (exact->inexact (/ (iter numer-fuc 1 n)
                          (iter denom-fuc 1 n)))))

		 
		