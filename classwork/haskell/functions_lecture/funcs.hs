disemvowel = filter (\c -> c /= 'a' && c /= 'e' &&  c /= 'i' &&  c /= 'o' &&  c /= 'u')

-- sumAreas rectangles = foldl (\accum (w, h) -> accum + (w * h)) 0 rectangles
sumAreas = sum . map (\(w, h) -> w * h)

millisToSeconds = map (/ 1000)