#lang racket
(require eopl)

; auxiliary procedure
; find : a -> list -> n
(define find
  (lambda (x lst)
    (if (equal? x (car lst)) 0
        (+ 1 (find x (cdr lst))))))

; list-index : pred -> list
(define list-index
  (lambda (pred lst)
    (let ((res (filter pred lst)))
      (if (null? res) #f
          (find (car res) lst)))))

; ----------------------------- test code ---------------------------
(list-index number? '(a 2 (1 3) b 7))
(list-index symbol? '(a (b c) 17 foo))
(list-index symbol? '(1 2 (a b) 3))