-- This file give some examples of Curryand section method.
-- First we should know that
{-
  The reason why we write a function tag as
    max :: (Ord a) => a -> a -> a
  instead of 
    max :: (ord a) => (a -> a) -> a
  is that we are indicating Function Currying.
  
  We can see max as an unary function, and then get partial application.
  to execute :t (max 2), we will get:
    (max 2) :: (Num a, Ord a) => a -> a
  This means that (max 2) is a function.
  
  For the same reason, the expression (mulThree 3 5 8) can be write as
    (((mulThree 3) 5) 8)
  you can consider this function as:
    mulThree :: (Int -> Int -> Int) -> Int
  or using Currying, consider it as:
    mulThree :: Int -> (Int -> (Int -> Int))
  
  When partial application is used, section of an infix function is often given.
  Here we will give some examples of what we have talked about.
-}

-- a simple example of partial application
-- to compare a number with 100, we can define it as:
comparewithHundred :: Int -> Ordering
comparewithHundred x = compare 100 x
-- also, we can define it as:
comparewithHundred' :: Int -> Ordering
comparewithHundred' = compare 100

-- now we use section method on an infix function.
divideByTen :: (Floating a) => a -> a
divideByTen  = (/ 10)