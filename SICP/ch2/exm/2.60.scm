; solution for exercise 2.60
; implement multi-set


; elements of a set, O(N)
; no need to rewrite
(define (element-of-set? x set)
(cond ((null? set) false)
      ((equal? x (car set)) true)
      (else (element-of-set? x (cdr set)))))

; adjoint set, O(1)
; no need to check duplicate, just throw it in our set
(define (adjoint-set x set)
  (cons x set))

; union-set, O(N)
; just append a set on another one
(define union append)

; intersection-set method, O()
; need to rewrite, hold a minimal number of duplicate
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) 
          (cons (car set1) 
                (intersection-set (cdr set1) 
                                  (remove-fst-element (car set1) set2))))
        (else (intersection-set (cdr set1) set2))))
; implement remove process
(define (remove-fst-element x set)
  (define (iter-remove result rest-set) 
    (cond ((null? rest-set) result) 
          ((equal? x (car rest-set))
            (append result (cdr rest-set))
          (else (iter-remove (adjoint-set x result) (cdr rest-set)))))) 
  (iter-remove '() set)))