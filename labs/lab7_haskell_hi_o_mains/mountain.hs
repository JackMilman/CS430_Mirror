import System.Environment
import GHC.Exts

main = do
    args <- getArgs
    text <- readFile $ head args
    mapM_ print $ sortWith length $ lines text