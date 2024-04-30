import Text.Printf
data Point = Point Double Double

instance Show Point where
    show (Point x y) = printf "(%.2f,%.2f)" x y

data Transform
    = Scale Double Double
    | Rotate Double
    | Translate Double Double

transform :: Transform -> Point -> Point
transform (Scale factorX factorY) (Point x y) = Point (x * factorX) (y * factorY)
transform (Translate offsetX offsetY) (Point x y) = Point (x + offsetX) (y + offsetY)
transform (Rotate radians) (Point x y) = undefined

main = do
    let p = Point 10 9
    let p' = transform (Scale 0.2 0.8) p
    print p
    print p'