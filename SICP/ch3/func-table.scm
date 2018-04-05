#lang planet neil/sicp

; now we have implemented a kind of 2d-table with list structure
; as we can see, table can be implemented as function, just like what we did on queue
; message passing style should also be considered

 (define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))


(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key1 key2)
      (let ((subtable (assoc key1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key2 (cdr subtable))))
              (if record (cdr record)
                  false))
            false)))
    (define (insert! key1 key2 value)
      (let ((subtable (assoc key1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key2 (cdr subtable))))
              (if record (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key1 (cons key2 value))
                            (cdr local-table))))))
    (define (dispatch m)
      (cond ((equal? m 'lookup-proc) lookup)
            ((equal? m 'insert-proc) insert!)
            (else (error "Undefined operation"))))
    dispatch))

(define (lookup key1 key2 table)
  ((table 'lookup-proc) key1 key2))

(define (insert! key1 key2 value table)
  ((table 'insert-proc) key1 key2 value))

; -------------------------------- test code ------------------------------------
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
