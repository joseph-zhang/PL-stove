#lang racket
(require eopl)

; duple : Natural -> schemeVal -> (schemeVal)
(define duple
  (lambda (n x)
    (if (zero? n) '()
        (cons x (duple (- n 1) x)))))

; ------------- test code ---------------
(duple 3 3)
(duple 4 '(ha ha))
(duple 0 '(blah))