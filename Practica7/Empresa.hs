module Empresa (
  Empresa,
  consEmpresa,
  buscarPorCUIL,
  empleadosDelSector,
  todosLosCUIL,
  todosLosSectores,
  agregarSector,
  agregarEmpleado,
  agregarASector,
  borrarEmpleado) where

import Empleado
import MapV1
import SetV1
import Data.Maybe (fromJust)


-- type SectorId = Int
-- type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)
{-  INV.REP: Dado una empresa: ConsE ms mc, se cumple que si k es una clave asociada en
    ms y lookupM k ms es de la forma Just se y se no es vacio, entonces cada elemento
    de se es un empleado asociado a un unico CUIL en mc.

    Sea (k,v) un par donde k es un CUIL, v es un empleado con el CUIL k.

    Los CUILs son >= 0

    Ademas, cada empleado en "se" es un empleado que tiene incorporado el sector k.



    Represento a los maps como listas de pares para la describir los casos validos/invalido.
    e_n es un empleado.
    VALIDOS:
      ConsE [] []
      ConsE [(13, []] []
      ConsE [(13, []] [(112233, e_1)]
      ConsE [(13, [e_1)]] [(112233, e_1)]
      ConsE [(13, [e_1, e_2)]] [(112233, e_1), (331122, e_2)]
      ConsE [(13, [e_1], (15, [])] [(112233, e_1), (331122, e_2)]

    INVALIDOS:
      ConsE [(13, [e_1])] []
      ConsE [(13, [e_1])] [(331122, e_2)]
      ConsE [(13, [e_1]), (15, [])] [(331122, e_2)]
      ConsE [(13, [e_1)]] [(112233, e_1), (331122, e_1)]
-}

-- Propósito: construye una empresa vacía.
-- Costo: O(1)
consEmpresa :: Empresa
consEmpresa = ConsE emptyM emptyM

-- Propósito: devuelve el empleado con dicho CUIL.
-- Sabiendo que el costo de lookupM en el map es O(Log N)
-- Costo: O(costo lookupM E)
-- Costo: O(log E)
-- Siendo E la cantidad de claves de map mc
buscarPorCUIL :: CUIL -> Empresa -> Empleado
-- Precond: Existe un empleado con ese cuil en la empresa.
buscarPorCUIL c (ConsE _ mc) = fromJust (lookupM c mc)

-- Propósito: indica los empleados que trabajan en un sector dado.
-- Sabiendo que el costo de lookupM en el map es O(Log N)
-- Suponiendo que el costo de setToList es O(N)
-- Costo: O([costo lookupM S] + E)
-- Costo: O(logS + E)
-- Siendo S la cantidad de claves del map ms y E la cantidad
-- de empleados en la empresa
empleadosDelSector :: SectorId -> Empresa -> [Empleado]
empleadosDelSector sid (ConsE ms _) =
  case lookupM sid ms of
    Nothing -> []
    Just se -> setToList se

-- Propósito: indica todos los CUIL de empleados de la empresa.
-- Sabiendo que el costo de keys es O(N)
-- Costo: O(costo keys E)
-- Costo: O(E)
-- Siendo E la cantidad de claves del map mc
todosLosCUIL :: Empresa -> [CUIL]
todosLosCUIL (ConsE _ mc) = keys mc

-- Propósito: indica todos los sectores de la empresa.
-- Sabiendo que el costo de keys es O(N)
-- Costo: O(costo keys S)
-- Costo: O(S)
-- Siendo S la cantida de claves del map ms
todosLosSectores :: Empresa -> [SectorId]
todosLosSectores (ConsE ms _) = keys ms

-- Propósito: agrega un sector a la empresa, inicialmente sin empleados.
-- Costo: O(costo agregarSectorM S)
-- Costo: O(logS)
-- Siendo S la cantida de claves del map ms
agregarSector :: SectorId -> Empresa -> Empresa
agregarSector sid (ConsE ms mc) = ConsE (agregarSectorM sid ms) mc

-- Propósito: agrega un empleado a la empresa, en el que trabajará en dichos sectores y tendrá
-- el CUIL dado.
-- Costo:
--  O([costo empleadoSsConC (S)]+[costo agregarEmpleadoMS (S, M, C)] + [costo assocM (C)])
--  O([costo empleadoSsConC (S)] + [costo agregarEmpleadoMS (S, M, C)] + Log C)
--  O([costo empleadoSsConC (S)] + [S*(Log M + Log C)] + Log C)
--  O([S * Log S] + [S*(Log M + Log C)] + Log C)
--  O([M * Log M] + [M*(Log M + Log C)] + Log C)
--  O(M * Log M + M*(Log M + Log C) + Log C)
--  O(M * Log M + M * Log M + M * Log C + Log C)
--  O(2 * (M * Log M) + M * Log C + Log C)
--  O(M * Log M + M * Log C + Log C)
--  O(M * (Log M + Log C) + Log C)
--  Siendo S la longitud de la lista ss
--  Siendo M la cantidad de claves del map ms
--  Siendo C la cantidad de claves del map mc
--  S puede ser reemplazado por M ya que como mucho un empleado podra
--  trabajar en M sectores.
agregarEmpleado :: [SectorId] -> CUIL -> Empresa -> Empresa
-- Precond: El CUIL no esta asociado a un empleado, los sectores dados existen en la empresa
agregarEmpleado ss c (ConsE ms mc) =
  let e = empleadoSsConC ss c in
    ConsE (agregarEmpleadoMS ss e ms) (assocM c e mc)

-- Propósito: agrega un sector al empleado con dicho CUIL.
-- Costo: O([costo empleadoConS (S, C)] + [costo assocM S] + [costo agregarEmpleadoS (C,S)] + [costo assocM C])
-- Costo: O([costo empleadoConS (S, C)] + [costo assocM S] + [Log C + Log S] + Log C)
-- Costo: O(Log S + Log C + Log S + Log C + Log S + Log C)
-- Costo: O(Log S + Log C)
-- Siendo S la cantidad de claves del map ms
-- Siendo C la cantidad de claves del map mc
agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
-- Precond: existe un empleado con dicho CUIL en la empresa
agregarASector sid c (ConsE ms mc) =
  let e = empleadoConS c sid mc in
    ConsE (assocM sid (agregarEmpleadoS e sid ms) ms) (assocM c e mc)

-- Costo: O([costo incorporarSector (E)] + [costo valueM (C)])
-- Costo: O([costo incorporarSector (E)] + [Log C])
-- Costo: O(Log E + Log C)
-- Siendo E la cantidad de sectores en los que trabaja el empleado
-- Siendo C la cantidad de claves del map mc
empleadoConS :: CUIL -> SectorId -> Map CUIL Empleado -> Empleado
-- Precond: existe la clave CUIL en el map
empleadoConS c sid mc = incorporarSector sid (valueM c mc)


-- Propósito: elimina al empleado que posee dicho CUIL.
-- Costo: O(costo borrarEmpleado' (S, C))
-- Costo: O(Log C + S * [Log C + Log S] + S)
-- Siendo C la cantidad de claves del map mc
-- Siendo S la cantidad de claves del map ms
-- Aclaracion: la cantidad maxima de empleados en un sector equivale a C.
borrarEmpleado :: CUIL -> Empresa -> Empresa
borrarEmpleado c (ConsE ms mc) =
  let (ms', mc') = borrarEmpleado' c ms mc in
    ConsE ms' mc'

-- Costo O([costo loookupM (C)] + [costo borrarEmpleadoMS (S)] + [costo deleteM (C)])
-- Costo O([costo loookupM (C)] + [costo borrarEmpleadoMS (S)] + Log C)
-- Costo O([costo loookupM (C)] + [S * [Log C + Log S] + S] + Log C)
-- Costo O(Log C + S * [Log C + Log S] + S + Log C)
-- Costo O(Log C + S * [Log C + Log S] + S)
-- Siendo C la cantidad de claves del map mc
-- Siendo S la cantidad de claves del map ms
-- Aclaracion: la cantidad maxima de empleados en un sector equivale a C.
borrarEmpleado' :: CUIL -> Map SectorId (Set Empleado) -> Map CUIL Empleado -> (Map SectorId (Set Empleado), Map CUIL Empleado)
borrarEmpleado' c ms mc =
  case lookupM c mc of
    Nothing -> (ms, mc)
    Just e -> (borrarEmpleadoMS e ms, deleteM c mc)

-- Costo O([costo borrarEmpleadoMS' (E,S)] + [costo setToList (S)] + [costo sectores (S)])
-- Costo O([costo borrarEmpleadoMS' (E,S)] + [costo setToList (S)] + 1)
-- Costo O([costo borrarEmpleadoMS' (E,S)] + S)
-- Costo O(S * [Log E + Log S] + S)
-- Siendo S La cantidad de claves de ms
-- Siendo E la cantidad maxima de empleados que trabajan en un sector
borrarEmpleadoMS :: Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
borrarEmpleadoMS e ms = borrarEmpleadoMS' (setToList (sectores e)) e ms

-- Costo: O(S * [Costo borrarEmpleadoS (E, S2)])
-- Costo: O(S * [Log E + Log S2])
-- Siendo S la cantidad de elementos de la lista ss
-- Siendo E la cantidad maxima de empleados que trabajan en un sector
-- Siendo S2 la cantidad de claves del map ms
borrarEmpleadoMS' :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
-- Precond: El empleado trabaja en los sectores
borrarEmpleadoMS' [] _ ms = ms
borrarEmpleadoMS' (sid:ss) e ms = borrarEmpleadoMS' ss e (borrarEmpleadoS e sid ms)

-- Costo: O([costo assocM (S)] + [costo removeS (E)] + [costo valueM S])
-- Costo: O([costo assocM (S)] + [costo removeS (E)] + Log S)
-- Costo: O([costo assocM (S)] + Log E + Log S)
-- Costo: O(Log S + Log E + Log S)
-- Costo: O(Log E + Log S)
-- Siendo E la cantidad maxima de empleados que trabajan en un sector
-- Siendo S la cantidad de claves del map ms
borrarEmpleadoS :: Empleado -> SectorId -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
-- Precond: El empleado trabaja en el sector
borrarEmpleadoS e sid ms = assocM sid (removeS e (valueM sid ms)) ms

-- Propósito: agrega un sector al map de sectores, inicialmente sin empleados.
-- Suponemos
-- Costo: O(assocM M)
-- Costo: O(log M)
-- Siendo M la cantidad de claves del map
agregarSectorM :: SectorId -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
agregarSectorM sid ms = assocM sid emptyS ms

-- Sabemos que assocM y addS son O(Log N)
-- Costo: O(S*([costo assocM (M)] + [costo agregarEmpleadoS (E, M)]))
-- Costo: O(S*([costo assocM (M)] + Log E + Log M))
-- Costo: O(S*(Log M + Log E + Log M))
-- Costo: O(S*(Log M + Log E))
-- Siendo S la longitud de la lista de ids de sectores
-- Siendo M la cantidad de claves del map de sectores
-- Siendo E la maxima cantidad de empleados que trabajan en un sector
agregarEmpleadoMS :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
-- Precond: Los sectores dados estan en la empresa.
agregarEmpleadoMS [] e ms = ms
agregarEmpleadoMS (s:ss) e ms =
  let ms' = agregarEmpleadoMS ss e ms in
  assocM s (agregarEmpleadoS e s ms') ms'

-- Sabiendo que addS es de O(Log N)
-- Costo: O([costo addS (E)] + [costo valueM (M)])
-- Costo: O([costo addS (E)] + Log M)
-- Costo: O(Log E + Log M)
-- Siendo E la cantidad de empleados que trabajan en el sector
-- Siendo M la cantidad de claves del map ms 
agregarEmpleadoS :: Empleado -> SectorId -> Map SectorId (Set Empleado) -> Set Empleado
-- Precond: Empleado es un empleado que tiene incorporado el sector s
agregarEmpleadoS e s ms = addS e (valueM s ms)

-- Sabemos que consEmpleado es O(1)
-- Sabemos que incorporarSector es O(Log S)
-- Costo: O(L * [costo incorporarSector L])
-- Costo: O(L * Log L)
-- Siendo L la longitud de la lista dada.
empleadoSsConC :: [SectorId] -> CUIL -> Empleado
empleadoSsConC [] c = consEmpleado c
empleadoSsConC (s:ss) c = incorporarSector s (empleadoSsConC ss c)

-- suponemoes que lookupM es log n
-- Costo: O(lookup (S))
-- Costo: O(log S)
-- Siendo S la cantidad de claves del map
valueM :: Eq k => k -> Map k v -> v
-- Precond: k tiene un valor en el map
valueM k m = fromJust (lookupM k m)