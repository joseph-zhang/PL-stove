#lang racket
(require eopl)

; the procedure list-of accept a predicate and then builds a new predicate
; which tests its argument to see if it is a list and that each of its elements satisfies the predicate
; list-of : Pred -> Pred
(define list-of
  (lambda (pred)
    (lambda (lst)
      (if (null? lst) #t
          (and (pred (car lst))
               ((list-of pred) (cdr lst)))))))

; the new lambda-calculus expression grammar
; Lc-Exp ::= Identifier
;        ::= (lambda ({Identifier}*) Lc-Exp)
;        ::= (Lc-Exp {Lc-Exp}*)
(define-datatype Lc-exp Lc-exp?
  (var-exp
    (var identifier?))
  (lambda-exp
    (bound-vars (list-of identifier?))
    (body Lc-exp?))
  (app-exp
    (rator Lc-exp?)
    (rands (list-of Lc-exp?))))

; identifier? : SchemeVal -> Bool
(define identifier?
  (lambda (x)
    (if (eq? x 'lambda) #f
        (if (symbol? x) #t
            #f))))

; now write a parser for this kind of grammar
(define parse-expression
  (lambda (datum)
    (cond ((symbol? datum) (var-exp datum))
          ((pair? datum)
            (if (eq? 'lambda (car datum))
                  (lambda-exp (cadr datum)
                              (parse-expression (caddr datum)))
                (app-exp (parse-expression (car datum))
                         (map parse-expression (cdr datum))))))))

; ------------------------------ test code ------------------------------
(define exp (parse-expression '(+ b c d)))
(define exp0 (parse-expression '(lambda (x) (+ x c))))
(define exp1 (parse-expression
               '(lambda (x y) (+ c (* x y)))))