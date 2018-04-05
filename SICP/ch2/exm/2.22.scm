;we can find that the implementation in 2.21 is a recursion,
;but Louis Reasoner wanted to rewrite it as a recursive one.
;Here's his work:
(define (square-list1 items)
  (define (iter things answer)
    (if (null? things) answer
	    (iter (cdr things) 
		      (cons (square (car things)) answer))))
  (iter items '()))
;if we have a list a:
(define a (list 1 2 3 4 5))
;and we input it in his process like (square-list1 a),
;we will absolutely get (25 16 9 4 1), which is the reversion of what we want. 

;Then he corrected his work as:
(define (square-list2 items)
  (define (iter things answer)
    (if (null? things) answer
	    (iter (cdr things)
	          (cons answer 
			        (square (car things))))))
  (iter items '()))
;then input list a in it,
;we will get (((((() . 1) . 4) . 9) . 16) . 25)
;which is not we want either.

;We can help him to do this
;there are many methods to implement this.
;a easy method is pre-reverse
(define (square-list items)
  (square-list1 (reverse items)))