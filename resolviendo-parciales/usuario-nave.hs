-- importar nave
import Nave

-- protocolo de nave
-- b) construir :: [SectorId] -> Nave
-- Propósito: Construye una nave con sectores vacíos, en base a una lista de identificadores de sectores.
-- Eficiencia: O(S)
-- c) ingresarT :: Nombre -> Rango -> Nave -> Nave
-- Propósito: Incorpora un tripulante a la nave, sin asignarle un sector.
-- Eficiencia: O(log T)
-- d) sectoresAsignados :: Nombre -> Nave -> Set SectorId
-- Propósito: Devuelve los sectores asignados a un tripulante.
-- Precondición: Existe un tripulante con dicho nombre.
-- Eficiencia: O(log M)
-- e) datosDeSector :: SectorId -> Nave -> (Set Nombre, [Componente])
-- Propósito: Dado un sector, devuelve los tripulantes y los componentes asignados a ese sector.
-- Precondición: Existe un sector con dicho id.
-- Eficiencia: O(log S)
-- f) tripulantesN :: Nave -> [Tripulante]
-- Propósito: Devuelve la lista de tripulantes ordenada por rango, de mayor a menor.
-- Eficiencia: O(log T)
-- g) agregarASector :: [Componente] -> SectorId -> Nave -> Nave
-- Propósito: Asigna una lista de componentes a un sector de la nave.
-- Eficiencia: O(C + log S), siendo C la cantidad de componentes dados.
-- h) asignarASector :: Nombre -> SectorId -> Nave -> Nave
-- Propósito: Asigna un sector a un tripulante.
-- Nota: No importa si el tripulante ya tiene asignado dicho sector.
-- Precondición: El tripulante y el sector existen.
-- Eficiencia: O(log S + log T + T log T)

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
data Barril = Comida | Oxigeno | Torpedo | Combustible

-- i) sectores :: Nave -> Set SectorId
-- Propósito: Devuelve todos los sectores no vacíos (con tripulantes asignados).
sectores :: Nave -> Set SectorId
-- Eficiencia: tripulantesN O(T*Log(T)), sectoresDeTripulantes O(T*S*Log(S))
--             = O(T*Log(T)) + O(T*S*Log(S))
--             = O(T*Log(T) + T*S*Log(S))
--             = O(T*(Log(T) + S*Log(S))
-- En total: O(T + S*Log(S)), siendo T la cantidad de tripulantes y 
-- S la cantidad de sectores diferentes que hay entre todos los tripulantes.
sectores nave = sectoresDeTripulantes (tripulantesN nave)

-- Propósito: Devuelve todos los sectores no vacíos (con tripulantes asignados).
sectoresDeTripulantes :: [Tripulante] -> Set SectorId
-- Eficiencia: emptyS O(1), recursión O(T), unionS O(S*Log(S)), sectoresT O(1)
--             = O(1) + O(T * S*Log(S)) + O(1)
--             = O(1 + (T * S*Log(S)) + 1)
--             = O(T * S*Log(S)), esto es asi porque O(1) es depreciable respecto a O(T) y O(S*Log(S)
--             = O(T*S*Log(S))
-- En total: O(T + S*Log(S)), siendo T la cantidad de tripulantes y 
-- S la cantidad de sectores diferentes que hay entre todos los tripulantes.
sectoresDeTripulantes [] = emptyS
sectoresDeTripulantes (t:ts) = unionS (sectoresT t) (sectoresDeTripulantes ts)

-- j) sinSectoresAsignados :: Nave ->[Tripulante]
-- Propósito: Devuelve los tripulantes que no poseen sectores asignados.
-- Eficiencia: tripulantesN O(T), recursión O(T)
--             = O(T + T)
--             = O(2T)
--             = O(T), esto es asi porque multiplicar por una constante no cambia la complejidad
-- En total: O(T), siendo T la cantidad de tripulantes de la nave
sinSectoresAsignados :: Nave -> [Tripulante]
sinSectoresAsignados nave = sinSectoresAsignadosTS (tripulantesN nave)

-- Propósito: Devuelve los tripulantes que no poseen sectores asignados.
-- Eficiencia: sizeS O(1), sectoresT O(1), recursión O(T)
--             = O(T)
-- En total: O(T), siendo T la cantidad de tripulantes de la lista dada
sinSectoresAsignadosTS :: [Tripulante] -> [Tripulante]
sinSectoresAsignadosTS [] = []
sinSectoresAsignadosTS (t:ts) = if sizeS (sectoresT t) == 0 
                                then t : sinSectoresAsignadosTS ts
                                else sinSectoresAsignadosTS ts

-- k) barriles :: Nave -> [Barril]
-- Propósito: Devuelve todos los barriles de los sectores asignados de la nave.

barriles :: Nave -> [Barril]
barriles nave = barrilesCS (componentesN nave)

componentesN :: Nave -> [Componente]
componentesN nave = componentesSidS (setToList (sectores nave)) nave

componentesSidS :: [SectorId] -> Nave -> [Componente]
componentesSidS [] _ = []
componentesSidS (sid:sids) nave = 
    let (ns, cs) = datosDeSector sid nave in
    cs ++ componentesSidS sids nave

-- Propósito: Devuelve todos los barriles de la lista de componentes.
-- Eficiencia: C * (barrilesC O(1) + (++) O(C))
--          = C * (O(1) + O(C))
--          = C * O(C)
--          = O(C^2)
-- En total: O(C^2), siendo C la cantidad de componentes.
barrilesCS :: [Componente] -> [Barril]
barrilesCS [] = []
barrilesCS (c:cs) = barrilesC c ++ barrilesCS cs

-- Propósito: Devuelve la lista de barriles del componente.
-- Eficiencia: O(1)
barrilesC :: Componente -> [Barril]
barrilesC (Almacen bs) = bs
barrilesC c = []

-- i) Posible representación para el tipo Sector
data Sector = Sector SectorId (Set Nombre) [Componente]