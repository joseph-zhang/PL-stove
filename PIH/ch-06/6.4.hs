-- solution for ex. 6.4
-- implement merge procedure

merge :: (Ord a) => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge lsta@(x:xs) lstb@(y:ys)
    | x < y  = x: merge xs lstb
    | x > y  = y : merge lsta ys
    | otherwise = x : y : merge xs ys