main = do
    first <- getLine
    second <- getLine
    let message = first ++ "❤️" ++ second
    putStrLn message

getBoolean :: IO Bool
getBoolean = do
    boolString <- getLine
    return  ("t" == boolString)

getPrompted :: String -> IO String
getPrompted prompt = do
    putStrLn $ show prompt
    getLine

divMaybe :: Int -> Int -> Maybe Int
divMaybe first second = 
  case second of
    0 -> Nothing
    _ -> Just (div first second)

repeatWithIndex n action = do
  if n == 0 then
    return ()
  else do
    action n
    repeatWithIndex (n - 1) action

separator :: IO ()
separator = do
    putStrLn "---------------"

process p = do
  result <- readFile p
  return result