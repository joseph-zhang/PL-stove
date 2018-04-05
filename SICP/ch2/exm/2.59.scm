; a solution for exercise 2.59
(define (union-set set1 set2)
(if (null? set1) set2
    (union-set (cdr set1) (adjoint-set (car set1) set2))))