; a solution for exercise 2.51
; the first definition is also implemented in "painter-frame" file
(define (below painter1 painter2)
(let ((split-point (make-vect 0.0 0.5)) 
  (let ((paint-up 
          (transform-painter painter2 
                             split-point
                             (make-vect 1.0 0.5)
                             (make-vect 0.0 1.0))) 
        (paint-down 
          (transform-painter painter1 
                             (make-vect 0.0 0.0)
                             (make-vect 1.0 0.0)
                             split-point))) 
    (lambda (frame)
      (paint-up frame)
      (paint-down frame))))))

; another method is using rotate process and beside
(define (new-below painter1 painter2) 
    (rotate90 (beside (rotate270 painter1) (rotate270 painter2)))) 