`include "timer.v"
module testbench;
 wire [3:0] timer_out;
 wire done;
 wire clk, start, key;
 wire [3:0] begin_Counting;
 // declare an instance of the timer module
 timer dut (timer_out, done, clk, begin_Counting, start, key);
 // declare an instance of the testIt module
 Tester aTester (timer_out, done, clk, begin_Counting, start, key);

 // file for gtkwave
 initial
 begin
	// these two files support gtkwave and are required
	$dumpfile("timer.vcd");
	$dumpvars(0,dut);
end
endmodule

module Tester (timer_out, done, clk, begin_Counting, start, key);

 	input [3:0] timer_out;
	input done;
	output reg clk, start, key;
	output reg [3:0] begin_Counting;

 parameter stimDelay = 1;

 initial begin
   clk = 0;
  end
  always begin
    #1 clk = ~clk;
  end
 
 initial // Stimulus
 begin
 
	start = 1'b0;
	begin_Counting = 4'b0101;
	key = 1'b1;
	#stimDelay;
	#stimDelay;
	start = 1'b1;
	#stimDelay;
	#stimDelay;
	#stimDelay;

	#stimDelay;
	#(100*stimDelay);
	
	
 $finish; // finish simulation
 end
endmodule