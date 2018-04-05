;Church numeral examples, church numeral is a process.
(define zero (lambda (f) (lambda (x) x)))
(define one (lambda (f) (lambda (x) (f x))))
(define two (lambda (f) (lambda (x) (f (f x)))))

;add-one method for church count, input:church numeral output:church numeral
(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
