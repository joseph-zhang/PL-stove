{-
Countdown is a popular quiz programme that has been running on British television since 1982.
Given a sequence of numbers and a target number, attempt to construct an expression whose value is the target,
by combining one or more numbers from the sequence using addition, subtraction, multiplication, division and parentheses.
Each number in the sequence can only be used at most once in the expression, and all of the numbers involved,
including intermediate values, must be positive natural numbers
-}

-- define a new type named Op
data Op = Add | Sub | Mul | Div

-- Op is the instance of Show Typeclass
instance Show Op where
  show Add = "+"
  show Sub = "-"
  show Mul = "*"
  show Div = "/"

-- check if the operation is valid
-- naive one
{-
valid :: Op -> Int -> Int -> Bool
valid Add _ _ = True
valid Sub x y = x > y
valid Mul _ _ = True
valid Div x y = x `mod` y == 0
-}
-- improved one
valid :: Op -> Int -> Int -> Bool
valid Add x y = x <= y
valid Sub x y = x > y
valid Mul x y = x /= 1 && y /= 1 && x <= y
valid Div x y = y /= 1 && x `mod` y == 0

-- apply the operations
apply :: Op -> Int -> Int -> Int
apply Add x y = x + y
apply Sub x y = x - y
apply Mul x y = x * y
apply Div x y = x `div` y

-- definition of game expression
data Expr = Val Int | App Op Expr Expr

-- Expr is the instance of Show Typeclass, show it as a arithematic expression
instance Show Expr where
  show (Val x)     = show x
  show (App o l r) = brak l ++ show o ++ brak r
                      where
                        brak (Val x) = show x
                        brak e       = "(" ++ show e ++ ")"

-- the list of values in an expression
values :: Expr -> [Int]
values (Val x)     = [x]
values (App o l r) = values l ++ values r

-- eval an expression
eval :: Expr -> [Int]
eval (Val x)     = [x | x > 0]
eval (App o l r) = [apply o x y | x <- eval l,
                                  y <- eval r,
                                  valid o x y]

-- subSequences of a list
subs :: [a] -> [[a]]
subs []     = [[]]
subs (x:xs) = yss ++ map (x:) yss
              where yss = subs xs
                    
-- possible ways of inserting a new element into a list
interleave :: a -> [a] -> [[a]]
interleave x []         = [[x]]
interleave x all@(y:ys) = (x:all) : map (y:) (interleave x ys)

-- permutations of a lists
perms :: [a] -> [[a]]
perms []     = [[]]
perms (x:xs) = concat $ (map (interleave x)) $ perms $ xs

-- choices from a list
choices :: [a] -> [[a]]
choices = concat . map perms . subs

-- an expression is a solution for a given list of numbers and a target,
-- if the list of values in the expression is chosen from the list of numbers,
-- and the expression successfully evaluates to give the target. 
solution :: Expr -> [Int] -> Int -> Bool
solution e ns n = elem (values e) (choices ns) && eval e == [n]

-- generate all split items
split :: [a] -> [([a],[a])]
split []     = []
split [_]    = []
split (x:xs) = ([x],xs) : [(x:ls,rs) | (ls,rs) <- split xs]

-- possible operations
ops :: [Op]
ops = [Add, Sub, Mul, Div]

{- FIRST. brute force solution -}
-- generate all possible expressions
exprs :: [Int] -> [Expr]
exprs []  = []
exprs [n] = [Val n]
exprs ns  = [es | (ls,rs) <- split ns,
                  l       <- exprs ls,
                  r       <- exprs rs,
                  es      <- combine l r]
            
-- combine two expression to a new one
combine :: Expr -> Expr -> [Expr]
combine e1 e2 = [App o e1 e2 | o <- ops]

-- generate game solutions
solutions :: [Int] -> Int -> [Expr]
solutions ns n = [e | ns' <- choices ns,
                      e   <- exprs ns',
                      eval e == [n]]

{- SECOND. imporoved solution -}
type Result = (Expr, Int)

results :: [Int] -> [Result]
results []  = []
results [n] = [(Val n, n) | n > 0]
results ns  = [res | (ls,rs) <- split ns,
                     l       <- results ls,
                     r       <- results rs,
                     res     <- combine' l r]
              
combine' :: Result -> Result -> [Result]
combine' (l,x) (r,y) = [(App o l r, apply o x y) | o <- ops,
                                                   valid o x y]
                       
solutions' :: [Int] -> Int -> [Expr]
solutions' ns n = [e | ns'   <- choices ns,
                       (e,m) <- results ns',
                       m == n]

-------------------------------------------------------- test code ------------------------------------------------------
-- compiling with -O2 flag
{-
main :: IO ()
main = print (solutions [1,3,7,10,25,50] 765)
-}

main :: IO ()
main = print (solutions' [1,3,7,10,25,50] 765)
