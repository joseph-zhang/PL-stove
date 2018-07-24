#lang planet neil/sicp

; use alteration method, we can construct a classic data structure named queue
; constructor : make-queue
; selective : empty-queue? front-queue
; changing : insert-queue! delete-queue!
; maintain two pointers to ehance efficiency : front-ptr rear-ptr
; hence, queue structure is represented as a pair of points

(define (make-queue) (cons '() '()))
(define (empty-queue? que) (null? (front-ptr que)))
(define (front-queue que)
  (if (not (empty-queue? que)) (car (front-ptr que))
      (error "the queue is empty!" que)))

(define (front-ptr que) (car que)) ; ptr for head position 
(define (rear-ptr que) (cdr que)) ; ptr for tail position

(define (insert-queue! que x)
  (let ((new-pair (cons x '())))
    (cond ((empty-queue? que)
           (set-front-ptr! que new-pair)
           (set-rear-ptr! que new-pair)
           que)
          (else
           (set-cdr! (rear-ptr que) new-pair)
           (set-rear-ptr! que new-pair)
           que))))
(define (delete-queue! que)
  (cond ((empty-queue? que) (error "queue is empty!"))
        (else (set-front-ptr! que (cdr (front-ptr que)))
              (if (empty-queue? que)
                    (begin (set-rear-ptr! que '()) que) ; #different from sicp here 
                  que))))

(define (set-front-ptr! que x) (set-car! que x))
(define (set-rear-ptr! que x) (set-cdr! que x))

; ------------------------------------ test code ----------------------------------------
(define q (make-queue))
(empty-queue? q)
(insert-queue! q 'a)
(insert-queue! q 'b)
(insert-queue! q 'c)
(front-queue q)
(delete-queue! q)
(front-queue q)
(delete-queue! q)
(front-queue q)
(delete-queue! q)
(empty-queue? q)
