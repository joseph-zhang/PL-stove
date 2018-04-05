;a simple implementation of for-each high-level abstraction.
(define (for-each proc items)
  (define (iter subitems val)
    (if (null? subitems) val
	    (iter (cdr subitems)
		      (or (proc (car subitems)) val))))
  (iter items false))

;here is an example
(for-each (lambda (x) (newline) (display x))
  (list 1 2 3 4))
;another interesting example
(for-each odd? '())