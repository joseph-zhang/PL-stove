; here we are going to implement a digital curcuit simulation
; At the same time, this is also an example of Event driven method
#lang racket
(require (planet neil/sicp))
(provide (all-defined-out))

;;----------------- wire utilities -------------------
; wire construction, using message passing style
(define (make-wire)
  (let ((signal-value 0)
        (action-procedures '()))
    (define (set-my-signal! new-value)
      (if (not (= signal-value new-value))
          (begin (set! signal-value new-value)
                 (call-each action-procedures))
          'done))
    (define (accept-action-procedure! proc)
      (set! action-procedures (cons proc action-procedures))
      (proc)) ;note that the procedure should be invoked when it is accpted
    (define (dispatch m)
      (cond  ((eq? m 'get-signal) signal-value)
             ((eq? m 'set-signal!) set-my-signal!)
             ((eq? m 'add-action!) accept-action-procedure!)
             (else (error "unkonw operation -- WIRE" m))))
    dispatch))

; auxiliary function, call-each
(define (call-each procedures)
  (if (null? procedures) 'done
      (begin ((car procedures))
             (call-each (cdr procedures)))))

; wire interface
(define (get-signal wire)
  (wire 'get-signal))

(define (set-signal! wire new-value)
  ((wire 'set-signal!) new-value))

(define (add-action! wire action)
  ((wire 'add-action!) action))
