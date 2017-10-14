-- In this file, we will see some examples of recursion 
-- Now we are going to re-implement some inner functions of Haskell


maximum' :: (Ord a) => [a] -> a
maximum' [] = error "list is empty1"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

replicate' :: Int -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x : (replicate' (n-1) x)

take' :: Int -> [a] -> [a]
take' n _ 
    | n <= 0 = []
take' _ [] = []
take' n (x:xs) = x : (take' (n-1) xs)

reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = (reverse' xs) ++ [x]

repeat' :: a -> [a]
repeat' x = x : (repeat' x) -- Note that this will construct an infinite list

zip' :: [a] -> [b] -> [(a, b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : (zip' xs ys)

elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
    | a == x = True
    | otherwise = (elem' a xs)
	