#include <iostream>
using namespace std;
#include "Tree.h"
#include "Queue.h"

struct NodoQ {
  Tree elem; // valor del nodo
  NodoQ* siguiente; // puntero al siguiente nodo
};

struct QueueSt {
  /* INV.REP.: cantidad >= 0
     primero == NULL <=> ultimo == NULL
     cantidad == 0 <=> primero == NULL
  */
  int cantidad; // cantidad de elementos
  NodoQ* primero; // puntero al primer nodo
  NodoQ* ultimo; // puntero al ultimo nodo
};

typedef QueueSt* QueueT;

// Crea una lista vacía.
QueueT emptyQT() {
  QueueSt* q = new QueueSt;
  q->cantidad = 0;
  q->primero = NULL;
  q->ultimo = NULL;
  return q;
}
// Costo: O(1)

// Indica si la lista está vacía.
bool isEmptyQT(QueueT q) {
  return q->cantidad == 0;
}
// Costo: O(1).

// Devuelve el primer elemento.
// Precondición: !isEmptyQ(q)
Tree firstQT(QueueT q) {
  return q->primero->elem;
}
// Costo: O(1).

// Agrega un elemento al final de la cola.
void EnqueueT(NodeT* t, QueueT q) {
  NodoQ* nodo = new NodoQ;
  nodo->elem = t;
  nodo->siguiente = NULL;
  if (q->cantidad == 0) {
    q->primero = nodo;
  } else {
    q->ultimo->siguiente = nodo;
  }
  q->ultimo = nodo;
  q->cantidad++;
}
// Costo: O(1).

// Quita el primer elemento de la cola.
// Precondición: !isEmptyQ(q)
void DequeueT(QueueT q) {
  NodoQ* nodo = q->primero;
  q->primero = q->primero->siguiente;
  delete nodo;
  q->cantidad--;
}
// Costo: O(1).

// Devuelve la cantidad de elementos de la cola.
int lengthQT(QueueT q) {
  return q->cantidad;
}
// Costo: O(1).

// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
void MergeQT(QueueT q1, QueueT q2) {
  if (q1->cantidad == 0) {
    q1->primero = q2->primero;
    q1->ultimo = q2->ultimo;
  } else {
    q1->ultimo->siguiente = q2->primero;
    q1->ultimo = q2->ultimo;
  }
  q1->cantidad += q2->cantidad;
  delete q2;
}
// Costo: O(1).

// Libera la memoria ocupada por la lista.
void DestroyQT(QueueT q) {
  NodoQ* actual = q->primero;
  while (actual != NULL) {
    NodoQ* anterior = actual;
    actual = actual->siguiente;
    delete anterior;
  }
  delete q;
}
// Costo: O(n).