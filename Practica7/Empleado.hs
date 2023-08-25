module Empleado (Empleado, CUIL, SectorId, consEmpleado, cuil, incorporarSector, sectores) where
import SetV1

data Empleado = E CUIL (Set SectorId)

type SectorId = Int
type CUIL = Int

-- define la eq para empleado
instance Eq Empleado where
  (E c1 _) == (E c2 _) = c1 == c2

-- Propósito: construye un empleado con dicho CUIL.
-- Costo: O(1)
consEmpleado :: CUIL -> Empleado
consEmpleado c = E c emptyS

-- Propósito: indica el CUIL de un empleado.
-- Costo: O(1)
cuil :: Empleado -> CUIL
cuil (E c _) = c

-- Propósito: incorpora un sector al conjunto de sectores en los que trabaja un empleado.
-- Costo: O(log S), siendo S la cantidad de sectores que el empleado tiene asignados.
incorporarSector :: SectorId -> Empleado -> Empleado
incorporarSector sid (E c ss) = E c (addS sid ss)

-- Propósito: indica los sectores en los que el empleado trabaja.
-- Costo: O(1)
sectores :: Empleado -> Set SectorId
sectores (E _ ss) = ss
