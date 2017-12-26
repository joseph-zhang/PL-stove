#lang racket
(require eopl)

; another idea to implement environment is proceduaral representation
; see apply-env as a procedure that takes a variable and returns its associated value

; empty-env : () -> Env
(define empty-env
  (lambda ()
    (lambda (search-var)
      (report-no-binding-found search-var))))

; extend-env : Var -> SchemeVal -> Env -> Env
(define extend-env
  (lambda (saved-var saved-val saved-env)
    (lambda (search-var)
      (if (eqv? search-var saved-var) saved-val
          (apply-env saved-env search-var)))))

; apply-env : Env -> Var -> SchemeVal
(define apply-env
  (lambda (env search-var)
    (env search-var)))

(define report-no-binding-found
  (lambda (search-var)
    (eopl:error 'apply-env "No binding for ~s" search-var)))

; --------------------- test code -------------------------
(define e
  (extend-env 'd 6
    (extend-env 'y 8
      (extend-env 'x 7
        (extend-env 'y 14
          (empty-env))))))

(apply-env e 'x)
(apply-env e 'y)
(apply-env e 'w) ; apply-env: No binding for w

