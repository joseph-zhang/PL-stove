; this chapter mainly expain some useful and basic Scheme/Lisp syntax and procedure.
; we have learnt all of them in SICP, just list the definitions here.

; s-expression
; s-expressions are a notation for nested list data,
; an s-expression is classically defined as:
; an atom, or
; an expression of the form (x. y) where x and y are s-expressions.

; The Law of car 
; The primitive car is defined only for non-empty lists.

; The law of cdr
; The primitive cdr is defined only for non-empty lists.
; The cdr of any non-empty list is always another list.

; The law of cons
; The primitive cons takes two arguments.
; The second argument must be a list.
; The first one is any s-expression. The result is a list.

; The law of null?
; The primitive null? is defined only for lists.

; The law of eq?
; The primitive eq? takes two arguments.
; Each must be a non-numeric atom.

