#lang racket
(require eopl)


; extend-env* : var-list -> val-list -> Env
(define extend-env*
  (λ (vars vals env)
    (if (null? vars) env
        (cons (cons vars vals) env))))