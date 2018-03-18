// main program to connect the SRAM and the niosII processor with the DE1 board
module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic CLOCK_50;
 input logic [3:0] KEY;
 input logic [9:0] SW;
 wire [10:0] address;
 wire [7:0] data;
 wire outputEnable, writeEnable;
  
 logic [31:0] clk;
 parameter whichClock = 23;  
 clock_divider cdiv (CLOCK_50, clk); 
	first_nios2_system f (.address_export(address), .clk_clk(CLOCK_50), .data_export(data), .led_export(LEDR[7:0]), 
								 .outputenable_export(outputEnable), .reset_reset_n(KEY[0]), .switch_export(SW[7:0]), .writeenable_export(writeEnable));
	sram s (.clk(CLOCK_50), .address(address), .writeEnable(writeEnable), .outputEnable(outputEnable), .data(data));
endmodule 


module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks;

 initial begin
 divided_clocks <= 0;
 end

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule 