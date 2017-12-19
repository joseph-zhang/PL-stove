#lang racket
(require eopl)

; merge two ordered number list
; merge : list -> list -> list
(define merge
  (lambda (loi1 loi2)
    (cond ((null? loi1) loi2)
          ((null? loi2) loi1)
          (else (cond ((< (car loi1) (car loi2))
                        (cons (car loi1)
                              (merge (cdr loi1) loi2)))
                      (else (cons (car loi2)
                                  (merge loi1 (cdr loi2)))))))))

; -------------------------- test code ---------------------------------
(merge '(1 4) '(1 2 8))
(merge '(35 62 81 90 91) '(3 83 85 90))