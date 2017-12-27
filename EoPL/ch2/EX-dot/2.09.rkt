#lang racket
(require eopl)

; check if the variable has an associated value in env
; has-binding : Var -> Env -> Bool
(define has-binding?
  (lambda (var env)
    (cond ((null? env) #f)
          ((eq? (caar env) var) #t)
          (hsd-binding var (cdr env))))