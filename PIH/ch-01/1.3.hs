-- solution for ex. 1.3
-- the product of a list of numbers
prod :: (Num a) => [a] -> a
prod [] = 1
prod (x:xs) = x * prod xs