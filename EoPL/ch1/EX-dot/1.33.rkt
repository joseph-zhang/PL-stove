#lang racket
(require "./1.31.rkt")

; mark-leaves-with-red-depth : Bintree -> Bintree
(define mark-leaves-with-red-depth
  (λ (tree)
    (record-trail tree 0)))

; red-node? : Bintree -> Bool
(define red-node?
  (λ (treeNode)
    (if (leaf? treeNode) false
        (eq? 'red (contents-of treeNode)))))

; auxiliary procedure
; record-trail : Bintree -> n -> Bintree
(define record-trail
  (λ (subTree record)
    (cond ((leaf? subTree) (leaf record))
          ((red-node? subTree)
             (interior-node 'red
                            (record-trail (lson subTree)
                                          (add1 record))
                            (record-trail (rson subTree)
                                          (add1 record))))
          (else (interior-node (contents-of subTree)
                               (record-trail (lson subTree) record)
                               (record-trail (rson subTree) record))))))

; ------------------------- test code ----------------------------
(define testTree
  (interior-node 'red
    (interior-node 'bar
      (leaf 26)
      (leaf 12))
    (interior-node 'red
      (leaf 11)
      (interior-node 'quux
        (leaf 117)
        (leaf 14)))))

(mark-leaves-with-red-depth testTree)