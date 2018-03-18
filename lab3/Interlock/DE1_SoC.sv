// Top-level module that defines the I/Os for the DE-1 SoC board

module DE1_SoC (CLOCK_50, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, KEY, LEDR, SW);
 input logic CLOCK_50;
 output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
 output logic [9:0] LEDR;
 input logic [3:0] KEY;
 input logic [9:0] SW;
	
 // Controls the clock rate
 logic [31:0] clk;
 parameter whichClock = 23;  
 clock_divider cdiv (CLOCK_50, clk); 
 assign HEX5 = ~7'b0000000;
 assign HEX4 = ~7'b0000000;
 assign HEX3 = ~7'b0000000;
 assign HEX2 = ~7'b0000000;
 assign HEX1 = ~7'b0000000;
 assign HEX0 = ~7'b0000000;
 
 
 logic waiting, filling, draining; // outputs of interlock that tells the timer to start and the display what to display
 logic wait_finished, fill_finished, drain_finished; // tells the interlock the appropriate timer is finished counting
 logic [3:0] wait_count, fill_count, drain_count; // output of the timer indicating time left
 
 logic arrive, depart, inner, outer, fill, evacuate, checkempty;
 logic [3:0] state;
 
 first_nios2_system (.arrive_export(arrive), .checkempty_export(checkempty), .clk_clk(CLOCK_50), .depart_export(depart), .evacuate_export(evacuate), .fill_export(fill),
		.inner_export(inner), .outer_export(outer), .reset_reset_n(KEY[0]), .state_export(state));
		

 
 // instance of interlock with specified inputs and outputs
 interlock il (.clk(clk[whichClock]), .reset(~KEY[0]), .fill(fill), .evacuate(evacuate), .check(checkempty), .arrive(arrive), .depart(depart), .outer(outer), .inner(inner), .wait_done(wait_finished), .fill_done(fill_finished), .drain_done(drain_finished), .wait_start(waiting), .fill_start(filling), .drain_start(draining), .ps(state));
 
 // 3 instances of timers for waiting, filling, and draining
 timer waittimer(.timer_out(wait_count), .done(wait_finished), .clk(clk[whichClock]), .begin_Counting(4'b0101), .start(waiting));
 timer filltimer(.timer_out(fill_count), .done(fill_finished), .clk(clk[whichClock]), .begin_Counting(4'b0111), .start(filling));
 timer draintimer(.timer_out(drain_count), .done(drain_finished), .clk(clk[whichClock]), .begin_Counting(4'b1000), .start(draining));
 
 
 // assigns LEDs to indicate switch states
// assign LEDR[9] = SW[9];
// assign LEDR[3] = SW[3];
// assign LEDR[2] = SW[2];
// assign LEDR[1] = SW[1];
// assign LEDR[0] = SW[0];
 
endmodule 

// divides system clock
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