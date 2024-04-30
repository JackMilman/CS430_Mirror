main = multiplier

multiplier = do
    text1 <- getLine
    text2 <- getLine
    let n1 = read text1 :: Int
    let n2 = read text2 :: Int
    let product = n1 * n2
    print product