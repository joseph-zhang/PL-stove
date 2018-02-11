-- a game in chapter 10, guess a word
-- a top-down manner is implemented in this file

import System.IO
  
-- main game function
hangman :: IO ()
hangman = do putStrLn "Think of a word:"
             word <- sgetLine -- character is relacement by placeholder
             putStrLn "Try to guess it:"
             play word
             
-- input and mask the answer word
sgetLine :: IO String
sgetLine = do x <- getCh -- our own io function
              if x == '\n' then
                do putChar x
                   return []
              else
                do putChar '-'
                   xs <- sgetLine
                   return (x:xs)

-- getCh procedure, modify getChar to hide the input on screen
getCh :: IO Char
getCh = do hSetEcho stdin False
           x <- getChar
           hSetEcho stdin True
           return x
           
-- play procedure, define gamer actions
play :: String -> IO ()
play word = do putStr "? "
               guessWord <- getLine
               if guessWord == word then
                 putStrLn "You got it!"
               else
                 do putStrLn (match word guessWord)
                    play word

-- match the answer word
match :: String -> String -> String
match xs ys = [if x `elem` ys then x else '-' | x <-xs]
