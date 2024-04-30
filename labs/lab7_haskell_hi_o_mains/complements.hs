import System.Environment

main = do
    args <- getArgs
    text <- readFile $ head args
    let vals = map (\x -> read x :: Int) $ lines text
    mapM_ print $ filter (\x -> elem (100 - x) vals) vals
