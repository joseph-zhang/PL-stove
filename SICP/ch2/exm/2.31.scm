;another implementation based on exercise 2.30
;in this file, process square-tree has definition as this:
(define (square-tree tree)
  (tree-map square tree))

;we just need an abstract process "tree-map" to do tree mapping.
(define (tree-map proc tree)
  (map (lambda (subtree)
         (if (pair? subtree) (tree-map proc subtree)
		     (proc subtree)))
	   tree))
