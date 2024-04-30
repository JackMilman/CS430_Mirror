import System.Environment

sumStrings :: [String] -> Int
sumStrings strings =
    if null strings then
        0
    else
        number + sumStrings rest
            where first = head strings
                  number = read first :: Int
                  rest = tail strings

main = do
    args <- getArgs
    let total = sumStrings args
    print args
    print total