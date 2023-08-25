#include <iostream>
using namespace std;
#include <iomanip>
#include "TiposBasicos.h"
#include "TableroInfinito.h"

int main(){
  TableroInfinito t = TInfInicial();
  MoverNTInf(t, OESTE, 1);
  SacarNTInf(t, AZUL,  0);
  int b = nroBolitasTInf(t, AZUL);
  PrintRepTInf(t);

 cout << "Test nroBolitas(Azul) ( -1,0) - "; PRINTCOLORN(AZUL, b);  cout << " (debe ser `Azul: 0`)" << endl;
  LiberarTInf(t);
}

/* La salida de este programa debe ser la siguiente:

Celda actual: (-1, 0)
BiBST:

Test nroBolitas(Azul) ( -1,0) - Azul: 0 (debe ser `Azul: 0`)
*/
     