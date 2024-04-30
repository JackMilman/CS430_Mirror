import Text.Printf

data Color = Color Int Int Int

data Shape
    = Circle (Double, Double) Double Color
    | Rectangle (Double, Double) (Double, Double) Color

data Frankenshape = Frankenshape [Shape]

class Svg a where
    toSvg :: a -> String

instance Svg Color where
    toSvg (Color r g b) = printf "rgb(%d, %d, %d)" r g b

instance Svg Shape where
    toSvg (Circle (cx, cy) radius color) = printf "<circle cx=\"%0.2f\" cy=\"%0.2f\" r=\"%0.2f\" fill=\"%s\" />\n" cx cy radius (toSvg color)
    toSvg (Rectangle (x, y) (w, h) color) = printf "<rect x=\"%0.2f\" y=\"%0.2f\" width=\"%0.2f\" height=\"%0.2f\" fill=\"%s\" />\n" x y w h (toSvg color)

instance Svg Frankenshape where
    toSvg (Frankenshape list) = printf "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n%s</svg>\n" $ concat $ map ("\t" ++) $ map (toSvg) list

main = do
    let skin_c = Color 255 128 0
    let white_c = Color 255 255 255
    let hat_c = Color 0 0 0

    let skull = Circle (500, 500) 100 skin_c
    let left_eye = Circle(450, 475) 25 white_c
    let right_eye = Circle(550, 475) 25 white_c

    let brim = Rectangle (400, 400) (200, 10) hat_c
    let crown = Rectangle (450, 350) (100, 50) hat_c
    let v = toSvg $ Frankenshape [skull, left_eye, right_eye, brim, crown]
    putStr v
    writeFile "picture.svg" v