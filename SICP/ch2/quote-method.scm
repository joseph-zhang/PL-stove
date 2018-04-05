; quote method is important 
; we use it to express literally

; usual definition of variable
; this bind the value 1 to its name 'a'
(define a 1)

; use quote to define syntax object
(list 'a 'b)
; which is equal to expression
(list (quote a ) (quote b))

; here is another example
(car '(a b c))
; which can be defined as 
(list 'car (list 'quote '(a b c))) ; this is expression "(car (quote (a b c)))"

; actually, quote method let us manipulate syntax !!

