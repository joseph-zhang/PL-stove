;In exercise 2.18, we implement "reverse elements of a list"
(define (myreverse items)
  (if (null? (cdr items)) items
      (append (myreverse (cdr items))
                (list (car items)))))
;if we use it to reverse a list (or a tree) like x = ((1 2) (3 4))
(define x (list (list 1 2) (list 3 4)))
;we will get ((3 4) (1 2))

;now we can implement a similar reverse process by using high-level abstraction
;it can help us to reverse not only element of a list(this can be value or list)
;but also the subtree(a list) of that list.
				 
(define (deep-reverse items)
  (define (subp sub)
    (if (pair? sub) (deep-reverse sub)
	    sub))
  (reverse (map subp items)))