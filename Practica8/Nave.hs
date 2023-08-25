import Control.Applicative (Alternative(empty))
import Map (emptyM)
data Nave = N (Map SectorId Sector) (Map Nombre Tripulante) (MaxHeap Tripulante)
{- INV.REP:
    * un tripulante no puede estar en 2. conjuntos asociados a multiples
    claves del map.
    * el primer componente del par esta asociado en el map al conjunto con mayor
      cardinalidad y dicha cardinalidad es igual a la segunda componente
    * cada tripulante que esta en un conjunto de valor del map debe estar
      presente en la heap y viceversa.
-}

naveVacia :: [Sector] -> Nave
naveVacia ss = MkN (asKeys ss) emptyM (head ss, 0)

asKeys :: Eq k => [k] -> Map k v
asKeys [] = emptyM
asKeys (x:xs) = assocM x emptyS (asKeys xs
