; the previous file, datastructure-assign, shows the power of the assign method based on type,
; however, the representation can be various, we still need to name them in different ways.
; here we are going to see another method to deal with this problem, which is the data oriented assign method.
; the key idea is implementing a 2-d items table to correspond general operations.

; basic method : put and get (from the table)
; suppose we have already implemented them (actually in exm. 3.24)
; (put <op> <type> <item>)
; (get <op> <type>)

; install rectangular package
(install-rectangular-package
  (define (real-part* z) (car z))
  (define (imag-part* z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude* z)
    (sqrt (+ (square (real-part* z))
	         (square (imag-part* z)))))
  (define (angle* z)
    (atan (imag-part* z) (real-part* z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))
	
  ;interface 
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part*)
  (put 'imag-part '(rectangular) imag-part*)
  (put 'magnitude '(rectangular) magnitude*)
  (put 'angle '(rectangular) angle*)
  (put 'make-from-real-imag 'rectangular
    (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular 
    (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)
  
; note that the installation of polar-package is similair to rectangular one
; The following is omitted ...



