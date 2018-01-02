-- showing some examples of recursion with multiple arguments
-- the first example is zip function
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y): zip' xs ys

-- drop function of list
drop' :: Int -> [a] -> [a]
drop' 0 lst = lst
drop' _ [] = []
drop' n (x:xs) = drop' (n-1) xs 