-- we are going to implement a classic game named tic tac toe.
-- this is the version for two human players
import qualified Data.List as L
import qualified Data.Char as C
import qualified System.IO as SIO

-- grid size
size :: Int
size = 3

-- player state
data Player = O | B | X deriving (Show,Eq,Ord,Read)

type Grid = [[Player]]

-- switch player
next :: Player -> Player
next O = X
next B = B
next X = O

-- empty grid definition 
empty :: Grid
empty = replicate size (replicate size B)

-- grid state chekcing, full state
full :: Grid -> Bool
full = all (/= B) . concat

-- decide the turn
turn :: Grid -> Player
turn g = if os <= xs then O else X
            where
              os = (length . filter (== O)) ps
              xs = (length . filter (== X)) ps
              ps = concat g
              
-- decide if a player wins
wins :: Player -> Grid -> Bool
wins p g = any (all (== p)) (rows ++ cols ++ dias)
           where
             rows = g
             cols = L.transpose g
             dias = [diag g, diag (map reverse g)]
             
-- diag procedure returns main diagonal of a grid
diag :: Grid -> [Player]
diag g = [g !! n !! n | n <- [0..size-1]]

-- if a player has won
won :: Grid -> Bool
won g = wins O g || wins X g


-- displaying utilities
-- display player state
showPlayer :: Player -> [String]
showPlayer O = ["   ", " O ", "   "]
showPlayer B = ["   ", "   ", "   "]
showPlayer X = ["   ", " X ", "   "]

-- utility to insert bar
interleave :: a -> [a] -> [a]
interleave x []     = []
interleave x [y]    = [y]
interleave x (y:ys) = y : x : interleave x ys 

-- display an row 
showRow :: [Player] -> [String]
showRow = beside . interleave bar . map showPlayer
          where
            beside = foldr1 (zipWith (++))
            bar    = replicate 3 "|"
            
-- display the grid 
putGrid :: Grid -> IO ()
putGrid = putStrLn . unlines . concat . interleave bar . map showRow
          where bar = [replicate (size*4-1) '-']
                
           
-- now move, set a newplayer to replace empty position
-- if the position is valid, all the position in grid is numbered 
valid :: Grid -> Int -> Bool
valid g i = 0 <= i && i < size^2 && concat g !! i == B 

-- move action
move :: Grid -> Int -> Player -> [Grid]
move g i p = if valid g i then [chop size (xs ++ [p] ++ ys)] else []
             where (xs,B:ys) = L.splitAt i (concat g)

chop :: Int -> [a] -> [[a]]
chop n [] = []
chop n xs = take n xs : chop n (drop n xs)

-- interactive utilities
getNat :: String -> IO Int
getNat prompt = do putStr prompt
                   xs <- getLine
                   if xs /= [] && all C.isDigit xs then
                     return (read xs)
                   else
                     do putStrLn "ERROR!-->> Invalid number!"
                        getNat prompt

type Pos = (Int, Int)

cls :: IO ()
cls = putStr "\ESC[2J"

goto :: Pos -> IO ()
goto (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

-- actions to play
run :: Grid -> Player -> IO ()
run g p = do cls
             goto (1,1)
             putGrid g
             run' g p
                     
-- auxiliary procedure
run' :: Grid -> Player -> IO ()
run' g p | wins O g  = putStrLn "Player O wins!\n"
         | wins X g  = putStrLn "Player X wins!\n"
         | full g    = putStrLn "It's a draw!\n"
         | otherwise = do i <- getNat (prompt p)
                          case move g i p of
                            [] -> do putStrLn "ERROR!-->> Invalid move"
                                     run' g p
                            [g'] -> run g' (next p)

prompt :: Player -> String
prompt p = "Player " ++ show p ++ ", enter your move: "

playgame :: IO ()
playgame = do putStr "Which player is the first turn?(O/X) "
              turn <- getLine
              if turn == "O" || turn == "X" then 
                run empty (read turn)
              else
                do putStrLn "ERROR!-->> Invalid turn, should be 'X' or 'O',"
                   putStr "now try again, "
                   playgame
