-- This file will give some examples of lambda, 
-- lambda can enhance the abstraction.

-- lambda with pattern matching
addTwo :: [(Int,Int)] -> [Int]
addTwo xx = map (\(a, b) -> a + b) xx

-- using lambda to explain Currying
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

addThree' :: Int -> Int -> Int -> Int
addThree' = \x -> \y -> \z -> x + y + z

-- lambda make a definition more clear
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = \x y -> (f y x)