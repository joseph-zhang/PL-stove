;A binary mobile structure can be defined as:
(define (make-mobile left right)
  (list left right))
;a (left/right) branch can be defined as:
(define (make-branch len structure)
  (list len structure))
;this "structure" can be a value or a mobile structure.

;there are some selective process to get informations.
(define (left-branch items)
  (car items))
(define (right-branch items)
  (cadr items))
(define (branch-length branch)
  (car branch))
(define (branch-structure branch)
  (cadr branch))

;the process to get total value of mobile structure
(define (total-weight items)
  (define (branch-weight branch)
    (if (pair? (branch-structure branch))
	      (total-weight (branch-structure branch)) 
	    (branch-structure branch)))
  (+ (branch-weight (left-branch items)) 
     (branch-weight (right-branch items)))) 
	 
;the process to check if a mobile structure is balanced
(define (mobile-balance? items)
  (define (branch-balance? branch)
    (if (pure-branch? branch) true
	    (mobile-balance? (branch-structure branch))))
  (let ((Lb (left-branch items))
        (Rb (right-branch items)))
    (and (= (branch-torque Lb)
            (branch-torque Rb))
         (branch-balance? Lb)
		 (branch-balance? Rb))))
		 
(define (pure-branch? branch)
  (not (pair? (branch-structure branch))))
  
(define (branch-torque branch)
  (* (branch-length branch)
     (branch-weight branch)))

(define (branch-weight branch)
  (if (pair? (branch-structure branch))
	    (total-weight (branch-structure branch)) 
	  (branch-structure branch)))