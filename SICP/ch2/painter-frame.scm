; a frame for painter mode
; can be treated as a simple vector frame

; a frame is described by using three vectors: base vector and two direction vectors,
; from the thought of data abstraction, we have a construct process and some selection processes.
; <make-frame>
; <origin-frame>
; <edge1-frame>
; <edge2-frame>
; we should also define a process, mapping the unit square to the frame.
; the formula is : Origin(frame) + x \cdot Edge1(frame) + y \cdot  Edge2(frame) 
(define (frame-coord-map frame)
  (lambda (v)
    (add-vect (origin-frame frame)
	          (add-vect (scale-vect (xcor-vect v) (edge1-frame frame))
			            (scale-vect (ycor-vect v) (edge2-frame frame))))))

; the data abstraction for vector
; vector construction, use 'cons' instaed of list.
(define (make-vect xcor ycor)
  (cons xcor ycor))
  
; vector selection processes 
(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

; some useful processes for vector
; also implemented in exercise 2.46
(define (vect-comb f vect1 vect2)
  ((make-vect (f (xcor-vect vect1) (xcor-vect vect2))
              (f (ycor-vect vect1) (ycor-vect vect2)))))

(define (scale-vect factor vect)
  (make-vect (* factor (xcor-vect)
             (* factor (ycor-vect)))))

(define (add-vect vect1 vect2)
  (vect-comb + vect1 vect2))
  
(define (sub-vect vect1 vect2)
  (vect-comb - vect1 vect2))

; implementation for frame structure
; also implemented in exercise 2.47
(define(make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

; painter is abstracted as a process
; use process "draw-line" to construct a painter 
(define (segments->painter segment-list)
  (lambda (frame) 
    (for-each (lambda (segment)
	            (draw-line
				  ((frame-coord-map frame) (start-segment segment)) 
				  ((frame-coord-map frame) (end-segment segment))))
    segment-list)))

; an definition of segment structure
; a segment can be defined by two vectors
; also implemented in exercise 2.48
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

; closure of painter 
; composition and transformation
(define (transform-painter painter origin corner1 corner2)
  (lambda (frame) 
    (let ((m (frame-coord-map frame))) 
      (let ((new-origin (m origin))) 
        (painter (make-frame new-origin 
                             (sub-vect (m corner1) new-origin)
                             (sub-vect (m corner2) new-origin)))))))

; method to flip a painter                             
(define (flip-vert painter)
  (transform-painter painter 
                     (make-vect 0.0 1.0)  ; new origin
                     (make-vect 1.0 1.0)  ; new end of edge1
                     (make-vect 0.0 0.0))) ; new end of edge2

; rotate 90 degree
(define (rotate90 painter)
  (transform-painter painter
                     (make-vect 1.0 0.0)
                     (make-vect 1.0 1.0)
                     (make-vect 0.0 0.0)))

; define beside method, which used in "pattern-language" file
(define (beside painter1 painter2)
  (let ((split-point (make-vect 0.5 0.0)))
    (let ((paint-left 
            (transform-painter painter1 
                               (make-vect 0.0 0.0)
                               split-point
                               (make-vect 0.0 1.0))) 
          (paint-right 
            (transform-painter painter2 
                               split-point
                               (make-vect 1.0 0.0)
                               (make-vect 0.5 1.0)))) 
      (lambda (frame) 
        (paint-left frame)
        (paint-right frame)))))

; define below method, which used in "pattern-language" file
; this is also defined in exercise 2.51
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






