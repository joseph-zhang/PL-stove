#lang racket
(require eopl)

; solution for ex. 2.12
; remember the idea of SICP chapter2 ? the message passing method

; empty-stack : () -> Stack
(define empty-stack
  (lambda ()
    (lambda (op)
      (eopl:error 'empty-stack "Cannot operate ~s on empty-stack" op))))

; push : Val -> Stack -> Stack
(define push
  (lambda (val stack)
    (lambda (op)
      (cond ((eqv? op 'top) val)
            ((eqv? op 'pop) stack)
            (else
             (eopl:error 'push "Bad operation ~s" op))))))

; top : Stack -> Val
(define top
  (lambda (stack)
    (stack 'top)))

; pop : Stack -> Stack
(define pop
  (lambda (stack)
    (stack 'pop)))


; ------------------------------------- test code --------------------------------------
(define s
  (push 1
    (push 2
      (push 5
        (push 132
          (empty-stack))))))

(top s)
(top (pop s))
(top (pop (pop s)))
(top (pop (pop (pop s))))
(top (pop (pop (pop (pop s))))) ; empty-stack: Cannot operate top on empty-stack
