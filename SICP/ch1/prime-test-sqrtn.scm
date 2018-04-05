(define (smallest-divisor x)
  (find-divisor x 2))

(define (find-divisor x test-divisor)
  (cond ((> (square test-divisor) x) x)
        ((divides? test-divisor x) test-divisor)
		(else (find-divisor x (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (prime? x)
  (= (smallest-divisor x) x))
  
  