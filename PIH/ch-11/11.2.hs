-- This is the exmaple of solution for ex. 11.2
-- just generate all possible best moves, and use random function

import TicTac
import System.Random as SR hiding (next)
import System.IO as SIO

-- procedure to generate all possible moves instead of
-- just select the first one
bestmoves :: Grid -> Player -> [Grid]
bestmoves g p = [g' | Node (g',p') _ <- ts, p' == best]
                where
                  tree = prune depth (gametree g p)
                  Node (_,best) ts = minimax tree

-- rewrite the run function
-- the second parameter represent who is deciding
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
                          let gs = bestmoves g p
                          n <- randomRIO(0, length gs)
                          run (gs !! n) (next p)

-- main function as before                          
main :: IO ()
main = do SIO.hSetBuffering SIO.stdout SIO.NoBuffering
          run empty O
