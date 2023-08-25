#include <iostream>
#include "LinkedListV2.h"
using namespace std;

struct NodoL {
  int elem; // valor del nodo
  NodoL* siguiente; // puntero al siguiente nodo
};

struct LinkedListSt {
  // INV.REP.:
  // * cantidad indica la cantidad de nodos que se pueden recorrer
  //    desde primero por siguiente hasta alcanzar a NULL.
  // * first = NULL si last = NULL
  // * si last != NULL, last->next = NULL
  int cantidad; // cantidad de elementos
  NodoL* primero; // puntero al primer nodo
  NodoL* ultimo; // puntero al ultimo nodo
};

typedef LinkedListSt* LinkedList; // INV.REP.: el puntero NO es NULL

struct IteratorSt {
  NodoL* current;
};

typedef IteratorSt* ListIterator; // INV.REP.: el puntero NO es NULL

// Crea una lista vacía.
LinkedList nil() {
  LinkedListSt* xs = new LinkedListSt;
  xs->primero = NULL;
  xs->ultimo = NULL;
  xs->cantidad = 0;
  return xs;
}
// Costo: O(1)

// Indica si la lista está vacía.
bool isEmpty(LinkedListSt* xs) { 
  return xs->cantidad == 0;
}
// Costo: O(1)

// Devuelve el primer elemento.
// Precond: la lista no es vacia
int head(LinkedListSt* xs) {
  return xs->primero->elem;
}
// Costo: O(1)

// Agrega un elemento al principio de la lista.
void Cons(int x, LinkedListSt* xs) {
  NodoL* nodo = new NodoL;
  nodo->elem = x;
  nodo->siguiente = xs->primero;
  xs->primero = nodo;
  if (xs->ultimo == NULL) xs->ultimo = nodo;
  xs->cantidad++;
}
// Costo: O(1)

// Quita el primer elemento.
// Precond: La lista no es vacia
void Tail(LinkedListSt* xs) {
  NodoL* temp = xs->primero;
  xs->primero = xs->primero->siguiente;
  if (xs->primero == NULL) xs->ultimo = NULL;
  xs->cantidad--;
  delete temp;
}
// Costo: O(1)

// Devuelve la cantidad de elementos.
int length(LinkedListSt* xs) {
  return xs->cantidad;
}
// Costo: O(1)

// Agrega un elemento al final de la lista.
void Snoc(int x, LinkedListSt* xs) {
  NodoL* nodo = new NodoL;
  nodo->elem = x;
  nodo->siguiente = NULL;
  if (xs->ultimo == NULL) xs->primero = nodo;
  else xs->ultimo->siguiente = nodo;
  xs->ultimo = nodo;
  xs->cantidad++;
}
// Costo: O(N)
// Siendo N la cantidad de elementos de la lista.

// Apunta el recorrido al primer elemento.
ListIterator getIterator(LinkedListSt* xs) {
  IteratorSt* ixs = new IteratorSt;
  ixs->current = xs->primero;
  return ixs;
}
// Costo: O(1)

// Devuelve el elemento actual en el recorrido.
// Precond: ixs->current != NULL;
int current(IteratorSt* ixs) {
  return ixs->current->elem;
}
// Costo: O(1)

// Reemplaza el elemento actual por otro elemento.
// Precond: ixs->current != NULL;
void SetCurrent(int x, IteratorSt* ixs) {
  ixs->current->elem = x;
}
// Costo: O(1)

// Pasa al siguiente elemento.
// Precond: ixs->current != NULL;
void Next(IteratorSt* ixs) {
  ixs->current = ixs->current->siguiente;
}
// Costo: O(1)

// Indica si el recorrido ha terminado.
bool atEnd(IteratorSt* ixs) {
  return ixs->current == NULL;
}
// Costo: O(1)

// Libera la memoria ocupada por el iterador.
void DisposeIterator(IteratorSt* ixs) {
  delete ixs;
}
// Costo: O(1)

// Libera la memoria ocupada por la lista.
void DestroyL(LinkedListSt* xs) {
  NodoL* temp = xs->primero;
  while (xs->primero != NULL) {
    xs->primero = xs->primero->siguiente;
    delete temp;
    temp = xs->primero;
  }
  delete xs;
}
// Costo: O(N)
// Siendo N la cantidad de elementos de la lista

// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
void Append(LinkedList xs, LinkedListSt* ys) {
  xs->ultimo->siguiente = ys->primero;
  xs->ultimo = ys->ultimo;
  xs->cantidad += ys->cantidad;
  DestroyL(ys);
}
// DestroyL es O(N)
// Costo: O(M)
// Siendo M la cantidad de elementos de la lista ys.