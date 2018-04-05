; this exercise will construct a simple vector system.
; a vector can be seen as a list, a matrix is a nested list.

; an example of 3x4 matrix [1 2 3 4 ; 4 5 6 6 ; 6 7 8 9] 
(define mat1 (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
; an example of vectors
(define vec1 (list 1 22 3 44))
(define vec2 (list 2 65 4 8))

; folder: foldr		
(define (acc op initial sequence)
  (if (null? sequence) initial
      (op (car sequence) ;the first element of op is not initial! 
	      (acc op initial (cdr sequence)))))
; foldr-n
(define (acc-n op init seqs)
  (if (null? (car seqs)) '() 
      (cons (acc op init (map car seqs))
	        (acc-n op init (map cdr seqs)))))
			
; dot product of vector
(define (dot-product v w)
  (acc + 0 (map * v w)))

; matrix transpose
(define (transpose mat)
 (acc-n cons '() mat))

; multi between matrix and vector
(define (matrix-*-vector m v)
  (map (lambda (vi) (dot-product vi v)) m))

; multi between matrices: numerical
(define (matrix-*-matrix m1 m2)
  (let ((cols (transpose m2)))
    (map (lambda (vi) 
	       (map (lambda (coli) (dot-product vi coli)) cols))
		   m1)))

; multi between matrices: linear combination
(define (matrixp-*-matrixp m1 m2)
  (let ((cols (transpose m2)))
    (map (lambda (vi) (matrix-*-vector cols vi)) m1)))