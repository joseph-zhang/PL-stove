-- naive solution for ex 8.3
-- this exercise gives a method to check if a binary tree is balanced

-- declaration of binary tree
data Tree a = Leaf a | Node (Tree a) (Tree a)

-- method to count leafs in a subtree (slow)
count :: Tree a -> Int
count (Leaf _) = 1
count (Node l r) = count l + count r 

-- check it recursively
balanced :: Tree a -> Bool
balanced (Leaf _) = True
balanced (Node l r) = abs (count l - count r) <= 1 &&
                        balanced l && balanced r
