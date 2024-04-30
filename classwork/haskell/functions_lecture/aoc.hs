main = do
    text <- readFile "parens.txt"
    let deltas = map (\p -> if p == '(' then 1 else -1) text
    print deltas
    print $ sum deltas