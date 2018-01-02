-- the implementation of insert sort method
-- auxiliary procedure, insertion
insert :: (Ord a) => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys)
    | x <= y  = x:y:ys
    | otherwise  = y : (insert x ys)
    
-- insertion sort
isort :: (Ord a) => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)