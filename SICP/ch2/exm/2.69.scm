; solution for exercise 2.69
; also implemented in file Huffman-tree

; the encode method need Huffman tree
; here is a procedure to construct one from frequentness table
(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs)))

(define (successive-merge sorted-leaf-set)
  (if (= (length sorted-leaf-set) 1) sorted-leaf-set 
      (let ((oneTree (car sorted-leaf-set))
            (anotherTree (cadr sorted-leaf-set)))
        (successive-merge (adjoint-set (make-tree oneTree anotherTree)
                                       (cddr sorted-leaf-set))))))