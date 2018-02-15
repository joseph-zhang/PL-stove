-- this is a simple game, two players take in turn to remove one or more stars from the end of a single row.
-- these two players are playing on a board comprising five numbered rows of stars.
-- The winner is the player who makes the board empty.
import Data.Char

-- alias
type Board = [Int]
-- representation of board
initial :: Board
initial = [5,4,3,2,1]

-- exchange turn
next :: Int -> Int
next 0 = 1
next 1 = 0

-- end of the game
finished :: Board -> Bool
finished = all (== 0)

-- check if an action is valid
valid :: Board -> Int -> Int -> Bool
valid board row num = board !! (row - 1) >= num

-- refresh board state
refresh :: Board -> Int -> Int -> Board
refresh board row num = [update r n | (r,n) <- zip [1..] board]
                            where update r n = if r == row then 
                                    n-num else n
            
-- show board state
putRow :: Int -> Int -> IO ()
putRow row num = do putStr (show row)
                    putStr ": "
                    putStrLn $ concat $ (replicate num "* ")

putBoard :: Board -> IO ()
putBoard [a,b,c,d,e] = do putRow 1 a
                          putRow 2 b
                          putRow 3 c
                          putRow 4 d
                          putRow 5 e

newline :: IO ()
newline = putChar '\n'

-- safe digit input 
getDigit :: String -> IO Int
getDigit prompt = do putStr prompt
                     x <- getChar
                     newline
                     if isDigit x then
                        return (digitToInt x)
                     else
                        do putStrLn "ERROR OCCUR: Invalid digit"
                           getDigit prompt

play :: Board -> Int -> IO ()
play board player =  do newline
                        putBoard board
                        if finished board then
                            do newline
                               putStr "Player "
                               putStr (show $ next $ player)
                               putStrLn " Wins!"
                        else 
                            do newline
                               putStr "Player "
                               putStrLn (show player)
                               row <- getDigit "Enter a row number: "                          
                               num <- getDigit "Start to remove: "
                               if valid board row num then 
                                  play (refresh board row num) (next player)
                               else do newline
                                       putStr "ERROR OCCUR: invalid action!"
                                       play board player

-- nim game
nim :: IO ()
nim = do play initial 0