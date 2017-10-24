-- this file will show an example about monad.

-- rename the bird object
type Birds = Int
type Pole = (Birds, Birds)

-- we need to put information in context, this process is likely to fail.
-- if we write normal function without Maybe, a legal result may be produced by an illegal pilot process.
landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right) 
  | abs ((left + n) - right) < 4 = Just (left + n, right)
  | otherwise = Nothing

landRight :: Birds -> Pole -> Maybe Pole 
landRight n (left, right)
  | abs ((right + n) - left) < 4 = Just (left, right + 4)
  | otherwise = Nothing
-- the result of this function is a monad value, we should use >>= to get it and load in the function.

-- now we implement a function to make a fallen down.
banana :: Pole -> Maybe Pole
banana _ = Nothing

-- previous implementation will cause a failure as long as the ">=" string has banana.
-- now we should change it by using >> function.



