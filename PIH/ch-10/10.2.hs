-- a simple solution for exercise 10.2

type Board = [Int]

putRow :: Int -> Int -> IO ()
putRow row num = do putStr (show row)
                    putStr ": "
                    putStrLn $ concat $ (replicate num "* ")

putBoard :: Board -> IO ()
putBoard = iterfunc 1

iterfunc :: Int -> Board -> IO ()
iterfunc _ [] = return ()
iterfunc n (b:bs) = do putRow n b
                       iterfunc (n+1) bs
