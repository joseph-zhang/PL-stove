#lang racket
(require eopl)

; the binary tree definition
(define-datatype Bintree Bintree?
  (leaf-node
    (num integer?))
  (interior-node
    (key symbol?)
    (left Bintree?)
    (right Bintree?)))


; bintree-to-list : Bintree -> List
(define bintree-to-list
  (lambda (tree)
    (cases Bintree tree
      (leaf-node (num) `(leaf-node ,num))
      (interior-node (key left right)
        (list 'interior-node
              key
              (bintree-to-list left)
              (bintree-to-list right))))))

; ----------------------------- test code -------------------------------
(define t
  (interior-node 'a
                 (leaf-node 3)
                 (leaf-node 4)))

(bintree-to-list t)


