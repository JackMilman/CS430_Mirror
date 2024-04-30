import System.Environment

data Amount = None | One | Two | Many
    deriving (Eq, Show, Enum)

more :: Amount -> Amount
more Many = Many
more cur = succ cur

data Schedule =
  Day Int Int Int |   -- only on the given Y/M/D
  Daily |             -- recurs everday
  Weekly Int |        -- once a week (Sunday is 0)
  Monthly Int |       -- once a month (day is in 1-31)
  Yearly Int Int      -- once a year on given M/D

data Polynomial =
    Quadratic Double Double Double |
    Linear Double Double |
    Constant Double
    deriving (Show)

evaluate :: Polynomial -> Double -> Double
evaluate (Quadratic q m b) x = (q * x * x) + (m * x) + b
evaluate (Linear m b) x = (m * x) + b
evaluate (Constant b) x = b

data Throw = Rock | Paper | Scissors

instance Eq Throw where
    (==) Rock Rock = True
    (==) Rock _ = False
    (==) Paper Paper = True
    (==) Paper _ = False
    (==) Scissors Scissors = True
    (==) Scissors _ = False

instance Ord Throw where
    compare Rock Paper = LT
    compare Paper Scissors = LT
    compare Scissors Rock = LT
    compare Paper Rock = GT
    compare Scissors Paper = GT
    compare Rock Scissors = GT
    compare _ _ = EQ

data Coordinate = Coordinate Double Double

data House = House { bedroomCount :: Int
                   , bathroomCount :: Int
                   , area :: Int
                   , yearBuilt :: Int
                   , askingPrice :: Int} deriving Show
                   
age :: House -> Int -> Int
age house year = year - (yearBuilt house)

data Defaultable a = Default a | Custom a
    deriving (Show, Eq)

at :: [Double] -> Int -> Defaultable Double
at [] _ = Default 0.0
at list 0 = Custom (head list)
at list ind =
    if ind < 0 then
        Default 0.0
    else
        at (tail list) (ind - 1)

main = do
    putStr ("Element: ")
    text <- getLine
    putStrLn text