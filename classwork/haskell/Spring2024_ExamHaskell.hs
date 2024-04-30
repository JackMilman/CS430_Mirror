import System.Environment
import GHC.Exts
import Data.List.Split
import Data.List
import Data.Ord


pick :: (a -> Bool) -> b -> b -> [a] -> [b]
pick _ _ _ [] = []
pick pred first second list =
    [elem] ++ (pick pred first second (tail list))
    where
        elem = 
            if pred (head list) then 
                first 
            else 
                second




helper :: Int -> String -> String
helper _ [] = ""
helper width word = 
    if width < (length word) 
        then first ++ "\n" ++ (helper width rest)
        else word ++ "\n"
    where 
        first = take width word
        rest = drop width word

linebreak :: Int -> String -> String
linebreak width word = helper width word

linebreakAll :: Int -> [String] -> [String]
linebreakAll width words = map (linebreak width) words




-- staircase :: Int -> [String] -> IO ()
-- staircase offset words = do
--     putStrLn ((concat $ replicate offset " ") ++ (head words))
--     if (tail words == []) then
--         return ()
--     else
--         staircase (offset + (length $ head words)) $ tail words

-- main = do
--     args <- getArgs
--     let strs = args
--     staircase 0 strs




data Expression
    = Literal Int
    | Increment Expression
    | Negate Expression
    | Add Expression Expression
    | Mod Expression Expression

compute :: Expression -> Int
compute (Literal val) = val
compute (Increment val) = (compute val) + 1
compute (Negate val) = -(compute val)
compute (Add l_val r_val) = (compute l_val) + (compute r_val)
compute (Mod l_val r_val) = (compute l_val) `mod` (compute r_val)

instance Show Expression where
    show (Literal val) = show $ Literal val
    show (Increment val) = show $ compute $ Increment val
    show (Negate val) = show $ compute $ Negate val
    show (Add l_val r_val) = show $ compute (Add l_val r_val)
    show (Mod l_val r_val) = show $ compute (Mod l_val r_val)




data Arithmetic = Arithmetic Integer Integer
    deriving Show

data Geometric = Geometric Integer Integer
    deriving Show

class Sequence a where
    ith :: a -> Integer -> Integer

instance Sequence Arithmetic where
    ith (Arithmetic start offset) i = start + (offset * i)

instance Sequence Geometric where
    ith (Geometric start ratio) i = start * (ratio ^ i)



stringify :: [String] -> String
stringify pair = (head pair) ++ ": " ++ (head $ tail pair)

main = do
    args <- getArgs
    file <- readFile $ head args
    let strs = chunksOf 2 $ lines file
    mapM_ putStrLn $ map stringify $ sortWith (\(first : last) -> first) strs