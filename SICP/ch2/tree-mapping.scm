;we have already implemented list-mapping processes.
;Then we sill find that the "map" high-level abstraction is
;also important in tree with recursion method.
(define x (list 1 (list 2 (list 3 4) 5) (list 6 7)))

;the tree scaling method with recursion.
(define (scale-tree1 tree factor)
  (cond ((null? tree) '())
        ((not (pair? tree)) (* factor tree))
		(else (cons (scale-tree1 (car tree) factor)
		            (scale-tree1 (cdr tree) factor)))))
					
;another implementation is using map.
;to use this method, we treat a tree as sequence of subtrees.
(define (scale-tree tree factor)
  (map (lambda (subtree)
         (if (pair? subtree) (scale-tree subtree factor)
		     (* subtree factor)))
	   tree))