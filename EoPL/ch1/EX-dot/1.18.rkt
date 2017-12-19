#lang racket
(require eopl)

; auxiliary procedure, currying
; swapper-exp : a -> b -> sexp -> sexp
(define swapper-exp
  (lambda (a)
    (lambda (b)
      (lambda (sexp)
        (if (symbol? sexp)
              (cond ((eq? sexp a) b)
                    ((eq? sexp b) a)
                    (else sexp)) 
            (swapper a b sexp))))))

; swapper : a -> b -> slist -> slist
(define swapper
  (lambda (a b slist)
    (if (null? slist) '()
        (map ((swapper-exp a) b) slist))))

; ------------------------ test code ------------------------
(swapper 'a 'd '(a b c d))
(swapper 'a 'd '(a d () c d))
(swapper 'x 'y '((x) y (z (x))))