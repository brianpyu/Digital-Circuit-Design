// module controlling the HEX1 and HEX0 7seg displays
module display (mode, count, clk, waitCount, fillCount, drainCount, waiting, filling, draining);

	output reg [6:0] mode, count;
	input clk, waiting, filling, draining;
   input [3:0] waitCount, fillCount, drainCount;
	
	
	always @(posedge clk)
	begin
		if(!waiting && !filling && !draining)  // if no timers are running
			begin
				mode <= ~7'b0000000;
				count <= ~7'b0000000;
			end
		else
		begin
			if(waiting) // if waiting timer is running
				begin
				mode <= ~7'b1000000; // display a dash
				case(waitCount) 		// and the count number
					// Light: 6543210 
					0: count <= ~7'b0111111; 
					1: count <= ~7'b0000110; 
					2: count <= ~7'b1011011; 
					3: count <= ~7'b1001111; 
					4: count <= ~7'b1100110; 
					5: count <= ~7'b1101101; 
					6: count <= ~7'b1111101; 
					7: count <= ~7'b0000111; 
					8: count <= ~7'b1111111; 
					default: count <= 7'bX; 
				endcase
			end
				
			else if(filling)		
				begin
				mode <= ~7'b1110011; // display a p for pressurizing(filling chamber)
				case(fillCount)		// and the count number
					// Light: 6543210 
					0: count <= ~7'b0111111; 
					1: count <= ~7'b0000110; 
					2: count <= ~7'b1011011; 
					3: count <= ~7'b1001111; 
					4: count <= ~7'b1100110; 
					5: count <= ~7'b1101101; 
					6: count <= ~7'b1111101; 
					7: count <= ~7'b0000111; 
					8: count <= ~7'b1111111; 
					default: count <= 7'bX; 
				endcase
				end 
			else
				begin
				mode <= ~7'b1011110;	// display a d for depressurizing(or d for draining chamber)
				case(drainCount)		// and the count number
					// Light: 6543210 
					0: count <= ~7'b0111111; 
					1: count <= ~7'b0000110; 
					2: count <= ~7'b1011011; 
					3: count <= ~7'b1001111; 
					4: count <= ~7'b1100110; 
					5: count <= ~7'b1101101; 
					6: count <= ~7'b1111101; 
					7: count <= ~7'b0000111; 
					8: count <= ~7'b1111111; 
					default: count <= 7'bX;
				endcase 
				end
			end
		end

	
endmodule

