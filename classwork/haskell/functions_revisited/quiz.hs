onesDigit :: Int -> Int
onesDigit a = mod a 10

headNeck :: [a] -> (a, a)
headNeck (x : y : _) = (x, y)

-- a = (^ 2)
-- b = (`div` 2)

tuplist :: (Int, Char) -> [Char]
tuplist tuple =
  case tuple of
    (1, c) -> [c]
    (2, c) -> [c, c]
    (3, c) -> [c, c, c]
    _ -> error("invalid tuple " ++ show tuple)