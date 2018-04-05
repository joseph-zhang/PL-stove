;the definition of square-tree can be implemented as what we did for scale-tree
;the first version is native recursion.
(define (square-tree tree)
  (cond ((null? tree) '()) 
        ((not (pair? tree)) (square tree))
		(else (cons (square-tree (car tree))
		            (square-tree (cdr tree))))))

;In another version, we use map.
(define (square-tree tree)
  (map (lambda (subtree) 
         (if (pair? subtree) (square-tree subtree)
		     (square subtree)))
	   tree))