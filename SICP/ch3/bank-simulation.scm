#lang planet neil/sicp

; in this chapter, we introduce the state in system
; once the object can be calculated with state, the assignment operation must be considered about.
; a system maybe contains some objects with their own local states
; as an example, here is a bank withdraw systerm
; note that once the set! is used, procedures can no longer be seen as the pure mathematical function

; need not to write sign, because unpure
(define make-withdraw
  (lambda (balance) ; residue as free variable
    (lambda (amount)
      (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
          (error "the funds is insufficient!")))))


; go deeper, this method can be used to design a simple bank system
; using the message passing to dispatch operations
(define make-account
  (lambda (balance)
    (define (withdraw amount)
      (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
          (error "the funds is insufficient!")))
    (define (deposit amount)
      (begin (set! balance (+ balance amount))
             balance))
    (lambda (message)
      (cond ((eq? message 'withdraw) withdraw)
            ((eq? message 'deposit) deposit)
            (else
               (error "Unknown request -- MAKE-ACCOUNT" message))))))

; --------------------------- test code ----------------------------
(define acc (make-account 100))
((acc 'withdraw) 45)
((acc 'deposit) 23)
((acc 'withdraw) 100) ; the funds is insufficient!
