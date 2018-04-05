;The target of this file is understanding "Let"
;First we suppose x has global value 5
(define x 5)

;case1: using let to cover global value => (((3 * 10) + 3) + 5) = 38
(+ (let ((x 3))
        (+ x (* x 10)))     
   x) 
   
;case2: note that the <exp> can only act on <body> => ((3) * (7)) = 21
(let ((x 3)
      (y (+ x 2)))
  (* x y))