#lang planet neil/sicp

; table is a structure constructed with a pair, which contains key and value
; just like dict-array in some other languages (but not so efficient)
(define (make-table) (list '*table*)) ; dumb node

(define (lookup key table)
  (let ((record (assoc key (cdr table))))
    (if record (cdr record)
        false)))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (table-insert! key value table)
  (let ((record (assoc key (cdr table))))
    (if record (set-cdr! record value)
        (set-cdr! table (cons (cons key value) (cdr table)))))
  'done.)

; ----------------------------------- test code -------------------------------------
(define t (make-table))
(table-insert! 'a 1 t)
(table-insert! 'b 2 t)
(lookup 'a t)
(lookup 'b t)
(table-insert! 'b 3 t)
(lookup 'b t)

