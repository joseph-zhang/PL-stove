;This file give a few operations of list.
;Though most of these operation have already included in MIT-scm.

;list reference method
(define (mylist-ref items n)
  (if (= n 0) (car items)
    (mylist-ref (cdr items) (- n 1))))

;get list length(recursion)
(define (mylength1 items)
  (if (null? items) 0
    (+ 1 (mylength1 (cdr items)))))

;get list length(recursive)
(define (mylength2 items)
  (define (length-iter subitems cnt)
    (if (null? subitems) cnt
	  (length-iter (cdr subitems) (+ 1 cnt))))
  (length-iter items 0))
 
;append method, connect list2 at the tail of list1
(define (myappend list1 list2)
  (if (null? list1) list2
    (cons (car list1)
	  (myappend (cdr list1) list2))))

;get last element of list(naive method)
(define (last-pair1 items)
  (if (= 1 (length items)) (car items)
    (last-pair1 (cdr items))))

;get last element of list(more efficient)
(define (last-pair items)
  (define (last-iter subitems cnt)
    (if (= 1 cnt)(car subitems)
	  (last-iter (cdr subitems) (- cnt 1))))
  (last-iter items (length items)))
  
;reverse elements of a list
(define (myreverse items)
  (define (subrev subitems cnt)
    (if (<= cnt 1) subitems
	  (append  
	    (subrev (cdr subitems) (- cnt 1))
		(list (car subitems)))))
  (subrev items (length items)))
