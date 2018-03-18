`include "counters.v"
`include "spSR.v"
module SerialParallel(charReceived, dataToCPU, enable, fromSerial, clk, reset);
	
	input clk, reset;
	input fromSerial;
	output wire charReceived;
	output [7:0] dataToCPU;
	output reg enable;
	
	wire bitClk;
	reg clkReset;
	reg srReset;
	wire extender;
	
	always@(posedge clk or posedge extender or negedge enable) begin
		case(enable)
			0: begin
				if (fromSerial == 0) begin
					clkReset = 0;
					srReset = 1;
					enable = 1;	// at start bit, enable counter
				end
				else enable = 0;
			end
			1: begin
				srReset = 0;
				if (extender) begin
					enable = 0;	// at stop bit, disable counter
					clkReset = 1;
				end
				else enable = 1;
			end
			default: enable = 0;
		endcase
//		if(extender) charReceived = 1;
//		if(enable) charReceived = 0;
	end
	assign charReceived = ~enable;
	combined counter (.frame(), .endFrame(extender), .bitClk(bitClk), .clk(clk), .reset(reset || clkReset), .enable(enable));
	spSR shiftReg (.out(dataToCPU), .in(fromSerial), .bitClk(bitClk), .clk(clk), .reset(reset || srReset));
	
	
	
endmodule
