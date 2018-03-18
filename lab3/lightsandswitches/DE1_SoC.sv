// file to upload niosII to the DE1 board
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic CLOCK_50;
 input logic [3:0] KEY;
 input logic [9:0] SW;
	
	first_nios2_system f (.clk_clk(CLOCK_50), .led_export(LEDR[7:0]), .reset_reset_n(KEY[0]), .switch_export(SW[7:0]));

endmodule 