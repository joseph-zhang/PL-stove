{-
this chapter(ch-11) shows some basic ideas of monads, there are Functors, Applicatives and Monads.
I think the Laws of those typeclasses are most important here. all of us can find a thruth,
there are so many blogs talk about details of monads, we'd  better to consider what we are going to write about.
However, we just need to read those best introductions, E.g.(http://homepages.inf.ed.ac.uk/wadler/papers/marktoberdorf/baastad.pdf) 
Functor Laws:
    fmap id      = id
    fmap (g . h) = fmap g . fmap h

Applicative Laws:
    pure id <*> x   = x
    pure (g x)      = pure g <*> pure x
    x <*> pure y    = pure (\g -> g y) <*> x
    x <*> (y <*> z) = (pure (.) <*> x <*> y) <*> z

Monad Laws:
    return x >>= f   = f x
    mx >>= return    = mx
    (mx >>= f) >>= g = mx >>= (\x -> (f x >>= g))
-}
