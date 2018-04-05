; now that the interface of wire is given, here we are going to implement after delay method
; the after delay method use a kind of structure named agenda list
#lang racket
(require (planet neil/sicp))
(require "../queue.scm")
(require "./wire-utility.scm")
(provide after-delay
         propagate
         probe)

;;------------------------------- after delay method ----------------------------------
; definition of after delay method, add an item to agenda
(define (after-delay delay action)
  (add-to-agenda! (+ delay (current-time the-agenda))
                  action
                  the-agenda))


; motivate actions
(define (propagate)
  (if (empty-agenda? the-agenda) 'done
      (let ((first-item (first-agenda-item the-agenda)))
        (first-item)
        (remove-first-agenda-item! the-agenda)
        (propagate))))

;;------------------------------- agenda list ------------------------------------
;; agenda list is made up of time segments
(define (make-time-segment time queue)
  (cons time queue))

(define (segment-time s)
  (car s))

(define (segment-queue s)
  (cdr s))

;; agenda list is a linear structure of time segments
; here we need a head to show current time
(define (make-agenda) (list 0))

(define (current-time agenda) (car agenda))

(define (set-current-time! agenda time)
  (set-car! agenda time))

(define (segments agenda) (cdr agenda))

(define (set-segments! agenda segments)
  (set-cdr! agenda segments))

(define (first-segment agenda)
  (car (segments agenda)))

(define (rest-segments agenda)
  (cdr (segments agenda)))

(define (empty-agenda? agenda)
  (null? (segments agenda)))

; add an action to agenda
(define (add-to-agenda! time action agenda)
  (define (belongs-before? segments) ; check if the action time is earlier than given segments
    (or (null? segments)
        (< time (segment-time (car segments)))))
  (define (make-new-time-segment time action) ; make a new time segment
    (let ((q (make-queue)))
      (insert-queue! q action)
      (make-time-segment time q)))
  (define (add-to-segments! segments) ; add an action to current segments
    (if (= (segment-time (car segments)) time)
        (insert-queue! (segment-queue (car segments))
                       action)
        (let ((rest (cdr segments)))
          (if (belongs-before? rest)
              (set-cdr! segments
                        (cons (make-new-time-segment time action)
                              rest))
              (add-to-segments! rest)))))
  (let ((segments (segments agenda)))
    (if (belongs-before? segments)
        (set-segments! agenda
                       (cons (make-new-time-segment time action)
                             segments))
        (add-to-segments! segments))))

; auxiliary procedure of propagate
; remove the first procedure of the queue in the segments list head
(define (remove-first-agenda-item! agenda)
  (let ((q (segment-queue (first-segment agenda))))
    (delete-queue! q)
    (if (empty-queue? q)
        (set-segments! agenda
                       (rest-segments agenda)))))

; auxiliary procedure of propagate
; return the first procedure of the queue in the segments list head
(define (first-agenda-item agenda)
  (if (empty-agenda? agenda)
      (error "Agenda is empty -- FIRST-AGENDA-ITEM")
      (let ((first-seg (first-segment agenda)))
        (set-current-time! agenda (segment-time first-seg))
        (front-queue (segment-queue first-seg)))))


;; set an agenda object
(define the-agenda (make-agenda))

;;----------------------------------------- wire monitor ---------------------------------------------
(define (probe name wire)
  (add-action! wire
               (lambda ()
                 (display name)
                 (display " ")
                 (display (current-time the-agenda))
                 (display "  New-value = ")
                 (display (get-signal wire))
                 (newline))))