#include "HeapBin.h"
#include <iostream>
#include <cassert> 
using namespace std;

void ShowArray(int* array, int size) {
  cout << "[";
  for (int i = 0; i < size; i++) {
    cout << array[i];
    if (i < size - 1) {
      cout << ", ";
    }
  }
  cout << "]" << endl;
}

void ShowBinHeap(BinHeap h) {
  cout << "[";
  while (!isEmptyHeap(h)) {
    cout << findMin(h);
    deleteMin(h);
    if (!isEmptyHeap(h)) {
      cout << ", ";
    }
  }
  cout << "]" << endl;
}

int main() {
  int* array = new int[7];
  int size = 7;
  array[0] = 10;
  array[1] = 33;
  array[2] = 3;
  array[3] = 6;
  array[4] = 9;
  array[5] = 7;
  BinHeap h = crearHeap(array, 6, 7);

  assert(findMin(h) == 3);
  deleteMin(h);
  assert(findMin(h) == 6);
  deleteMin(h);
  assert(findMin(h) == 7);
  deleteMin(h);
  assert(findMin(h) == 9);
  deleteMin(h);
  assert(findMin(h) == 10);
  deleteMin(h);
  assert(findMin(h) == 33);
  deleteMin(h);
  assert(isEmptyHeap(h));

  BinHeap h2 = emptyHeap();

  assert(isEmptyHeap(h2));

  InsertH(10, h2);
  InsertH(33, h2);
  deleteMin(h2);
  InsertH(3, h2);
  InsertH(15, h2);
  InsertH(25, h2);

  // tests
  assert(findMin(h2) == 3);
  deleteMin(h2);
  assert(findMin(h2) == 15);
  deleteMin(h2);
  assert(findMin(h2) == 25);
  deleteMin(h2);
  assert(findMin(h2) == 33);
  deleteMin(h2);
  assert(isEmptyHeap(h2));

  return 0;
}