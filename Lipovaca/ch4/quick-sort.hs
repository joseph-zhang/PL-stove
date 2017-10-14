-- this file will give an implementation of quick sort

quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = 
    let leftinterval = [a | a <- xs, a <= x]
        rightinterval = [a | a <- xs, a > x]
    in (quickSort leftinterval) ++ [x] ++ (quickSort rightinterval)  		