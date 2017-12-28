#lang racket
(require eopl)
(require "./2.24.rkt")

; max-interior : Bintree -> Symbol
(define max-interior
  (lambda (tree)
    (define (inner-proc tree)
      (cases Bintree tree
        (leaf-node (num)
          (list '() num num))
        (interior-node (key left right)
          (let ((left-res (inner-proc left))
                (right-res (inner-proc right)))
            (let ((cur-sum (+ (cadr left-res)
                              (cadr right-res)))
                  (left-sign (car left-res))
                  (right-sign (car right-res))
                  (left-max (caddr left-res))
                  (right-max (caddr right-res)))
              (cond ((and (> cur-sum left-max)
                          (> cur-sum right-max))
                      (list key cur-sum cur-sum))
                    ((> left-max right-max)
                      (list left-sign cur-sum left-max))
                    ((> right-max left-max)
                      (list right-sign cur-sum right-max))))))))
    (car (inner-proc tree))))

; ------------------------ test code -------------------------------
(define tree-1
  (interior-node 'foo (leaf-node 2) (leaf-node 3)))

(define tree-2
  (interior-node 'bar (leaf-node -1) tree-1))

(define tree-3
  (interior-node 'baz tree-2 (leaf-node 1)))

(max-interior tree-1)
(max-interior tree-2)
(max-interior tree-3)