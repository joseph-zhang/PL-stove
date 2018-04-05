; Once there is an appointment in our program, we can use a powerful 
; abstract interface to control complexity of details.

; a simple implementation of filter.
; you can see these kinds of method in many functional PL,
; In Haskell, you can even use it on other structures, not only for list or sequence.
(define (filter predicate sequence)
  (cond ((null? sequence) '())
        ((predicate (car sequence))
		  (cons (car sequence)
		        (filter predicate (cdr sequence))))
		(else (filter predicate (cdr sequence)))))

; folder: foldr		
(define (acc op initial sequence)
  (if (null? sequence) initial
      (op (car sequence)
	      (acc op initial (cdr sequence)))))
		  
; enum on interval
(define (enum-interval low high)
  (if (> low high) '()
      (cons low (enum-interval (+ 1 low) high))))

; enum on tree (leaves)
(define (enum-leaves tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (list tree))
        (else (append (enum-leaves (car tree))
		              (enum-leaves (cdr tree))))))