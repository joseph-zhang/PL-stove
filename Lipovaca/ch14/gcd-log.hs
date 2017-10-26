-- this file contains an example about gcd algorithms,
-- the target is showing the usage of Writer.
import Data.List
import Control.Monad
import Data.Monoid
import Control.Monad.Writer

-- the normal gcd implementation
gcd' :: Int -> Int -> Int
gcd' a b 
  | b == 0  =  a 
  | otherwise = gcd' b (a `mod` b)

-- try to add log in calculation steps
gcd'' :: Int -> Int -> Writer [String] Int 
gcd'' a b
  | b == 0  =  do 
    tell ["Finished with " ++ show a]
    return a
  | otherwise  =  do
    tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
    gcd'' b (a `mod` b)    

-- Note that the implementation above is more efficient than another version,
-- the reason is that list-appending operation is slow, but adding something in front of a list is fast.
-- to solve this problem, Difference list may help.
-- a Difference list is a function, its parameter is a list, connecting another list in front of it.
diffList :: [a] -> [a]
diffList = \xs -> [] ++ xs
-- however we can define a new type, let it be Monoid instance
newtype DiffList a = DiffList { getDiffList :: [a] -> [a] }
instance Monoid (DiffList a) where
  mempty = DiffList (\xs -> [] ++ xs)
  (DiffList f) `mappend` (DiffList g) = DiffList ( \xs -> f (g xs)) 
-- methods to transfer
toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs ++ )  -- "xs ++" equal to "\x -> xs ++ x" 

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

-- now we can use difference list to rewrite the slower version.
gcdnew :: Int -> Int -> Writer (DiffList String) Int 
gcdnew a b 
  | b == 0  =  do 
    tell (toDiffList ["Finished with " ++ show a])
    return a
  | otherwise = do 
    result <- gcdnew b (a `mod` b)
    tell (toDiffList [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)])
    return result