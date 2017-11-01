-- This file give an example of zipper on list structure
import Control.Monad
import Data.Monoid
import Data.List

-- a list strucutre can be defined as 
data List' a = Empty | Cons a (List' a) deriving (Show, Eq, Read, Ord)
-- there are only two directions on list, so we can define zipper as
type ListZipper a = ([a], [a])

-- go forward
goForwad :: ListZipper a -> ListZipper a
goForwad (x:xs, bs) = (xs, x:bs)

-- go back 
goBack :: ListZipper a -> ListZipper a
goBack (xs, b:bs) = (b:xs, bs) 