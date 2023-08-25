import MultiSet

ocurrencias :: String -> MultiSet Char
-- Propósito: dado un string, devuelve un map donde las claves son los caracteres que aparecen
-- en el string, y los valores la cantidad de veces que aparecen en el mismo.(*)
ocurrencias [] = emptyMS 
ocurrencias (c:cs) = addMS c (ocurrencias cs)

ejMS = addMS 'a' (addMS 'b' (addMS 'a' (addMS 'c' emptyMS)))
ejMS2 = addMS 'd' (addMS 'b' (addMS 'a' (addMS 'd' emptyMS)))