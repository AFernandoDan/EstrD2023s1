#include <iostream>
using namespace std;
#include "LinkedListV1.h"
#include <cassert>

// Show LinkedList as a sequence of elements as array
void ShowLinkedList(LinkedList xs) {
  cout << "LinkedList[" << xs << "](";
  ListIterator ixs = getIterator(xs);
  while (!atEnd(ixs)) {
    cout << current(ixs);
    Next(ixs);
    if (!atEnd(ixs)) cout << ",";
  }
  DisposeIterator(ixs);
  cout << ")" << endl;
}

// Devuelve la suma de todos los elementos.
int sumatoria(LinkedList xs) {
  int total = 0;
  ListIterator ixs = getIterator(xs);
  while (!atEnd(ixs)) {
    total += current(ixs);
    Next(ixs);
  }
  DisposeIterator(ixs);
  return total;
}
// n (por el recorrido de la lista)
// Costo: O(n)
// Siendo n la cantidad de elementos de la lista.

// Incrementa en uno todos los elementos.
void Sucesores(LinkedList xs) {
  ListIterator ixs = getIterator(xs);
  while (!atEnd(ixs)) {
    SetCurrent(current(ixs)+1, ixs);
    Next(ixs);
  }
  DisposeIterator(ixs);
}
// n (por el recorrido de la lista)
// Costo: O(n)
// Siendo n la cantidad de elementos de la lista.

// DUDAS: SE PUEDE HACER MEJOR?
// Indica si el elemento pertenece a la lista.
bool pertenece(int x, LinkedList xs) {
  ListIterator ixs = getIterator(xs);
  while (!atEnd(ixs) && current(ixs) != x) {
    Next(ixs);
  }
  bool pertenece = !atEnd(ixs);
  DisposeIterator(ixs);
  return pertenece;
}
// n (por el recorrido de la lista)
// Costo: O(n)
// Siendo n la cantidad de elementos de la lista.

int unoSi(bool b) {
  if (b) return 1;
  else return 0;
}
// Costo: O(1)

// Indica la cantidad de elementos iguales a x.
int apariciones(int x, LinkedList xs) {
  int cantApariciones = 0;
  ListIterator ixs = getIterator(xs);
  while (!atEnd(ixs)) {
    cantApariciones += unoSi(current(ixs) == x);
    Next(ixs);
  }
  DisposeIterator(ixs);
  return cantApariciones;
}
// n (por el recorrido de la lista)
// Costo: O(n)
// Siendo n la cantidad de elementos de la lista.

// Devuelve el elemento más chico de la lista.
// Precond: !isEmpty(xs);
int minimo(LinkedList xs) {
  ListIterator ixs = getIterator(xs);
  int minimo = current(ixs);
  while (!atEnd(ixs)) {
    minimo = min(minimo, current(ixs));
    Next(ixs);
  }
  DisposeIterator(ixs);
  return minimo;
}
// n (por el recorrido de la lista)
// Costo: O(n)
// Siendo n la cantidad de elementos de la lista.

// Dada una lista genera otra con los mismos elementos, en el mismo orden.
// Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
LinkedList copy(LinkedList xs) {
  LinkedList copy = nil();
  ListIterator ixs = getIterator(xs);
  while (!atEnd(ixs)) {
    Snoc(current(ixs), copy);
    Next(ixs);
  }
  DisposeIterator(ixs);
  return copy;
}
// Snoc es O(n), ademas tambien se recorre la lista xs,
// quedando un costo de O(n^2)
// Siendo n la cantidad de elementos de la lista.

// si Snoc fuese O(1) el costo sería O(n), ya que insertar
// al final de la lista seria constante. Quedando el costo
// de la funcion en O(n).

// Agrega todos los elementos de la segunda lista al final de los de la primera.
// La segunda lista se destruye.
// Nota: notar que el costo mejoraría si Snoc fuese O(1), ¿cómo podría serlo?
void Append(LinkedList xs, LinkedList ys) {
  ListIterator iys = getIterator(ys);
  while (!atEnd(iys)) {
    Snoc(current(iys), xs);
    Next(iys);
  }
  DisposeIterator(iys);
  DestroyL(ys);
}
// Snoc es O(n) y DestroyL es O(m)
// ademas tambien se recorre la lista ys
// quedando un costo de O(m*n+m)

// Siendo n la cantidad de elementos de la lista xs
// Siendo m la cantidad de elementos de la lista ys

// Si snoc fuese O(1) el costo quedaria en O(m+m),
// Que simplificando seria O(m).

int main() {
  LinkedList ll = nil();
  assert(length(ll) == 0);
  assert(isEmpty(ll) == true);

  Cons(4,ll);
  assert(head(ll) == 4);
  assert(length(ll) == 1);
  assert(isEmpty(ll) == false);

  LinkedList ll2 = nil();
  Cons(4,ll2);
  assert(head(ll2) == 4);
  Cons(5,ll2);
  Tail(ll2);
  assert(isEmpty(ll2) == false);
  assert(length(ll2) == 1);
  assert(head(ll2) == 4);

  LinkedList ll3 = nil();
  Cons(4,ll3);
  Snoc(5,ll3);
  Tail(ll3);
  assert(head(ll3) == 5);
  assert(length(ll3) == 1);
  assert(isEmpty(ll3) == false);

  LinkedList ll4 = nil();
  Cons(4,ll4);
  Snoc(5,ll4);
  Snoc(6,ll4);
  Cons(3,ll4);
  assert(sumatoria(ll4) == 18);

  LinkedList ll5 = nil();
  Cons(4,ll5);
  Snoc(5,ll5);
  Snoc(6,ll5);
  Cons(3,ll5);
  ShowLinkedList(ll5);
  assert(pertenece(3,ll5) == true);
  assert(pertenece(7,ll5) == false);

  Sucesores(ll5);

  ShowLinkedList(ll5);

  assert(pertenece(3,ll5) == false);
  assert(pertenece(7,ll5) == true);

  LinkedList ll6 = nil();
  Cons(4,ll6);
  Snoc(4,ll6);
  Snoc(4,ll6);
  Cons(7,ll6);
  Cons(7,ll6);
  ShowLinkedList(ll6);
  assert(apariciones(4,ll6) == 3);
  assert(apariciones(7,ll6) == 2);
  assert(apariciones(8,ll6) == 0);

  assert(minimo(ll6) == 4);
  Snoc(3,ll6);
  assert(minimo(ll6) == 3);

  // copia de ll6
  assert(minimo(copy(ll6)) == 3);

  LinkedList ll7 = nil();
  Cons(10,ll7);
  Snoc(11,ll7);

  Append(ll6,ll7);
  assert(length(ll6) == 8);
  assert(head(ll6) == 7);
  assert(isEmpty(ll6) == false);
}