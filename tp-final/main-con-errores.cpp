#include <iostream>
using namespace std;
#include <iomanip>
#include "TiposBasicos.h"
#include "TableroInfinito.h"

int main(){
  TableroInfinito t = TInfInicial();
  PonerNTInf(t, ROJO,  -1);  PrintRepTInf(t);
  PonerNTInf(t, AZUL,  -100);
  MoverNTInf(t, OESTE, -100);
  PonerNTInf(t, VERDE, -10);  PrintRepTInf(t);
  MoverNTInf(t, OESTE, -1);
  PonerNTInf(t, ROJO,  -3);
  PonerNTInf(t, AZUL,  -5);  PrintRepTInf(t);
  MoverNTInf(t, ESTE,  -8);
  PonerNTInf(t, ROJO,  -7);  PrintRepTInf(t);
  int r = nroBolitasTInf(t, ROJO);
  int b = nroBolitasTInf(t, AZUL);
  MoverNTInf(t, ESTE,  -3);
  MoverNTInf(t, NORTE, -3);
  PonerNTInf(t, NEGRO, 0);  PrintRepTInf(t);
  MoverNTInf(t, SUR,   -5);
  MoverNTInf(t, OESTE, 0);
  MoverNTInf(t, NORTE, 1);
  MoverNTInf(t, ESTE, 1);
  PonerNTInf(t, AZUL, 10);  PrintRepTInf(t);
  int b2 = nroBolitasTInf(t, AZUL);
  MoverNTInf(t, SUR, 1);
  MoverNTInf(t, OESTE, 1);
  PonerNTInf(t, AZUL, 10);  PrintRepTInf(t);
  SacarNTInf(t, AZUL, 10);  PrintRepTInf(t);
  int b3 = nroBolitasTInf(t, AZUL);
  
  cout << "Test nroBolitas(Rojo) ( 0,0) - "; PRINTCOLORN(ROJO, r);  cout << " (debe ser `Rojo: 0`)" << endl;
  cout << "Test nroBolitas(Azul) ( 0,0) - "; PRINTCOLORN(AZUL, b);  cout << " (debe ser `Azul: 0`)" << endl;
  cout << "Test nroBolitas(Azul) ( 1,1) - "; PRINTCOLORN(AZUL, b2); cout << " (debe ser `Azul: 10`)" << endl;
  cout << "Test nroBolitas(Rojo) ( 0,0) - "; PRINTCOLORN(AZUL, b3);  cout << " (debe ser `Azul: 0`)" << endl;

  LiberarTInf(t);
}

/* La salida de este programa debe ser la siguiente:

Celda actual: (0, 0)
BiBST:
  (0,0): Azul: 0, Negro: 0, Rojo: 1, Verde: 0

Celda actual: (-1, 0)
BiBST:
  (0,0): Azul: 1, Negro: 0, Rojo: 1, Verde: 0
   (-1,0): Azul: 0, Negro: 0, Rojo: 0, Verde: 1

Celda actual: (-5, 0)
BiBST:
  (0,0): Azul: 1, Negro: 0, Rojo: 1, Verde: 0
   (-1,0): Azul: 0, Negro: 0, Rojo: 0, Verde: 1
    (-5,0): Azul: 2, Negro: 0, Rojo: 1, Verde: 0

Celda actual: (0, 0)
BiBST:
  (0,0): Azul: 1, Negro: 0, Rojo: 3, Verde: 0
   (-1,0): Azul: 0, Negro: 0, Rojo: 0, Verde: 1
    (-5,0): Azul: 2, Negro: 0, Rojo: 1, Verde: 0

Celda actual: (1, 1)
BiBST:
  (0,0): Azul: 1, Negro: 0, Rojo: 3, Verde: 0
   (1,1): Azul: 0, Negro: 1, Rojo: 0, Verde: 0
   (-1,0): Azul: 0, Negro: 0, Rojo: 0, Verde: 1
    (-5,0): Azul: 2, Negro: 0, Rojo: 1, Verde: 0

Test nroBolitas(Rojo) ( 0,0) - Rojo: 3 (debe ser `Rojo: 3`)
Test nroBolitas(Azul) ( 0,0) - Azul: 1 (debe ser `Azul: 1`)
Test nroBolitas(Azul) (-5,0) - Azul: 2 (debe ser `Azul: 2`)
*/
     