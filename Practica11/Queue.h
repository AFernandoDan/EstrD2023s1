struct NodoQ;
struct QueueSt;
typedef QueueSt* Queue;

// Crea una lista vacía.
Queue emptyQ();

// Indica si la lista está vacía.
bool isEmptyQ(Queue q);

// Devuelve el primer elemento.
int firstQ(Queue q);

// Agrega un elemento al final de la cola.
void Enqueue(int x, Queue q);

// Quita el primer elemento de la cola.
void Dequeue(Queue q);

// Devuelve la cantidad de elementos de la cola.
int lengthQ(Queue q);

// Anexa q2 al final de q1, liberando la memoria inservible de q2 en el proceso.
// Nota: Si bien se libera memoria de q2, no necesariamente la de sus nodos.
void MergeQT(Queue q1, Queue q2);

// Libera la memoria ocupada por la lista.
void DestroyQ(Queue q);