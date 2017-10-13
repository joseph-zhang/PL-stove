-- This file will give some examples of pattern matching

-- Two examples of pattern matching in function definition
lucky :: Int -> String
lucky 7 = "Lucky number!"
lucky x = "Out of luck~"  -- using a letter to implement catchall pattern

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n-1)

-- pattern matching in tuple
addVectors :: (Double, Double) -> (Double, Double) -> (Double, Double)
addVectors (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)

first :: (a,b,c) -> a
first (x, _, _) = x

-- pattern matching in list
head' :: [a] -> a
head' [] = error "error! the list is empty~"
head' (x:_) = x

tell :: (Show a) => [a] -> String
tell [] = "empty list!"
tell (x:[]) = "The list has only one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell lst = "this is a long list"

-- an example of as-pattern
firstletter :: String -> String
firstletter "" = "Empty list!"
firstletter all@(x:xs) = "the first letter of "++ all ++ " is " ++ [x]
