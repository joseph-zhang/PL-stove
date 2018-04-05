; this file will give an implementataion about Huffman code,
; which contains Huffman tree construction and Huffman decoding.
; the weight of a leave is the frequentness of character, 
; the weight of a inner node is the summation of its sub-nodes.

; expression about Huffman tree, some basic procedures.
(define (make-leaf symbol weight)
  (list 'leaf symbol weight))

(define (leaf? node)
  (eq? 'leaf (car node)))

; selected functions
(define (symbol-leaf x) (cadr x))

(define (weight-leaf x) (caddr x))

; tree construction
(define (make-tree left right)
  (list left 
        right
        (append (symbols left) (symbols right)) 
        (+ (weight left) (weight right))))

(define (left-branch tree) (car tree))
(define (right-branch tree) (cadr tree))
(define (symbols tree)
  (if (leaf? tree) (list (symbol-leaf tree))
      (caddr tree)))
(define (weight tree)
  (if (leaf? tree) (weight-leaf tree)
      (cadddr tree)))

; decoding procedure
(define (decode bits tree)
  (define (sub-decode bits subtree)
    (if (null? bits) '()
        (let ((next-branch (choose-branch (car bits) subtree))) 
          (if (leaf? next-branch) 
              (cons (symbol-leaf next-branch) 
                    (sub-decode (cdr bits) tree))
              (sub-decode (cdr bits) next-branch)))))
  (sub-decode bits tree))

(define (choose-branch bit tree)
  (cond ((= bit 0) (left-branch tree)) 
        ((= bit 1) (right-branch tree))
        (else (error "cannot decode the bit -- it's not 0 or 1" bit))))

; to generate Huffman tree from a list, we need a method to find minimal item in a list,
; it's better to maintain a sorted list.   
(define (adjoint-set x set)
  (cond ((null? set) (list x))
        ((< (weight x) (weight (car set))) (cons x set))
        (else (cons (car set)
                    (adjoint-set x (cdr set))))))

(define (make-leaf-set pairs)
  (if (null? pairs) '()
      (let ((pair (car pairs))) 
           (adjoint-set (make-leaf (car pair)
                                   (cadr pair))
                        (make-leaf-set (cdr pairs))))))

; a sample for previous procedures
; define a code tree
(define sample-tree
  (make-tree (make-leaf 'A 4)
             (make-tree (make-leaf 'B 2)
                        (make-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))
; define code information
(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

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



