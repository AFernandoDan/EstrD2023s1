#include "Queue.h"
#include <iostream>
#include "LinkedListV1.h"
using namespace std;
#include <cassert>

int main() {
  Queue q = emptyQ();
  assert(isEmptyQ(q) == true);

  assert(lengthQ(q) == 0);
  Enqueue(1,q);
  assert(isEmptyQ(q) == false);
  assert(lengthQ(q) == 1);
  assert(firstQ(q) == 1);

  assert(lengthQ(q) == 1);
  Enqueue(33,q);
  assert(lengthQ(q) == 2);
  assert(firstQ(q) == 1);
  assert(isEmptyQ(q) == false);

  assert(lengthQ(q) == 2);
  Enqueue(55,q);
  assert(lengthQ(q) == 3);
  assert(firstQ(q) == 1);
  assert(isEmptyQ(q) == false);

  assert(lengthQ(q) == 3);
  Dequeue(q);
  assert(lengthQ(q) == 2);
  assert(firstQ(q) == 33);
  assert(isEmptyQ(q) == false);

  assert(lengthQ(q) == 2);
  Dequeue(q);
  assert(lengthQ(q) == 1);
  assert(firstQ(q) == 55);
  assert(isEmptyQ(q) == false);

  assert(lengthQ(q) == 1);
  Dequeue(q);
  assert(lengthQ(q) == 0);
  assert(isEmptyQ(q) == true);

  assert(lengthQ(q) == 0);

  cout << "Todos los tests pasaron" << endl;
}