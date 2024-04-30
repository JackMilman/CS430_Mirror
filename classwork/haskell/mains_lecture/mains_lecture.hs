mxb :: (Num a, Show a) => a -> a -> String
mxb slope intercept = show slope ++ " * x + " ++ show intercept

hyfix :: Int -> String
hyfix digits = first : "-" ++ rest
    where string = show digits
          first = head string
          rest = tail string

main = do
    text <- getLine
    let n = read text :: Int
--    putStr $ show n
    let power = 2 ^ n
    print power