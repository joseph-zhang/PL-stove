#lang planet neil/sicp

; once the assignment is brought to our language, the substitution modle is not proper for evaluation
; hence we construct another one named environment modle, which is the sequence of frames
; use define to make a constraint
; here's our previous bank system
(define make-withdraw
  (lambda (balance) ; residue as free variable
    (lambda (amount)
      (if (>= balance amount)
            (begin (set! balance (- balance amount))
                   balance)
          (error "the funds is insufficient!")))))

; now use this system to construct two DIFFERENT objects
(define W1 (make-withdraw 100))
(define W2 (make-withdraw 100))
(W1 50)
(W2 20)
