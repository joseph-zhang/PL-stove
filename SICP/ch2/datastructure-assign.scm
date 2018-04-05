; data abstraction is an important method to control the complexity
; a kind of data can be expressed by multiple forms,
; and there are many methods to implement abstraction.
; in this file, a kind of method named type assign will be implemented.
; here we are going to use complex number as an example,
; although it has been implemented in MIT-Scheme.
; those procedures which use complex number should be in common use.

; expression of complex number
; suppose we select rectangular expression as base form. 
(define (make-from-real-img-1 x y) (cons x y))
(define (make-from-mag-ang-1 r a)
  (cons (* r (cos a))
        (* r (sin a))))
; or polar expression 
(define (make-from-real-img-2 x y)
  (cons (sqrt (+ (square x) (square y)))
        (atan y x))) 
(define (make-from-mag-ang-2 r a)
  (cons r a))

; however, it's better to add signature in data structure
(define (attach-tag sign contents)
  (cons sign contents))
(define (type-tag datum)
  (if (pair? datum) (car datum)
      (error "Bad datum type -- DATUM_TAG" datum)))
(define (contents datum)
  (if (pair? contents) (cdr datum)
      (error "Bad datum type -- DATUM_CONTENTS" datum)))

; check type
(define (rectangular? z)
  (eq? 'rectangular (type-tag z)))
(define (polar? z)
  (eq? 'polar (type-tag z)))

; the constructor for rectangular form
(define (make-from-real-img-rectangular x y)
  (attach-tag 'rectangular
    (make-from-real-img-1 x y)))
(define (make-from-mag-ang-rectangular r a)
  (attach-tag 'rectangular 
    (make-from-mag-ang-1 r a)))
; the constructor for polar form
(define (make-from-real-img-polar x y)
  (attach-tag 'polar)
    (make-from-real-img-2 x y))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar 
    (make-from-mag-ang-2 r a)))

; selected process
; selection for rectangular form
(define (real-part-rectangular z)
  (car z))
(define (img-part-rectangular z)
  (cdr z))
(define (magnitude-rectangular z)
  (+ (square (real-part-rectangular z)
     (square (img-part-rectangular z)))))
(define (angle-rectangular z)
  (atan (img-part-rectangular z)
        (real-part-rectangular z)))
; selection for polar form
(define (magnitude-polar z)
  (car z))
(define (angle-polar z)
  (cdr z))
(define (real-part-polar z)
  (* (magnitude-polar z) (cos (angle-polar z))))
(define (img-part-polar z)
  (* (magnitude-polar z) (sin (angle-polar z))))

; write general procedure for these selective methods
(define (real-part z)
  (cond ((rectangular? z) (real-part-rectangular (contents z)))
        ((polar? z) (real-part-polar (contents z))) 
        (else (error "unkown type -- REAL-PART" z))))
(define (img-part z)
  (cond ((rectangular? z) (img-part-rectangular (contents z))) 
        ((polar? z) (img-part-polar (contents z)))
        (else (error "unkown type -- IMAG-PART" z))))
(define (magnitude z)
  (cond ((rectangular? z) (magnitude-rectangular (contents z))) 
        ((polar? z) (magnitude-polar (contents z)))
        (else (error "unkown type -- MAGNITUDE" z))))
(define (angle z)
  (cond ((rectangular? z) (angle-rectangular (contents z))) 
        ((polar? z) (angle-polar (contents z))) 
        (else (error "unkown type -- ANGLE" z))))

; some basic calc func
(define (add-complex z1 z2)
  (make-from-real-img (+ (real-part z1) (real-part z2))
                      (+ (img-part z1) (img-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-img (- (real-part z1) (real-part z2))
                      (- (img-part z1) (img-part z2))))
(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

; general construct methods
; decide base form for expression of complex number
(define (make-from-real-img x y)
  (make-from-real-img-rectangular x y))
(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))




