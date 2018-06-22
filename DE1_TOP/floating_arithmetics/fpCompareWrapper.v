module fpCompareWrapper
(
	input clock,
	input clk_en,
	input [31:0] dataa,
	input [31:0] datab,
	output [31:0] result,
	output done
);
	wire aeb;
	wire agb;
	wire alb;
	wire aleb;
	wire aneb;

	fpCompare	fpCompare_inst (
		.clk_en ( started ),
		.clock ( clock ),
		.dataa ( dataa ),
		.datab ( datab ),
		.aeb ( aeb ),
		.agb ( agb ),
		.ageb ( ageb ),
		.alb ( alb ),
		.aleb ( aleb ),
		.aneb ( aneb )
	);


	localparam WAIT_CYCLES = 3;

	integer counter, counter_next;
	reg started, started_next;
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
		if(counter == WAIT_CYCLES-1)
		begin
			started_next <= 0;
		end
	end

	always @(posedge clock)
	begin
		counter <= counter_next;
		started <= started_next;
	end

	assign result = { 29'b0, alb, agb, aeb };
	assign done = counter == WAIT_CYCLES;
endmodule
