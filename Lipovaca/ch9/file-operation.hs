--This file will give some examples about file operation.
-- to redirect input/output, use '<' in GHCi.
-- remember I/O is lazy, once we use foo <- getContents, it just read
-- a part of imput file into memory.
import Data.Char
import Control.Monad
import System.IO

main = do
  -- read lines of a file and print those which is shorter than 10
  contents <- getContents
  putStr (shortLinesOnly contents)
  -- we can do this by using "interact", which is the abstraction of previous process
  -- interact :: (String -> String) -> IO ()

shortLinesOnly :: String -> String
shortLinesOnly = unlines . filter (\line -> length line < 10) . lines


