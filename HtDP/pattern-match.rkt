#lang racket

; we have been familiar with pattern matching in some languages like Haskell
; in racket, there is also a support of pattern matching.
; the idea of pattern matching in racket (reference racket doc)

;  expr	 	=	 	...
; 	 	|	 	(match expr [pattern expr] ...)
; 	 	 	 	 
;  pattern	=	        variable
; 	 	|	 	literal-constant
; 	 	|	 	(cons pattern pattern)
; 	 	|	 	(structure-name pattern ...)
; 	 	|	 	(? predicate-name)
; here are some simple examples

; summation of a list of number
(define sum-items
  (lambda (lst)
   (match lst
      ('() 0)
      ((cons fst rst)
         (+ fst (sum-items rst))))))

; another way to implement it, without pattern matching
(define summation
  (lambda (lst)
    (if (null? lst) 0
        (+ (car lst) (summation (cdr lst))))))

; compare this with what we did in haskell
; summation :: (Num a) => [a] -> a
; summation [] = 0
; summation (x:xs) = x + (summation xs)

; to match all
(match 3
  (3 "3")
  (x (number->string x)))

; the pattern matching is powerful, just follow the grammar to get more usage
; note that it can also used on structures that we defined by using define-struct