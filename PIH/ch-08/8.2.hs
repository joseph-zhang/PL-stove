-- solution for ex 8.2
-- the definition of binary tree 
data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Show,Read)

-- redefine occurs procedure, faster
occurs :: Ord a => a -> Tree a -> Bool
occurs x (Leaf n) = x == n
occurs x (Node l v r) = case compare x v of
                            LT -> occurs x l
                            EQ -> True
                            GT -> occurs x r