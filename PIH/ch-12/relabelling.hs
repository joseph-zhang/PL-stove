{-
Since the state monad has been constructed, we can use it to do label
here, a relabelling function is developed.
-}
import StateM as SM

-- type definition
data Tree a = Leaf a
            | Node { leftTree  :: (Tree a)
                   , rightTree :: (Tree a)} deriving (Show) 

-- simply relabel definition
rlabel :: Tree a -> Int -> (Tree Int, Int)
rlabel (Leaf _) n   = (Leaf n, n+1)
rlabel (Node l r) n = (Node l' r', n'') where
  (l', n')  = rlabel l n
  (r', n'') = rlabel r n'


-- state transformer, return current state as result, and new state as next param
-- which is a value of the accompanying state
fresh :: SM.ST Int
fresh = SM.S (\n -> (n, n+1))

-- applicative relabel definition
alabel :: Tree a -> SM.ST (Tree Int)
alabel (Leaf _)   = Leaf <$> fresh
alabel (Node l r) = Node <$> alabel l <*> alabel r  

-- monadic relabel definition
mlabel :: Tree a -> SM.ST (Tree Int)
mlabel (Leaf _) = do n <- fresh
                     return (Leaf n)
mlabel (Node l r) = do l' <- mlabel l
                       r' <- mlabel r
                       return (Node l' r')

{- ******************************* Test Code ******************************** -}
-- define a Tree
tree :: Tree Char
tree = Node (Node (Leaf 'a') (Leaf 'b')) (Leaf 'c')            
