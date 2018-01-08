-- the file "basic-parser.hs" show some basic parser 
-- and we can find that it can be instance of monad
-- remember that the previous type Parser just use type to define alias
-- now, we want to give it a monad instance definition, use newtype to embellish it

module Parsing where

import Data.Char
import Control.Monad
import Control.Applicative

-- embellish it!
newtype Parser a = P (String -> [(a,String)])

-- parser function
parse :: Parser a -> String -> [(a,String)]
parse (P p) inp = p inp

-- as Monad instance
instance Monad Parser where
    -- return :: a -> Parser a
    return v = P (\inp -> [(v,inp)])
    -- (>>=) :: Parser a -> (a -> Parser b) -> Parser b
    p >>= f  = P (\inp -> case parse p inp of 
                              [] -> []
                              [(v,out)] -> parse (f v) out)



-- as MonadPlus instance 
instance MonadPlus Parser where
    -- mzero :: Parser a, just as failure
    mzero = P (\inp -> [])
    -- mplus :: Parser a -> Parser a -> Parser a, just as (+++)
    mp `mplus` mf = P (\inp -> case parse mp inp of
                                   [] -> parse mf inp
                                   [(v,out)] -> [(v,out)])


instance Applicative Parser where
    pure = return 
    (<*>) = ap

instance Functor Parser where
    fmap = liftM

instance Alternative Parser where
    empty = mzero
    (<|>) = mplus

-- basic parser 
failure :: Parser a
failure = mzero

item :: Parser Char 
item = P (\inp -> case inp of
                 [] -> []
                 (x:xs) -> [(x,xs)])

(+++) :: Parser a -> Parser a -> Parser a
(+++) = mplus


-- Derived primitives

sat :: (Char -> Bool) -> Parser Char
sat pred = do x <- item
              if pred x then return x else failure

digit :: Parser Char 
digit = sat isDigit

letter :: Parser Char 
letter = sat isAlpha

lower :: Parser Char
lower = sat isLower

upper :: Parser Char
upper = sat isUpper

alphanum :: Parser Char
alphanum = sat isAlphaNum

char :: Char -> Parser Char
char x = sat (== x)

string :: String -> Parser String 
string [] = return []
string (x:xs) = do char x
                   string xs
                   return (x:xs)

ident :: Parser String 
ident = do x <- lower 
           xs <- many alphanum
           return (x:xs)

nat :: Parser Int 
nat = do x <- some digit 
         return (read x)

space :: Parser ()
space = do many (sat isSpace)
           return ()

-- token, ignore the white space around the obj-p
token :: Parser a -> Parser a
token p = do space 
             x <- p
             space
             return x

identifier :: Parser String 
identifier = token ident

natural :: Parser Int
natural = token nat 

symbol :: String -> Parser String
symbol s = token (string s)


          




                   