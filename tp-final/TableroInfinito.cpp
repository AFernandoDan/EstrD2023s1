#include <iostream>
#include <iomanip>
#include <algorithm>
#include "TiposBasicos.h"
#include "TableroInfinito.h"
#include "BiBST.h"
using namespace std;

//==========================================================================
// Implementación de TableroInfinito
//==========================================================================
struct TableroInfinitoHeader {
  int cax;
  int cay;
  BiBST celdas;
}; 
/* INV.REP.:
  * no hay un BiBST en el tablero que tenga cantidades negativas de bolitas.
  * el BiBST no es nulo.
*/

//--------------------------------------------------------------------------
TableroInfinito TInfInicial(){
  TableroInfinitoHeader* t = new TableroInfinitoHeader;
  t->cax = 0;
  t->cay = 0;
  t->celdas = insertBBNode(EMPTYBB, 0,0);

  return t;
}

//--------------------------------------------------------------------------
void PonerNTInf(TableroInfinito t, Color color, int n){
  // PRECOND:
  //  * el color es válido
  //  * n >= 0

  if (!VALIDCOLOR(color)) {
    BOOM("El color no es valido");
  }

  BiBST celdaActual = insertBBNode(t->celdas, t->cax, t->cay);
  if (n >= 0) {
    celdaActual->bolitas[color] += n;
  }
}

//--------------------------------------------------------------------------
void SacarNTInf(TableroInfinito t, Color color, int n){
  // PRECOND:
  //  * el color es válido
  //  * hay al menos n bolitas en la celda actual en t
  //  * n >= 0

  if (!VALIDCOLOR(color)) {
    BOOM("El color no es valido");
  }
  
  BiBST celdaActual = insertBBNode(t->celdas, t->cax, t->cay);
  if (celdaActual->bolitas[color] < n) {
    BOOM("No hay suficientes bolitas para sacar");
  }

  if (n >= 0) {
    celdaActual->bolitas[color] -= n;
  }
  
}

//--------------------------------------------------------------------------

// Proposito: mueve la posicion actual del tablero N veces
//  hacia la dirección dada.
void modificarPosicion(TableroInfinito t, Dir dir, int n) {
  // PRECOND: la dirección dada es válida
  switch (dir) {
    case NORTE:
      t->cay += n;
      break;
    case SUR:
      t->cay -= n;
      break;
    case ESTE:
      t->cax += n;
      break;
    case OESTE:
      t->cax -= n;
      break;
  }
}

void MoverNTInf(TableroInfinito t, Dir dir, int n){
  // PRECOND:
  //  * la dirección dada es válida
  //  * n >= 0
  
  if (!VALIDDIR(dir)) {
    BOOM("La direccion no es valida");
  }

  if (n >= 0) {
   modificarPosicion(t, dir, n);
  }

}

//--------------------------------------------------------------------------
int nroBolitasTInf(TableroInfinito t, Color color) {
  // PRECOND: el color es válido
  if (VALIDCOLOR(color)) {
    return insertBBNode(t->celdas, t->cax, t->cay)->bolitas[color];
  } else {
    BOOM("El color no es valido");
  }
}

//--------------------------------------------------------------------------
void LiberarTInf(TableroInfinito t) {
  LiberarBiBST(t->celdas);
  delete t;
}

//==========================================================================
// Impresión para verificaciones
//==========================================================================
void PrintRepTInf(TableroInfinito t) {
 cout << "Celda actual: ("
      << t->cax
      << ", "
      << t->cay
      << ")"
      << endl;

 PrintBB(t->celdas);

 cout << endl;
}
