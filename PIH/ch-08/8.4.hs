-- solution for ex 8.4
-- construct a procedure to transfer a list into balanced tree

data Tree a = Leaf a | Node (Tree a) (Tree a) deriving (Show)

halve :: [a] -> ([a], [a])
halve xs = splitAt (length xs `div` 2) xs

balance :: [a] -> Tree a
balance [x] = Leaf x
balance xl = let (l, r) = halve xl in
                Node (balance l) (balance r)