{- basic notions about parser-}
{-
In general, a parser process an input string to get a tree structure (AST).
However, some instances must be considered.

1. a parser might not always consume its entire argument string.
2. a parser might not always succeed.
3. different parsers will likely return different kinds of trees,
or more generally, any kind of value.

For these reasons, a parser can be defined as a kind of function described like
"
A parser for things
Is a function from strings
To lists of pairs
Of things and strings
"
-}

import Control.Applicative
import Data.Char

{------------------------------------------- parser definition -------------------------------------------}

-- use newtype to pack the function by giving it a dummy constructor
newtype Parser a = P (String -> [(a, String)])

-- applied parser to an input string
parse :: Parser a -> String -> [(a, String)]
parse (P p) inp = p inp

-- parsing primitive : item
item :: Parser Char
item = P (\inp -> case inp of
             [] -> []
             (x:xs) -> [(x, xs)])

{-------------------------------------------- instance of monad ------------------------------------------}

-- now make the Parser into a functor
-- just implement fmap
instance Functor Parser where
  -- fmap :: (a -> b) -> Parser a -> Parser b
  fmap g p = P (\inp -> case parse p inp of
                   [] -> []
                   [(v, out)] -> [(g v, out)])

-- then make the Parser into an Applicative
-- just implement pure and <*>
instance Applicative Parser where
  -- pure :: a -> Parser a
  pure v = P (\inp -> [(v, inp)])

  -- <*> :: Parser (a -> b) -> Parser a -> Parser b
  pg <*> px = P (\inp -> case parse pg inp of
                    [] -> []
                    [(g, out)] -> parse (fmap g px) out) 

-- finally, make the Parser into a monad
instance Monad Parser where
  -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
  p >>= f = P (\inp -> case parse p inp of
                  [] -> []
                  [(v, out)] -> parse (f v) out)
