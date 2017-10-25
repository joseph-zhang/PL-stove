------------------------------------------------------------------------
{- basic syntax and concept ~ Ch1 -}                                             
------------------------------------------------------------------------
-- simple form: to define a function or process
<name> <parameters> = <body>
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
(<obj1>, <obj2>,..)
-- there are some basic operations act on pair(the tuple which has two vals)
{fst, snd, zip}

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch2 -}                                             
------------------------------------------------------------------------
-- simple form: to check type of an obj
:t <obj>
-- there are some common types 
{Int, Integer, Float, Double, Bool, Char}
-- the type variable can represent any one of types, an example: 
head:: [a] -> a
-- there are some common typeclasses
{Eq, Ord, Show, Read, Enum, Bounded, Num, Floating, Integeral}
-- type constraint used to indicate type, it often located the left of "=>"
(<typeclass> <typevar>) => <Type-expressions>

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch3 -}                                             
------------------------------------------------------------------------
-- simple form: using pattern matching when define a function 
<function-typeform>
<name> <inputcase1> = <body1>
<name> <inputcase2> = <body2>
...
<catchall-pattern>
-- simple form: using "as-pattern" to represent entire pattern
<asname>@<pattern-expr>
-- simple form: the usage of "guard" just like "cond" in lisp
<expr> 
    | <p1> = <e1>	
	| <p2> = <e2>
	...
	| otherwise = <en>
-- simple form: using "where" to represnet an object
<body>
  where <typeObjects/function> = <exprs/body>
-- simple form: using "let" to represent an object, just like it in lisp
let <typeobject1> = <expr1>
    <typeobject2> = <expr2>
	...
in  <exprn>
-- simple form: using "case" to implement pattern matcing
case <expr> of <pattern1> -> <expr1>
               <pattern2> -> <expr2>
			   ...	
			   
------------------------------------------------------------------------
{- basic syntax and concept ~ Ch4 -}                                             
------------------------------------------------------------------------
{-This chapter give a few examples of recursion-}

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch5 -}                                             
------------------------------------------------------------------------
-- In this chapter, we should first know about Curry function, partial application andsection,
-- and then grasp how to implement some high-level abstraction.

-- simple form: "map" high-level abstraction
map :: (a -> b) -> [a] -> [b]
-- simple form: "filter" high-level abstraction
filter :: (a -> Bool) -> [a] - > [a]
-- simple form: simple lambda form, usually enclosed by parenthesis
(\<parameters> -> <body>)
-- a kind of flod: "foldl" high-level abstraction
-- foldlike: foldl, foldr, foldl1, foldr1 
foldl :: (Foldable t) => (b -> a -> b) -> b -> t a -> b
-- a kind of scan: "scanl" high-level abstraction
-- scanlike: scanl, scanr, scanl1, scanr1
scanl :: (b -> a -> b) -> b -> [a] -> [b]
-- function application operator: "$"
($) :: (a -> b) -> a -> b
f $ x = f x
-- function composition: "."
(.) :: (b -> c) -> (a -> b)  -> a -> c
f . g = \x -> f (g x)

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch6 -}                                             
------------------------------------------------------------------------
-- simple form: load a module
import <ModuleName>
-- use qualified import to prevent conflict
import qualified <ModuleName>
-- selective import 
import <ModuleName> (<typeObjects>)
-- ignore import
import <ModuleName> hiding (<typeObjects>)
-- import with rename
import <ModuleName> as <rename>
-- simple form: association list, the list of pair
<name> = 
    [ (<key1>, <cal1>),
	  (<key2>, <val2>),
	  ...
	]
-- simple form: write new module
module <moduleName> 
( <processname1>
, <processname2>
, <processname3>
, ...
) where
<body to implement processes>

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch7 -}                                             
------------------------------------------------------------------------
-- some interesting type constructor
{Maybe, Either ..}
data Maybe a = Nothing | Just a
data Either a b = Left a | Right a
...
-- simple form: define a new type
data <typename> = <valueConstructor> 
-- use record syntax
data <typename> = <constructorName> { <fieldname1> :: <typename1>
                                     ,<fieldname2> :: <typename2>
									 , ...
                                    }
-- use parameterization to define a polymorphic type
data <typeConstructor> <parameters> = <value constructor>
-- use derive method let our type be instance of a typeclass
<typeDefinition> deriving (<typeclasses>)
-- use type synonyms to simplify a pattern
type <newname> = <particular-typeform>
-- type synonyms with parameters
type <nername> <parameters> = <genericity-typeform> 
-- use "deriving" to define behavior of a type, directly derive
<typedefinition> deriving (<typeClasses>)
-- simple form: define a typeClass
class <typeclass-name> <parameters> where
    <process-tags>
	<body>
-- use instance keyword to derive, manually derive
instance <typeclass-name> <typename> where
    <instanceBody>
-- use type constraint to do subclassing, let a typeclass be subclass of another one.
class (<additional-typeclass> <parameter>) => <constraint-typeclass> <parameter> where
    ...
-- simple form: to check the instances of a typeClass,
--              or ownership of a type or type constructor
:info <typeclassName/typeName/typeConstructorName>
-- simple form: to check the tag of a type
:k <typeName>

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch8 -}                                             
------------------------------------------------------------------------
-- First you should know about I/O action,
-- I/O action can be treated as a container, it is closed unless we "open" it

-- simple form: use putStrLn function to output a string 
putStrLn :: String -> IO ()
-- simple form: use do-syntax to combine multiple I/O actions
-- the I/O actions become a holistic I/O action, its type is identical to the last action's.
do <I/O actions>
-- the binding action is the method to "open" the container of I/O action
<common-Type> <- <I/O action>
-- the "return" is just a container
return :: (Monad m) => a -> m a
-- some useful I/O functions
{putStr, putChar, print, when, sequence, mapM, forever, forM}

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch9 -}                                             
------------------------------------------------------------------------
-- First you should know how to redirect to files as input/output
-- also you should understand lazy I/O

-- use getContents to read from stdin until end-of-file
getContents :: IO String
-- use interact to Convert the input
interact :: (String -> String) -> IO ()
-- use "openFile" to open a file and construct a handle, in System.IO
openFile :: FilePath -> IOMode -> IO Handle
-- the definition of IOMode is enumerable
data IOMode = ReadMode | WriteMode | AppendMode | ReadWriteMode
-- use "hClose" to close a file
hClose :: Handle -> IO ()
-- use "hGetContents" with a handle to read file, the handle version of getContents
hGetContents :: Handle -> IO String
-- some useful I/O function, the version of handle
{hGetContents, hGetLine, hPutStr, hPutStrLn, hGetChar, ...}
-- use "withFile" to process file
withFile :: FilePath -> IOMode -> (Handle -> IO a) -> IO a
-- use "bracket" in Control.Exception to process resource
bracket :: IO a -> (a -> IO b) -> (a -> IO c) -> IO c
-- use "bracketOnError" in Control.Exception to process resource, it'll do clear when exception
bracketOnError :: IO a -> (a -> IO b) -> (a -> IO c) -> IO c 
-- some useful small functions for file processing
{
  readFile :: FilePath -> IO String
, writeFile :: FilePath -> String -> IO ()
, appendFile :: FilePath -> String -> IO ()  
} 
-- use bracketOnError in Control.Exception to clear temp file
bracketOnError :: IO a -> (a -> IO b) -> (a -> IO c) -> IO c
-- two useful I/O actions about command line parameter, in System.Enviroment
{
  getArgs :: IO [String]
, getProgName :: IO String  
}
-- simple form: "openTempFile" in System.IO, to manipulate a temp file
openTempFile :: FilePath -> String -> IO (FilePath, Handle) 
-- use "removeFile" in System.Directory to delete a file
removeFile :: FilePath -> IO ()
-- use "renameFile" in System.Directory to rename a file
renameFile :: FilePath -> FilePath -> IO ()
-- simple form: typeclass RandomGen defines behaviors of random source
class RandomGen g where 
  next :: g -> (Int, g)
  genRange :: g -> (Int, Int) 
  split :: g -> (g, g)
-- simple form: a instance of typeclass RandomGen, StdGen is useful,
-- function mkStdGen will return a random source(make standard Generator)
mkStdGen :: Int -> StdGen
-- simple form: typeclass Random defines behaviors to produce random value,
-- function "random" return  value of instance derive from Random 
random :: (RandomGen g, Random a) => g -> (a, g)
-- function randoms" return an infinite list of random value
randoms :: (RandomGen g, Random a) => g -> [a]
-- function "randomR" return random value in a particular range
randomR :: (RandomGen g, Random a) => (a, a) -> g -> (a, g)
-- function "randomRs" return random value stream in a particular range
randomRs :: (RandomGen g, Random a) => (a, a) -> g -> [a]
-- use "getStdGen" I/O action to get global generator
getStdGen :: IO StdGen
-- use "newStdGen" I/O action to split current generator 
newStdGen :: IO StdGen

-- now you should know about "thunk",
-- we are going to show some of bytestring.
-- bytestring is an efficient version of list, so we can use it to process String faster.
-- two styles: 1.strict(no thunk) in Data.ByteString   >>as S
--             2.and lazy(weaker thunk) in Data.ByteString.Lazy  >>as B
-- we can use "toChunks" and "fromChunks" to transfer them.
 
-- The difference between this and list is,
-- ":" becomes "cons", "String" becomes "ByteString", ...

-- simple form: use "pack" to transfer a lazy-list to bytestring version
pack :: [Word8] -> ByteString
-- simple form: use "unpack" to do inverse process of pack
unpack :: ByteString -> [Word8]

-- Note that the useful function of list is still implemented in bytestring version,
-- remember add qualified when you import these Modules.
{head, tail, init, null, length, map, reverse, foldl, foldr, concat, takeWhile, filter,...}

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch10 -}                                             
------------------------------------------------------------------------
{-This chapter give a few examples of FP programming method-}

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch11 -}                                             
------------------------------------------------------------------------
{- 
  we should first know about "Functor" and then learn about applicative functor.
  the value of functor can be mapped, Functor is expressed as a typeclass.
  Functor: 将函数应用到在上下文中的值
  http://hackage.haskell.org/package/base-4.10.0.0/docs/Prelude.html#t:Functor
  
    class Functor (f :: * -> *) where 
      fmap :: (a -> b) -> f a -> f b
      (<$) :: a -> f b -> f a   |infixl 4|  

  the function fmap use a single parameter function to make a functor value be another,
  f can be treated as a type constructor.
  
  the fmap function for list is what we familair with, that is map:
    map :: (a -> b) -> [a] -> [b]
  so we find that [] is instance of Functor typeclass:
    data [] a = [] | a : [a]
  there are still many instance of Functor:
  {Maybe, Tree, Either a, ...}
  for example, our type Tree is the instance of Functor:
-}
-- also, fmap can be seen as a method to lift a normal function
fmap :: (a -> b) -> (f a -> f b)

-- Tree is instance of Functor
instance Functor Tree where
  fmap f EmptyTree = EmptyTree
  fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right)
  
-- Actually, I/O action is also Functor instance
instance Functor IO where 
  fmap f action = do 
    result <- action
    return (f result)
	
-- function is also instance of Functor
-- here is a truth: function is map, a map can also be mapped,
instance Functor ((->) r) where
  fmap f g = (\x -> f (g x))
-- What we can find is, if we consider function as a kind of type constructor,
-- this becomes function combination, fmap :: (a -> b) -> ((->) r a) -> ((->) r b)
-- which means, fmap :: (a -> b) -> (r -> a) -> (r -> b)

{-
  to write a type as instance of Functor, you should make sure it satisfies functor-law.
  - Law 1:
      fmap id = id
      where, id = \x -> x (identity function)
  - Law 2:
      fmap (f . g) x = fmap f (fmap g x) = fmap f . fmap g 
      where f and g are both function.
  Haskell cannot automated verify this, this is what we should consider about before instantiation.	  
-}

{-
  we know that a function can be Currying, but a type constructor can also do this.
  the type class Applicative is defined in Control.Applicative.
  This module describes a structure intermediate between a functor and a monad.
  Applicative: 将在上下文中的函数应用到在上下文中的值.
  http://hackage.haskell.org/package/base-4.10.0.0/docs/Control-Applicative.html#v:liftA2
-}

class (Functor f) => Applicative f where 
  pure :: a -> f a    -- put a value in context
  (<*>) :: f (a -> b) -> f a -> f b  |infixl 4|
	
{-  
  from this definition, we'll find that expr `pure f <*> x` is equal to `fmap f x`, 
  this is abstracted as a infix character <$>:
  (<$>) :: (Functor f) => (a -> b) -> f a -> f b
  f <$> x = fmap f x 
  
  Also, applicative functor has some laws:
  - Law 1: identity
    pure id <*> v = v
  - Law 2: composition
    pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
  - Law 3: homomorphism
    pure f <*> pure x = pure (f x)
  - Law 4: interchange
    u <*> pure y = pure ($ y) <*> u  
-}

--There are also many instances type of Applicative typeclass, 
-- Maybe is Applicative Functor instance
{-
  pure :: a -> Maybe a 
  (<*>) :: Maybe (a -> b) -> Maybe a -> Maybe b
-}
instance Applicative Maybe where
  pure = Just
  Nothing <*> _ = Nothing
  (Just f) <*> something = fmap f somethng
  
-- [] is Applicative Functor instance 
-- here is a possible instance process
{-
  pure :: a -> [a] 
  (<*>) :: [a -> b] -> [a] -> [b]
-}
instance Applicative [] where
  pure x = [x]   -- microcontext
  fs <*> xs = [f x | f <- fs, x <- xs]
  
-- IO is Applicative Functor instance
{-
  pure :: a -> IO a 
  (<*>) :: IO (a -> b) -> IO a -> IO b
-}
instance Applicative IO where
  pure = return
  a <*> b = do
    f <- a
    x <- b
    return (f x)

-- function is Applicative Functor instance
-- function is a map, a map can produce another map.
-- recalling (->) is a infix function
-- pure :: a -> (r -> a)
instance Applicative ((->) r) where
  pure x = (\_ -> x)
  f <*> g = \x -> f x (g x)
-- To understand this, we just replace f with (r -> (a -> b)).
{-
  > :t (+) <$> (+3) 
  > (Num a) => a -> a -> a   -- or you can understand it as a -> (a -> a), is an Applicative.
  
  consider this expression: (+) <$> (+3) <*> (*100) 5 , result is 508.
  (+) <$> (+3) is a map which can produce a map(function), we sign it as f.
  and we sign (*100) as g.

  recalling: f <*> g = \x -> f x (g x), here x is 5 (what we input in this function)
  g x  -- 5 * 100 = 500
  f x (g x) -- (+ (+ 3 5) (* 100 5))  -- here we use lisp form to show result, may help you understand.  
-}

-- the list type has another way to implement instantiation
-- zipWith function is an example for this type of list, we can call it zipList
instance Applicative ZipList where 
  pure x = ZipList (repeat x)
  ZipList fs <*> ZipList xs = ZipList (ZipWith (\f x -> f x) fs xs)

-- there are some useful applicative functions in Control.Applicative
-- "liftA2" function apply a funtion between two applicative values
-- liftA2 can be understand as: lift a function, process two Applicative Functor value.
liftA2 :: (Applicative f) => (a -> b -> c) -> (f a -> f b -> f c)
liftA2 f a b = f <$> a <*> b

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch12 -}                                  
------------------------------------------------------------------------
{-
  To begin this chapter, we'd better know about the notion of "newtype",
  figure out difference between type, newtype and data. Understand "3H" about them (what, where, when)

  Actually, the function of newtype is adding a shell for current type to make a newtype.
  The definition of newtype has only one value constructor, this constructor has only one field.
  some types have their restrict, cannot realize instantiation directly, so we'll give it a shell.
  ZipList is an example as a shell:
-}
newtype ZipList a = ZipList {getZipList :: [a]}

{-
  Now let's consider about Monoid typeclass.
  http://hackage.haskell.org/package/base-4.10.0.0/docs/Data-Monoid.html
  from what we have talked about, monoid is <S, *>
  * is a binary operator which satisfies:
  1. associativity and closed
  2. closed
  S should contain unit-element.
-}
class Monoid m where
  mempty :: m  -- unit element
  mappend : m -> m -> m  -- binary operator
  mconcat :: [m] -> m
  mconcat = foldr mappend mempty
{-
  Monoid has some laws:
  - Law 1: mempty is unit-element
    mempty `mappend` x = x 
  - Law 2: mempty is unit-element
    x `mappend` mempty = x
  - Law 3: associativity
    (x 'mappend' y) `mappend` z = x 'mappend' (y 'mappend' z)
-}

-- here we'll talk some instance of Monoid
-- list is monoid
instance Monoid [a] where
  mempty  = []
  mappend = (++)

-- Num with operator +
-- it is named as Product, Product is a type constructor
newtype Product a = Product {getProduct :: a}
  deriving (Eq, Ord, Read, Show, Bounded)
instance Num a => Monoid (Product a) where
  mempty = Product 1
  Product x `mappend` Product y = Product (x * y)

--Num with operator +
-- it is named as Sum, Sum is a type constructor
newtype Sum a = Sum {getSum :: a}
  deriving (Eq, Ord, Read, Show, Bounded)
instance Num a => Monoid (Sum a) where
  mempty = Sum 0 
  Sum x `mappend` Sum y = Sum (x + y)

-- Bool with operator ||
-- it is named as Any 
newtype Any = Any {getAny :: Bool}
  deriving (Eq, Ord, Read, Show, Bounded)
instance Monoid Any where
  mempty = False
  Any x `mappend` Any y = Any (x || y)

-- Bool with operator && 
--it is named as All
newtype All = All {getAll :: Bool}
  deriving (Eq, Ord, Read, Show, Bounded)
instance Monoid All where
  mempty = True
  All x `mappend` All y = All (x && y)
  
-- Ordering is monoid
instance Monoid Ordering where
  mempty = EQ
  LT `mappend` _ = LT
  EQ `mappend` y = y
  GT `mapped` _ = GT

-- Maybe is monoid
instance Monoid a => Monoid (Maybe a) where
  mempty = Nothing
  Nothing `mappend` m = m
  m `mappend` Nothing = m
  Just m1 `mappend` Just m2 = Just (m1 `mappend` m2)
  
{-
  typeclass "Foldable" define the behavior that a type can be applied fold.
  Prelude and Foldable module both have fold function, but they are not same.
  > :t foldr
  > foldr :: (a -> b -> c) -> b -> [a] -> b
  > :t F.foldr
  > F.foldr :: (F.Foldable t) => (a -> b -> c) -> b -> t a -> b
  
  We can find that the foldr in Prelude is a particular case of which in Data.Foldable. 
  You can use ":info Foldable" to see its definition.
  A very important process in Foldable is foldMap:
  foldMap :: (Monoid m, Foldable t) => (a -> m) -> t a -> m
  it apply a function like (\x -> Monoid-value) to a value of foldable type,
  get a monoid foldable structure, then apply "mappend" on this foldable structure to produce a monoid value. 
-}

-- Tree can be a instance of Foldable
instance F.Foldable Tree where
  foldMap f EmptyTree = mempty
  foldMap f (Node x l r) = F.foldMap f l `mappend`
                           f x           `mappend`
                           F.foldMap f r 		
-- use this method, we can process tree and other foldable structure cool! 

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch13 -}                                  
------------------------------------------------------------------------
-- This chapter, we mainly talk about basic notion about monad.
-- http://hackage.haskell.org/package/base-4.10.0.0/docs/Control-Monad.html
-- Haskell use Monad to do many things, as you can see, monad can deal with side effect of I/O. 
-- To sum up, a monad is a monoid in the category of endofunctors.
-- just like Applicative is enhanced version of Functor, Monad is enhanced version of Applicative.
class (Applicative m) => Monad (m :: * -> *) where
  return :: a -> m a  -- just like pure function
  (>>=) :: m a -> (a -> m b) -> m b  -- bind function
  (>>) :: m a -> m b -> m b
  x >> y = x >>= \_ -> y
  
  fail :: String -> m a
  fail msg = error msg
  
-- let's consider an example, Maybe is Monad instance
instance Monad Maybe where
  return x = Just x
  Nothing >>= f = Nothing
  Just x >>= f = Just (f x)
  fail _ = Nothing

-- Monad is so useful that we give it a special form.
-- we have used it many times, that is "do" notation.
-- we can not only use "do" in I/O actions, but in all Monad instance.(I/O is monad)
-- an example:
foo :: Maybe String
foo = Just 3 >>= (\x -> Just "!" >>= (\y -> Just (show x ++ y)))
-- the result is certain, "3!"
-- use "do" notation, we can rewrite it as:
foo:: Maybe String 
foo = do
  x <- Just 3
  y <- Just "!"
  Just (show x ++ y)
-- you can use pattern matching in "do" notation, if it is failed, the fail function will work.

-- Another important example of Monad is list.
instance Monad [] where
  return x = [x]
  xs >>= f = concat (map f xs)
  fail _ = []
-- to see how to use it
res = [3, 4, 5] >>= \x -> [x, -x]  -- result is [3, -3, 4, -4, 5, -5] = concat [[3, -3], [4, -4], [5, -5]]
-- the list type has randomness, list comprehension is just syntactic sugar of list Monad.
-- to understand how can it work, we need typeclass MonadPlus and function guard.
-- MonadPlus is used to express monoid-monad
class (Monad m) => MonadPlus (m :: * -> *)where
  mzero :: m a  -- unit-element : mempty
  mplus :: m a -> m a -> m a  -- binary operator : mappend
-- list is instance of MonadPlus
instance MonadPlus [] where
  mzero :: []
  mplus :: (++)
-- guard function is just like a guarder
-- use it with MonadPlus instance, we can implement filter in list comprehension 
guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()  -- case : minimum context
guard False = mzero  -- case : computation failed
 
{-
  Monad has some laws.
  - law1: left unit-element
    return a >>= k  =  k a   -- equal to f <=< return
  - law2: right unit-element
    m >>= return  =  m
  - law3: associative law
    m >>= (\x -> k x >>= h)  =  (m >>= k) >>= h
  
  note that, fmap f xs  =  xs >>= return . f
-} 

-- function >> ignore the parameter, return a predetermined monad value.
(>>) :: (Monad m) => m a -> m b  -> m b
m >> n  =  m >>= \_ -> n
-- here is a useful Monad function
(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
f <=< g = (\x -> g x >>= f)
-- you can compare (<=<) with (.)
(.) :: (b -> c) -> (a -> b) -> (a -> c)
f . g = (\x -> f (g x))
-- so we can find that, (<=<) can combine two monad function,
-- just like (.) can combine two normal function.

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch14 -}                                  
------------------------------------------------------------------------
-- we will go on exploring Monad in this chapter.
-- some Monad are included in mtl, which is bind with Haskell platform.
-- First, we should understand: a value with monoid-value is a value of monad form.  
-- an example is writer type
newtype Writer w a = Writer {runWriter :: (a, w)}  -- w is a value with monoid-value
-- Thus, it is a instance of Monad
instance (Monad w) => Monad (Writer w) where
  return x = Writer (x, mempty)
  (Writer (x, v)) >>= f  =  let (Writer (y, v')) = f x in Writer (y, v `mappend` v')  

-- function is instance of Monad
-- recalling that function can be seen as a value in context
instance Monad ((->) r) where
  return x = \_ -> x
  h >>= f  =  \w -> f (h w) w
{-
  note that monad is a determinate type.
  > :t (+3) >>= (*) 
  > (+3) >>= (*) :: (Num b) => b -> b
  here (+3) is monad, a bit like functor.
  > (+3) >>= (*) 20
  > 460
  the calculation is just (* (+ 3 20) 20)
-}  
-- an example to show how to use function monad
addStuff :: Int -> Int
addStuff = do 
  a <- (*2)
  b <- (+10)
  return (a+b)  -- note that this is a function, \_ -> (a+b), always return (a+b)
-- this is equal to
addStuff' :: Int -> Int
addStuff' x = let 
  a = (*2) x
  b = (+10) x 
  in a + b

-- State monad can describe the change of state and hold the purity.
-- a computation with state can be treated as a function: s -> (a, s)
-- (State s) is a computation with state
-- State monad (Control.Monad.State) 
newtype State s a = State {runState :: s -> (a, s)}
-- it is a instance of Monad
instance Monad (State s) where
  return x = State $ \s -> (x, s)
  (State h) >>= f  =  State $ let (a, newState) = h s 
                                  (State g) = f a
                              in g newState

-- definition of MonadState typeclass, minimal definition is either both of get and put or just state.
class (Monad m) => MonadState s m | m -> s where		
  get :: m s
  put :: s -> m ()
  state :: (s -> (a, s)) -> m a
-- there are two useful functions in Control.Monad.Stack, in MonadState typeclass
-- these two functions realize get and put method for State Monad.
get = state $ \s -> (s, s)
put newState = state $ \s -> ((), newState)
-- know about the definition of >>= for State Monad
(>>=) :: State s a -> (a -> State s b) -> State s b

-- we know that "Maybe" can be used to express the calculation which may be failed.
-- however, we can use "Either" to add failure information.
data Either a b = Left a | Right b
-- (Either e) can be seen as a advanced Maybe, it's also Monad instance.
instance (Error e) => Monad (Either e) where
  return x = Right x
  Right x >>= f  =  f x
  Left err >>= f  =  Left err
  fail msg = Left (strMsg msg)
-- typeclass Error define behaviors for those types which can be used to express error information.
class Error a where
  noMsg :: a
  strMsg :: String -> a
  
-- now let's talk abour some useful functions related to monad.
-- These function will show a truth: Monad do not depend on Applicative or Functor.
-- liftM, just like fmap!
liftM :: (Monad m) => (a -> b) -> m a -> m b  -- can also be (a -> b) -> (m a -> m b)
liftM f m = m >>= (\x -> return(f x))

-- ap, just like <*>!
ap :: (Monad m) => m (a -> b) -> m a -> m b
ap mf m = do
  f <- mf
  x <- m
  return (f x)
 
-- also, liftM2 is just like liftA2, a version for Monad.
liftM2 :: (Monad m) => (a1 -> a2 -> r) -> m a1 -> m a2 -> m r  -- can also be (a1 -> a2 -> r) -> (m a1 -> m a2 -> m r)
liftM2 f x y = f <$> x <*> y

-- nested Monad value can be flatten by using join
join :: (Monad m) => m (m a) -> m a
join mm = do
  m <- mm
  m

-- filterM, just like filter, but the return value is a monad value.
filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]

-- foldM, just like foldl!
foldM :: (Monad m) => (a -> b -> m a) -> a -> [b] -> m a

------------------------------------------------------------------------
{- basic syntax and concept ~ Ch15 -}                                  
------------------------------------------------------------------------
-- In this chapter we are going to learn zipper.
-- this method is very useful in data structure, 
-- let us get precise location more convenient on tree or other structures.  
-- To understand this notion, we need a concrete example, this part is included in ch15..
