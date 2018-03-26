{-
example of monad in chapter 12
state monad is a good idea. State is changeable, a method to update state safely is important.
Actually, state monad has a definition in Control.Monad.State (remember to install mtl with cabal)
-}
module StateM
( State
, ST(S)
, app
) where

-- supppose the sate here is an integer number
type State = Int

-- return the result in addition to update the sate value
-- use newtype here instead of type. (because type is just alias, cannot be made into instance)
newtype ST a = S (State -> (a, State))

app :: ST a -> State -> (a, State)
app (S g) s = g s

instance Functor ST where
  -- fmap :: (a -> b) -> ST a -> ST b
  fmap g st = S (\s -> let (x, s') = app st s in (g x, s'))


instance Applicative ST where
  -- pure :: a -> ST a
  pure x = S (\s -> (x, s))

  -- (<*>) :: ST (a -> b) -> ST a -> ST b
  stf <*> stx = S (\s -> let (f, s')  = app stf s
                             (x, s'') = app stx s' in (f x, s''))

instance Monad ST where
  -- (>>=) :: ST a -> (a -> ST b) -> ST b
  stx >>= f = S (\s -> let (x, s') = app stx s in app (f x) s') 
