import System.Environment

main = do
    -- args <- getArgs
    -- let path = head args
    -- let nAsString = head $ tail args

    path : nAsString : _ <- getArgs
    text <- readFile path
    let n = read nAsString :: Int
    mapM_ putStrLn $ take n $ lines text