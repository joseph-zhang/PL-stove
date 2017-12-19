#lang racket
(require eopl)

; just use map method
(define down
  (lambda (lst)
    (map list lst)))

; -------------------- test code -------------------------
(down '(1 2 3))
(down '((a) (fine) (idea)))
(down '(a (more (complicated)) object))