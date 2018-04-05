; use fold method to rewrite count-leaves 

; previous definition
(define (count-leaves tree)
  (cond ((null? tree) 0)
        ((not (pair? tree)) 1)
		(else (+ (count-leaves (car tree))
		         (count-leaves (cdr tree))))))

; use foldr to define it, just like what we did in scale-tree.
(define (count-leaves1 tree)
  (acc + 0 
         (map (lambda (sub-tree)
		        (if (pair? sub-tree)
				      (count-leaves sub-tree)
					1))
		   tree)))