#lang planet neil/sicp

; solution for ex. 3.08
; procedure f is not a pure function
(define f
  (let ((inner '()))
    (lambda (x)
      (if (null? inner)
            (begin (set! inner x) inner)
          0))))

; ------------------------ test code --------------------------
(+ (f 0) (f 1))