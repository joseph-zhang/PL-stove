#lang planet neil/sicp

; table can be also implemented as two-dimensional dict-array
 (define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key1 key2 table)
  (let ((subtable (assoc key1 (cdr table))))
    (if subtable
        (let ((record (assoc key2 (cdr subtable))))
          (if record (cdr record)
              false))
        false)))

(define (insert! key1 key2 value table)
  (let ((subtable (assoc key1 (cdr table))))
    (if subtable
        (let ((record (assoc key2 (cdr subtable))))
          (if record (set-cdr! record value)
              (set-cdr! subtable
                        (cons (cons key2 value)
                              (cdr subtable)))))
        (set-cdr! table
                  (cons (list key1 (cons key2 value))
                        (cdr table))))))

(define (make-table)
  (list '*table*))

; --------------------------------- test code ---------------------------------
(define t (make-table))
(insert! 'math '+ 43 t)
(insert! 'math '- 45 t)
(lookup 'math '+ t)

(insert! 'letters 'a 97 t)
(insert! 'letters 'b 98 t)
(lookup 'letters 'b t)
(lookup 'jak 'm t)
(lookup 'letters 'c t)
(insert! 'letters 'c 99 t)
(lookup 'letters 'c t)
(insert! 'letters 'b 2 t)
(lookup 'letters 'b t)

