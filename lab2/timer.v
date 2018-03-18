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

