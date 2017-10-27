-- this file will give an example to show the method on how to think about 
-- monad instantiation when we define a data type.
import Data.List
import Data.Ratio
import Control.Monad
import Control.Monad.Writer
import Data.Monoid

-- use rational to express the probability
newtype Prob a = Prob {getProb :: [(a, Rational)]} deriving (Show)

-- it should be instance of Monad
instance Monad Prob where
  return x = Prob [(x, 1%1)]
  m >>= f  =  flatten (fmap f m)
  fail _ = Prob []
 
-- Note that monad is not depend on Functor or Applicative,
-- but we should write instance process for them, using monad functions.
instance Functor Prob where
  fmap = liftM
  
instance Applicative Prob where
  pure = return 
  (<*>) = ap

flatten :: Prob (Prob a) -> Prob a
flatten (Prob xs) = Prob $ concat $ map multAll xs
  where multAll (Prob innerxs, p) = map (\(x, r) -> (x, p*r)) innerxs

-- return to what we have talked about, throwing coins.
data Coin = Heads | Tails deriving (Show, Eq)

-- uniform coin
coin :: Prob Coin
coin = Prob [(Heads, 1%2), (Tails, 1%2)]

-- uneven coin
loadedCoin :: Prob Coin
loadedCoin = Prob [(Heads, 1%10), (Tails, 9%10)]

-- throwing process
flipThree :: Prob Bool
flipThree = do
  a <- coin 
  b <- coin
  c <- loadedCoin 
  return (all (== Tails) [a,b,c])