 -- solution for exercise 8.5

data Expr = Val Int | Add Expr Expr deriving (Show)

folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f g e = case e of
                (Val x) -> f x
                (Add sube1 sube2) -> (g (folde f g sube1) (folde f g sube2))

----------------------------------------- test code ------------------------------------------
e1 :: Expr
e1 = (Add (Add (Val 34) (Val 6)) (Add (Val 8) (Val 10)))

main = do
  let result = folde id (+) e1
  putStrLn $ show result
