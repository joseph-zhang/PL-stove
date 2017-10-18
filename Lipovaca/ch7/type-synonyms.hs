-- this file will give some examples of type synonyms
import Data.List
import qualified Data.Map as Map
-- we have used type synonyms before, [Char] and String is an example
-- use "type" to give a type another name, just like type String = [Char]
-- in ch6, we defined association list named phoneBook
phoneBook :: [(String,String)]
phoneBook = [ ("betty", "555-2938")
             ,("bonnie", "452-2928")
             ,("pastsy", "493-2928")
            ]
-- now we can rename some patterns as
type PhoneNumber = String
type Name = String
type PhoneBook = [(PhoneNumber, Name)]
-- this equal to rename [(String, String)] as PhoneBook.
-- we can use these new name to write a process
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name pnumber pbook = (name, pnumber) `elem` pbook

-- this still has restrict, we can bring ploymorphic in synonyms
-- to express association list with uncertain type
type AssocList k v = [(k, v)]
type IntMap = Map.Map Int
-- the above rename of IntMap use Currying to simplify.
-- we can also write it as : type IntMap v = Map Int v 