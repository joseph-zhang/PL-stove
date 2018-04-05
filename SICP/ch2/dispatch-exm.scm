;this is an example of dispatch method
;it shows the relation between data type and process

;construct function 
(define (my-cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
	      ((= m 1) y)
		  (else (error "argument cannot be matched!" m))))
  dispatch)

;select function
(define (my-car z) (z 0))
(define (my-cdr z) (z 1))

;This kind of programming style is called message passing.

  
