module spSR(out, in, bitClk, clk, reset);
	input	bitClk, clk, reset;
	input 	in;
	output [7:0] out;
	reg [9:0] data;

	initial data = 10'b1111111110;
	assign out = data[8:1]; // ignores start and stop bits
	
	always@(posedge clk) begin
		if (reset) 
			data <= 10'b1111111110;
		if(bitClk)
			data <= {data[8:0], in};
	end

endmodule