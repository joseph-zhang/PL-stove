#lang racket
(require "./1.31.rkt")

; a simple implementation of double tree, doubling the value of leaves in a bintree
; double-tree : Bintree -> Bintree
(define double-tree
  (λ (tree)
    (if (leaf? tree) (leaf (* 2 tree))
        (interior-node (contents-of tree)
                       (double-tree (lson tree))
                       (double-tree (rson tree))))))
