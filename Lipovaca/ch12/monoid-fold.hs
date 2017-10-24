-- This file will give example about fold method in monoid
import qualified Data.Foldable as F
{- 
recalling the definition of typeclass monoid:
class Monoid m where
  mempty :: m  -- unit element
  mappend : m -> m -> m  -- binary operator
  mconcat :: [m] -> m
  mconcat = foldr mappend mempty
-}
-- we can see the last function mconcat has a foldr process.
-- fold can be applied on any Foldable value, not only for list.
-- or we can say, list is just an instance of Foldable.
res = F.foldl (+) 2 (Just 9)  -- 11
res' = F.foldr (||) False (Just True)  -- True

-- an interesting example is Tree, which is an instance of Foldable. =
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a leftTree rightTree) 
    | x == a = Node x leftTree rightTree  -- do nothing
    | x < a = Node a (treeInsert x leftTree) rightTree  -- recursive insert
    | x > a = Node a leftTree (treeInsert x rightTree)  -- recursive insert

-- instantiation, we can implement function foldMap for Tree.
-- foldMap :: (Monoid m, Foldable t) => (a -> m) -> t a -> m
instance F.Foldable Tree where 
  foldMap f EmptyTree = mempty
  foldMap f (Node x l r) = F.foldMap f l `mappend`
                           f x           `mappend`
                           F.foldMap f r 

-- to construct a tree						   
testTree = foldr treeInsert EmptyTree [10,8,9,6,1,3,5]
-- we can use this process to flat a tree to a list
transTree :: Tree a -> [a]
transTree EmptyTree = []
transTree tree = F.foldMap (\x -> [x]) tree
