{- Arithmatic Expression Parser-}
{-
A Basic arithmatic expression contains
addition and multiplication.

In this kind of expression,
we assume that addition and multiplication associate to the right,
and that multiplication has higher priority than addition.

1). origin definition
expr ::= expr + expr | expr * expr | (expr) | nat
nat  ::= 0 | 1 | 2 | ...

2). consider of priority
expr   ::= expr + expr | term
term   ::= term * term | factor
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...

3). consider of assocation
expr   ::= term + expr | term
term   ::= factor * term | factor
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...

Hence, an expression always begins with a term.
The definition can be simplified as:
expr   ::= term (+ expr | ε)
term   ::= factor (* term | ε)
factor ::= (expr) | nat
nat    ::= 0 | 1 | 2 | ...
(note that ε denotes the empty string)
-}

import Primitive
import SeqParser
import Control.Applicative

expr :: Parser Int
expr = do t <- term
          do symbol "+"
             e <- expr
             return (t + e)
             <|> return t

term :: Parser Int
term = do f <- factor
          do symbol "*"
             t <- term
             return (f * t)
             <|> return f

factor :: Parser Int
factor = do symbol "("
            e <- expr
            symbol ")"
            return e
            <|> natural

-- evaluate an expression
eval :: String -> Int
eval xs = case (parse expr xs) of
            [(n, [])] -> n
            [(_, out)] -> error ("Unused input " ++ out)
            [] -> error ("Invalid input")
