module sin
(
	input clock,
	input clk_en,
	input [31:0] data,
	output [31:0] result,
	output done
);

	sinus	s (
		.clk_en ( started ),
		.clock ( clock ),
		.data ( data ),
		.result ( result )
	);
	
	localparam WAIT_CYCLES = 35;
	
	integer counter, counter_next;
	reg started, started_next;
	reg actual_clk_en, actual_clk_en_next;
	
	initial
	begin
		counter = 0;
		counter_next = 0;
		started = 0;
		started_next = 0;
	end
	always @(*)
	begin
		counter_next <= counter;
		started_next <= started;
		
		if(clk_en == 1 && counter == 0)
		begin
			started_next <= 1;
		end
		if(started)
		begin
			counter_next <= counter + 1;
		end
		if(counter == WAIT_CYCLES)
		begin
			counter_next <= 0;
		end
		else if (counter == WAIT_CYCLES - 1)
		begin
			started_next <= 0;
		end
	end
	
	always @(posedge clock)
	begin
		counter <= counter_next;
		started <= started_next;
	end
	
	assign done = counter == WAIT_CYCLES;
endmodule
