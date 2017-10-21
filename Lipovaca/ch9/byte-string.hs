-- whis file will give some examples about byteString

import qualified Data.ByteString as S
import qualified Data.ByteString.Lazy as B
import System.Environment
import System.Directory
import System.IO
import Data.List
import Control.Exception

-- now we are going to implement file copy by using lazy byteString
-- use command line parameter to deliver filename
main = do
  (fileName1 : fileName2 : []) <- getArgs
  copy fileName1 fileName2

-- here is our file copy function 
copy :: String -> String -> IO ()
copy source dest = do 
  contents <- B.readFile source
  bracketOnError (openTempFile "." "temp")
    (\(tempName, tempHandle) -> do
      hClose tempHandle
      removeFile tempName)
    (\(tempName, tempHandle) -> do
      B.hPutStr tempHandle contents
      hClose tempHandle
      renameFile tempName dest)