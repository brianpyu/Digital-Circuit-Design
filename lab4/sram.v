module sram(clk, address, writeEnable, outputEnable, data);

	input clk;
	input writeEnable;						// writeEnable reads when 1, writes when 0
	input outputEnable;						// outputEnable disables output when 1, enables output when 0
	input [10:0] address;					// contains address (0-2047) in the SRAM to write to
	inout [7:0] data;						// contains data to write to specified address
	

	reg [7:0]SRAM[2047:0]; 					// stores state of the SRAM
	
	assign data = (writeEnable & !outputEnable) ? SRAM[address] : 8'bZ; // contents of the location appear on the IO pins when outputEnable is low
																		// and writeEnable is high, otherwise the IO pins have high impedance

	always @(posedge clk) begin
		if( !writeEnable & outputEnable) 	// if we want to write, and the IO pins are disabled
				SRAM[address] = data; 		// The appropriate address of the SRAM array is updated to the new data value
	end

endmodule  