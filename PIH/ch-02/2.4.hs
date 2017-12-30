-- solution for ex. 2.4
-- the func of last 
last' :: [a] -> a
last' [] = error "The list is empty"
last' [x] = x
last' (x:xs) = last' xs