#include <iostream>
using namespace std;
#include "Pokemon.h"

typedef string TipoDePokemon;

struct PokeSt {
  TipoDePokemon tipo;
  int energia;
};

// Interfaz
// Dado un tipo devuelve un pokémon con 100 % de energía.
Pokemon consPokemon(TipoDePokemon tipo) {
  PokeSt* p = new PokeSt;
  p->tipo = tipo; p->energia = 100;
  return p;
}

// Devuelve el tipo de un pokémon.
TipoDePokemon tipoDePokemon(Pokemon p) {
  return p->tipo;
}

// Devuelve el porcentaje de energía.
int energia(Pokemon p) {
  return p->energia;
}

// Le resta energía al pokémon.
void perderEnergia(int energia, Pokemon p) {
  p->energia -= energia;
}

// Dados dos tipoDePokemon indica si el primero, es superior al segundo. Agua supera
// a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
bool superaATipo(TipoDePokemon t1, TipoDePokemon t2) {
  return (t1 == "Agua" && t2 == "Fuego") ||
         (t1 == "Fuego" && t2 == "Planta") ||
         (t1 == "Planta" && t2 == "Agua");
}

// Dados dos pokémon indica si el primero, en base al tipo, es superior al segundo. Agua supera
// a fuego, fuego a planta y planta a agua. Y cualquier otro caso es falso.
bool superaA(Pokemon p1, Pokemon p2) {
  return superaATipo(tipoDePokemon(p1), tipoDePokemon(p2));
}