#lang planet neil/sicp

; the solution for ex. 3.02
(define make-monitored
  (lambda (f)
    (let ((counter 0))
      (lambda (command)
          (cond ((eq? command 'how-many-calls?) counter)
                ((eq? command 'reset-count)
                   (set! counter 0))
                (else (begin
                        (set! counter (+ counter 1))
                        (f command))))))))

; ------------------------------- test code ------------------------------
(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 25)
(s 'how-many-calls?)
(s 'reset-count)
(s 'how-many-calls?)