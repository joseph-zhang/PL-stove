-- this file will show some examples about function monad,
-- Function monad is also called Reader monad.
import Control.Monad 
-- import Control.Monad.Instances
import Data.Monoid
import Data.List

{-
recalling the instance method of function:

instance Monad ((->) r) where
  return x = \_ -> x
  h >>= f  =  \w -> f (h w) w
-}
-- an example to show how to use function monad
addStuff :: Int -> Int
addStuff = do 
  a <- (*2)
  b <- (+10)
  return (a+b)  -- note that this is a function, \_ -> (a+b), always return (a+b)
-- this is equal to
addStuff' :: Int -> Int
addStuff' x = let 
  a = (*2) x
  b = (+10) x 
  in a + b


