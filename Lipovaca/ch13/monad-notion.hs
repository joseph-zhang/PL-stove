-- this file will show some basic notions about monad
-- a monad is a monoid in the category of endofunctors (自函子范畴上的幺半群)
-- monad is advanced applicative, it support (>>=) :: (monad m) => a -> (a -> m b) -> m b

-- let's compare monad and applicaitve
-- from the chaptr about Applicative funtor
res = (*) <$> Just 2 <*> Just 8  -- 16
-- Maybe is monad instance, now we give it a functional manual implementation to show >>= on it.
applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing f = Nothing
applyMaybe (Just x) f = f x
-- use it just like what we do on applicative functor
res' = Just 3 `applyMaybe` \x -> Just (x + 1)  -- Just 4
-- it is equal to
res'' = Just 3 >>= \x -> Just (x + 1)  -- Just 4
-- actually, we can use "return" function to give it a shell
res''' = Just 3 >>= \x -> return (x + 1)  -- Just 4

