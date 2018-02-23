-- in previous section, the human vs human tic-tac-toe game is implemented
-- however, it is more interesting section to add an opponent with game tree
module TicTac
( gametree
, minimax
, prune
, depth
, wins
, full
, prompt
, move
, Player(O,B,X)
, Grid
, Tree(Node)
) where


import qualified Data.List as L
import qualified Data.Char as C
import qualified System.IO as SIO

{-******************************************* Utilities ******************************************-}
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

-- some utilities to manipulate screen with ANSI code
type Pos = (Int, Int)

-- clear screen
cls :: IO ()
cls = putStr "\ESC[2J"

-- cursor move
goto :: Pos -> IO ()
goto (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

{-******************************************* Utilities ******************************************-}


-- game tree definition
data Tree a = Node a [Tree a] deriving (Show)

-- construct game tree,note that the hasekll lazy mode
gametree :: Grid -> Player -> Tree Grid
gametree g p = Node g [gametree g' (next p) | g' <- moves g p]

-- positions the player can move to
moves :: Grid -> Player -> [Grid]
moves g p
  | won g     = []
  | full g    = []
  | otherwise = concat [move g i p | i <- [0..((size^2)-1)]]

-- prune game trees to a particular depth
prune :: Int -> Tree a -> Tree a
prune 0 (Node x _)  = Node x []
prune n (Node x ts) = Node x [prune (n-1) t | t <- ts]

-- set the prune depth
depth :: Int
depth = 9

-- here we use a method named minimax algorithm to determine the best next move (when O is the first turn)
-- because the order of player is O < B < X, hence the selection should be minimum in player O's turn, and vice versa
minimax :: Tree Grid -> Tree (Grid, Player)
minimax (Node g [])
  | wins O g  = Node (g,O) []
  | wins X g  = Node (g,X) []
  | otherwise = Node (g,B) []
minimax (Node g ts)
  | turn g == O = Node (g,minimum ps) ts'
  | turn g == X = Node (g,maximum ps) ts'
                  where
                    ts' = map minimax ts
                    ps = [p | Node (_,p) _ <- ts']

-- aquire next grid state
bestmove :: Grid -> Player -> Grid
bestmove g p = head [g' | Node (g',p') _ <- ts, p' == best]
               where
                 tree = prune depth (gametree g p)
                 Node (_,best) ts = minimax tree
                 
-- IO utilities
run :: Grid -> Player -> IO ()
run g p = do cls
             goto (1,1)
             putGrid g
             run' g p

prompt :: Player -> String
prompt p = "Player " ++ show p ++ ", enter your move: "

-- operator $! is used, forces evaluation of the best move for the computer player prior to the function run being invoked again
run' :: Grid -> Player -> IO ()
run' g p | wins O g  = putStrLn "Player O wins!\n"
         | wins X g  = putStrLn "Player X wins!\n"
         | full g    = putStrLn "It's a draw!\n"
         | p == O    = do i <- getNat (prompt p)
                          case move g i p of
                            [] -> do putStrLn "ERROR!-->> Invalid move"
                                     run' g p
                            [g'] -> run g' (next p)
         | p == X    = do putStr "Player X(computer) is thinking... "
                          (run $! (bestmove g p)) (next p)

-- main control action
-- use function hSetBuffering to turn output buffering off
main :: IO ()
main = do SIO.hSetBuffering SIO.stdout SIO.NoBuffering
          run empty O

-- invoke in ghci 
play :: IO ()
play = run empty O

