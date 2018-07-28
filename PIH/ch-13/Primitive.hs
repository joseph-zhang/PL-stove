{-
Since the definition of parser is clear,
there are some useful primitives should be implemented.
-}
import SeqParser
import Control.Applicative
import Data.Char

-- It is obviously that Parser is a natural alternative example.
-- Note that there is no need to define some and many.
instance Alternative Parser where
  -- empty :: Parser a
  empty = P (\inp -> [])

  -- (<|>) :: Parser a -> Parser a -> Parser a
  p <|> q = P (\inp -> case parse p inp of
                  [] -> parse q inp
                  [(v, out)] -> [(v, out)])

-- parser for single characters that satisfy a predicate
sat :: (Char -> Bool) -> Parser Char
sat p = do x <- item
           if p x then return x else empty

-- some useful small parser
digit :: Parser Char
digit = sat isDigit

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

alphanum :: Parser Char
alphanum = sat isAlphaNum

-- specific characters
char :: Char -> Parser Char
char x = sat (== x)

-- specific string
string :: String -> Parser String
string []     = return []
string (x:xs) = do char x
                   string xs
                   return (x:xs)

-- parser for identifiers
ident :: Parser String
ident = do x <- lower
           xs <- many alphanum
           return (x:xs)

-- parser for natural numbers
nat :: Parser Int
nat = do xs <- some digit
         return (read xs)

-- parser for spaces, tabs and newlines 
space :: Parser ()
space = do many (sat isSpace)
           return ()

-- parser for integer numbers
int :: Parser Int
int = do char '-'
         n <- nat
         return (-n)
       <|> nat

-- ignore any space before and after applying a parser for a token
token :: Parser a -> Parser a
token p = do space
             v <- p
             space
             return v

-- new versions for those parsers
identifier :: Parser String
identifier = token ident

natural :: Parser Int
natural = token nat

integer :: Parser Int
integer = token int
