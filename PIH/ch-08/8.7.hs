-- solution for ex. 8.7
-- this exercise shows that (Maybe a) is a instance of Eq if a is the instance of Eq
-- note that this block of code can not be loaded in Ghci because it has been implemented in GHC.Base

instance Eq a => Eq (Maybe a) where
  Just x == Just y = x == y
  Nothing == Nothing = False
  _ == _ = False

instance Eq a => Eq [a] where
  (==) :: [a] -> [b] -> Bool
  (x:[]) == (y:[]) = x == y
  (x:xs) == (y:ys) = x == y && xs == ys
  _ == _ = False
