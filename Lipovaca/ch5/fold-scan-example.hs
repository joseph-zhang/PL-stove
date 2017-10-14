-- This file will give some examples of fold and scan

{-
  "fold" is an abstract calculate pattern to traverse a list
  some common processes: foldl, foldr, foldl1, foldr1 
-}

-- rewrite sum process with fold, using Currying method.
-- here we saves input list
sum' :: (Num a) => [a] -> a
sum' = foldl (+) 0

-- an example of "foldr"
map' :: (a -> b) -> [a] -> [b]
map' f lst = foldr (\x result -> f x : result) [] lst

-- Note that foldl cannot execute infinite list but foldr can do this.
elem' :: (Eq a) => a -> [a] -> Bool
elem' x lst = foldr (\y result -> if (x == y) then True else result) False lst

-- foldl1 and foldr1 is similar, but we need not to give initial value,
-- but use the first/last element as initial value.
-- Note that you need to check if the list is empty
maximum' :: (Ord a) => [a] -> a 
maximum' = foldl1 max

{-
  "scan" is also an abstract calculate pattern to traverse a list
  some common processes: scanl, scanr, scanl1, scanr1 
  but it is different from "fold", "scan" will return a list 
-}

sqrtSums :: Int
sqrtSums = length (takeWhile (< 1000) (scanl1 (+) (map sqrt [1..]))) + 1

fulls :: (Ord a) => [a] -> [a]
fulls = scanl1 (\x result -> if x > result then x else result) 
