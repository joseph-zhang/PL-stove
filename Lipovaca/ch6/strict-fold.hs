-- This file will show the strict fold, which is different from what we have talked about
import Data.List
-- In previous chapter, we talked about fold abstraction
-- when we write the function as:
adding :: (Num a) => [a] -> a 
adding = foldl (+) 0
{-
  if we use this function as: 
    adding [1,2,3]
  the foldl will delay the calculating till	we need the result.
  foldl (+) 0 [1,2,3] = 
  foldl (0 + 1) [2,3] = 
  foldl ((0 + 1) + 2) [3] = 
  foldl (((0 + 1) + 2) + 3) [] = 
  ((0 + 1) + 2) + 3 = 
  (1 + 2) + 3 = 
  3 + 3 = 
  6
  
  We can find that if the input list is very long,
  the calculating process will reach stack overflow. 
-}  

-- the strict fold can deal with this problem
adding' :: (Num a) => [a] -> a 
adding' = foldl' (+) 0
{-
  the strict version of fold is fold' in Data.List
  if we do this, the calculate process will become:
  foldl' (+) 0 [1,2,3] =
  foldl' (+) 1 [2,3] = 
  foldl' (+) 3 [3] = 
  foldl' (+) 6 [] = 
  6
  
  do you remember what we have learnt in SICP? Here is its application.
-}