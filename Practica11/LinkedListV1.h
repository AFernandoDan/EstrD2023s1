struct NodoL;

struct LinkedListSt;

typedef LinkedListSt* LinkedList; // INV.REP.: el puntero NO es NULL

struct IteratorSt;

typedef IteratorSt* ListIterator; // INV.REP.: el puntero NO es NULL

// Crea una lista vacía.
LinkedList nil();

// Indica si la lista está vacía.
bool isEmpty(LinkedList xs);

int head(LinkedList xs);
// Devuelve el primer elemento.

// Agrega un elemento al principio de la lista.
void Cons(int x, LinkedList xs);

// Quita el primer elemento.
void Tail(LinkedList xs);

// Devuelve la cantidad de elementos.
int length(LinkedList xs);

// Agrega un elemento al final de la lista.
void Snoc(int x, LinkedList xs);

// Apunta el recorrido al primer elemento.
ListIterator getIterator(LinkedList xs);

int current(ListIterator ixs);
// Devuelve el elemento actual en el recorrido.

void SetCurrent(int x, ListIterator ixs);
// Reemplaza el elemento actual por otro elemento.

void Next(ListIterator ixs);
// Pasa al siguiente elemento.

bool atEnd(ListIterator ixs);
// Indica si el recorrido ha terminado.

// Libera la memoria ocupada por el iterador.
void DisposeIterator(ListIterator ixs);

// Libera la memoria ocupada por la lista.
void DestroyL(LinkedList xs);