{-
Alternative is a kind of subclass of Applicative.
it provides a method to process an input by using multiple way.
If one way fails, then another way will be applied to the same input.

This class is defined in the library Control.Applicative

``
class Applicative f => Alternative f where
  empty :: f a
  (<|>) :: f a -> f a -> f a
''

1). empty represents an alternative that has failed.
2). <|> is an appropriate choice operator for the type.

Alternative laws:
1). empty <|> x     = x
2). x <|> empty     = x
3). x <|> (y <|> z) = (x <|> y) <|> z
-}

-- an example, Maybe as Alternative
instance Alternative Maybe where
  -- empty :: Maybe a
  empty = Nothing

  -- (<|>) :: Maybe a -> Maybe a -> Maybe a
  Nothing <|> my = my
  (Just x) <|> _ = Just x
