#include <iostream>
using namespace std;

struct NodeT {
int elem;
NodeT* left;
NodeT* right;
};

typedef NodeT* Tree;

Tree emptyT() {
  return NULL;
}
// Costo: O(1)

Tree nodeT(int elem, Tree left, Tree right) {
  NodeT* t = new NodeT;
  t->elem = elem;
  t->left = left;
  t->right = right;
  return t;
}
// Costo: O(1)

bool isEmptyT(Tree t) {
  return t == NULL;
}

// Precondición: !isEmptyT(t)
int rootT(Tree t) {
  return t->elem;
}
// Costo: O(1)

// Precondición: !isEmptyT(t)
Tree left(Tree t) {
  return t->left;
}
// Costo: O(1)

// Precondición: !isEmptyT(t)
Tree right(Tree t) {
  return t->right;
}
// Costo: O(1)