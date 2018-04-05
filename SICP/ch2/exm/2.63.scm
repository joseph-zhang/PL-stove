; solution for exercise 2.63 
; which contains procedures transfer a tree into a list.
(define (tree->list tree)
  (define (sub-transfer sub-tree res)
    (if (null? sub-tree) res
        (sub-transfer (left-branch sub-tree)
                      (cons (entry sub-tree)
                            (sub-transfer (right-branch sub-tree)
                                          res)))))
  (sub-transfer tree '()))