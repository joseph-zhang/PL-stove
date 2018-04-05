#lang planet neil/sicp
; this file contains a system that reoresent simple single variable polynomial arithmetic.
; to implement this system, we will use the method which has been talked about in previous files,
; the data-oriented model is chosen because the system is not so big.
; recalliong the derive system in 2.3.2
; constrcuted procedure : make-poly
; selective procedure : variable term-list

; variable? : obj -> Bool  
(define variable?
  (lambda (v)
    (symbol? v)))

; same-variable? : obj -> obj -> Bool
(define same-variable?
  (lambda (v1 v2)
    (and (variable? v1)
         (variable? v2)
         (eq? v1 v2))))

; addition method
; add-poly : poly -> poly -> poly
(define add-poly
  (lambda (p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
          (make-poly (variable p1)
                     (add-terms (term-list p1)
                               (term-list p2)))
        (error "Polys not in same var -- ADD-POLY" (list p1 p2)))))

; multi method
; mul-poly : poly -> poly -> poly
(define mult-poly
  (lambda (p1 p2)
    (if (same-variable? (variable p1)
                        (variable p2))
          (make-poly (variable p1)
                     (mult-terms (term-list p1)
                                (term-list p2)))
        (error "Polys not in same var -- MUL-POLY" `(,p1 ,p2)))))
; constructed procedure 
; make-poly : Symbol -> termlistlist -> poly
(define make-poly 
  (lambda (var terms)
    (cons var terms)))

; selective procedures
; variable : poly -> Symbol
(define variable car)
; term-list : poly -> termlist
(define term-list cdr)

; the term-list is a new structure
; constructed procedure : the-empty-termlist adjoint-term 
; selective procedure : first-term rest-terms
; predicate : empty-termlist?

; every term in term-list is also a kind of structure
; constructed procedure : make-term
; selective procedure : order coeff

; term-list addition : termlist -> termlist -> termlist
(define add-terms
  (lambda (terms1 terms2)
    (cond ((empty-termlist? terms1) terms2)
          ((empty-termlist? terms2) terms1)
          (else 
            (let ((fst-term1 (first-term terms1))
                  (fst-term2 (first-term terms2)))
              (cond ((> (order fst-term1) (order fst-term2))
                       (adjoint-term fst-term1
                         (add-terms (rest-terms terms1)
                                    terms2)))
                    ((< (order fst-term1) (order fst-term2))
                       (adjoint-term fst-term2 
                         (add-terms terms1
                                    (rest-terms terms2))))
                    (else 
                      (adjoint-term
                        (make-term (order fst-term1)
                                   (add (coeff fst-term1) ; note that here we use add instead of +
                                        (coeff fst-term2))) 
                        (add-terms (rest-terms terms1)
                                   (rest-terms terms2))))))))))

; mul-terms : termlist -> termlist -> termlist
(define mult-terms
  (lambda (terms1 terms2)
    (if (empty-termlist? terms1) (the-empty-termlist)
        (add-terms 
          (mul-term-by-all-terms 
            (first-term terms1) terms2)
          (mult-terms (rest-terms terms1)
                      terms2)))))

; mul-term-by-all-terms : term -> termlist -> termlist
(define mul-term-by-all-terms
  (lambda (term termlst)
    (if (empty-termlist? termlst)
          (the-empty-termlist)
        (let ((t (first-term termlst)))
          (adjoint-term
            (make-term (+ (order term) (order t))
                       (mul (coeff term) (coeff t)))  ; note that here we use mul instead of *
            (mul-term-by-all-terms term (rest-terms termlst)))))))

; now, implement basement procedures, termlist and term
(define (adjoint-term term termlist)
  (if (=zero? (coeff term)) termlist
      (cons term termlist)))

(define (the-empty-termlist) '())
(define first-term car)
(define rest-terms cdr)
(define empty-termlist? null?)
(define make-term 
 (lambda (order coeff)
   (list order coeff)))
(define order car)
(define coeff cadr)
(define add +)
(define mul *)

(define =zero?
  (lambda (coe)
    (if (number? coe) (zero? coe)
        (if (pair? coe) false
            (error "Bad type -- =ZERO?" coe)))))



; -------------------------- test code ------------------------------
; 5x^2 + 3x + 7
(define poly1
  (make-poly 'x
    (adjoint-term (make-term 2 5)
      (adjoint-term (make-term 1 3)
        (adjoint-term (make-term 0 7)
                       (the-empty-termlist))))))

; p1 add p1 = 10x^2 + 6x + 14
(add-poly poly1 poly1)
; p1 mul p1 = 25x^4 + 15x^3 + 35x^2 + 15x^3 + 9x^2 + 21x + 35x^2 + 21x + 49
;           = 25x^4 + 30x^3 + 79x^2 + 42x + 49
(mult-poly poly1 poly1)
