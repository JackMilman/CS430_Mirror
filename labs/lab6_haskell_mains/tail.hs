import System.Environment

main = do
    args <- getArgs
    text <- readFile $ head args
    let num = read (head $ tail args) :: Int
    let entries = lines text
    putStr $ unlines $ drop (length entries - num) entries