; solution for exercise 2.67
; also implemented in file Huffman-tree 
(define sample-tree
    (make-tree (make-leaf 'A 4)
               (make-tree (make-leaf 'B 2)
                          (make-tree (make-leaf 'D 1)
                                     (make-leaf 'C 1)))))
; define code information
(define sample-message '(0 1 1 0 0 1 0 1 1 1 0))

; call function to show result
(decode sample-message sample-tree)
; the result is 
; (a d a b c a)