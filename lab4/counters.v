
module combined(frame, endFrame, bitClk, clk, reset, enable);
	output endFrame, bitClk;
	output [3:0] frame;
	input clk, reset, enable;
	
	BSC sample (.out(), .bitOut(bitClk), .clk(clk), .reset(reset), .enable(enable));
	BIC identify (.frame(frame), .endFrame(endFrame), .bitClk(bitClk), .clk(clk), .reset(reset), .enable(enable));
	

endmodule

module BIC(frame, endFrame, bitClk, clk, reset, enable);
	output reg [3:0] frame;
	output endFrame;
	input bitClk, clk, reset, enable;
	
	initial frame = 0;
	assign endFrame = (frame == 10); // for a frame width of 10
	always@(posedge clk) begin
		if(reset) frame <= 0;
		if(bitClk) frame <= frame + 1'b1;
	end
	

endmodule


module BSC(out, bitOut, clk, reset, enable);

	output reg [3:0] out;
	output bitOut;
	input clk, reset, enable;
	
	initial out = 0;
	assign bitOut = (out == 4'b0111);
	always@(posedge clk) begin
		if(reset) out <= 0;
		else begin
			if(enable) 
				out <= out+1'b1;
			else
				out <= 0;
		end
	end
	
endmodule

