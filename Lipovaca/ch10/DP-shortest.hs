-- this file will solve a simple DP problem

-- define a new type for street section
data Section = Section{
  getA :: Int
, getB :: Int
, getC :: Int
} deriving (Show)

-- use this type to define street system (rename method)
type RoadSystem = [Section]

-- define direction label type 
data Label = A | B | C deriving (Show)
type Path = [(Label, Int)]
type PathLength = Int

-- process to calculate pathLength
pathLength :: Path -> Int
pathLength path = sum (map snd path)
 
-- a simple version for DP step, this version record the path transfer information.
-- pathA and pathB are path transfer information to arrive current A / B road cross point.
roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) = 
  let timeA = pathLength pathA
      timeB = pathLength pathB
      forwardTimeToA = timeA + a 
      forwardTimeToB = timeB + b       
      crossTimeToA = timeB + c + b
      crossTimeToB = timeA + c + a
      newpathA = if crossTimeToA >= forwardTimeToA 
                   then (A, a) : pathA
                   else (C, c) : (B, b) : pathB
      newpathB = if crossTimeToB >= forwardTimeToB
                   then (B, b) : pathB
                   else (C, c) : (A, a) : pathA
  in (newpathA, newpathB)
  
-- whole DP process
-- Note that the paths is reversive, we should reverse it back
optimalPath :: RoadSystem -> Path
optimalPath roadSystem = 
  let (bestAPath, bestBPath) = foldl roadStep ([], []) roadSystem in
    if pathLength bestAPath <= pathLength bestBPath
      then reverse bestAPath
      else reverse bestBPath

-- assist function, groupsOf.
-- split a long list into a few same-lngth sublists
groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = (take n xs) : groupsOf n (drop n xs)

-- main process with I/O actions
main = do 
  contents <- getContents 
  let threes = groupsOf 3 (map read $ lines contents)
      roadSystem = map (\[a,b,c] -> Section a b c) threes
      path = optimalPath roadSystem
      pathString = concat $ map (show . fst) path
      pathTime = pathLength path
  putStrLn $ "The best path to take is: " ++ pathString
  putStrLn $ "Time taken: " ++ show pathTime