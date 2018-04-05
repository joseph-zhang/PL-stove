; a simple language for graph
; this is an example for showing the power of data abstraction and **closure**

; a painter can draw a picture, like "Mona Lisa" or other something.
; we cannot compile this file because we need a frame to draw these pictures.
; suppose we have some basic processes (in a particular graph frame, perhaps)
; <below>
; <beside>
; <flip-vert>
; <flip-horiz>
; there are many patterns which can be constructed easily by using composition.
; after composition process, the result is also a painter. => closure

; composition example 
(define (flipped-pairs painter)
  (let ((painter2 (beside painter (flip-vert painter)))) 
    (below painter2 painter2)))
	
; recursion examples 
(define (right-split painter n)
  (if (= n 0) painter
      (let ((smaller (right-split painter (- n 1))))
      (beside painter (below smaller smaller)))))
      
; new pattern to draw a picture recursively 
(define (corner-split painter n)
  (let ((up (up-split painter (- n 1)))
        (right (right-split painter (- n 1))))
    (let ((bottom-right (below right right)) 
	        (top-left (besides up up))
		      (corner (corner-split painter (- n 1))))
      (beside (below painter top-left) (below bottom-right corner)))))

; conpose those process to construct a new pattern 
(define (square-limit painter n)
  (let ((quater (corner-split painter (- n 1))))
    (let ((half (beside (flip-vert quater) quater)))
      (below (flip-vert half) half))))

; up-split process, also defined in exercise 2.44
(define (up-split painter n)
  (if (= n 0) painter 
      (let ((smaller (up-split painter (- n 1))))
        (below painter (beside smaller smaller))))) 

; abstraction on process "flip-pairs" and "square-limit" 
(define (square-of-four tl tr bl br)
  (lambda (painter)
    (let ((top (beside ((tl painter) (tr painter))))
          (bottom (beside ((bl painter) (br painter)))))
      (below bottom top))))

; use "square-of-four" to redefine them
(define (flipped-pairs-new painter)
  (square-of-four identity flip-vert identity flip-vert))
(define (square-limit painter n)
  (let ((combine4 (square-of-four flip-horiz 
                   identity rotate180 flip-vert)))
    (combine4 (corner-split painter n))))

; split pattern, also defined in exercise 2.45
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

