module Empresa
(Empresa, SectorId, CUIL,Empleado,consEmpresa, buscarPorCUIL, empleadosDelSector, 
todosLosCUIL, todosLosSectores, agregarEmpleado, agregarASector , agregarSector, borrarEmpleado) 
where

import Map1
import Empleado 
import SetV2 

type SectorId = Int
type CUIL = Int
data Empresa = ConsE (Map SectorId (Set Empleado)) (Map CUIL Empleado)
--los id de sectores y los legajos no pueden repetirse.
--los empleados son un tipo abstracto.
--el primer map relaciona id de sectores con los empleados que trabajan en dicho sector.
--el segundo map relaciona empleados con su número de CUIL.
--un empleado puede estar asignado a más de un sector
--tanto Map como Set exponen una interfaz efficiente con costos logarítmicos para inserción,
--búsqueda y borrado, tal cual vimos en clase.

consEmpresa :: Empresa
--Propósito: construye una empresa vacía.
--Costo: O(1)
consEmpresa = ConsE emptyM emptyM

buscarPorCUIL :: CUIL -> Empresa -> Empleado
--Propósito: devuelve el empleado con dicho CUIL.
--Costo: O(log N)
buscarPorCUIL c (ConsE m1 m2) = case (lookupM c m2) of 
                                (Just x) -> x 
                                Nothing  -> error "asdf"

empleadosDelSector :: SectorId -> Empresa -> [Empleado]
--Propósito: indica los empleados que trabajan en un sector dado.
--Costo: O(N)
empleadosDelSector sId (ConsE m1 m2) =  case (lookupM sId m1) of 
                                        (Just x) -> setToList x 
                                        Nothing  -> error "asdf"

todosLosCUIL :: Empresa -> [CUIL]
--Propósito: indica todos los CUIL de empleados de la empresa.
--Costo: O(N)
todosLosCUIL (ConsE m1 m2) = keys m2  

todosLosSectores :: Empresa -> [SectorId]
--Propósito: indica todos los sectores de la empresa.
--Costo: O(N)
todosLosSectores (ConsE m1 m2) = keys m1 

agregarSector :: SectorId -> Empresa -> Empresa
-- o(Log n)
agregarSector sid (ConsE m1 m2) = ConsE (assocM sid emptyS m1) m2

agregarEmpleado ::[SectorId] -> CUIL -> Empresa -> Empresa
-- o(M log N) dada la funcion agregarEmpleadoPorSIds 
--Propósito: agrega un empleado a la empresa, en el que trabajará en dichos sectores y tendrá
--el CUIL dado.-
agregarEmpleado sIds cuil (ConsE m1 m2) =   let em = agregarSectoresAEmpleado sIds (consEmpleado cuil) -- o(M log N)
                                            in ConsE (agregarEmpleadoPorSIds sIds em m1) (assocM cuil em m2)

agregarASector :: SectorId -> CUIL -> Empresa -> Empresa
--Propósito: agrega un sector al empleado con dicho CUIL.
--Costo: o(Log N) dada la subtarea agregarASector'
agregarASector sId cuil (ConsE m1 m2) = ConsE (agregarASector' sId (incorporarSector sId (consEmpleado cuil)) m1) m2 

borrarEmpleado ::  CUIL -> Empresa -> Empresa
--Propósito: elimina
--o(M log N)
borrarEmpleado cuil (ConsE m1 m2) = case lookupM cuil m2 of 
                                    (Just x) -> ConsE (borrarEmpleadoDeSector (setToList (sectores x)) x m1) (deleteM cuil m2)
                                    Nothing  -> error "asdf "













agregarEmpleadoPorSIds :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
-- o(M Log N) M es la cantidad de elementos de la lista
--            log N es la operacion assocM                                           
agregarEmpleadoPorSIds []     em map = emptyM
agregarEmpleadoPorSIds (x:xs) em map = agregarASector' x em (agregarEmpleadoPorSIds xs em map)

borrarEmpleadoDeSector :: [SectorId] -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado)
-- o(M log N) 
-- M es la cantidad de elementos de la lista 
-- log N es por las 3 operaciones que se hacen a cada elemento de la lista (assocM, removeS y lookupM)
borrarEmpleadoDeSector []         em map = emptyM
borrarEmpleadoDeSector (sid:sids) em map = case (lookupM sid map) of
                                            (Just x) -> assocM sid (removeS em x) (borrarEmpleadoDeSector sids em map)
                                            Nothing  -> error "asd"
agregarASector' ::  SectorId -> Empleado -> Map SectorId (Set Empleado) -> Map SectorId (Set Empleado) 
-- o(Log N) dada a que son dos operaciones logaritmicas 
agregarASector' sid em map =  case (lookupM sid map) of
                                    (Just x) ->  assocM sid (addS em x)      map  
                                    Nothing  ->  assocM sid (addS em emptyS) map 

agregarSectoresAEmpleado :: [SectorId] -> Empleado -> Empleado
-- o(M log N)
-- M es la cantidad de elementos de la lista 
-- log N es el costo de la operacion incorporarSector
agregarSectoresAEmpleado [] em         = em 
agregarSectoresAEmpleado (sid:sids) em = incorporarSector sid em 