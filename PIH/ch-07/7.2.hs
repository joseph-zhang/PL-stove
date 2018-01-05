-- solution for ex. 7.2
-- naive implementation of some higher order functions like 
-- all, any, takeWhile, dropWhile

all' :: (a -> Bool) -> [a] -> Bool
all' _ [] = True
all' pred (x:xs) = (pred x) && (all' pred xs)

any' :: (a -> Bool) -> [a] -> Bool
any' _ [] = False
any' pred (x:xs)
    | pred x = True
    | otherwise = any' pred xs

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' pred (x:xs)
    | pred x = x : (takeWhile' pred xs)
    | otherwise = []

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' pred all@(x:xs)
    | pred x = dropWhile' pred xs
    | otherwise = all
 