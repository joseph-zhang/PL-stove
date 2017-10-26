-- this file will show how to use writer to add log.
-- this method also show a thought on the relationship between monoid and monad.
import Data.List
import Control.Monad
import Data.Monoid
import Control.Monad.Writer

-- to return a result with a particular record(log), we can write the log-string in tuple.
-- this is a bit like >>= in Monad, the log is just like context. 
applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
applyLog (x, log) f = let (y, newLog) = f x in (y, log ++ newLog)
-- a truth is that a String is a Monad value, we can generalize String to normal Monad.
applyLog' :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog' (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)

-- Now that we often use this form, there is an abstraction named Writer.
-- newtype :: Writer w a = Writer {runWriter :: (a,w)} 
-- here is an example to apply do notion in Writer.
logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number : " ++ show x])

multiWithLog :: Writer [String] Int
multiWithLog = do
  a <- logNumber 3
  b <- logNumber 5
  return (a * b)
-- Note that we can use "tell" to add log
multiWithLog' :: Writer [String] Int
multiWithLog' = do
  a <- logNumber 3
  b <- logNumber 5
  tell ["Gonna multiply these two"]
  return (a * b)

