#lang racket
(require eopl)
(require "./data-type.rkt")

; the abstract syntax of data is its structure described as a data type
; if the concrete syntax is given as a set of lists, the parsing process is simplified


; parse-expression : SchemeVal -> LcExp
(define parse-expression
  (lambda (datum)
    (cond ((symbol? datum) (var-exp datum))
          ((pair? datum)
             (if (eq? (car datum) 'lambda)
                   (lambda-exp (caadr datum)
                               (parse-expression (caddr datum)))
                 (app-exp
                   (parse-expression (car datum))
                   (parse-expression (cadr datum))))))))

; unparse-lc-exp : LcExp -> SchemeVal
(define unparse-lc-exp
  (lambda (exp)
    (cases lc-exp exp
      (var-exp (var) var)
      (lambda-exp (bound-var body)
        (list 'lambda
              (list bound-var)
              (unparse-lc-exp body)))
      (app-exp (rator rand)
        (list (unparse-lc-exp rator)
              (unparse-lc-exp rand))))))


; ------------------------ test code ----------------------------------

(define exp (parse-expression '(lambda (x) (f (f x)))))
(display (unparse-lc-exp exp))