-- this file will implement RPN expr calculation.
-- the algorithm to calculate RPN has been talked about.
import Data.List
import Data.Char 

solveRPN :: String -> Double
solveRPN = head . foldl foldingfunc [] . words
  where foldingfunc (x:y:ys) "*" = (y * x) : ys
        foldingfunc (x:y:ys) "+" = (y + x) : ys
        foldingfunc (x:y:ys) "-" = (y - x) : ys
        foldingfunc xs numberString = read numberString : xs