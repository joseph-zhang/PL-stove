-- here we are going to implement a tautology checker
-- this can be treated as a simple language of propositions
-- to implement tautology checker means that the parser of this kind of language need to be considered

--  a proposition can be defined as 
data Prop = Const Bool
          | Var Char
          | Not Prop
          | And Prop Prop
          | Imply Prop Prop deriving (Eq,Show,Read)

-- the value of logic variable just like 'A', 'B' are bound to specific value 
-- this is described as a list of pair
type Subst = Assoc Char Bool

-- recalling the definition of Assoc
type Assoc a b = [(a, b)]

-- a proposition is evaluated in such a Subst environment
eval :: Subst -> Prop -> Bool
eval _ (Const b) = b
eval s (Var x) = find x s
eval s (Not p) = not (eval s p)
eval s (And p q) =  (eval s p) && (eval s q)
eval s (Imply p q) = eval s p <= eval s q

find :: Eq a => a -> [(a,b)] -> b
find _ [] = undefined 
find v (x:xs)
    | fst x == v = snd x
    | otherwise = find v xs

-- nowthat we are able to evaluate a proposition,
-- just make sure that for all possible bound value, the result is 'True'
-- the key method here is generating a list which contains all possible value pairs

-- procedure to get all variables in a proposition
-- note that the result string may contain duplicates
vars :: Prop -> [Char]
vars (Const _) = []
vars (Var x) = [x]
vars (Not p) = vars p
vars (And p q) = vars p ++ vars q
vars (Imply p q) = vars p ++ vars q

-- then we need to find a method to generate taget list
bools :: Int -> [[Bool]]
bools 0 = [[]]
bools n = map (False:) bss ++ map (True:) bss
        where bss = bools (n-1)

-- create bound list
substs :: Prop -> [Subst]
substs p = map (zip tead) (bools . length $ tead)
            where tead = rmdups . vars $ p

rmdups :: Eq a => [a] -> [a]
rmdups [] = []
rmdups (x:xs) = x: filter (/= x) (rmdups xs)

-- checker
isTaut :: Prop -> Bool
isTaut p = and [eval s p | s <- substs p]

---------------------------- test code -----------------------
p1 :: Prop 
p1 = And (Var 'A') (Not (Var 'A'))

p2 :: Prop
p2 = Imply (And (Var 'A') (Var 'B')) (Var 'A')

p3 :: Prop
p3 = Imply (Var 'A') (And (Var 'A') (Var 'B'))

p4 :: Prop
p4 = Imply (And (Var 'A') (Imply (Var 'A') (Var 'B'))) (Var 'B')
