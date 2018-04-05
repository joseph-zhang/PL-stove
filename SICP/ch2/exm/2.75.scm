; exm. 2.75
; using message passing method to implement make-from-mag-ang procedure

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