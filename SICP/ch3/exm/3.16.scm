#lang planet neil/sicp

; the procedure in ex. 3.16
(define (count x)
  (if (not (pair? x)) 0
      (+ (count (car x))
         (count (cdr x))
         1)))

; however, this procedure cannot count the number of pairs in object x correctly
; structure 1st, return 3
(define s1 '(a b c))
(count s1)

; structure 2nd, return 4
; the key point here is data/code sharing (Homoiconic)
(define x '(a))
(define y (cons x x))
(define s2 (list y))
(count s2)

; structure 3rd, return 7
(define s3 (cons y y))
(count s3)

; structure, eternity
(define s4 '(a b c))
(set-cdr! (cddr s4) s4)
(count s4)