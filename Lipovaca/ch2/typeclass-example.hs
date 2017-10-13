-- This file will show you some basic examples of typeclass
-- typeclass is a set of functions, its instance is a particular type.
-- a type can be treated as the instance of more than one typeclass

-- "Eq" typeclass is important and basic
{-
  >:t (==)
  >(==)::(Eq a) => a -> a -> Bool 
-}

-- "Ord" typrclass contains some comparing functions
{-
  >:t (>)
  >(>)::(Ord a) => a -> a -> Bool
-}

-- the instance of "Show" typeclass can be represented as string  
{-
  >show 3
  >"3"
  
  >show 5.33
  >"5.33"
  
  >show True
  >"True"
-}

-- "Read" typeclass is the opposite of typeclass "Show"
{-
  >read "True"||False
  >True

  >read "8.2" + 3.8
  >12.0  
-}

-- the instance of "Enum" typeclass should have successer and predecesor
{-
  >succ 'A'
  >'B'
-}

-- the instance of "Bounded" typeclass should have bound
{-
  >minBound:: Int
  >-2147483648
  
  >maxBound:: Char
  >'\1114111'
-}

-- the instance of "Num" has characteristic of "number"
{-
  >:t 20
  >20 :: (Num a) => a
  
  >:t (*)
  >(*) :: (Num a) => a -> a -> a 
-}

-- "Floating" and "Integeral" typeclass is weaker than "Num"
{-
  >:t fromIntegral
  >fromIntegral :: (Integral a, Num b) => a -> b
-}

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r