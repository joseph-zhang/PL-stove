-- a simple solution for ex. 11.1
-- now that we have construct a gametree, just count the nodes
import TicTac

nodes :: Tree a -> Int
nodes (Node _ ts) = 1 + sum (map nodes ts)

-- count the maximum depth of gametree
maxDepth :: Tree a -> Int
maxDepth (Node _ []) = 0
maxDepth (Node _ ts) = 1 + maximum (map maxDepth ts)

size :: Int
size = 3

-- empty grid definition 
empty :: Grid
empty = replicate size (replicate size B)

{-******************************* test code *********************************-}
tree :: Tree Grid
tree = gametree empty O

main :: IO ()
main = do putStr "Total nodes in gametree: "
          putStrLn (show $ nodes $ tree)
          putStr "And the depth of tree is: "
          putStrLn (show $ maxDepth $ tree)
