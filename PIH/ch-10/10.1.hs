-- this is a simple answer for exercise 10.1
-- about sequence_ function: Evaluate each action in the sequence from left to right, and ignore the results.
-- the original tag is sequence_ :: Monad m => [m a] -> m (), so it can be sequence_ :: [IO a] -> IO ()

putStr' :: String -> IO ()
putStr' xs = sequence_ [putChar x | x <- xs]
