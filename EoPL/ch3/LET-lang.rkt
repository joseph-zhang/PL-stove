#lang racket
(require eopl)

; 'LET' is a small toy language
; this file will implement the LET language, and show how it work.
; in LET, the expressed and denoted values will be the same, which contains Int and Bool.
; note that the program of the Let is just an expression.

; tools for values, for translation:
; 'num-val' : Int -> ExpVal 
; 'bool-val' : Bool -> ExpVal
; 'expval->num' : ExpVal -> Int
; 'expval->bool' : Expval -> Bool

; expression constructors:
; 'const-exp' : Int -> Exp
; 'zero?-exp' : Exp -> Exp
; 'if-exp' : Exp -> Exp -> Exp -> Exp
; 'diff-exp' : Exp -> Exp -> Exp
; 'var-exp' : Var -> Exp
; 'let-exp' : Var -> Exp -> Exp -> Exp

; observer:
; 'value-of' : Exp -> Env -> ExpVal

; a LET program is an expression
(define-datatype program program?
  (a-program
    (exp1 expression?)))

; expressions in LET
(define-datatype expression expression?
  (const-exp
    (num number?))
  (diff-exp
    (exp1 expression?)
    (exp2 expression?))
  (zero?-exp
    (exp1 expression?))
  (if-exp
    (exp1 expression?)
    (exp2 expression?)
    (exp3 expression?))
  (var-exp
    (var identifier?))
  (let-exp
    (var identifier?)
    (exp1 expression?)
    (body expression?)))

; the data LET can deal with
(define-datatype expval expval?
  (num-val
    (num number?))
  (bool-val
    (bool boolean?)))

; extractors
; expval->num : ExpVal -> Int
(define expval->num
  (lambda (val)
    (cases expval val
      (num-val (num) num)
      (else (report-expval-extractor-error 'num val)))))

; expval->bool : ExpVal -> Bool
(define expval->bool
  (lambda (val)
    (cases expval val
      (bool-val (bool) bool)
      (else (report-expval-extractor-error 'bool val)))))
