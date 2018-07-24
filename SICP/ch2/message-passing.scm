; in the previous file, a kind of design method, data-oriended, was described
; this file will show another method, a more interesting way
; before that, it is important to know about the selective method
(define (apply-generic op . args)
  (let* ((type-tags (map type-tag args))
         (proc (get op (type-tags))))
    (if proc (apply proc (map contents args)
             (error 
                "No method for theses types -- APPLY-GENERIC"
                (list op type-tags))))))

; then, the correct proc canbe assign according to types
; for example
(define (real-part* z)
  (apply-generic 'real-part z)) 
(define (imag-part* z)
  (apply-generic 'imag-part z))


; now, consider another assign method named message passing
; this kind of method conbstruct a flexible data object
; as an example, we implement make-from-real-imag constructed procedure
(define (make-from-real-imag x y)
  (lambda (op)
    (cond ((eq? op 'real-part) x)
          ((eq? op 'imag-part) y)
          ((eq? op 'magnitude)
            (sqrt (+ (square x) (square y))))
          ((eq? op 'angle)
            (atan y x))
          (else 
            (error "Unkown op -- MAKE-FROM-REAL-IMAG" op)))))

; this kind of method using the idea "procedure as data"
; when you construct a complex number, it begin waiting a message, and then assign,
; now we can implement another procedure by using this method.
; this procedure is implemented in exm. 2.75
(define (make-from-mag-ang r a)
  (lambda (op)
    (cond ((eq? op 'magnitude) r)
          ((eq? op 'angle) a)
          ((eq? op 'real-part)
            (* r (cos a)))
          ((eq? op 'imag-part)
            (* r (sin a)))
          (else
            (error "Unkown op -- MAKE-FROM-MAG-ANG" op)))))
