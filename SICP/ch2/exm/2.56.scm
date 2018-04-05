#lang scheme

; solution for exercise 2.57 
(define (derive exps var)
(cond ((number? exps) 0) 
      ((variable? exps) 
        (if (same-var? exps var) 1 0))
      ((sum? exps) 
        (make-sum (derive (addend exps) var)
                  (derive (augend exps) var)))
      ((product? exps)
        (make-sum (make-product (derive (multiplier exps) var) 
                                (multiplicand exps))
                  (make-product (multiplier exps)
                                (derive (multiplicand exps) var))))
      ((exponentiation? exps) 
        (let ((expo (exponent exps)) 
              (basement (base exps))) 
          (make-product (make-product expo 
                        (make-exponentiation basement (minus-one expo))) 
                        (derive basement var))))
      (else (error "unknown expression type" exps))))

(define (variable? exps) (symbol? exps))
; check equality of two variables
(define (same-var? var1 var2) 
    (and (variable? var1) (variable? var2)
         (eq? var1 var2)))
(define (sum? exps)
  (and (pair? exps) (eq? '+ (car exps))))
; is product form? 
(define (product? exps)
  (and (pair? exps) (eq? '* (car exps))))
; is exponentiation form?
(define (exponentiation? exps)
  (and (pair? exps) (eq? '** (car exps))))
; select addend 
(define addend cadr)
; select augend 
(define augend caddr)
; select multiplier
(define multiplier cadr)
; select multiplicand
(define multiplicand caddr)
; select basement 
(define base cadr)
; select exponent 
(define exponent caddr)

(define (make-product exps1 exps2)
(cond  ((or (=number? exps1 0) (=number? exps2 0)) 0)
       ((=number? exps1 1) exps2)
       ((=number? exps2 1) exps1)
       ((and (number? exps1 ) (number? exps2)
         (* exps1 exps2)))
       (else (list '* exps1 exps2))))

(define (make-sum exps1 exps2)
  (cond  ((=number? exps1 0) exps2)
         ((=number? exps2 0) exps1)
         ((and (number? exps1 ) (number? exps2)
           (+ exps1 exps2)))
         (else (list '+ exps1 exps2))))

; construct method for exponentiation 
(define (make-exponentiation basement expo)
  (cond ((=number? expo 0) 1) 
        ((=number? expo 1) basement)
        ((and (number? basement) (number? expo)
          (expt basement expo))) 
        
        (else (list '** basement expo))))

; (exps - 1) for string minus
(define (minus-one exps)
  (cond ((number? exps) (- exps 1))
        ((sum? exps) 
          (make-sum (addend exps) (- (augend exps) 1))) 
        (else (make-sum exps '-1))))

(define (=number? exps num)
  (and (number? exps) (= exps num)))