; the solution for exercise 2.46
; an interface of vector system, also defined in painter-frame.scm

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