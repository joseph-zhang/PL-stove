; the given function display the value and return it
(define (show x)
  (display-line x)
  x)

; note that the delay structure has memory
; and cons-stream is a (val) + (tag) structure

; 1).
(define x (stream-map show (stream-enumerate-interval 0 10)))
; will print 0 and return x

; 2).
(stream-ref x 5)
; print 1\n2\n3\n4\n5. Return 5

; 3).
(stream-red x 7)
; print 6/n7. Return 7
