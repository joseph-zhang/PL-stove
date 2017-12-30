-- solution for ex. 1.4
-- another version of qsort, in descending order
qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x:xs) = 
    let left = [s | s <- xs , s > x]
        right = [s | s <- xs, s <= x]
    in (qsort left) ++ [x] ++ (qsort right)