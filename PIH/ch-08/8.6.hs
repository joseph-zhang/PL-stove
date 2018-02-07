-- solution for 8.6

data Expr = Val Int | Add Expr Expr deriving (Show)

folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f g e = case e of
                (Val x) -> f x
                (Add sube1 sube2) -> (g (folde f g sube1) (folde f g sube2))

eval :: Expr -> Int
eval = folde id (+)

size :: Expr -> Int
size (Val x) = 1
size (Add e1 e2) = (size e1) + (size e2)

----------------------------------------- test code ------------------------------------------
e1 :: Expr
e1 = (Add (Add (Val 34) (Val 6)) (Add (Val 8) (Val 10)))

main = do
  rs <- return $ sequence [eval, size] $ e1 
  print rs
