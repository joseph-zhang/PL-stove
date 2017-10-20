-- This file will give some examples about file read/write method
import Control.Monad
import Data.Char
import System.IO

main = do 
  -- simple method, use "openFile" to open a file with a particular mode
  -- it will produce a handle related to the file 
  handle <- openFile "girlfriend.txt" ReadMode
  contents <- hGetContents handle
  putStr contents
  -- close the file
  hClose handle
  
  --another method, use "withFile" with lambda function
  -- it makes sure the file closed after our process
  withFile "girlfriend.txt" ReadMode (\handle -> do 
                                       contens <- hGetContents handle
                                       putStr contents)
  -- a simple process is just use "readFile"
  contents <- readFile "girlfriend.txt"
  putStr contents