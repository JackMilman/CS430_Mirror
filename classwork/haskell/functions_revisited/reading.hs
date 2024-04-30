import Data.Char

middle :: (a, b, c) -> b
middle (_, y, _) = y

flipVertical:: (Double, Double) -> (Double, Double)
flipVertical (x, y) = (x, -y)

asciiToString :: [Int] -> String
asciiToString list = map chr list

extractDigits :: String -> String
extractDigits strn = filter isDigit strn

followers :: [Int] -> [(Int, Int)]
followers params = map (\x -> (x, x + 1)) params

diagonals :: [(Int, Int)] -> [Int]
diagonals = map fst . filter (\(x, y) -> x == y)

printTo :: Int -> IO ()
printTo n = mapM_ putStrLn $ map show [1..n]
