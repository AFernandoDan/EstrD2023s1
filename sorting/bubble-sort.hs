bubbleSort :: (Ord a) => [a] -> [a]
bubbleSort xs = if bpassed == xs then xs
                 else bubbleSort bpassed
                 where bpassed = bubblePass xs
-- costo: O(n^2), siendo n la longitud de la lista

bubblePass :: (Ord a) => [a] -> [a]
bubblePass [] = []
bubblePass [x] = [x]
bubblePass (x1:x2:xs) = if x1 > x2
                        then x2:bubblePass (x1:xs)
                        else x1:bubblePass (x2:xs)