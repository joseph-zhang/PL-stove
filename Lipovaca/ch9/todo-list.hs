-- we will implement a TODO list 
{-
  a TODO list support three actions :
  1. check assignments;
  2. add an assignment;
  3. delete an assignment.
-}
-- to implement TODO list better, we use command line parameter.

import System.IO
import System.Directory
import System.Environment
import Data.List
import Control.Exception

-- function dispatch: mapping command 
dispatch :: String -> [String] -> IO ()
dispatch "add" = add
dispatch "view" = view
dispatch "remove" = remove

-- main process
main = do 
  (command : argList) <- getArgs
  dispatch command argList
  
-- function add: add an assignment
add :: [String] -> IO ()
add [fileName, todoItem] = appendFile fileName (todoItem ++ "\n")

-- function view: check assignment
view :: [String] -> IO ()
view [fileName] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ "-" ++ line) [0..] todoTasks
  putStr $ unlines numberedTasks

-- function remove: delete an assignment
-- use bracketOnError in Control.Exception to prevent open error (for temp file)
remove :: [String] -> IO ()
remove [fileName, numberString] = do
  contents <- readFile fileName
  let todoTasks = lines contents
      numberedTasks = zipWith (\n line -> show n ++ "-" ++ line) [0..] todoTasks
      numberToDelete = read numberString
      newTodoItems = unlines $ delete (todoTasks !! numberToDelete) todoTasks
  bracketOnError (openTempFile "." "temp") -- tmp file in default directory, its name is "temp"
    (\(tempName, tempHandle) -> do  -- exception process
      hClose tempHandle
      removeFile tempName)
    (\(tempName, tempHandle) -> do  -- normal process
      hPutStr tempHandle newTodoItems
      hClose tempHandle
      removeFile fileName
      renameFile tempName fileName)	  