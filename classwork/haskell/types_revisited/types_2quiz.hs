data Planet = Planet String Double Int

name :: Planet -> String
name (Planet s _ _) = s

satelliteCount :: Planet -> Int
satelliteCount (Planet _ _ i) = i


data Flavor = String
data Opinion t = Like t | Dislike t

likedFlavors :: [Opinion Flavor] -> [Flavor]
likedFlavors opinions = foldl mix [] opinions
  where
    mix flavors opinion = case opinion of
      Like flavor -> flavor : flavors
      Dislike _ -> flavors


-- charAt :: String -> Int -> Maybe Char
-- charAt s i
--   | i >= length s = Nothing
--   | otherwise = Just $ s !! i

charAt :: String -> Int -> Either String Char
charAt s i
  | i >= length s = Left "index out of bounds"
  | otherwise = Right $ s !! i