-- this file will show some useful I/O functions
-- the effect of "do" combine a sequnce of I/O actions 
import Control.Monad 
import Data.Char

main = do 
    -- putStr is similar to putStrLn, but no Ln..
    putStr "Hey~"
    putStr "I'm Andy"
    putStrLn ", Nice to see you."
    -- putChar will show a character on screen
    putChar 't'
    putChar 'e'
    -- print can stringify a value of Show instance
    print True
    print [3,4,1]
    -- "when" is defined in Control.Monad, just like a control expr 
    input <- getLine
    when (input == "swordfish") $ do
      putStrLn input
    -- sequence return the list of return value of IO actions
    rs <- sequence [getLine, getLine, getLine]
    print rs
    -- mapM and mapM_ 
    mapM print [1,2,3]
    mapM_ print [1,2,3]
    -- forM is similar to mapM, but the position of parameters are different
    colors <- forM [1,2,3,4] (\a -> do
                putStrLn $ "which color do you associate with the number " ++ show a ++ "?"
                color <- getLine
                return color)
    putStrLn "The colors that you associate with 1, 2, 3 and 4 are: "
    mapM putStrLn colors
    -- "forever" can let a IO action do forever 
    forever $ do
      putStr "Give me some input: "
      l <- getLine
      putStrLn $ map toUpper l