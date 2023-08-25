#include "HeapBin.h"
#include "limits.h"

struct BinHeapHeaderSt {
  int maxSize; // INV.REP cursize < maxsize
  int curSize;
  int* elems;
};

typedef BinHeapHeaderSt* BinHeap; // INV.REP.: el puntero NO es NULL

BinHeap emptyHeap() {
  BinHeapHeaderSt* h = new BinHeapHeaderSt;
  h->maxSize = 16;
  h->curSize = 0;
  h->elems = new int[h->maxSize];
  h->elems[0] = INT_MIN;
  return h;
}

// Auxiliar para ampliar el espacio de elementos de la heap
void AumentarEspacio(BinHeap h) {
  int* newElements = new int[h->maxSize*2];
  for(int i=0;i<=h->curSize;i++) {
    newElements[i] = h->elems[i];
  }
  delete h->elems;
  h->maxSize *= 2;
  h->elems = newElements;
}

void InsertH(int x, BinHeap h) {
  if(h->curSize==h->maxSize-1) { AumentarEspacio(h); }
  // Flotar el nuevo elemento (haciendo lugar para él)
  int curNode = ++h->curSize;
  while(x < h->elems[curNode/2]) {
    h->elems[curNode] = h->elems[curNode/2];
    curNode /= 2;
  }
  h->elems[curNode] = x;
}

bool isEmptyHeap(BinHeap h) {
  return h->curSize == 0;
}

int findMin(BinHeap h) {
  // PRECOND: la heap no está vacía
  return h->elems[1];
}

void deleteMin(BinHeap h) {
  // Precond: h->curSize > 0;
  int child; int curNode;
  int last = h->elems[h->curSize--];
  for (curNode = 1; curNode*2 <= h->curSize; curNode=child) {
    child = curNode*2;
    if ((child != h->curSize) // Elige al hijo mas chico
      && (h->elems[child+1] < h->elems[child])) child++;
      // Baja un nivel, si el hijo más chico es mas chico que last
    if (last > h->elems[child]) h->elems[curNode] = h->elems[child];
    else break; // o termina (evitando comparar dos veces lo mismo)
  }
  h->elems[curNode] = last;
}

BinHeap crearHeap(int* elements, int cant, int max) {
  // PRECOND: cant < max
  int curNode; int child;
  BinHeapHeaderSt* h = new BinHeapHeaderSt;
  h->maxSize = max; 
  h->curSize = cant;
  h->elems = new int[h->maxSize];
  h->elems[0] = INT_MIN;
  for(int i=1; i <= h->curSize; i++)
    { h->elems[i] = elements[i-1]; }
  for (int j = h->curSize/2; j >= 1; j--) {
    // Hundir el elemento j
    int last = h->elems[j];
    for (curNode = j; curNode*2 <= h->curSize; curNode=child) {
      child = curNode*2;
      if ((child != h->curSize) // Elige al hijo mas chico
        && (h->elems[child+1] < h->elems[child])) child++;
        // Baja un nivel, si el hijo más chico es mas chico que last
      if (last > h->elems[child]) h->elems[curNode] = h->elems[child];
      else break; // o termina (evitando comparar dos veces lo mismo)
    }
    h->elems[curNode] = last;
  }
  return h;
}