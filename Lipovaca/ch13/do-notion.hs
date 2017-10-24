-- this file will talk about do notion.
-- we have used do notion in I/O action. Actually, we can use it on every Monad instance.
import Data.List
import Control.Monad
-- let's see an example 
res = Just 3 >>= (\x -> Just (show x ++ "!")) -- Just "3!"
res' = Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y)))  -- Just "3!"
-- to write it in a function
foo :: Maybe String 
foo = Just 3 >>= (\x -> 
      Just "!" >>= (\y ->
      Just (show x ++ y)))
-- use do notion to rewrite it, this form is very concise
foo' :: Maybe String 
foo' = do 
  x <- Just 3
  y <- Just "!"
  Just (show x ++ y)

