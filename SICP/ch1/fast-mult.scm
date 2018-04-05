(define (fast-mult a b)
  (cond ((= b 0) 0)
        ((even? b) (* 2 (fast-mult a (/ b 2))))
		(else (+ a (fast-mult a (- b 1))))))
		