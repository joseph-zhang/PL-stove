#lang racket
(require (planet neil/sicp))
(provide (all-defined-out))
; solution for ex. 3.26
; use binary search tree to implement table structure
; remember the definition of the binary tree -> Tree a = EmptyTree | Node a (Tree a) (Tree a)

(define empty-tree '())
(define (empty-tree? t) (eq? t '()))
(define (make-tree x left right)
  (list x left right))
(define entry car)
(define left-branch cadr)
(define right-branch caddr)
(define (get-val tree) (car (entry tree)))

(define (insert-tree x t)
  (cond ((empty-tree? t)
         (make-tree x
                    empty-tree
                    empty-tree))
        ((< (car x) (get-val t))
         (make-tree (entry t)
                    (insert-tree x (left-branch t))
                    (right-branch t)))
        ((> (car x) (get-val t))
         (make-tree (entry t)
                    (left-branch t)
                    (insert-tree x (right-branch t))))
        ((= (car x) (get-val t)) t)
        (else (error "Error occur when insert-tree!"))))

(define (make-table)
  (let ((local-table empty-tree))
    (define (empty-table?) (empty-tree? local-table))
    (define lookup
      (lambda (subtree) ; currying
        (lambda (key) ; currying
          (cond ((empty-tree? subtree) false)
                ((< key (get-val subtree))
                 ((lookup (left-branch subtree)) key))
                ((> key (get-val subtree))
                 ((lookup (right-branch subtree)) key))
                ((= key (get-val subtree))
                 (entry subtree))
                (else (error "Error occur when lookup on a tree!"))))))
    (define (insert! key val)
      (let ((record ((lookup local-table) key)))
        (if record (set-cdr! record val)
            (set! local-table
                  (insert-tree (cons key val)
                               local-table)))))
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) (lookup local-table))
            ((eq? m 'insert-proc) insert!)
            ((eq? m 'empty) (empty-table?))
            (else (error "Error occur -- invalid operation!"))))
    dispatch))

(define (lookup key table) ((table 'lookup-proc) key))
(define (insert! x key table) ((table 'insert-proc) key x))
(define (empty? table) (table 'empty))
; ------------------------------------------------------------------ test code --------------------------------------------------------------

(define t (make-table))
(define w (make-table))
(empty? t)
(insert! 'jpp 5 t)
(empty? t)
(empty? w)
(lookup 5 t)
(insert! 'spp 8 t)
(lookup 8 t)
(lookup '16 t)
(lookup 8 t)
(lookup 5 t)


 
