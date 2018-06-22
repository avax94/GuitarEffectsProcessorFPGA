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
`timescale 1 us/ 1 us
module test_distortion();
   localparam LESS = {29'b0, 1'b1, 2'b0}, GREATER = {30'b0, 1'b1, 1'b0};

   wire                  distortion_done;
   wire [15:0] distortion_data_out;
   reg                   my_turn;
   wire                  done;
   wire [15:0]            data_out;
   reg [15:0]            data_in;
   reg                   clk;

   initial begin
      clk = 0;
   end

   always begin
      clk = ~clk;
      #2.5;
   end

   distortion #(
                .DATA_WIDTH(16)
                )
   distt (
          .cs(1),
          .my_turn(my_turn),
          .data_in(data_in),
          // 2000 / (48000 * 48000)
          .done(done),
          .data_out(data_out),
          .clk(clk),
          .rst(0),
          );
   always begin
          // Take one that is < 1/3
      data_in <= 16'b0000101010101010;
      my_turn <= 1;
      @(posedge done);

      // Take one grater than 1/3 and less than 2/3
      data_in <= 16'b0010101010101011;
      my_turn <= 1;
      @(posedge done);

      data_in <= 16'b0101010101010100;
      my_turn <= 1;
      @(posedge done);

      // Take one that is > - 1 / 3 //
      data_in <= 16'b1101010101010111;

      my_turn <= 1;
      @(posedge done);

      // Take one that is < - 1 / 3 and > - 2 / 3 // -15000
      data_in <= 16'b1100010101101000;
      my_turn <= 1;
      @(posedge done);

      // Take one that is < - 2 / 3 // - 30000
      data_in <= 16'b1000101011010000;
      my_turn <= 1;
      @(posedge done);

      $stop;
   end
endmodule
