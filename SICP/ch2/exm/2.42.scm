; N-Queen problem

; main process
(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0) (list empty-state)
	  (filter (lambda (positions) (safe? k positions)) 
	    (flatmap (lambda (rest-queens)
	               (map (lambda (new-row) (adjoin-position new-row rest-queens)) 
			  	     (enumerate-to board-size))) 
	    (queen-cols (- k 1))))))
  (queen-cols board-size))

; folder: foldr		
(define (foldr op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (foldr op initial (cdr sequence)))))
		  
; flatmap method 
(define (flatmap proc seq)
  (foldr append '() (map proc seq)))
  
; adjoin-position method
(define (adjoin-position adder target)
  (cons adder target))

; definition of empty state
(define empty-state '())

; checking
(define (safe? k sub-state)
  (safe-now? (car sub-state) (cdr sub-state)))
 
(define (safe-now? curpos spos)
  (define (iter cnt sub-spos)
    (if (null? sub-spos) true
	  (let ((adjoint-pos (car sub-spos)))
        (if (or (= curpos (+ cnt adjoint-pos))
	             (= curpos (- adjoint-pos cnt))
			     (= curpos adjoint-pos)) false
	        (iter (+ cnt 1) (cdr sub-spos)))) ))
  (iter 1 spos))  
  
; enumer
(define (enumerate-to n)
  (define (iter cnt result)
    (if (> cnt n) result
	    (iter (+ cnt 1) (append result (list cnt)))))
  (iter 1 '()))
 
