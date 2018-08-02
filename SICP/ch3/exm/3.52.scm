; 3.52 is a good exercise that help us to understand stream

; pre-definitions
(define sum 0)

(define (accum x)
  (set! sum (+ x sum))
  sum)

; 1). 
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; seq is a stream which is constructed as (val) + (tag)
; if we considier it deeper, it might be '(1, 3, 6, ...)
; after this definition, sum => 1
; because the (val) has been calculated
; that is, (accum 1) completed!

; 2).
(define y (stream-filter even? seq))
; y is another sequence, filter with predicate even?
; the construction of stream will not stop until the first even number is calculated
; we can find that, it is 6.
; hence, after this definition, sum => 6

; 3).
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
; z is another sequence
; the construction of stream will not stop until the first 5* number is calculated.
; the list track will be 1 (+2)=> 3 (+3)=> 6 (+4)=> 10
; hence the result is, sum => 10

; 4).
(stream-ref y 7)
; an expression to get the (7+1)th number of y
; we can calculate the sequence y
; 6 10  28  36  66  78  120  136
; hence the result is, sum => 136

; 5).
(display-stream z)
; this expression get the whole sequence z
; just do it, we get (10 15 45 55 105 120 190 210)
; and the sum => 120

; note that the delay function can memorize what we have calculated.
; so in 5) expression, the calculation will start from 136, not 1
; if delay is just (lambdsa () exp),
; every time we the program is calculating from 1, not the previous one,
; the value of sum will be much bigger.

