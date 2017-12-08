; this file shows some code in chapter 6
; the first part mainly describe an evaluators, skip it~
; an interesting part is another representation of number system with llist

; the empty list is represented as zero
(define sero? 
  (lambda (x) (null? x)))

; some basic numerical methods
(define edd1
  (lambda (x)
    (cons '() x)))

(define zub1
  (lambda (x)
    (cdr x)))

(define plus
  (lambda (x y)
    (append x y)))

(define plus*
  (lambda (x y)
    (if (sero? y) x
      (edd1 (plus x (zub1 y))))))

