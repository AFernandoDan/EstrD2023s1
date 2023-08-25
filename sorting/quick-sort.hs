quickSort :: Ord a => [a] -> [a]
quickSort [] = []
quickSort (x:xs) = 
    let smallerSorted = quickSort (getSmaller xs x)
        biggerSorted = quickSort (getBigger xs x)
    in smallerSorted ++ [x] ++ biggerSorted

-- el costo en promedio es O(n*log(n))
-- en peor caso es: O(n^2)

-- siendo n la cantidad de elementos de la lista dada

getSmaller :: Ord a => [a] -> a -> [a]
getSmaller [] _ = []
getSmaller (x:xs) pivot = 
    if x <= pivot 
        then x : getSmaller xs pivot
        else getSmaller xs pivot

getBigger :: Ord a => [a] -> a -> [a]
getBigger [] _ = []
getBigger (x:xs) pivot =
    if x > pivot
        then x : getBigger xs pivot
        else getBigger xs pivot