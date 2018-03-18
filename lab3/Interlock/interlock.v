// module controlling interlock finite state machine
module interlock(clk, reset, fill, evacuate, check, arrive, depart, outer, inner, wait_done, fill_done, drain_done, wait_start, fill_start, drain_start, ps);  

	
	input clk, reset, fill, evacuate, check, arrive, depart, outer, inner, wait_done, fill_done, drain_done; 
	output reg wait_start, fill_start, drain_start;

	// 8 states
	parameter [2:0] empty = 3'b000, timer_5_min = 3'b001, ready = 3'b010, timer_7_min = 3'b011;
	parameter [2:0] closed_and_filled = 3'b100, outer_open = 3'b101, timer_8_min = 3'b110, inner_open = 3'b111;
	
	output reg [2:0] ps;
	
	// see attached diagram for finite state machine
	always@(posedge clk)
		if(reset) begin
			ps <= empty; 
			wait_start <= 0;
			fill_start <= 0;
			drain_start <= 0;
		end else begin
			case(ps)
				empty:
					if ((arrive || depart) && check) ps <= timer_5_min;
				timer_5_min: begin
					wait_start <= 1;
					if (wait_done) begin
						ps <= ready;
						wait_start <= 0;
					end
				end
				ready: begin
					if (fill) ps <= timer_7_min;
					else if (inner) ps <= inner_open;
				end
				timer_7_min: begin
					fill_start <= 1;
					if (fill_done) begin
						ps <= closed_and_filled;
						fill_start <= 0;
						end
				end
				closed_and_filled: begin
					if (outer) ps <= outer_open;
					else if (evacuate) ps <= timer_8_min;
				end
				outer_open:
					if (~outer) ps <= closed_and_filled;
				timer_8_min: begin
					drain_start <= 1;
					if (drain_done && arrive) begin 
						ps <= ready;
						drain_start <= 0;
					end else if (drain_done && depart) begin
						ps <= empty;
						drain_start <= 0;
					end
				end
				inner_open: begin
					if (~inner && arrive) ps <= empty;
					else if (~inner && depart) ps <= ready;
				end
			endcase
		end
			
			
endmodule

// module controlling the timers
module timer(timer_out, done, clk, begin_Counting, start);

	output reg [3:0] timer_out;
	output reg done;
	input clk, start;
	input [3:0] begin_Counting;
	
	always@(posedge clk) 
	begin
		if(~start)
		begin
			timer_out <= begin_Counting;
			done <= 0;
		end

		else if(timer_out == 4'b0000)
			done <= 1;

		else
			timer_out <= timer_out - 4'b0001;
	end
endmodule


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

