;; solution for ex. 3.28
; also be implemented in 'digital-circuit.scm'

; or gate
(define (or-gate a1 a2 output)
  (define (or-action-proc)
    (let ((new-value (logical-or (get-signal a1)
                                 (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-proc)
  (add-action! a2 or-action-proc))

; auxiliary logical function
(define (logical-or s1 s2)
  (if (or (= s1 1)
         (= s2 1)) 1
     0))
