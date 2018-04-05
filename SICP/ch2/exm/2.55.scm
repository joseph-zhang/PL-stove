; an explanation for exercise 2.55

; Eva's code 
(car ''abracadabra)
; trying it, the result is string "quote"

; the reason is very simple
; sign `'` construct a list as
'(quote abracadabra)
; also equal to 
(list 'quote 'abracadabra) 
