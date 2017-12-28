#lang racket
(require eopl)

; solution for ex. 2.22
; use the algebraic datatype to define stack
; stack ::= (empty-stack)
;       ::= (pushed-stack SchemeVal stack)

(define-datatype stack stack?
  (empty-stack)
  (pushed-stack
     (stack-top flat-contract?)
     (stk stack?)))

; push : Val -> Stack -> Stack
(define push
  (lambda (val saved-stack)
    (pushed-stack val saved-stack)))

; top : Stack -> SchemeVal
(define top
  (lambda (saved-stack)
    (cases stack saved-stack
      (empty-stack ()
        (eopl:error 'top "the stack ~s is empty!" saved-stack))
      (pushed-stack (stack-top stk)
        stack-top))))

; pop : Stack -> Stack
(define pop
  (lambda (saved-stack)
    (cases stack saved-stack
      (empty-stack ()
        (eopl:error 'top "the stack ~s is empty!" saved-stack))
      (pushed-stack (stack-top stk)
         stk))))

; --------------------------------- test code --------------------------------
(define stk0 (empty-stack))
(define stk1 (pushed-stack 5
               (pushed-stack 6
                 (pushed-stack 9 stk0))))

(push 4 stk0)
(top stk1)
(top (pop stk1))
(top (pop (pop stk1)))
(top (pop (pop (pop stk1)))) ; top: the stack #(struct:empty-stack) is empty!
