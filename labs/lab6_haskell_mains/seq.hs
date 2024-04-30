import System.Environment

count :: Int -> Int -> Int -> IO ()
count current end delta = do
    print current
    if current == end then
        return ()
    else
        count (current + delta) end delta

main = do
    args <- getArgs
    let start = read (head args) :: Int
    let end = read (head $ tail args) :: Int
    let delta = if (start > end) then (-1) else (1)
    count start end delta