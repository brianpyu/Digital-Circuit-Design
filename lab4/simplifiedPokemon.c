// TO DO: CHECK NO REFERENCING ISSUES!!
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
// #include <altera_avalon_pio_regs.h> // Uncomment later. Caused compiliation errors.
#include "game_structs.h"
#include "auxillary_functions.h"
/* Import any additional necessary libraries here. */

void printPokemon(pokemon * poke) {
  char * name = poke->name;
  printf("pokemon name: %s\n", name);

} 

void printPlayer(player * player) {
  printPokemon(&(player->pokemonParty[0]));
  printf("pokemon hp: %d\n", player->pokemon1HP);
  printPokemon(&(player->pokemonParty[1]));
  printf("pokemon hp: %d\n", player->pokemon2HP);
  printf("which pokemon: %d\n", player->whichPokemon);
}



int main() {
  attack* allAttacks = defineAttacks();
  pokemon* allPokemon = definePokemon(allAttacks);
  *LOAD = 0;
  *TRANSMIT = 0;

  
  while (1) {
    player me;
  	player* whoAmI = &me;
  	srand(time(NULL));
    int ran1 = rand() % 8;
    int ran2 = rand() % 8;
    printf("ran1 %d, rand2 %d\n", ran1, ran2);
  	definePlayerMe(whoAmI, allPokemon, ran1, ran2);
    printPlayer(whoAmI);
    // Maybe add function to check connection?

    sendInfoToOpponent(whoAmI);
    player oppo;
    player* opponent = & oppo;
    receiveInfoFromOpponent(opponent, allPokemon);
    printPlayer(opponent);

  	bool myTurn = rockPaperScissor();
  	printf("myTurn: %d\n", myTurn);

    bool gameOverForOpponent = false;
    bool gameOverForMe = false;

    int round = 1;
  	while (!gameOverForOpponent && !gameOverForMe) {
      printf("round %d \n", round);
      printf("me\n");
      printPlayer(whoAmI);
      printf("oppo\n");
      printPlayer(opponent);
  		if (myTurn) {
        int usrCommand = getCommand(opponent, whoAmI);
        processCommand(opponent, whoAmI, usrCommand);
        send(usrCommand);
        myTurn = false;
      } else {
        int opponentInformation = receive();
        processCommand(whoAmI, opponent, opponentInformation);
        myTurn = true;
      }

      gameOverForOpponent = checkGameOver(opponent);
      gameOverForMe = checkGameOver(whoAmI);
      if (gameOverForOpponent || gameOverForMe) {
        handleGameOver(gameOverForOpponent, gameOverForMe);
      }
      round += 1;
      printf("\n");
    }
  }
}
