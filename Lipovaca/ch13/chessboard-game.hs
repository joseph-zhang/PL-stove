-- this file show a simple implementation about a chessboard game.
-- this implementation can be an example of indeterminate value (list) 
import Data.List
import Control.Monad 

-- position of chess pieces 
type KnightPos = (Int, Int)

-- positions the chess pieces can arrive at 
moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = filter onBoard 
  [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)
  ,(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
  where onBoard (c,r) = c `elem`[1..8] && r `elem` [1..8]
-- also, remember that filter method can be implemented by using guard
moveKnight' :: KnightPos -> [KnightPos]
moveKnight' (c,r) = do
  (c',r') <- [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1)
             ,(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
  guard (c' `elem` [1..8] && r' `elem` [1..8])
  return (c', r')

-- 3 times possible next positions
in3 :: KnightPos -> [KnightPos]
in3 start = do 
  first <- moveKnight start
  second <- moveKnight first
  moveKnight second

-- functional process
canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start