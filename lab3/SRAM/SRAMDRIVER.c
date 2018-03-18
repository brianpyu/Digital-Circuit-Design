#include "sys/alt_stdio.h"
#include <system.h>
#include <stdio.h>
#include <altera_avalon_pio_regs.h>
#include <time.h>
#include <unistd.h>
#define switches (volatile char *) SWITCH_PIO_BASE
#define leds (volatile char *) LED_PIO_BASE
#define writeEnable (volatile char *) WRITEENABLE_PIO_BASE
#define outputEnable (volatile char *) OUTPUTENABLE_PIO_BASE
#define data (volatile char *) DATA_PIO_BASE
#define address (volatile char *) ADDRESS_PIO_BASE
// main c program to take console inputs to output SRAM values on the DE1 board
int main() {

	int i;
	int j;
	alt_putstr("\nTo write type W\n");
	char input = alt_getchar();
	while (input != 'W') {
		input = alt_getchar();
	}
	*outputEnable = 1;
	*writeEnable = 0;
	*address = 0x0;
	for (i = 0; i < 128; i++) {
		*address = i;
		*data = 127 - i;
	}

	alt_putstr("\nTo read type R\n");
	input = alt_getchar();
	while (input != 'R') {
		input = alt_getchar();
	}
	while (1) {
		*outputEnable = 0;
		*writeEnable = 1;
		*address = 0x0;
		for (j = 0; j < 128; j++) {
			*address = j;
			*leds = *data;
//			usleep(1000000/2);
		}
	}

	return 0;
}
