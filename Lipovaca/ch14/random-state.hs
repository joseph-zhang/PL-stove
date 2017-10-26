-- this file will give an example to show relationship betwenn state monad and random.
import System.Random
import Control.Monad.State

-- randomgen value is state, result value is a ramdom value 
-- recalling that, random :: (RandomGen g, Random a) => g -> (a, g)
randomSt :: (RandomGen g, Random a) => State g a 
randomSt = state random

-- rewrite the previous implementation
threeCoins :: State StdGen (Bool, Bool, Bool)
threeCoins = do 
  a <- randomSt
  b <- randomSt
  c <- randomSt
  return (a, b, c)
  
-- then, if you apply a mkStdGen type value on it,
-- for example, executing "runState threeCoins (mkStdGen 33)"
-- result type is ((Bool, Bool, Bool), StdGen)