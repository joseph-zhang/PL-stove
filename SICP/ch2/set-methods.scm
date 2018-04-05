; instance :: set methods
; this file contains some basic processes related to set structure
; it will support those method in math-set,
; intersection
; union
; find
; adjoint
; note that adjoint method can be used as a set constructor 

; elements of a set can be thrown into a list structure O(N)
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
; use element-set method to implement adjoint-set, O(N)
(define (adjoint-set x set)
  (if (element-of-set? x set) set
      (cons x set)))
; intersection set method, O(N^2)
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '()) 
        ((element-of-set? (car set1) set2) 
          (cons (car set1)
                (intersection-set (cdr set1) set2))) 
        (else (intersection-set (cdr set1) set2))))
; untion-set method, O(N^2)
; also implemented in exercise 2.59 
(define (union-set set1 set2)
  (if (null? set1) set2
      (union-set (cdr set1) (adjoint-set (car set1) set2))))

; To enhance the performance of set, let set be sorted list.
; and those methods for unsorted list will be changed.
; element-in? O(N)
(define (st-element-of-set? x set)
  (cond ((null? set) false)
        ((= x (car set)) true)
        ((< x (car set)) false)
        (else (st-element-of-set? x (cdr set)))))

; intersection method, O(N) 
(define (st-intersection-set set1 set2)
  (if (or (null? set1) (null? set2)) '()
      (let ((a (car set1))
            (b (car set2))) 
        (cond ((= a b) (cons a (st-intersection-set (cdr set1) (cdr set2)))) 
              ((< a b) (st-intersection-set (cdr set1) set2)) 
              ((> a b) (st-intersection-set set1 (cdr set2)))))))

; adjoint method, O(N)
; also implemented in exercise 2.61
(define (st-adjoint-set x set)
  (if (null? set) (list x)
    (let ((fstelement (car set)))
      (cond ((= x fstelement) set)
            ((< x fstelement) (cons x set)) 
            (else (cons fstelement (st-adjoint-set x (cdr set))))))))

; union-set method, O(N)
; also implemented in exercise 2.62
(define (st-union-set set1 set2)
  (cond ((null? set1) set2) 
        ((= (car set1) (car set2))
          (cons (car set1) (st-union-set (cdr set1)
                                         (cdr set2))))
        ((< (car set1) (car set2))
          (cons (car set1) (st-union-set (cdr set1) 
                                         set2))) 
        (else (cons (car set2) (st-union-set (cdr set2) set1)))))