-- here a mechanism named abstract machine is defined
-- to show the effect, an arithmetic parser is implemented

-- the grammar support addition operation
data Expr = Val Int | Add Expr Expr deriving (Show,Read)

-- abstract machine specifies the evaluate order
-- first, define a control stack
type Cont = [Op]

data Op = EVAL Expr | ADD Int deriving (Show,Read)

-- a function to evaluates expression in a context of control stack
eval :: Expr -> Cont -> Int
eval (Val n) c = exec c n
eval (Add x y) c = eval x (EVAL y : c)

-- a function that exexutes a control stack in the context of an integer argument
exec :: Cont -> Int -> Int
exec [] n = n
exec (EVAL y : c) n = eval y (ADD n : c)
exec (ADD n : c) m = exec c (n + m)

-- procedure to evaluates an expression to an integer
value :: Expr -> Int
value e = eval e []


------------------------------ test code ----------------------------
e1 :: Expr
e1 = Add (Add (Val 2) (Val 3)) (Val 4)

e2 :: Expr 
e2 = Add (Add (Add (Val 3) (Val 4)) (Val 7)) (Val 7)