#lang racket

; define-struct is a simple method to implement data abstraction
; as we can see, data abstraction give us a powerful way to construct layered abstraction
; here is the definition of a kind of binary tree in EoPL
; interior-node : Symbol -> Bintree -> Bintree
(define interior-node
  (lambda (Symbol Ltree Rtree)
    (list Symbol Ltree Rtree)))

; use data abstraction method, we need not to conern about the implementation of representation
(define-struct Bintree (content Ltree Rtree))
; Once the struct is defined, some procedures are available:
; make-structure-name
; structure-name-field-name
; structure-name?

; just implement those methods in this way
(define lson Bintree-Ltree)
(define rson Bintree-Rtree)
(define contents-of Bintree-content)

; the construction procedure is just make-Bintree, need not to write interior-node
; here is an example
(define testTree
  (make-Bintree 'aa (make-Bintree 'bb 1 2) (make-Bintree 'cc 4 5)))

; ----------------------------- test code -------------------------------------
(contents-of (lson testTree))
(contents-of (rson testTree))