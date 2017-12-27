#lang racket
(require eopl)

; solution for ex. 2.13
; another representation of the environment interface

; empty-env : () -> Env
(define empty-env
  (lambda ()
    (list (lambda (var)
            (report-no-binding-found var))
          (lambda () #t))))

; extend-env : Var -> SchemeVal -> Env -> Env
(define extend-env
  (lambda (var val env)
    (list (lambda (search-var)
            (if (eq? var search-var) val
                ((env-apply env) search-var)))
          (lambda () #f))))

; apply-env : Env -> Var -> SchemeVal
(define apply-env
  (lambda (env var)
    ((car env) var)))

(define report-no-binding-found
  (lambda (search-var)
    (eopl:error 'apply-env "No binding for ~s" search-var)))

(define env-apply car)
(define empty-env? cdar)

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