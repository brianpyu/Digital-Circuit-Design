module DE1_SoC(LEDR, GPIOin, GPIOout, KEY, CLOCK_50, SW);
	output wire [9:0] LEDR;
	input wire GPIOin;
	output wire GPIOout;
	input wire [2:0] KEY;
	input wire [9:0] SW;
	input wire CLOCK_50;
		
	logic [31:0] clk;
	parameter whichClock = 23;  
	clock_divider cdiv (CLOCK_50, clk); 
	
	// instance of interlock with specified inputs and outputs
	interlock il (.clk(clk[whichClock]), .reset(SW[8]), .fill(SW[7]), .evacuate(SW[6]), .check(SW[4]), .arrive(SW[0]), .depart(SW[1]), .outer(SW[2]), .inner(SW[3]), .wait_done(wait_finished), .fill_done(fill_finished), .drain_done(drain_finished), .wait_start(waiting), .fill_start(filling), .drain_start(draining), .ps(LEDR[7:5]));
 
	// 3 instances of timers for waiting, filling, and draining
	timer waittimer(.timer_out(wait_count), .done(wait_finished), .clk(clk[whichClock]), .begin_Counting(4'b0101), .start(waiting));
	timer filltimer(.timer_out(fill_count), .done(fill_finished), .clk(clk[whichClock]), .begin_Counting(4'b0111), .start(filling));
	timer draintimer(.timer_out(drain_count), .done(drain_finished), .clk(clk[whichClock]), .begin_Counting(4'b1000), .start(draining));
 
	
	reg [31:0] counter;
	reg controlledClock;
	wire [7:0] dataOut, dataIn;
	wire transmitEnable, characterReceived, characterSent, load;
	
	wire [10:0] address;
	wire [7:0] data;
	wire outputEnable, writeEnable;
		
	always@(posedge CLOCK_50) begin
		if(~KEY[2]) begin
			counter <= 32'd0;
			controlledClock <= 1'b0;
		end else begin
			counter <= counter + 1'b1;
			if(counter == 325) begin
				controlledClock <= 1'b1;
			end else if(counter == 650) begin
				controlledClock <= 1'b0;
				counter <= 32'd0;
			end
		end
	end
	processor p(address, characterReceived, characterSent, CLOCK_50, data, load, outputEnable, dataIn, dataOut, KEY[2], transmitEnable, writeEnable);

	
	ParallelSerial PS(.charSent(charactersent), .out(GPIOout), .fromCPU(dataOut), .load(load), .enable(transmitenable), .clk(controlledClock), .reset(KEY[0]));
	SerialParallel SP(.charReceived(characterReceived), .dataToCPU(dataIn), .enable(), .fromSerial(GPIOin), .clk(controlledClock), .reset(KEY[0]));
	
	sram s (.clk(CLOCK_50), .address(address), .writeEnable(writeEnable), .outputEnable(outputEnable), .data(data));
	
	
	
	
	
endmodule

module clock_divider (clock, divided_clocks);
 input logic clock;
 output logic [31:0] divided_clocks;

 initial begin
 divided_clocks <= 0;
 end

 always_ff @(posedge clock) begin
 divided_clocks <= divided_clocks + 1;
 end

endmodule 