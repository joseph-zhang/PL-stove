-- this file is a new version for RPN calculator.
-- when pattern matcing is failed, "Nothing" will be thrown out.
import Control.Monad
import Data.Monoid
import Control.Monad.Writer
import Data.List

-- interface 
solveRPN :: String -> Maybe Double
solveRPN st = do 
  [result] <- foldM foldingFunction [] (words st)
  return result

-- main function
foldingFunction :: [Double] -> String -> Maybe [Double]
foldingFunction (x:y:ys) "*" = return $ (y * x):ys  
foldingFunction (x:y:ys) "+" = return $ (y + x):ys
foldingFunction (x:y:ys) "-" = return $ (y - x):ys
foldingFunction xs numberString = liftM (:xs) (readMaybe numberString)

-- auxiliary function
readMaybe :: (Read a) => String -> Maybe a
readMaybe st = case reads st of [(x, "")] -> Just x
                                _ -> Nothing
