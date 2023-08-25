#include <iostream>
#include "LinkedListV1.h"
#include "Set.h"
using namespace std;

struct NodoS {
  int elem; // valor del nodo
  NodoS* siguiente; // puntero al siguiente nodo
};

struct SetSt {
  int cantidad; // cantidad de elementos diferentes
  NodoS* primero; // puntero al primer nodo
};

typedef SetSt* Set;

// Crea un conjunto vacío.
Set emptyS() {
  SetSt* s = new SetSt;
  s->cantidad = 0;
  s->primero = NULL;
  return s;
}

// Indica si el conjunto está vacío.
bool isEmptyS(Set s) {
  return s->cantidad == 0;
}

// Indica si el elemento pertenece al conjunto.
bool belongsS(int x, Set s) {
  NodoS* nodoActual = s->primero; 
  while (nodoActual != NULL && nodoActual->elem != x) {
    nodoActual = nodoActual->siguiente;
  }
  return nodoActual != NULL;
}

// Agrega un elemento al conjunto.
void AddS(int x, Set s) {
  NodoS* nodo = new NodoS;
  nodo->elem = x;
  nodo->siguiente = NULL;
  NodoS* actual = s->primero;

  if (actual == NULL) {
    s->primero = nodo;
    s->cantidad++;
    return;
  }

  while (actual->siguiente != NULL && actual->elem != x) {
    actual = actual->siguiente;
  }

  if (actual->elem != x) {
    actual->siguiente = nodo;
    s->cantidad++;
    return;
  }
}

// Quita un elemento dado.
void RemoveS(int x, Set s) {
  NodoS* anterior = NULL;
  NodoS* actual = s->primero;

  while (actual != NULL && actual->elem != x) {
    anterior = actual;
    actual = actual->siguiente;
  }
  if (actual != NULL) {
    anterior->siguiente = actual->siguiente;
    s->cantidad--;
    delete actual;
  }
}

// Devuelve la cantidad de elementos.
int sizeS(Set s) {
  return s->cantidad;
}

// Devuelve una lista con los lementos del conjunto.
LinkedList setToList(Set s) {
  LinkedList xs = nil();
  NodoS* actual = s->primero;
  for (int i = 0; i < s->cantidad; i++) {
    Cons(actual->elem, xs);
    actual = actual->siguiente;
  }
  return xs;
}

// Libera la memoria ocupada por el conjunto.
void DestroyS(Set s) {
  NodoS* actual = s->primero;
  NodoS* temp = NULL;
  for (int i = 0; i < s->cantidad; i++) {
    temp = actual;
    actual = actual->siguiente;
    delete temp;
  } 
  delete s;
}