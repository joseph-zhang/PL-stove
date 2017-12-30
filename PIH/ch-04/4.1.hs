-- solution for ex. 4.1
halve :: [a] -> ([a], [a])
halve lst = (s1, s2) where
    s1 = (take $ len $ lst) lst
    s2 = reverse . (take $ len $ lst) . reverse $ lst 

-- auxiliary function
len :: [a] -> Int
len = (`div` 2) . length
