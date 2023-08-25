  if(nodo == NULL) return BBNodeIn(x,y);

  if (x == nodo->kx && y == nodo->ky) {
    return nodo;
  }

  if (x > nodo->kx && y > nodo->ky) {
    nodo->hijo[NE] = insertBBNode(nodo->hijo[NE], x, y);
  }

  if (x > nodo->kx && y <= nodo->ky) {
    nodo->hijo[SE] = insertBBNode(nodo->hijo[SE], x, y);
  }

  if (x <= nodo->kx && y > nodo->ky) {
    nodo->hijo[NO] = insertBBNode(nodo->hijo[NO], x, y);
  }

  if (x <= nodo->kx && y <= nodo->ky) {
    nodo->hijo[SO] = insertBBNode(nodo->hijo[SO], x, y);
  }

  return NULL;