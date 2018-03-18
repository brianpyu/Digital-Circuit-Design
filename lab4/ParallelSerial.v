//`include "counters.v"
`include "psSR.v"
module ParallelSerial(charSent, out, fromCPU, load, enable, clk, reset);
	// to transmit, enable and load both need to be on, probably load first
	// to end transmission, disable enable and load
	input clk, reset, load, enable;
	input [7:0] fromCPU;
	output reg charSent;
	output out;
	
	wire extend;
	wire bitClk;
	
	combined counter (.frame(), .endFrame(extend), .bitClk(bitClk), .clk(clk), .reset(reset || extend || charSent), .enable(enable));
	psSR shiftReg (.out(out), .load(load), .in(fromCPU), .bitClk(bitClk), .clk(clk), .reset(reset));
	
	always@(posedge extend or negedge enable) begin
		if(extend) charSent = 1;
		if(~enable) charSent = 0;
	end
	
	
	
endmodule
