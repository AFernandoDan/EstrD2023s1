-- Nave Espacial
-- exportar nave
module Nave where (Nave, construir, ingresarT, sectoresAsignados, datosDeSector, tripulantesN, agregarASector, asignarASector)
-- En este examen modelaremos una Nave como un tipo abstracto, el cual nos permite construir una nave espacial, dividida en
-- sectores, a los cuales podemos asignar tripulantes y componentes. Para esto, damos por hecho que:
-- El tipo Sector es un tipo abstracto, y representa al sector de una nave, el cual contiene componentes y tripulantes asignados.
-- El tipo Tripulante es un tipo abstracto, y representa a un tripulante dentro de la nave, el cual tiene un nombre, un rango
-- y sectores asignados.
-- El tipo SectorId es sinónimo de String, e identifica al sector de forma unívoca.
-- Los tipos Nombre y Rango son sinónimos de String. Todos los nombres de tripulantes son únicos.
-- Un sector está vacío cuando no tiene tripulantes, y la nave está vacía si no tiene ningún tripulante.
-- Puede haber tripulantes sin sectores asignados.
-- Representación
-- Dicho esto, la representación será la siguiente (que no es posible modificar ):
-- data Nave = N (Map SectorId Sector) (Map Nombre Tripulante) (MaxHeap Tripulante)
-- Esta representación utiliza:
-- Un Map que relaciona para cada SectorId su sector correspondiente.
-- Otro Map que relaciona para cada Nombre de tripulante el tripulante con dicho nombre.
-- Una MaxHeap que incluye a todos los tripulantes de la nave, cuyo criterio de ordenado es por rango de los tripulantes.

data Componente = LanzaTorpedos | Motor Int | Almacen [Barril]
data Barril = Comida | Oxigeno | Torpedo | Combustible

type SectorId = String
type Nombre = String
type Rango = String

data Nave = N (Map SectorId Sector) (Map Nombre Tripulante) (MaxHeap Tripulante)
-- INV.REP:
-- Cada par (IdSector, Sector) en el map de sectores cumple que IdSector = sectorId Sector
-- Cada par (Nombre, Tripulante) en el map de tripulantes cumple que NombreTripulante = nombre Tripulante
-- Si un tripulante está en la heap, entonces está en el map de tripulantes
-- Si un sectorid esta en algun tripulante, entonces el sectorid esta en el map de sectores

-- a) Dar invariantes de representación válidos según la descripción de la estructura.

-- Implementación
-- Implementar la siguiente interfaz de Nave, utilizando la representación y los costos dados, calculando los costos de cada
-- subtarea, y siendo T la cantidad de tripulantes y S la cantidad de sectores:

-- b) construir :: [SectorId] -> Nave
-- Propósito: Construye una nave con sectores vacíos, en base a una lista de identificadores de sectores.
-- Eficiencia: mapConSectores O(S * Log S) + emptyM O(1) + emptyH O(1)
--           = O(S * Log S) + O(1) + O(1)
--           = O(S * Log S + 1 + 1)
--           = O(S * Log S), esto es asi porque 1 es despreciable al sumarse con algo mayor
-- En total, la eficiencia es O(S * Log S), siendo S la cantidad de sectores.
construir :: [SectorId] -> Nave
construir ss = Nave (mapConSectores ss) emptyM emptyH

-- Propósito: Dado un conjunto de sectores, devuelve un Map que relaciona cada SectorId con un sector vacío.
-- Eficiencia: emptyM O(1) + S * (assocM O(Log S) + crearS O(1))
--           = O(1) + (O(S) * O(Log S) + O(1))
--           = O(1 + S * (Log S + 1))
--           = O(S * Log S), esto es asi porque 1 es despreciable al sumarse con algo mayor
-- En total, la eficiencia es O(S * Log S), siendo S la cantidad de sectores.
mapConSectores :: [SectorId] -> Map SectorId Sector
mapConSectores [] = emptyM
mapConSectores (sid:sids) = assocM sid (crearS sid) (mapConSectores sids)

-- c) ingresarT :: Nombre -> Rango -> Nave -> Nave
-- Propósito: Incorpora un tripulante a la nave, sin asignarle un sector.
-- Eficiencia: assocM O(Log T) + insertH O(Log T)
--           = O(Log T) + O(Log T)
--           = O(Log T + Log T) = O(2 * Log T)
--           O(2 * Log T) = O(Log T), esto es asi porque multiplicar por una constante no cambia la complejidad
-- En total, la eficiencia es O(Log T), siendo T la cantidad de tripulantes.
ingresarT :: Nombre -> Rango -> Nave -> Nave
ingresarT n r (N ms mt ht) = 
    let t = crearT n r in
        N ms (assocM n t mt) (insertH t ht)

-- d) sectoresAsignados :: Nombre -> Nave -> Set SectorId
-- Propósito: Devuelve los sectores asignados a un tripulante.
-- Precondición: Existe un tripulante con dicho nombre.
-- Eficiencia: sectoresT O(1) + lookupM O(Log T)
--           = O(1) + O(Log T)
--           = O(1 + Log T) = O(Log T), esto es asi porque 1 es despreciable al sumarse con algo mayor
-- En total, la eficiencia es O(Log T), siendo T la cantidad de tripulantes.
sectoresAsignados :: Nombre -> Nave -> Set SectorId
sectoresAsignados n (N _ mt _) = 
    case lookupM n mt of
        Nothing -> error "No existe un tripulante con dicho nombre"
        Just t -> sectoresT t

-- e) datosDeSector :: SectorId -> Nave -> (Set Nombre, [Componente])
-- Propósito: Dado un sector, devuelve los tripulantes y los componentes asignados a ese sector.
-- Precondición: Existe un sector con dicho id.
-- Eficiencia: lookupM O(Log S) + tripulantesS O(1) + componentesS O(1)
--           = O(Log S) + O(1) + O(1)
--           = O(Log S + 1 + 1) = O(Log S), esto es asi porque 1 es despreciable al sumarse con algo mayor
-- En total, la eficiencia es O(Log S), siendo S la cantidad de sectores.
datosDeSector :: SectorId -> Nave -> (Set Nombre, [Componente])
datosDeSector sid (N ms _ _) = 
    case lookupM sid ms of
        Nothing -> error "No existe el sector con dicho id"
        Just s -> (tripulantesS s, componentesS s)

-- f) tripulantesN :: Nave -> [Tripulante]
-- Propósito: Devuelve la lista de tripulantes ordenada por rango, de mayor a menor.
-- Eficiencia: heapToList O(T * Log T)
-- En total, la eficiencia es O(T * Log T), siendo T la cantidad de tripulantes.
tripulantesN :: Nave -> [Tripulante]
tripulantesN (N _ _ ht) = heapToList ht


-- Propósito: Dado un MaxHeap, devuelve una lista con los elementos ordenados de mayor a menor.
-- Eficiencia: isEmptyH O(1) + (O(H) * (maxH O(1) + deleteMaxH O(Log H)))
--           = O(1) + (O(H) * (O(1) + O(Log H)))
--           = O(1 + (H * (1 + Log H)))
--           = O(1 + (H * Log H)), esto es asi porque 1 es despreciable al sumarse con algo mayor
--           = O(H * Log H), nuevamente, 1 es despreciable al multiplicarse por algo mayor
-- En total, la eficiencia es O(H * Log H), siendo H la cantidad de elementos en la heap.
heapToList :: MaxHeap a -> [a]
heapToList h =
    if isEmptyH h
        then []
        else maxH h : heapToList (deleteMaxH h)

-- g) agregarASector :: [Componente] -> SectorId -> Nave -> Nave
-- Propósito: Asigna una lista de componentes a un sector de la nave.
-- Eficiencia: lookupM O(Log S) + assocM O(Log S) + agregarComponentes O(C)
--           = O(Log S) + O(Log S) + O(C)
--           = O(Log S + Log S + C) 
--           = O(2 * Log S + C)
--           = O(Log S + C), esto es asi porque multiplicar por una constante no cambia la complejidad
-- En total, O(C + log S), siendo C la cantidad de componentes dados y S la cantidad de sectores en la nave.
agregarASector :: [Componente] -> SectorId -> Nave -> Nave
agregarASector cs sid (N ms mt ht) = 
    case lookupM sid ms of
        Nothing -> error "No existe el sector con dicho id"
        Just s -> N (assocM sid (agregarComponentes cs s) ms) mt ht

-- Propósito: Agrega una lista de componentes a un sector.
-- Eficiencia: C * agregarC O(1)
--           = O(C + 1) = O(C), esto es asi porque 1 es despreciable al sumarse con algo mayor
-- En total, la eficiencia es O(C), siendo C la cantidad de componentes de la lista.
agregarComponentes :: [Componente] -> Sector -> Sector
agregarComponentes [] s = s
agregarComponentes (c:cs) s = agregarComponentes cs (agregarC c s)

-- h) asignarASector :: Nombre -> SectorId -> Nave -> Nave
-- Propósito: Asigna un sector a un tripulante.
-- Nota: No importa si el tripulante ya tiene asignado dicho sector.
-- Precondición: El tripulante y el sector existen.
-- Eficiencia: O(log S + log T + T log T)
asignarASector :: Nombre -> SectorId -> Nave -> Nave
asignarASector n sid (N ms mt ht) = 
    let nt = asignarSATripulanteEnMap n sid mt in
        ns = asignarTASectorEnMap sid n ms in
        nht = reemplazarTripulanteEnHeap nt ht in
            N (assocM sid ns ms) (assocM n nt mt) nht

-- Propósito: dado un map de tripulantes, asigna un sector a un tripulante.
-- Precondición: El tripulante con el nombre dado existe.
asinagrSATripulanteEnMap :: Nombre -> SectorId -> Map Nombre Tripulante -> Tripulante
asignarSATripulanteEnMap n sid mt = asignarS sid (fromJust (lookupM n mt))

-- Propósito: dado un map de sectores, asigna un tripulante a un sector.
-- Precondición: El sector con el id dado existe.
asignarTASectorEnMap :: SectorId -> Nombre -> Map SectorId Sector -> Sector
asignarTASectorEnMap sid n ms = asignarT n (fromJust (lookupM sid ms))

-- Propósito: dado un heap de tripulantes, reemplaza un tripulante por otro. Sino existe, lo inserta.
-- Precondición: No hay dos tripulantes con el mismo nombre.
-- Eficiencia: O(log M + M log M)
reemplazarTripulanteEnHeap :: Tripulante -> MaxHeap Tripulante -> MaxHeap Tripulante
reemplazarTripulanteEnHeap nt ht = 
    if isEmptyH ht
        then insertH nt ht
        else if nombre (maxH ht) == nombre nt
            then insertH nt (deleteMaxH ht)
            else insertH (maxH ht) (reemplazarTripulanteEnHeap nt (deleteMaxH ht))


-- Anexo de interfaces
-- Sector, siendo C la cantidad de contenedres y T la cantidad de tripulantes:
crearS :: SectorId -> Sector -- O(1)
sectorId :: Sector -> SectorId -- O(1)
componentesS :: Sector -> [Componente] -- O(1)
tripulantesS :: Sector -> Set Nombre -- O(1)
agregarC :: Componente -> Sector -> Sector -- O(1)
agregarT :: Nombre -> Sector -> Sector -- O(log T)

-- Tripulante, siendo S la cantidad de sectores:
crearT :: Nombre -> Rango -> Tripulante -- O(1)
asignarS :: SectorId -> Tripulante -> Tripulante -- O(log S)
sectoresT :: Tripulante -> Set SectorId -- O(1)
nombre :: Tripulante -> String -- O(1)
rango :: Tripulante -> Rango -- O(1)

-- Set, siendo N la cantidad de elementos del conjunto:
emptyS :: Set a -- O(1)
addS :: a -> Set a -> Set a -- O(log N)
belongsS :: a -> Set a -> Bool -- O(log N)
unionS :: Set a -> Set a -> Set a -- O(N log N)
setToList :: Set a -> [a] -- O(N)
sizeS :: Set a -> Int -- O(1)

-- MaxHeap, siendo M la cantidad de elementos en la heap:
emptyH :: MaxHeap a -- O(1)
isEmptyH :: MaxHeap a -> Bool -- O(1)
insertH :: a -> MaxHeap a -> MaxHeap a -- O(log M)
maxH :: MaxHeap a -> a O(1)
deleteMaxH :: MaxHeap a -> MaxHeap a -- O(log M)

-- Map, siendo K la cantidad de claves distintas en el map:
emptyM :: Map k v -- O(1)
assocM :: k -> v -> Map k v -> Map k v -- O(log K)
lookupM :: k -> Map k v -> Maybe v -- O(log K)
deleteM :: k -> Map k v -> Map k v -- O(log K)
domM :: Map k v -> [k] -- O(K)