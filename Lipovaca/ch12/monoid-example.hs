-- This file will show some examples about monoid
-- we should remember that a monoid value is a certain type value, not a type constructor
-- note that this file cannot be compiled correctly.
import Data.Monoid
-- list is monoid instance
res = [1,2,3] `mappend` [4,5,6]  -- [1,2,3,4,5,6]
res = mconcat [[1,2], [3,6], [9]] -- [1,2,3,6,9]
mempty :: [a]  -- []

-- Product is monoid instance
res = getProduct $ Product 3 `mappend` Product 9  -- 27
res = getProduct $ Product 3 `mappend` mempty  -- 3
res = getProduct . mconcat . map Product $ [3,4,2]  -- 24

-- Sum is monoid instance 
res =  getSum $ Sum 2 `mappend` Sum 9  -- 11
res = getSum $ Sum 2 `mappend` mempty  -- 2
res = getSum . mconcat . map Sum $ [1,2,3]  -- 6

-- Any is monoid instance
res = getAny $ Any True `mappend` Any False  -- True
res = getAny $ Any True `mappend` mempty  -- True
res = getAny . mconcat . map Any $ [False,False,False,True]  -- True

-- All is monoid instance
res = getAll $ All True `mappend` mempty  -- True
res = getAll $ All False `mappedn` mempty  -- False
res = getAll . mconcat . map All $ [True,True,False]  -- False

-- Ordering is monoid instance 
-- use it to write a function 
lengthCompare :: String -> String -> Ordering
lengthCompare x y = let a = length x `compare` length y
                        b = x `compare` y 
                    in if a == EQ then b else a

lengthCompare' :: String -> String -> Ordering
lengthCompare' x y = (length x `compare` length y) `mappend`
                     (vowels x `compare` vowels y) `mappend`
                     (x `compare` y)
  where vowels = length . filter (`elem` "aeiou")

-- Maybe is monoid instance
res = Nothing `mappend` Just "andy"  -- Just "andy"
res = Just LT `mappend` Nothing -- Just LT
res = Just (Sum 3) `mappend` Just (Sum 4)  -- Just (Sum 7)
 	