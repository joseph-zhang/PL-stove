{- This file contains some examples of Haskell type inferences
 and we are going to see a few instances of serious process definition -}
-- Note that this file can not be compiled correctly, you should test it in GHCi.

:t 'a' -- result: 'a' :: Char
:t True -- result: True :: Bool
:t "Hello" -- result: "Hello" :: [Char]
:t (True, 'a') -- result: (True, 'a') :: (Bool, Char)

-- in later files, we will define a function with a more serious way
-- that is, we will add the type of a function. Here are some examples
removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [c | c <- st, c 'elem' ['A'..'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

-- and this is an example of type variable
-- the letter 'a' below is the type variable, it can represent any of common types 
-- this provides a method to implement "polymorphic" 
myhead :: [a] -> a
myhead (x:xs) = x 