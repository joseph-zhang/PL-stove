#lang racket
(require eopl)

; auxiliary procedure
; invert2-lists : 2-lists -> 2-lists
(define invert-2-lists
  (lambda (2lst)
    (let ((fst (car 2lst))
          (snd (cadr 2lst)))
      (list snd fst))))


; invert : (2-lists) -> (2-lists)
(define invert
  (lambda (lst)
    (map invert-2-lists lst)))

; ------------------------ test code ---------------------------
(invert '((a 1) (a 2) (1 b) (2 b)))