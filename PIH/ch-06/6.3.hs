-- solution for ex. 6.3

and' :: [Bool] -> Bool
and' [] = True
and' (x:xs)
    | x == True  = and xs
    | otherwise  = False 

concat' :: [[a]] -> [a]
concat' [] = []
concat' (x:xs) = x ++ concat' xs

replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x: replicate' (n-1) x

infixl 5 -!!-
(-!!-) :: [a] -> Int -> a
(-!!-) [] _ = error "index too large!"
(-!!-) (x:xs) n
    | n == 0  =  x
    | otherwise = xs -!!- (n-1)

elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
    | a == x    = True
    | otherwise = elem' a xs