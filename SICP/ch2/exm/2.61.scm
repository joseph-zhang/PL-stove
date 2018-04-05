; solution for exercise 2.61
(define (st-adjoint-set x set)
(if (null? set) (list x)
  (let ((fstelement (car set)))
    (cond ((= x fstelement) set)
          ((< x fstelement) (cons x set)) 
          (else (cons fstelement (st-adjoint-set x (cdr set))))))))