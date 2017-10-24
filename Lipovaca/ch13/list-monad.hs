-- this file will give examples about list monad
import Data.List
import Control.Monad

-- list is a very useful Indeterminate structure, also an instance of Monad.
res = [] >>= \x -> ["bad", "mad", "rad"]  -- []
res' = [1,2] >>= \n -> ['a','b'] >>= \ch -> return (n, ch)  -- [(1,'a'),(1,'b'),(2,'a'),(2,'b')]
-- >>= chain is troublesome, we can transfer it by using do notion
listOfTuples :: [(Int, Char)]
listOfTuples = do
  n <- [1,2]  -- Indeterminate value
  ch <- ['a','b']  -- Indeterminate value
  return (n, ch)  -- Cartesian product

-- Note that list comprehension is just syntax sugar of list do-notion.
-- previous function listOfTuples is equal to below definition  
listOfTuples' :: [(Int, Char)]
listOfTuples' = [(n, ch) | n <- [1,2], ch <- ['a', 'b']]

-- here is a problem, list comprehension has filter method
filterRes = [x | x <- [1..50], '7' `elem` show x]  -- [7,17,27,37,47]
-- how can we use monad method to do this?
-- the answer is MonadPlus typeclass and function guard
-- MonadPlus used to express those monoid-like monad instance  
{-
list is a instance of MonadPlus,
instance MonadPlus [] where
  mzero = []
  mplus = (++)
  
guard b is pure () if b is True, and empty if b is False.
function guard used for filtering.
guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()  
guard False = mzero  
-}
-- Thus, we can use these method to implement filter.
filterRes' = [1..50] >>= (\x -> guard ('7' `elem` show x) >> return x)
-- to understand this, let's see some examples:
exa = guard (5 > 2) >> return "cool" :: [String]  -- ["cool"]
exa' = guard (1 > 2) >> return "cool" :: [String]  -- []
-- rewrite it by using do notion
-- remember "Indeterminate" 
sevensOnly :: [Int]
sevensOnly = do
  x <- [1..50]
  guard ('7' `elem` show x)
  return x