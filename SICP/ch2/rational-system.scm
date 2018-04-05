;a rational system

;construct function;
;parameters: numer and denom
(define (make-rat n d)
  (cons n d))
;select function
(define (denom x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (cdr x) g)))
(define (numer x)
  (let ((g (gcd (car x) (cdr x))))
    (/ (car x) g)))
;print method
(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))
;addition function
(define (add-rat x y)
  (make-rat
    (+ (* (numer x) (denom y))
	   (* (numer y) (denom x)))
	(* (denom x) (denom y))))
	
(define (sub-rat x y)
  (make-rat
    (- (* (numer x) (denom y))
	   (* (numer y) (denom x)))
	(* (denom x) (denom y))))

(define (reciprocal x)
  (make-rat (denom x) (numer x)))
  
(define (mul-rat x y)
  (make-rat
    (* (numer x) (numer y))
	(* (denom x) (denom y))))

(define (div-rat x y)
  (mul-rat x (reciprocal y)))
 
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

	 