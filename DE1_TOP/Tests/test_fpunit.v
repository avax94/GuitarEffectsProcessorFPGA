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
	// Generated on "04/24/2017 13:13:01"

	// Verilog Test Bench template for design : ram
	//
	// Simulation tool : ModelSim-Altera (Verilog)
	//
`define fdivs 2
`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt
`define ficmp 6      //CMP
	`timescale 1 us/ 1 us
	module test_fpunit();
   localparam LESS = {29'b0, 1'b1, 2'b0}, GREATER = {30'b0, 1'b1, 1'b0};

   /* Initialize helper modules */
   reg clk;
	reg [31:0]                   fpu_dataa;
   reg [31:0]                   fpu_datab;
   reg [31:0]                   tmp;
   reg [2:0]                    fpu_operation;
   reg                          fpu_clk_en;
   wire                          fpu_done;
   wire [31:0]                   fpu_result;
   
	fpUnit u0 (
	      .dataa(fpu_dataa),
	      .datab(fpu_datab),
	      .operation(fpu_operation),
	      .clock(clk),
	      .clk_en(fpu_clk_en),
	      .done(fpu_done),
	      .result(fpu_result)
	      );

	initial begin
		clk = 0;
	end

	always begin
		clk <= ~clk;
		#2.5;
	end
  
	always begin
		fpu_dataa <= 32'b00111111100011001100110011001101; // 1.1
		fpu_datab <= 32'b00111111100110011001100110011010; // 1.2
		fpu_operation <= `ficmp;
		fpu_clk_en <= 1;
		@(posedge fpu_done);
		if (fpu_result & LESS) begin
		  tmp = fpu_dataa;
		  fpu_dataa <= fpu_datab;
		  fpu_datab <= tmp;
		  
		  @(posedge fpu_done);
		  if (fpu_result & GREATER) begin
		    $stop;
		  end
		end
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		$stop;
	end
endmodule
