; this chapter also give many details about Y-combinator 

; we have implemented a function named length to get the length of a list
; it is also an easy and basic recursive procedure
(define p-length
  (lambda (lst)
    (if (null? lst) 0
      (1+ (p-length (cdr lst))))))
  
; here is a function similar to len
; but it can onlt deal with the empty list, it is a partial function
; you know, (eternity '()) will not stop
; note that, suppose we don't have "define" method
(lambda (lst)
  (cond ((null? lst) 0)
        (else (1+ (eternity (cdr lst))))))

; so how can we deal with the list with more elements?
; now, suppose we have a single element list, how to write the procedure?
; just write the previous lambda in the new one
(lambda (lst)
  (cond ((null? lst) 0)
        (else (1+ ((lambda (lst)
                    (cond ((null? lst) 0)
                          (else (1+ eternity (cdr lst))))) 
                  (cdr lst))))))

; how to write a function to deal with a list whose length is not bigger than 2?
; just use the previous method!
(lambda (lst)
  (cond ((null? lst) 0)
        (else (1+ ((lambda (lst)
                    (cond ((null? lst) 0)
                          (else (1+ ((lambda (lst)
                                      (cond ((null? lst) 0)
                                            (else (1+ (eternity
                                                      (cdr lst))))))
                                    (cdr lst))))))
                  (cdr lst))))))

; from above examples, we have got a deeper sense about recursion
; this method do can work. but we cannot write an infinte function 
; here we should abstract out the form
(lambda (p-length)
  (lambda (lst) 
    (cond ((null? lst) 0)
          (else (1+ (p-length (cdr lst)))))))

; rewrite the function to deal with the single element list
((lambda (p-length)
  (lambda (lst) 
    (cond ((null? lst) 0)
          (else (1+ (p-length (cdr lst)))))))
  eternity)

;rewrite the function to deal with a list whose length is not bigger than 1
((lambda (f)
  (lambda (lst)
    (cond ((null? lst) 0)
          (else (1+ (f (cdr lst)))))))
 ((lambda (g)
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ (g (cdr lst))))))) 
  eternity))

; we can transform the form to make it more clear
; here is the first function to deal with single element list
((lambda (mk-length)
  (mk-length eternity))
 (lambda (p-length)
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ (p-length (cdr lst))))))))
; and here is another one
((lambda (mk-length)
  (mk-length
    (mk-length eternity)))
 (lambda (p-length)
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ (p-length (cdr lst))))))))

; we can find that the function we throw in is not important
; so just repace the eternity as mk-length
; the first function
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ (mk-length (cdr lst)))))))) 
; and another function 
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ ((mk-length eternity)
                   (cdr lst))))))))

; then the length function is implemented 
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ ((mk-length mk-length)
                     (cdr lst))))))))

; now reuse the name p-length
((lambda (mk-length)
  (mk-length mk-length))
 (lambda (mk-length)
   ((lambda (p-length)
     (lambda (lst)
       (cond ((null? lst) 0)
             (else (+1 (p-length (cdr lst))))))) 
      (lambda (x)
        ((mk-length mk-length) x)))))

; rewrite the function in another form to extract length
((lambda (le)
  ((lambda (mk-length)
    (mk-length mk-length)) 
   (lambda (mk-length)
     (le (lambda (x)
           ((mk-length mk-length) x))))))
 (lambda (p-length) ; here is our length function form
   (lambda (lst)
     (cond ((null? lst) 0)
           (else (1+ (p-length (cdr lst))))))))

; extract the main part
(lambda (le)
  ((lambda (mk-length)
    (mk-length mk-length))
   (lambda (mk-length)
     (le (lambda (x)
           ((mk-length mk-length) x))))))

; note that this is the Y-combinator
(define Y
  (lambda (le)
    ((lambda (f) (f f)) 
     (lambda (f)
       (le (lambda (x)
             ((f f) x)))))))

; test it~
((Y
(lambda (p-length)
  (lambda (l)
    (cond ((null? l) 0)
          (else (1+ (p-length (cdr l)))))))) '(a b c d))




