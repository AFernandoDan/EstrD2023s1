#include <iostream>
using namespace std;
#include "./Practica11/LinkedListV1.h"

// Show LinkedList as a sequence of elements as array
void ShowLinkedList(LinkedList xs) {
  cout << "LinkedList[" << xs << "](";
  ListIterator ixs = getIterator(xs);
  // while (!atEnd(ixs)) {
  //   cout << current(ixs);
  //   Next(ixs);
  //   if (!atEnd(ixs)) cout << ",";
  // }
  // DisposeIterator(ixs);
  // cout << ")" << endl;
}

int main() {
  exit(0);
}