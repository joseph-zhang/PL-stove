{-
many generic functions has their monadic version
map :: Monad m => (a -> m b) -> [a] -> m [b]
filterM :: Monad m => (a -> m Bool) -> [a] -> m [a]
join :: Monad m => m (m a) -> m a
-}

import Data.Char -- contains isDigit and digitToInt
import Control.Monad -- contains filterM and join

-- a function that converts a digit character to its numeric value
conv :: Char -> Maybe Int
conv c
  | isDigit c = Just (digitToInt c)
  | otherwise = Nothing


{- ************************************* test code ************************************ -}
-- what can we do?

-- first example:
-- mapM conv "1234" => Just [1,2,3,4]
-- easy to understand!

-- next example:
-- filterM (\x -> [True, False]) [1,2,3] => [[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]
-- why?
-- think about an implementation of fileterM
{-

filterM :: Monad m => (a -> m Bool) -> [a] -> m [a]
filterM p [] = return []
filterM p (x:xs) = do b <- p x
                      ys <- filterM p xs
                      return (if b then (b:ys) else ys)
-}
-- the keypoint is 'b <- p x' :)

-- the last example:
-- join [[1,2],[3,4],[5,6]] => [1,2,3,4,5,6]
-- join (Just (Just 1)) => Just 1
