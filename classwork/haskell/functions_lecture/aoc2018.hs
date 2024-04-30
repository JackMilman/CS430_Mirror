import Utilities

main = do
    text <- readFile "numbers.txt"
    let numbers = parseInts $ lines text
    print $ sum numbers