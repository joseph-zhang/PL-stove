; a solution for exercise 2.68
; also implemented in file Huffman-tree

; encode procedure, encoding a symbol list
(define (encode message tree)
(if (null? message) '()
    (append (encode-symbol (car message) tree)
            (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
(define (sub-encode currRes currBranch)
  (if (leaf? currBranch)
        (if (eq? symbol (symbol-leaf currBranch)) currRes
            '())  
      (append (sub-encode (append currRes '(0)) (left-branch currBranch))
              (sub-encode (append currRes '(1)) (right-branch currBranch)))))
(let ((result (sub-encode '() tree)))
  (if (null? result) (error "unkown symbol in message list! -- UNKOWN SYMBOL" symbol) 
      result)))