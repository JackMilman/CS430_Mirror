pairSum :: Num a => (a, a) -> a
--pairSum :: (Int, Int) -> Int
pairSum pair = x + y
    where x = fst pair
          y = snd pair

majority :: Int -> Int
majority n = div n 2 + 1

neck :: [a] -> a
neck xs = head (tail xs) --extremely high function precedence

slice :: Int -> Int -> [a] -> [a]
slice start end xs = take n suffix
    where
        suffix = drop start xs
        count = end - start
        n = count + 1