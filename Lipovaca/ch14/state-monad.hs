-- this file will show how to use state monad
import Control.Monad 
import Data.Monoid
import Data.List
import Control.Monad.Writer
import Control.Monad.State

-- a calculation with state is a function: s -> (a, s)
-- the simulation of stack operation is an obvious example
type Stack = [Int]

pop :: Stack -> (Int, Stack)
pop (x:xs) = (x, xs)

push :: Int -> Stack -> ((), Stack)
push a xs = ((), a:xs)

-- process stack
stackManip :: Stack -> (Int, Stack)
stackManip stack = let 
  ((),newStack1) = push 3 stack
  (a, newStack2) = pop newStack1
  in pop newStack2

-- this form is troublesome, we should manage stage when we use stack operation.
-- to use state monad, we can rewrite these processes.
pop' :: State Stack Int 
pop' = state $ \(x:xs) -> (x, xs)

push' :: Int -> State Stack ()
push' a = state $ \xs -> ((), a:xs)

stackManip' :: State Stack Int
stackManip' = do 
  push' 3
  a <- pop'
  pop' 

-- use put and get in MonadState to get and reset state
stackyStack :: State Stack ()
stackyStack = do 
  stackNow <- get
  if stackNow == [1,2,3]
    then put [8,3,1]
    else put [9,2,1] 
-- we can also implement push and pop by using pop and push
pop'' :: State Stack Int
pop'' = do
  (x:xs) <- get
  put xs
  return x

push'' :: Int -> State Stack ()
push'' a = do
  x <- get  
  put (a:x)

