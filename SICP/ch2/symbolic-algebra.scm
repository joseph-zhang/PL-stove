#lang scheme
; in thsi file, we are going to implement a simple symbolic algebra system,
; this system show the procession of derivative,
; the main process will use some possible interfaces, letting the derivative procession easier to implement.
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
        (else (error "unknown expression type" exps))))

; now, implement what we need in main derivative process
; check var
(define (variable? exps) (symbol? exps))
; check equality of two variables
(define (same-var? var1 var2) 
  (and (variable? var1) (variable? var2)
       (eq? var1 var2)))
; construct sum form 
(define (makesum exps1 exps2)
  (list '+ exps1 exps2))
; construct product form
(define (makeproduct exps1 exps2)
  (list '* exps1 exps2))
; if sum form?
(define (sum? exps)
  (and (pair? exps) (eq? '+ (car exps))))
; is product form? 
(define (product? exps)
  (and (pair? exps) (eq? '* (car exps))))
; select addend 
(define addend cadr)
;select augend 
(define augend caddr)
;select multiplier
(define multiplier cadr)
;select multiplicand
(define multiplicand caddr)

; a better implementation to define construction process of 
; sum form and product form is using another check method
(define (make-sum exps1 exps2)
  (cond  ((=number? exps1 0) exps2)
         ((=number? exps2 0) exps1)
         ((and (number? exps1 ) (number? exps2)
           (+ exps1 exps2)))
         (else (list '+ exps1 exps2))))

(define (make-product exps1 exps2)
         (cond  ((or (=number? exps1 0) (=number? exps2 0)) 0)
                ((=number? exps1 1) exps2)
                ((=number? exps2 1) exps1)
                ((and (number? exps1 ) (number? exps2)
                  (* exps1 exps2)))
                (else (list '* exps1 exps2))))

; then implement the auxiliary function
(define (=number? exps num)
  (and (number? exps) (= exps num)))
