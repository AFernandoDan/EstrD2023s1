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
  
  OBSERVACIÓN:
  * Si una celda no esta en el arbol de celdas, entonces la cantidad de bolitas
    de cada color es 0.
*/

//--------------------------------------------------------------------------
TableroInfinito TInfInicial(){
  TableroInfinitoHeader* t = new TableroInfinitoHeader;
  t->cax = 0;
  t->cay = 0;
  t->celdas = EMPTYBB;

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

  if (n > 0) {
      BiBST celdaActual = insertBBNode(t->celdas, t->cax, t->cay);
      if (t->celdas == EMPTYBB) {
        t->celdas = celdaActual;
      }
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
  
  BiBST celdaActual = findBBNode(t->celdas, t->cax, t->cay);
  int cantBolitasDelColor = 0;
  if (celdaActual != NULL) {
    cantBolitasDelColor = celdaActual->bolitas[color];
  }

  if (cantBolitasDelColor < n) {
    BOOM("No hay suficientes bolitas para sacar");
  }

  if (celdaActual != NULL && n > 0) {
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

  if (n > 0) {
   modificarPosicion(t, dir, n);
  }

}

//--------------------------------------------------------------------------
int nroBolitasTInf(TableroInfinito t, Color color) {
  // PRECOND: el color es válido
  if (VALIDCOLOR(color)) {
    BiBST celdaActual = findBBNode(t->celdas, t->cax, t->cay);
    if (celdaActual == NULL) {
      return 0;
    } else {
      return celdaActual->bolitas[color];
    }
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
