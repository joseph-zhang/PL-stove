;map is very important for list process.
;In this file, I'll give some basic examples of inner "map" method.
(map + (list 1 2 3) (list 2 3 4) (list 100 200 300))

(map (lambda (x y) (+ x (* 2 y)))
  (list 1 2 3)
  (list 4 5 6))
  
(map (lambda (x y z) (+ z (* x y)))
  (list 1 2 3)
  (list 2 3 4)
  (list 100 200 300))
 