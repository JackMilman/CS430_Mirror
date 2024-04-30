import System.Environment
import Data.List

grepFile :: String -> String -> IO ()
grepFile strn path = do
    text <- readFile path
    mapM_ print $ filter (isInfixOf strn) $ lines text

main = do
    args <- getArgs
    mapM_ (grepFile $ head args) $ tail args
    