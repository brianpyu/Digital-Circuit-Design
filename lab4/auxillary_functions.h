#ifndef AUXILLARY_FUNCTIONS
#define AUXILLARY_FUNCTIONS
#include "game_structs.h"
#include <stdio.h>
#include <stdlib.h>

attack* defineAttacks();

pokemon* definePokemon(attack* allAttacks);

void definePlayerMe(player* whoAmI, pokemon* allPokemon, int pokemonOne, int pokemonTwo);

void definePlayerOppo(player* whoAmI, pokemon* allPokemon, int pokemonOne, int pokemonTwo);

void send(char data);

char receive();

void sendInfoToOpponent(player* whoAmI);

void receiveInfoFromOpponent(player *, pokemon* allPokemon);

bool rockPaperScissor();

int getCommand(player* opponent, player* whoAmI);

int processCommand(player* opponent, player* whoAmI, int usrCommand);

void switchPokemon(player* whoAmI);

int calculateDamage(player* opponent, player* whoAmI, int usrCommand);

void processInformation(player* opponent, player* whoAmI, int opponentInformation);

void updateHP(player* whoAmI, int opponentInformation);

bool checkGameOver(player* whoAmI);

void handleGameOver(bool gameOverForOpponent, bool gameOverForMe);

int readSRAM(int sramAddress);

void writeSRAM(int sramAddress, int sramData);

void printPlayer(player * player);

#endif
