(define Y
  (lambda (f)
    ((lambda (x) (x x))
     (lambda (x)
       (f (lambda (y) ((x x) y)))))))

(define almost-len
  (lambda (f)
    (lambda (lst)
      (cond ((null? lst) 0)
            (else (1+ (f (cdr lst))))))))
  
(define len (Y almost-len))
