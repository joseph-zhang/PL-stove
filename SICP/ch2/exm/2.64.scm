; solution for exercise 2.64
; in exercise 2.63, we have implemented a method for tree transformation
; this time, we will implement its mirror version, constructing a balanced tree from a given list.

(define (list->tree elements)
  (car (partial->tree elements (length elements))))

; partial->tree procedure will transform a sorted list to balanced tree,
; the result of this method is a cons structure.
(define (partial->tree elts n)
  (if (= n 0) (cons '() elts)
      (let ((left-size (quotient (- n 1) 2))) 
        (let ((left-result (partial->tree elts left-size))) 
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial->tree (cdr non-left-elts) right-size)))
              (let ((right-tree (car right-result)) 
                    (remaining-elts (cdr right-result))) 
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))

; for question (a)  
;     5
;   /    \
;  1      9
;   \    / \
;    3  7  11  
; list form          
; (5 (1 '() (3 '() '())) (9 (7 '() '()) (11 '() '())))
(define res (list->tree (list 1 3 5 7 9 11)))

; for question (b)
; this method is divide and conquer, just write the equation 
; T(n) = 2\,T\Big(\frac{n}{2}\Big) + O(1)
; By the Master Theorem, T(n) = O(n)