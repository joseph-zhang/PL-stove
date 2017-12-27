#lang racket
(require eopl)

; now use algebraic method to define enviorment
; Env ::= (empty-env)
;     ::= (extend-env identifier schemeVal Env)
(define-datatype Env Env?
  (empty-env)
  (extend-env
    (var symbol?)
    (val flat-contract?)
    (env Env?)))

; has-binding? : Var -> Env -> Bool
(define has-binding?
  (lambda (search-var env)
    (cases Env env
      (empty-env () #f)
      (extend-env (saved-var saved-val saved-env)
        (if (eq? search-var saved-var) #t
              (has-binding? search-var saved-env))))))

; -------------------------- test code --------------------------------
(define e0 (empty-env))
(define e1 (extend-env
             'x 4 (extend-env
                    'y 2 (extend-env
                           'x 12 e0))))

(has-binding? 'x e1)
(has-binding? 'y e1)
(has-binding? 'w e0)
(has-binding? 'z e1)