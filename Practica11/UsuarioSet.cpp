#include "Set.h"
#include <iostream>
#include "LinkedListV1.h"
using namespace std;
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

int main() {
  Set s = emptyS();
  assert(isEmptyS(s) == true);

  assert(sizeS(s) == 0);
  assert(belongsS(1,s) == false);
  AddS(1,s);
  assert(isEmptyS(s) == false);
  assert(sizeS(s) == 1);
  assert(belongsS(1,s) == true);
  assert(belongsS(33,s) == false);

  AddS(1,s);
  assert(sizeS(s) == 1);
  cout << "setToList(s) luego de agregar nuevamente 1:" << endl;
  ShowLinkedList(setToList(s));
  assert(belongsS(1,s) == true);

  AddS(33,s);
  assert(sizeS(s) == 2);
  assert(belongsS(33,s) == true);
  cout << "setToList(s) luego de agregar 33:" << endl;
  ShowLinkedList(setToList(s));

  RemoveS(33,s);
  assert(belongsS(33,s) == false);
  assert(sizeS(s) == 1);
  cout << "setToList(s) luego de borrar 33:" << endl;
  assert(belongsS(33,s) == false);
  assert(sizeS(s) == 1);
  cout << "setToList(s) luego de borrar 33 nuevamente:" << endl;
  ShowLinkedList(setToList(s));
  assert(belongsS(33,s) == false);
  assert(sizeS(s) == 1);

  assert(isEmptyS(s) == false);
  cout << "todos los tests pasaron" << endl;
}