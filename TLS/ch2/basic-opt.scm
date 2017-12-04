; in chapter-2, the book show some useful methods as examples,
; and expain every part of the code

; a lat is a list of atoms
(define lat?
  (lambda (lst)
    (cond ((null? lst) true)
          ((atom? (car lst)) ((lat? (cdr lst))))
          (else false))))

; member? check whether an atom in a lat
(define member?
  (lambda (x lat)
    (cond ((null? lat) false)
          (else (or (eq? x (car lat))
                    (member? x (cdr lat)))))))

; here the book give a commandment 
; that is, remember to add "null?" branch in cond expression
           