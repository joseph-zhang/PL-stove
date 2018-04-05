#lang planet neil/sicp

; solution for ex. 3.18
; consider the solution of ex. 3.17, the eternity can be detected by using memq

; note that this is wrong answer 
(define (cycle? lst)
  (let ((record '()))
    (define (auxi lst)
      (cond ((not (pair? lst)) false)
            ((memq lst record) true)
            (else (begin
                    (set! record (cons lst record))
                    (or (auxi (car lst))  ; record used for both two branch
                        (auxi (cdr lst)))))))
    (auxi lst)))

; correct one
(define (has-loop? lst) 
  (define (iter lst seen) 
    (cond ((not (pair? lst)) #f) 
          ((memq lst seen) #t) 
          (else (or (iter (car lst) (cons lst seen)) ; every branch has its own record
                     (iter (cdr lst) (cons lst seen)))))) 
  (iter lst '())) 
  
; ---------------------------------------- test code ----------------------------------------------
(define t1 '(a b)) 
(define t2 (cons t1 t1))
(define t3 '(x y))
(set-cdr! (cdr t3) t3)

(cycle? t2) ; this will return true, hence wrong
(has-loop? t2) ; correct one

(cycle? t3)
(has-loop? t3)
