#lang racket
(provide (all-defined-out))

; the grammer of defining binary tree
; Bintree ::= Int | (Symbol Bintree Bintree)

; in this definition, the leaf is always a Int value
; note a iterior node can be a subtree
; interior-node : Symbol -> Bintree -> Bintree
(define interior-node
  (lambda (Symbol Ltree Rtree)
    (list Symbol Ltree Rtree)))

; leaf can be identity procedure, note that there is no type checking
(define leaf identity)

; predicate to check if a node is a leaf
; leaf? : Bintree -> Bool
(define leaf? number?)

; selective procedure
; lson : Bintree -> Bintree
(define lson
  (lambda (tree)
    (if (leaf? tree) '()
        (cadr tree))))
; rson : Bintree -> Bintree
(define rson
  (lambda (tree)
    (if (leaf? tree) '()
        (caddr tree))))

; extract the component of a node
; contents-of : Bintree -> schemeVal
(define contents-of
  (lambda (tree)
    (if (leaf? tree) tree
        (car tree))))
