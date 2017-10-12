------------------------------------------------------------------------
{- basic syntax ~ Ch1 -}                                             
------------------------------------------------------------------------
-- simple form: to define a function or process
<name> = <body>
-- simple form: use "if" condition expression
if <predicate> then <consequent> else <alternative>
-- simple form: use "let" to define an object, often used in terminal like GHCi
let <name> = <Object> 
-- simple form: use cons-like operator, just like what in lisp
<val> : <ListObject>
-- simple form: "++" can be treated as "append" in lisp
<ListObject> ++ <ListObject> 
-- there are some basic operations act on list
{head, tail, last, init, length, null, reverse, take, drop, maximum/minimum, sum, product, elem}
-- simple form: enumerable range has a simple x form
[<val-begin>,<val-assist>..<val-end>]
-- simple form: list comprehension is just like set comprehension in mathmatics
[<mapping-relation> | <domains>, <predicates>]
-- simple form: tuple is a chunk of isomerous object values
(<obj-1>, <obj-2>,..)
-- there are some basic operations act on pair(the tuple which has two vals)
{fst, snd, zip}