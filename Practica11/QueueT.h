#include "Tree.h"

struct NodoQ;
struct QueueSt;
typedef QueueSt* QueueT;

// Crea una lista vacía.
QueueT emptyQT();

// Indica si la lista está vacía.
bool isEmptyQT(QueueT q);

// Devuelve el primer elemento.
Tree firstQT(QueueT q);

// Agrega un elemento al final de la cola.
void EnqueueT(NodeT*, QueueT q);

// Quita el primer elemento de la cola.
void DequeueT(QueueT q);

// Devuelve la cantidad de elementos de la cola.
int lengthQT(QueueT q);

// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
void MergeQT(QueueT q1, QueueT q2);

// Libera la memoria ocupada por la lista.
void DestroyQT(QueueT q);