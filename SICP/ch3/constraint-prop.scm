#lang planet neil/sicp

; the notion of constraint propagation was appeared firstly in SKETCHPAD.
; A program is often described as a process which accept an input and calculate
; the output with some given poarameters. Obviously, it is undirected.

; however, another circumstance is common. In this circumstance, different quantities
; are connected to each other under a specific relationship.

; the implementation of this kind of system can be described as a network.
; Many constraints are connected with connectors, which maintain a value.

; now, a simple constraint propagation system will be implemented.
; this system contains some basic constraints, such as `add`, `multiply` ...

; the most important part of propagation is connector.
; the implementation detail of connector is up to our demand, interface should
; be firstly considered.

; ----------------------------------- interface of connector ---------------------------------------
; has-value? <connector>
; get-value <connector>
; set-value! <connector> <new-value> <informant>
; forget-value! <connvector> <retractor>
; connect  <connector> <new-constraint>

;------------------------------------ constraint implementation ------------------------------------ 
; implement adder constraint
(define (adder a1 a2 sum)
  (define (process-new-value)
    (cond ((and (has-value? a1) (has-value? a2))
           (set-value! sum
                       (+ (get-value a1) (get-value a2))
                       me))
          ((and (has-value? a1) (has-value? sum))
           (set-value! a2
                       (- (get-value sum) (get-value a1))
                       me))
          ((and (has-value? a2) (has-value? sum))
           (set-value! a1
                       (- (get-value sum) (get-value a2))
                       me))))
  (define (process-forget-value)
    (forget-value! sum me)
    (forget-value! a1 me)
    (forget-value! a2 me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknown request -- ADDER" request))))
  (connect a1 me)
  (connect a2 me)
  (connect sum me)
  me) ; me is an adder object

; motivation function
(define (inform-about-value constraint)
  (constraint 'I-have-a-value))

(define (inform-about-no-value constraint)
  (constraint 'I-lost-my-value))


; implement multiplier
(define (multiplier m1 m2 product)
  (define (process-new-value)
    (cond ((and (has-value? m1) (has-value? m2))
           (set-value! product
                       (* (get-value m1) (get-value m2))
                       me))
          ((and (has-value? m1) (has-value? product))
           (set-value! m2
                       (/ (get-value product) (get-value m1))
                       me))
          ((and (has-value? m2) (has-value? product))
           (set-value! m1
                       (/ (get-value product) (get-value m2))
                       me))))
  (define (process-forget-value)
    (forget-value! product me)
    (forget-value! m1 me)
    (forget-value! m2 me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknown request -- MULTIPLIER" request))))
  (connect m1 me)
  (connect m2 me)
  (connect product me)
  me) ; me is a multiplier object

; define constant block
(define (constant value connector)
  (define (me request)
    (error "Unknow request -- CONSTANT" request))
  (connect connector me)
  (set-value! connector value me)
  me) ; me is a constant object

; monitor(probe)
(define (probe name connector)
  (define (print-probe value)
    (newline)
    (display "probe: ")
    (display name)
    (display " = ")
    (display value))
  (define (process-new-value)
    (print-probe (get-value connector)))
  (define (process-forget-value)
    (print-probe "?"))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unkown request -- PROBE" request))))
  (connect connector me)
  me) ; me is a probe object

; ------------------------------------- connector implementation ------------------------------------=
; connector construction
(define (make-connector)
  (let ((value false)
        (informant false)
        (constraints '()))
    (define (set-my-value newval setter)
      (cond ((not (has-value? me))
             (set! value newval)
             (set! informant setter)
             (for-each-except setter
                              inform-about-value
                              constraints))
            ((not (= value newval))
             (error "Constradiction" (list value newval)))
            (else 'ignored)))
    (define (forget-my-value retractor)
      (if (eq? retractor informant)
          (begin (set! informant false)
                 (for-each-except retractor
                                  inform-about-no-value
                                  constraints))
          'ignored))
    (define (connect new-constraint)
      (if (not (memq new-constraint constraints))
          (set! constraints
            (cons new-constraint constraints)))
      (if (has-value? me)
          (inform-about-value new-constraint))
      'done)
    (define (me request)
      (cond ((eq? request 'has-value?)
             (if informant true false))
            ((eq? request 'value) value)
            ((eq? request 'set-value!) set-my-value)
            ((eq? request 'forget) forget-my-value)
            ((eq? request 'connect) connect)
            (else (error "Unknown operation -- CONNECTOR" request))))
    me))

; auxiliary function
(define (for-each-except exception procedure list)
  (define (loop items)
    (cond ((null? items) 'done)
          ((eq? (car items) exception)
           (loop (cdr items)))
          (else (procedure (car items))
                (loop (cdr items)))))
  (loop list))

; ------------------------------------------ interface definition ----------------------------------------
(define (has-value? connector)
  (connector 'has-value?))

(define (get-value connector)
  (connector 'value))

(define (set-value! connector new-value informant)
  ((connector 'set-value!) new-value informant))

(define (forget-value! connector retractor)
  ((connector 'forget) retractor))

(define (connect connector new-constraint)
  ((connector 'connect) new-constraint))

; ----------------------------------------------- test code ---------------------------------------------
; use above implementation to define a constraint system between C and F,
; which represent celsius and fahrenheit respectively.
; the relationship is 9C = 5(F - 32)
; define related connector and then construct network.

(define C (make-connector))
(define F (make-connector))

(define (celsius-fahrenheit-converter c f)
  (let ((u (make-connector))
        (v (make-connector))
        (w (make-connector))
        (x (make-connector))
        (y (make-connector)))
    (multiplier c w u)
    (multiplier v x u)
    (adder v y f)
    (constant 9 w)
    (constant 5 x)
    (constant 32 y)
    'ok))

(celsius-fahrenheit-converter C F)
(probe "Celsius temp" C)
(probe "Fahrenheit temp" F)

(set-value! C 25 'user)
(forget-value! C 'user)
(set-value! F 212 'user)

