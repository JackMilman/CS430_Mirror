data Medalists a = Medalists a a a

-- Only the first three in the list win a medal.
winners :: [String] -> Medalists String
winners (x : y : z : _) = Medalists x y z

-- half :: Int -> Maybe Int
-- half x
--   | even x = Just $ div x 2
--   | otherwise = half $ x - 1

half :: Int -> Either String Int
half x
  | even x = Right $ div x 2
  | otherwise = Left $ show x ++ " is odd"

data Photo = Photo String Int

url :: Photo -> String
url (Photo address _) = address

size :: Photo -> Int
size (Photo _ bytes) = bytes