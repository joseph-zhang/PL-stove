#lang racket
(require eopl)
(provide (all-defined-out))

; the assocation-list representation

; empty-env : () -> Env
(define empty-env
  (lambda () '()))

; extend-env : Var -> SchemeVal -> Env -> Env
(define extend-env
  (lambda (var val env)
    (cons (cons var val) env)))

; apply-env : Env -> Var -> SchemVal
(define apply-env
  (lambda (env search-var)
    (if (null? env)
          (report-no-binding-found search-var)
        (let ((saved-var (caar env))
              (saved-val (cdar env))
              (saved-env (cdr env)))
          (if (eqv? saved-var search-var) saved-val
              (apply-env saved-env search-var))))))

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

(apply-env e  'x)
(apply-env e 'y)