; this exercise(2.54) aim to implement process "equal?"
; use eq? to define it recursively

(define (equal? list1 list2)
  (cond ((and (not (pair? list1)) (not (pair? list2))) 
          (eq? list1 list2)) 
        ((and (pair? list1) (pair? list2) ) 
          (equal? (car list1) (car list2)))
        (else false)))
