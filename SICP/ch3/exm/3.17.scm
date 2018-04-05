#lang planet neil/sicp

; solution for ex. 3.17
; the key point is the sharing, use memq to check
(define (count x)
  (let ((record '()))
    (define (auxi x)
      (if (or (not (pair? x))
              (memq x record)) 0
          (begin
            (set! record (cons x record))
            (+ (auxi (car x))
               (auxi (cdr x))
               1))))
    (auxi x)))

; ------------------------------------- test code ----------------------------------------
(define s1 '(a b c))
(count s1)

(define x '(a))
(define y (cons x x))
(define s2 (list y))
(count s2)

(define s3 (cons y y))
(count s3)

(define s4 '(a b c))
(set-cdr! (cddr s4) s4)
(count s4)
