module noise_filter
#(
	parameter DATA_WIDTH=24,
	parameter N = 3
)
(
	input write,
	input clock,
	input [DATA_WIDTH-1:0] data_in,
	output done,
	output [DATA_WIDTH - 1:0] sum
);
	reg [DATA_WIDTH+N-1:0] summed;
	reg [DATA_WIDTH+N-1:0] summed_debug;
	reg [DATA_WIDTH+N-1:0] signal_debug;
	reg [N-1:0] counter;
	reg isDone;
	reg [DATA_WIDTH +N-1:0] fifo [0:2**N-1];
	integer i;
	initial
	begin
		counter = 0;
		summed = 0;
		isDone = 0;

		for(i = 0; i < 2**N; i= i+1)
		begin
			fifo[i] = 0;
		end
	end

	always @(posedge clock)
	begin
		if(isDone == 1)
		begin
			isDone <= 0;
		end
		else if(write == 1)
		begin
			summed <= summed - fifo[counter] + {{N{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]};
			summed_debug = summed - fifo[counter] + {{2*N{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:N]};
			signal_debug = {{2*N{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:N]};
			fifo[counter] = {{N{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]};
			counter <= counter + 1;
			isDone <= 1;
		end
	end
	assign sum = summed[DATA_WIDTH+N-1:N];
	assign done = isDone;
endmodule