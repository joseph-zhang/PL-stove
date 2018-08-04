; consider of the definition of s in ex 3.53
(define s (cons-stream 1 (add-stream s s)))

; Obviously, the definition is implicitly
; to find the result, just think it as a recusion definition.
; answer: power of 2
