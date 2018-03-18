// module controlling interlock finite state machine
module interlock(clk, reset, fill, evacuate, check, arrive, depart, outer, inner, wait_done, fill_done, drain_done, wait_start, fill_start, drain_start);  

	
	input clk, reset, fill, evacuate, check, arrive, depart, outer, inner, wait_done, fill_done, drain_done; 
	output reg wait_start, fill_start, drain_start;

	// 8 states
	parameter [2:0] empty = 3'b000, timer_5_min = 3'b001, ready = 3'b010, timer_7_min = 3'b011;
	parameter [2:0] closed_and_filled = 3'b100, outer_open = 3'b101, timer_8_min = 3'b110, inner_open = 3'b111;
	
	reg [2:0] ps;
	
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
