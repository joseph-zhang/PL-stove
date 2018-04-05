; this file is a soulution for exercise 2.45
; it is also used in "pattern-language" 

; it is obvious that the parameter is our two directions process
(define (split d1 d2)
  (define (sub-split painter n)
    (if (= n 0) painter 
        (let ((smaller (sub-split painter (- n 1))))
          (d1 painter (d2 smaller smaller)))))
  sub-split)

; use "split" process to redefine them 
(define (right-split-new painter n)
  (split beside below))
(define (up-split-new painter n)
  (split below beside))