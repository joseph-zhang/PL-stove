-- This file will give some examples of recursion data structure
-- especially tree structure.

-- the first example is what we have used a lot,
-- list is a recrsion structure, the list value [...] is just syntactic sugar
-- of ... : [] , we can implement our own list as
-- data List' a = Empty | Cons a (List' a) deriving (Show, Read, Eq, Ord)
-- or a more detailed version:
data List' a = Empty | Cons{ listHead :: a
                           , listTail :: List' a
                           } deriving (Show, Read, Eq, Ord)
-- define connection process (just like ++) for our list type
-- use character to name process, let it become a default infix function
-- the number 5 is its priority
infixr 5 +++
(+++) :: List' a -> List' a -> List' a
Empty +++ ys = ys
(x `Cons` xs) +++ ys = x `Cons` (xs +++ ys) 

-- the process Cons is just like : for normal list,
-- so we also want to write it as characters.
-- use fixity declaration to do this, we will rewrite our type definition
infixr 5 :-:
data List'' a = Empty' | a :-: (List'' a) deriving (Show, Read, Eq, Ord)

{-
  give an example, the value of last version list 
    Cons 4 (Cons 5 Empty)
  has the same meaning of 
    4 :-: (5 :-: Empty')
-}

-- Now we are going to implement Binary search Tree.
-- the type definition of our tree structure, polymorphic is used.
data BST a =  EmptyTree | Node a (BST a) (BST a) deriving (Show) 

-- two methods to construct a tree
-- the process to create a tree with only one node, as auxiliary function.
singleton :: a -> BST a
singleton x = Node x EmptyTree EmptyTree

treeInsert :: (Ord a) => a -> BST a -> BST a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a leftTree rightTree) 
    | x == a = Node x leftTree rightTree  -- do nothing
    | x < a = Node a (treeInsert x leftTree) rightTree  -- recursive insert
    | x > a = Node a leftTree (treeInsert x rightTree)  -- recursive insert

-- the process to check if a value in Tree
treeElem :: (Ord a) => a -> BST a -> Bool
treeElem _ EmptyTree = False
treeElem x (Node a leftTree rightTree)
    | x == a = True -- recursion boundary
    | x < a = treeElem x leftTree  -- recursive check
    | x > a = treeElem x rightTree
