-- here we are going to implement a simple game of life
-- the rules about life game can be referenced by "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life"
-- a living cell survives if it has precisely two or three neighbouring squares that contain living cells,
-- an empty square gives birth to a living cell if it has precisely three neighbours that contain living cells, and remains empty otherwise.
import Data.List as L

-- action that clears the screen
-- use ANSI control codes
cls :: IO ()
cls = putStr "\ESC[2J"

-- alias of cell position
type Pos = (Int, Int)

-- display a string at a given position
writeat :: Pos -> String -> IO ()
writeat p xs = do goto p
                  putStr xs
                  
goto :: Pos -> IO ()
goto (x, y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")

-- size of game board
width :: Int
width = 10

height :: Int
height = 10

type Board = [Pos]

-- display the living cells on the screen
showcells :: Board -> IO ()
showcells b = sequence_ [writeat p "0" | p <- b]

isAlive :: Board -> Pos -> Bool
isAlive b p = elem p b

isEmpty :: Board -> Pos -> Bool
isEmpty b p = not (isAlive b p)

-- returns the neighbours of a position
neighbs :: Pos -> [Pos]
neighbs (x,y) = map wrap [(x-1,y-1), (x,y-1),
                          (x+1,y-1), (x-1,y),
                          (x+1,y), (x-1,y+1),
                          (x,y+1), (x+1,y+1)]
               
-- wrap takes account of the wrapping around at the edges of the board
wrap :: Pos -> Pos
wrap (x,y) = (((x-1) `mod` width) + 1, ((y-1) `mod` height) + 1)

-- number of cells which around a position 
liveneighbs :: Board -> Pos -> Int
liveneighbs b = length . filter (isAlive b) . neighbs

-- those good cells
survivors :: Board -> [Pos]
survivors b = [p | p <- b, elem (liveneighbs b p) [2,3]]

{-
births :: Board -> [Pos]
births b = [(x,y) | x <- [1..width],
                    y <- [1..height],
                    isEmpty b (x,y),
                    liveneighbs b (x,y) == 3]
-}

births :: Board -> [Pos]
births b = [p | p <- L.nub (concat (map neighbs b)),
                isEmpty b p,
                liveneighbs b p == 3]

{-
rmdups :: Eq a => [a] -> [a]
rmdups []= []
rmdups (x:xs) = x : rmdups (filter (/= x) xs)
-}

-- generate next board
nextgen :: Board -> Board
nextgen b = survivors b ++ births b

wait :: Int -> IO ()
wait n = sequence_ [return () | _ <- [1..n]]

-- life game actions
life :: Board -> IO ()
life b = do cls
            showcells b
            wait 500000
            life (nextgen b)

            
-- example of a board
glider :: Board
glider = [(4,2),(2,3),(4,3),(3,4),(4,4)]
