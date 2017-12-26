#lang racket
(require eopl)
(require "./2.10.rkt")
(provide apply-env* empty-env)
; implement environment interface with ribcage representation
(define empty-env
  (lambda () '()))
(define empty-env? null?)

; rib : List -> Env -> Pair
(define rib
  (lambda (env)
    (car env)))

; apply-env* : Env -> Var -> SchemeVal
(define apply-env*
  (lambda (env search-var)
    (if (empty-env? env)
          (report-no-binding-found search-var)
        (let ((sign (apply-rib (rib env) search-var)))
          (if (eq? sign 'unfound)
                (apply-env* (cdr env) search-var)
              sign)))))

; apply-rib : Rib -> Var -> SchemeVal
(define apply-rib
  (lambda (rib search-var)
    (let ((var-list (car rib))
          (val-list (cdr rib)))
      (if (null? var-list) 'unfound
          (if (eq? (car var-list) search-var)
                (car val-list)
              (apply-rib (suc-rib rib) search-var))))))

; suc-rib : Rib -> Rib
(define suc-rib
  (lambda (rib)
    (cons (cdar rib)
          (cddr rib))))

(define report-no-binding-found
  (lambda (search-var)
    (eopl:error 'apply-env "No binding for ~s" search-var)))


; ----------------------------- test code --------------------------------
(define e
  (extend-env* '(a b c) '(11 12 13)
    (extend-env* '(x z) '(66 77)
      (extend-env* '(x y) '(88 99)
        (empty-env)))))

(apply-env* e 'a)
(apply-env* e 'x)
(apply-env* e 'c)
(apply-env* e 'w) ; apply-env: No binding for w