;the list of list can be treated as a hierarchic structure.
;for example, object a = ((1 2) 3 4) can be constructed by：
(define a
  (cons (list 1 2) (list 3 4)))

;Note that this structure is recursive,
;so we can also treat it as a tree.
;now we can give an implementation of process count-leaves.
(define (count-leaves items)
  (cond ((null? items) 0)
        ((not (pair? items)) 1)
		(else (+ (count-leaves (car items))
		         (count-leaves (cdr items))))))
;note that the length of a list is not the same as the number of leaves.
