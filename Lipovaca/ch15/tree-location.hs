-- This file will show you how to construct Zipper and do position on tree.
-- Zipper is a kind of method which is widely used in data structure construction.
import Control.Monad
import Data.List
import Data.Monoid
-- in previous lecture, we have implement a binary tree
data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)
-- use our tree type to construct a tree
freeTree :: Tree Char
freeTree = 
  Node 'P'
    (Node 'O'
      (Node 'L'
        (Node 'N' EmptyTree EmptyTree)
        (Node 'T' EmptyTree EmptyTree))
      (Node 'Y' 
        (Node 'S' EmptyTree EmptyTree)
        (Node 'A' EmptyTree EmptyTree)))
    (Node 'L'
      (Node 'W'
        (Node 'C' EmptyTree EmptyTree)
        (Node 'R' EmptyTree EmptyTree))
      (Node 'A' 
        (Node 'A' EmptyTree EmptyTree)
        (Node 'C' EmptyTree EmptyTree)))
-- to change a node value on tree, you can certainly use pattern matching,
-- but it is very troublesome, not clear. 
-- a better way is using a list to express direction, record the tree path.
data Direction = L | R deriving (Show)
type Directions = [Direction]

-- locate node on tree by using direction record, return value on that node.
elemAt :: Directions -> Tree a -> a
elemAt (L:ds) (Node _ l _) = elemAt ds l
elemAt (R:ds) (Node _ _ r) = elemAt ds r
elemAt [] (Node x _ _) = x
-- a method to change a tree is using direction list directly, reconstruct a new tree.
-- but it is not so efficient, if we want to change our tree many times, lots of time is needed.
changeNode :: Directions -> Tree a -> a -> Tree a
changeNode (L:ds) (Node x l r) y = Node x (changeNode ds l y) r
changeNode (R:ds) (Node x l r) y = Node x l (changeNode ds r y)
changeNode [] (Node _ l r) y = Node y l r

-- a better way is using an additional domain to record another side subtree.
data Crumb a = LeftCrumb a (Tree a) | RightCrumb a (Tree a) deriving (Show)
type Breadcrumbs a = [Crumb a]
-- to express all information, we need a pair.
-- this kind of pair is called Zipper.
type Zipper a = (Tree a, Breadcrumbs a)  -- (Tree a, [Crumb a])

-- functions to move on a tree   
goLeft :: Zipper a -> Zipper a
goLeft (Node x l r, bs) = (l, (LeftCrumb x r):bs)

goRight :: Zipper a -> Zipper a
goRight (Node x l r, bs) = (r, (RightCrumb x l):bs)

goUp :: Zipper a -> Zipper a
goUp (t, (LeftCrumb x r):bs) = (Node x t r, bs)
goUp (t, (RightCrumb x l):bs) = (Node x l t, bs)

-- higher-level change node function 
modify :: (a -> a) -> Zipper a -> Zipper a
modify f (Node x l r, bs) = (Node (f x) l r, bs)
modify f (EmptyTree, bs) = (EmptyTree, bs)

-- replace subtree
attach :: Tree a -> Zipper a -> Zipper a
attach t (_, bs) = (t, bs)

-- go top of a tree
topMost :: Zipper a -> Zipper a
topMost (t, []) = (t, [])
topMost z = topMost (goUp z)

-- a function to simplfy expression
(-:) :: a -> (a -> b) -> b 
x -: f = f x