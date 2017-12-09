 ; this file contains some basic procedures for tuple
 
 ; a pair is a list with only two s-expressions
(define (a-pair? x)
  (cond ((atom? x) false)
        ((null? x) false)
        ((null? (cdr x)) false)
        ((null? (cddr x)) true)
        (else false)))

; selected function
(define (first x)
  (car x))

(define (second x)
  (cadr x))

(define (third x)
  (caddr x))

(define (build s1 s2)
  (cons s1 (cons s2 '())))

; fun? check if the firsts of a pair list is a set
(define (fun? rel)
  (set? (firsts rel)))

; fullfun? check if the seconds of a pair list is a set
(define (fullfun? rel)
  (set? (seconds rel)))

(define (seconds lst)
  (if (null? lst) '()
    (cons (cadar lst)
          (seconds (cdr lst)))))

; revrel will reverse the first and the second elements in a pair list
(define (revrel rel)
  (if (null? rel) '() 
    (let ((firstpair (car rel))) 
      (let ((fst (first firstpair))
            (snd (second firstpair)))
        (cons (build snd fst) (revrel (cdr rel)))))))