; this file is a soulution for exercise 2.44
; it is also used in "pattern-language" 

; up-split process
(define (up-split painter n)
  (if (= n 0) painter 
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller))))) 