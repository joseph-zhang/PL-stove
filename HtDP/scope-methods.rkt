#lang racket

; we have used [let] syntax many times, however there are many other scope methods
; like local let* letrec etc.
; it is important to distinguish them from each other
; the key is that we should find out the bind relationship clearly


; the difference between let and let* is let will evaluate all the bindings with respect to the level above
; while let* does it sequentially, the order is important.
(let ((x 2))
  (let ((x 3)
        (y x)) ; x is still 2 here
    (list x y)))  ; => (3 2)

(let ((x 2))
  (let* ((x 3) 
         (y x)) ; x is shadowed here
    (list x y))) ; => (3 3)


; letrec allows you to bind recursive values, to construct an environment
; Like local, but with a simpler syntax.
(letrec ((even?
           (lambda(x)
             (if (= x 0) #t
                 (odd? (- x 1)))))
         (odd?
           (lambda(x)
             (if (= x 0) #f
                 (even? (- x 1))))))
  (even? 88))

; local : like letrec, but syntax is a bit more complicated
; Each definition can be either a define or a define-struct.
(define (insertion-sort alon)
  (local ((define (sort alon)
            (cond
              ((empty? alon) '())
              (else
               (add (first alon) (sort (rest alon))))))
          (define (add an alon)
            (cond
              ((empty? alon) (list an))
              (else
               (cond
                 ((> an (first alon)) (cons an alon))
                 (else (cons (first alon)
                             (add an (rest alon)))))))))
    (sort alon)))