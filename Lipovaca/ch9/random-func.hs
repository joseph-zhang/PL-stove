-- This file will give some examples about random process.
-- important module: System.Random
-- important typeclasses: RandomGen, Random

import Data.List
import System.IO
import Control.Monad
import System.Random

-- a simple way to produce random number
-- is use random and mkStdGen, for example: random (mkStdGen 100) :: (Int/Float/Integer..., StdGen)
-- use this method to write a simulation program
threeCoins :: StdGen -> (Bool, Bool, Bool)
threeCoins gen = 
  let (firstCoin, newGen) = random gen
      (secondCoin, newGen') = random newGen
      (thirdCoin, newGen'') = random newGen' 
  in (firstCoin, secondCoin, thirdCoin)
  
-- function "randoms" return an infinite list of random value,
-- this function can be implemented based on funtion "random".
randoms' :: (RandomGen g, Random a) => g -> [a]
randoms' gen = let (value, newGen) = random gen
               in value : randoms' newGen

-- we can also implement a finite version
finiteRandoms :: (RandomGen g, Random a) => Int -> g -> ([a], g)
finiteRandoms 0 gen = ([], gen)
finiteRandoms n gen = 
    let (value, newGen) = random gen
        (restOfList, finalGen) = finiteRandoms (n-1) newGen
    in (value : restOfList, finalGen)

-- I/O action getStdGen and newStdGen are useful
main = do
  gen <- getStdGen
  askForNumber gen

askForNumber :: StdGen -> IO ()
askForNumber gen = do
  let (randNumber, newGen) = randomR (1, 10) gen :: (Int, StdGen)
  putStr "Which number in the range from 1 to 10 am I thinking of? "
  numberString <- getLine
  when (not $ null numberString) $ do 
    let number = read numberString
    if randNumber == number 
      then putStrLn "You win!" 
      else putStrLn $ "you lose, it was " ++ show randNumber
    askForNumber newGen
  