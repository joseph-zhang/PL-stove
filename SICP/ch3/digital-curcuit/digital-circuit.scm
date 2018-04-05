; now that we have implemented two utility files,
; here we are going to construct some simulation of digital circuit block
#lang racket
(require (planet neil/sicp))
(require "./after-delay.scm")
(require "./wire-utility.scm")


;;----------------------------------------- Gate circuit -------------------------------------------
; inverter
(define (inverter input output)
  (define (invert-input)
    (let ((new-value (logical-not (get-signal input))))
      (after-delay inverter-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! input invert-input)
  'ok)

; auxiliary logical function
(define (logical-not s)
  (cond ((= s 0) 1)
        ((= s 1) 0)
        (else (error "Invalid signal" s))))

; and gate
(define (and-gate a1 a2 output)
  (define (and-action-proc)
    (let ((new-value (logical-and (get-signal a1)
                                  (get-signal a2))))
      (after-delay and-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 and-action-proc)
  (add-action! a2 and-action-proc)
  'ok)

; auxiliary logical function
(define (logical-and s1 s2)
  (if (and (= s1 1)
           (= s2 1)) 1
      0))

; or gate
(define (or-gate a1 a2 output)
  (define (or-action-proc)
    (let ((new-value (logical-or (get-signal a1)
                                 (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-proc)
  (add-action! a2 or-action-proc))

; auxiliary logical function
(define (logical-or s1 s2)
  (if (or (= s1 1)
         (= s2 1)) 1
     0))

; circuit delay time
(define inverter-delay 2)
(define and-gate-delay 3)
(define or-gate-delay 5)


;;----------------------------------------- adder definition ---------------------------------------
; half adder
(define (half-adder a b s c)
  (let ((d (make-wire))
        (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

; full adder
(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

;;--------------------------------------- test code --------------------------------------------
; construct four wires as adder block port
(define input-1 (make-wire))
(define input-2 (make-wire))
(define sum (make-wire))
(define carry (make-wire))

; then add monitor on two ports
(probe 'sum sum)
(probe 'carry carry)

; construct half adder
(half-adder input-1 input-2 sum carry)

; change wire state and check wire state
(set-signal! input-1 1)
(propagate)

(set-signal! input-2 1)
(propagate)

