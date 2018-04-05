;In this exercise, we are going to implement fringe process.
;the fringe process of a tree is just like dfs, constructing a list of leaves.
(define (fringe items)
  (define (subp sub result)
    (if (pair? sub)
	      (append (fringe (car sub)) (fringe (cadr sub)))
	    (append result (list sub))))  
  (subp items '()))
  
