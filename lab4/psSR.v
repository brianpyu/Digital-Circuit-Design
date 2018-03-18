module psSR(out, load, in, bitClk, clk, reset);
	input bitClk;
	input clk, reset;
	input load;
	input [7:0]	in;
	output out;
	reg [9:0] data;
	integer i = 10;
	initial data = 10'b1111111111;
		
	always@(posedge clk) begin
		if (bitClk) begin
			if(i > 0) i = i - 1;
		end
		if (load) begin
			data[9] = 1'b0;
			data[8:1] = in;
			data[0] = 1'b1;
		end
		else
			i = 10;
	end
	assign out = data[i];
endmodule