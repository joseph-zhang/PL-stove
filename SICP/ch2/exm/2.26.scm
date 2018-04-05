;this exercise help us find out the actions effect on tree
;first we define x and y
(define x (list 1 2 3))
(define y (list 4 5 6))

;if we act these on x and y, we will get 
;append action, result: (1 2 3 4 5 6)
(append x y)

;cons action, result:((1 2 3) 4 5 6)
(cons x y)

;list construction, result: ((1 2 3) (4 5 6))
(list x y)