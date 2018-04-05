;reverse elements of a list(recursion)
(define (myreverse items)
  (if (null? (cdr items)) items
      (append (myreverse (cdr items))
                (list (car items)))))

;iterative version
(define (myreverse items)
  (define (iter subitems result)
    (if (null? subitems) result
	    (iter (cdr subitems)
		      (cons (car subitems) result))))
  (iter items '()))
  