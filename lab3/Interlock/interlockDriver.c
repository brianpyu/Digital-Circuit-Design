// c program to control interlock inputs
#include "sys/alt_stdio.h"
#include <system.h>
#include <stdio.h>
#include <altera_avalon_pio_regs.h>
#include <time.h>
#include <unistd.h>

#define arrive (volatile char *) ARRIVE_PIO_BASE
#define empty (volatile char *) CHECKEMPTY_PIO_BASE
#define depart (volatile char *) DEPART_PIO_BASE
#define evacuate (volatile char *) EVACUATE_PIO_BASE
#define fill (volatile char *) FILL_PIO_BASE
#define inner (volatile char *) INNER_PIO_BASE
#define outer (volatile char *) OUTER_PIO_BASE
#define state (volatile char *) STATE_PIO_BASE

int main() {
	int written = 0;

	/* Event loop never exits. */
	while (1) {
		if (*state == 0) { // empty
			written = 0;
			alt_putstr("Ready to start\n");
			alt_putstr("Enter E if the interlock is empty\n");
			alt_putstr("Enter A for arrive\n");
			alt_putstr("Enter D for depart\n");
			char input = alt_getchar();
			if (input == 'E') {
				*empty = 1;
			}
			if (input == 'A') {
				*depart = 0;
				*arrive = 1;
			}
			if (input == 'D') {
				*arrive = 0;
				*depart = 1;
			}
		} else if (*state == 1) {	// timer 5 min
			if (!written) {
				alt_putstr("Waiting for Interlock\n");
				written = 1;
			}
			*empty = 0;
		} else if (*state == 2) {	// ready
			written = 0;
			alt_putstr("Enter F for fill\n");
			alt_putstr("Enter I to open inner door\n");
			char input = alt_getchar();
			if (input == 'F') {
				*fill = 1;
			}
			if (input == 'I') {
				*inner = 1;
			}
		} else if (*state == 3) {	// timer 7 min
			if (!written) {
				alt_putstr("Waiting for Fill\n");
				written = 1;
			}
			*fill = 0;
		} else if (*state == 4) {	// closed and filled
			written = 0;
			alt_putstr("Interlock closed filled\n");
			alt_putstr("Enter O to open outer door\n");
			alt_putstr("Enter E to evacuate interlock\n");
			char input = alt_getchar();
			if (input == 'O') {
				*outer = 1;
			}
			if (input == 'E') {
				*evacuate = 1;
			}
		} else if (*state == 5) {	// outer open
			written = 0;
			alt_putstr("Outer door is open\n");
			alt_putstr("Enter O to close outer door\n");
			char input = alt_getchar();
			if (input == 'O') {
				*outer = 0;
			}
		} else if (*state == 6) {	// timer 8 min
			if(!written){
			alt_putstr("Waiting for evacuate\n");
			written = 1;
			}
			*evacuate = 0;
		} else if (*state == 7) {	// inner open
			written = 0;
			alt_putstr("Inner door is open\n");
			alt_putstr("Enter I to close inner door\n");
			char input = alt_getchar();
			if (input == 'I') {
				*inner = 0;
			}
		}
	};

	return 0;
}
