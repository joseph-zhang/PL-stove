-- solution for ex. 5.7
-- implement the scalar product
scalarproduct :: [Int] -> [Int] -> Int
scalarproduct a b = sum [x*y | (x,y) <- zip a b]