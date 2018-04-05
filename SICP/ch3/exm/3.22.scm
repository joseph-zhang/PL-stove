#lang planet neil/sicp
; solution for ex. 3.22
; implement queue structure by using message passing style

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (set-front-ptr! x)
      (set! front-ptr x))
    (define (set-rear-ptr! x)
      (set! rear-ptr x))
    (define (front-queue)
      (if (empty-queue?) (error "Queue is empty!")
          (car front-ptr)))
    (define (insert-queue! x)
      (let ((new-pair (cons x '())))
        (if (empty-queue?)
            (begin (set-front-ptr! new-pair)
                   (set-rear-ptr! new-pair))
            (begin (set-cdr! rear-ptr new-pair)
                   (set-rear-ptr! new-pair)))))
    (define (delete-queue!)
      (if (empty-queue?) (error "Queue is empty!")
          (begin (set-front-ptr! (cdr front-ptr))
                 (if (empty-queue?) (set-rear-ptr! '())
                     (display "delete completed.\n")))))
    (define (dispatch m)
      (cond ((eqv? m 'empty-queue?) (empty-queue?))
            ((eqv? m 'front-queue) (front-queue))
            ((eqv? m 'insert-queue!) insert-queue!)
            ((eqv? m 'delete-queue!) (delete-queue!))
            (else (error "Undefined queue operation"))))
    dispatch))

(define (empty-queue? que) (que 'empty-queue?))
(define (front-queue que) (que 'front-queue))
(define (insert-queue! que x) ((que 'insert-queue!) x))
(define (delete-queue! que) (que 'delete-queue!))

; ---------------------------- test code ------------------------------
(define que (make-queue))
(empty-queue? que)
(insert-queue! que 'a)
(front-queue que)
(empty-queue? que)
(insert-queue! que 'b)
(delete-queue! que)
(empty-queue? que)
(front-queue que)
(delete-queue! que)
(empty-queue? que)
