; this file will show another method to implement set.
; that is, using tree structure to accelerate the search action.
; we have already know that the height of balanced tree is just O(logN)
; constructed method
(define (make-tree entry left right)
  (list entry left right))

; some select process, also imply the structure  of BST. 
(define entry car)
(define left-branch cadr)
(define right-branch caddr)

; element-of-set method
(define (element-of-set? x tree)
  (cond ((null? tree) false)
        ((= x (entry tree)) true)
        ((< x (entry tree))
          (element-of-set? x (left-branch tree))) 
        (else (element-of-set? x (right-branch tree)))))

; insert a value in BST
(define (adjoint-set x tree)
  (cond ((null? tree) (make-tree x '() '()))
        ((= x (entry tree)) tree) 
        ((< x (entry tree))
          (make-tree (entry tree) 
                     (adjoint-set x (left-branch tree)) 
                     (right-branch tree))) 
        (else (make-tree (entry tree)
                         (left-branch tree) 
                         (adjoint-set x (right-branch tree))))))

; test example 
;      7
;   3      9
; 1   5      11
;
(define x (make-tree 7 (make-tree 3 (make-tree 1 '() '()) (make-tree 5 '() '())) (make-tree 9 '() (make-tree 11 '() '()))))

