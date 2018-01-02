-- solution for ex. 6.5
-- use the previous defined merge procedure to implement merge sort
msort :: (Ord a) => [a] -> [a]
msort [] = []
msort [x] = [x]
msort lst = merge (msort xs) (msort ys)
    where (xs, ys) = split lst

split :: [a] -> ([a],[a])
split [] = ([],[])
split [x] = ([x],[])
split (x:y:rest) = (x:xs, y:ys)
    where (xs, ys) = split rest

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge lsta@(x:xs) lstb@(y:ys)
    | x < y  = x: merge xs lstb
    | x > y  = y : merge lsta ys
    | otherwise = x : y : merge xs ys