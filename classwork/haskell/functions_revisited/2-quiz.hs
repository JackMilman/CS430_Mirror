negative :: Int -> Bool
negative = (<0)

dropZ :: Num a => (a, a, a) -> (a, a)
dropZ (x,y,_) = (x, y)

divert :: String -> IO ()
divert code =
  case code of
    'R':serial -> putStrLn "Hello"
    'T':serial -> putStrLn "Goodbye"

-- func = filter (\a b -> a == b) [1, 2, 3, 400]

a = (+ 5)
b = (4 *)

ditchWinners :: [a] -> [a]
ditchWinners = drop 3