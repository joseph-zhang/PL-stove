#lang racket

; a naive implementation of quick-sort

; quick-sort : list -> list
(define quick-sort
  (lambda (lst)
    (if (null? lst) '()
        (let ((fst (car lst))
              (snd (cdr lst)))
          (let ((left (filter (lambda (x) (<= x fst))
                              snd))
                (right (filter (lambda (x) (> x fst))
                               snd)))
            (append (quick-sort left)
                    (list fst)
                    (quick-sort right)))))))

; ------------------------------ test code ---------------------------------------
(quick-sort '(8 2 5 2 3))
(quick-sort '(1 1 2 2 2 2 1 1))
(quick-sort '())