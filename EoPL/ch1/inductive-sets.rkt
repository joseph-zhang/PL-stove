#lang racket
(require eopl)

; this chapter introduce some basic ideas
; here, showing some basic tools
; note that the sign of function is written as haskell form

; list-length : List -> Int
(define list-length
  (lambda (lst)
    (if (null? lst) 0
        (+ 1 (list-length (cdr lst))))))

; nth-element : List -> Int -> schemeVal
(define nth-element
  (lambda (lst n)
    (if (null? lst)
          (report-list-too-short n)
        (if (zero? n)
              (car lst)
            (nth-element (cdr lst) (- n 1))))))

(define report-list-too-short
  (lambda (n)
    (eopl:error 'nth-element
                "List too short by ~s elements.~%" (+ n 1))))

; remove-first : Sym -> (Sym) -> (Sym)
(define remove-first
  (lambda (x lst)
    (if (null? lst) '()
        (if (eq? (car lst) x) (cdr lst)
            (cons (car lst)
                  (remove-first x (cdr lst)))))))

; occurs-free? : Sym -> LcExp -> Bool
; note that this procedure is not as readable as it might be.
; since it includes many predicates.
; definition of lambda-exp
; LcExp ::= Identifier
;       ::= (lambda (Identifier) LcExp)
;       ::= (LcExp LcExp)
(define occurs-free?
  (lambda (var exp)
    (cond ((symbol? exp) (eqv? var exp))
          ((eqv? (car exp) 'lambda)
             (and (not (eqv? var (car (cadr exp))))
                  (occurs-free? var (caddr exp))))
          (else (or (occurs-free? var (car exp))
                    (occurs-free? var (cadr exp)))))))

; definition of s-list and s-exp
; s-list ::= ()
;        ::= (s-exp . s-list)
; s-exp  ::= Sym | s-list
; subset function, we have implemented it in TLS(The Little Schemer)
; subset : Sym -> Sym -> s-list -> s-list
(define subset
  (lambda (new old slist)
    (if (null? slist) '()
        (cons (subset-in-sexp new old (car slist))
              (subset new old (cdr slist))))))
; subset-in-sexp : Sym -> Sym -> s-exp -> s-exp
(define subset-in-sexp
  (lambda (new old sexp)
    (if (symbol? sexp)
          (if (eqv? old sexp) new
              sexp)
        (subset new old sexp))))