// Copyright (C) 1991-2013 Altera Corporation
// Your use of Altera Corporation's design tools, logic functions
// and other software and tools, and its AMPP partner logic
// functions, and any output files from any of the foregoing
// (including device programming or simulation files), and any
// associated documentation or information are expressly subject
// to the terms and conditions of the Altera Program License
// Subscription Agreement, Altera MegaCore Function License
// Agreement, or other applicable license agreement, including,
// without limitation, that your use is for the sole purpose of
// programming logic devices manufactured by Altera and sold by
// Altera or its authorized distributors.  Please refer to the
// applicable agreement for further details.

// *****************************************************************************
// This file contains a Verilog test bench template that is freely editable to
// suit user's needs .Comments are provided in each section to help the user
// fill out necessary details.
// *****************************************************************************
// Generated on "04/21/2018 16:47:28"

// Verilog Test Bench template for design : DE1_TOP
//
// Simulation tool : ModelSim-Altera (Verilog)
//

`timescale 1 ps/ 1 ps
module test_noise_filter();

localparam DATA_WIDTH = 24;

reg write;
reg clock;
reg [DATA_WIDTH-1:0] data_in;
wire done;
wire [DATA_WIDTH-1:0] sum;

noise_filter nf (
	.write(write),
	.clock(clock),
	.data_in(data_in),
	.done(done),
	.sum(sum)
);

initial
begin
	clock = 0;
end

always
begin
 	clock <= ~clock;
	#2.5;
end

initial
begin
	write <= 0;
$display("Running testbench");
end

integer k;
always
begin
	// - 10
	data_in <=  24'b111111111111111111110110;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// 20
	data_in <= 24'b000000000000000000010100;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// -300
	data_in <= 24'b111111111111111011010100;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// 40
	data_in <= 24'b000000000000000000101000;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// 50
	data_in <= 24'b000000000000000000110010;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// 100
	data_in <= 24'b000000000000000001100100;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// 20
	data_in <= 24'b000000000000000000010100;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end

	// 40
	data_in <= 24'b000000000000000000101000;
	write <= 1;
	@(posedge clock);
	write <= 0;

	for(k=0; k<8; k=k + 1)
	begin
		@(posedge clock);
	end
	// (-10 + 20 -300 + 50 + 40 + 100 + 20 + 40) / 8 = 5 expected

	$stop;
end
endmodule
