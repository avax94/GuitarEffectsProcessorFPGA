// megafunction wizard: %ALTFP_DIV%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: altfp_div 

// ============================================================
// File Name: fpDiv.v
// Megafunction Name(s):
// 			altfp_div
//
// Simulation Library Files(s):
// 			
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


//altfp_div CBX_AUTO_BLACKBOX="ALL" DENORMAL_SUPPORT="NO" DEVICE_FAMILY="Cyclone II" OPTIMIZE="SPEED" PIPELINE=6 REDUCED_FUNCTIONALITY="NO" WIDTH_EXP=8 WIDTH_MAN=23 clk_en clock dataa datab result
//VERSION_BEGIN 13.0 cbx_altbarrel_shift 2013:06:12:18:03:40:SJ cbx_altfp_div 2013:06:12:18:03:40:SJ cbx_altsyncram 2013:06:12:18:03:40:SJ cbx_cycloneii 2013:06:12:18:03:40:SJ cbx_lpm_abs 2013:06:12:18:03:40:SJ cbx_lpm_add_sub 2013:06:12:18:03:40:SJ cbx_lpm_compare 2013:06:12:18:03:40:SJ cbx_lpm_decode 2013:06:12:18:03:40:SJ cbx_lpm_divide 2013:06:12:18:03:40:SJ cbx_lpm_mult 2013:06:12:18:03:40:SJ cbx_lpm_mux 2013:06:12:18:03:40:SJ cbx_mgl 2013:06:12:18:04:42:SJ cbx_padd 2013:06:12:18:03:40:SJ cbx_stratix 2013:06:12:18:03:40:SJ cbx_stratixii 2013:06:12:18:03:40:SJ cbx_stratixiii 2013:06:12:18:03:40:SJ cbx_stratixv 2013:06:12:18:03:40:SJ cbx_util_mgl 2013:06:12:18:03:40:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



//altfp_div_pst CBX_AUTO_BLACKBOX="ALL" DEVICE_FAMILY="Cyclone II" FILE_NAME="fpDiv.v:a" PIPELINE=6 WIDTH_EXP=8 WIDTH_MAN=23 aclr clk_en clock dataa datab result
//VERSION_BEGIN 13.0 cbx_altbarrel_shift 2013:06:12:18:03:40:SJ cbx_altfp_div 2013:06:12:18:03:40:SJ cbx_altsyncram 2013:06:12:18:03:40:SJ cbx_cycloneii 2013:06:12:18:03:40:SJ cbx_lpm_abs 2013:06:12:18:03:40:SJ cbx_lpm_add_sub 2013:06:12:18:03:40:SJ cbx_lpm_compare 2013:06:12:18:03:40:SJ cbx_lpm_decode 2013:06:12:18:03:40:SJ cbx_lpm_divide 2013:06:12:18:03:40:SJ cbx_lpm_mult 2013:06:12:18:03:40:SJ cbx_lpm_mux 2013:06:12:18:03:40:SJ cbx_mgl 2013:06:12:18:04:42:SJ cbx_padd 2013:06:12:18:03:40:SJ cbx_stratix 2013:06:12:18:03:40:SJ cbx_stratixii 2013:06:12:18:03:40:SJ cbx_stratixiii 2013:06:12:18:03:40:SJ cbx_stratixv 2013:06:12:18:03:40:SJ cbx_util_mgl 2013:06:12:18:03:40:SJ  VERSION_END

//synthesis_resources = altsyncram 1 lpm_add_sub 4 lpm_compare 1 lpm_mult 5 mux21 74 reg 339 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpDiv_altfp_div_pst_4fe
	( 
	aclr,
	clk_en,
	clock,
	dataa,
	datab,
	result) ;
	input   aclr;
	input   clk_en;
	input   clock;
	input   [31:0]  dataa;
	input   [31:0]  datab;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   aclr;
	tri1   clk_en;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [8:0]   wire_altsyncram3_q_a;
	reg	a_is_infinity_dffe_0;
	reg	a_is_infinity_dffe_1;
	reg	a_is_infinity_dffe_2;
	reg	a_is_infinity_dffe_3;
	reg	a_is_infinity_dffe_4;
	reg	a_zero_b_not_dffe_0;
	reg	a_zero_b_not_dffe_1;
	reg	a_zero_b_not_dffe_2;
	reg	a_zero_b_not_dffe_3;
	reg	a_zero_b_not_dffe_4;
	reg	[33:0]	b1_dffe_0;
	reg	b_is_infinity_dffe_0;
	reg	b_is_infinity_dffe_1;
	reg	b_is_infinity_dffe_2;
	reg	b_is_infinity_dffe_3;
	reg	b_is_infinity_dffe_4;
	reg	both_exp_zeros_dffe;
	reg	divbyzero_pipe_dffe_0;
	reg	divbyzero_pipe_dffe_1;
	reg	divbyzero_pipe_dffe_2;
	reg	divbyzero_pipe_dffe_3;
	reg	divbyzero_pipe_dffe_4;
	reg	[16:0]	e1_dffe_0;
	reg	[16:0]	e1_dffe_1;
	reg	[7:0]	exp_result_dffe_0;
	reg	[7:0]	exp_result_dffe_1;
	reg	[7:0]	exp_result_dffe_2;
	reg	[7:0]	exp_result_dffe_3;
	reg	frac_a_smaller_dffe1;
	reg	[22:0]	man_a_dffe1_dffe1;
	reg	[22:0]	man_b_dffe1_dffe1;
	reg	[22:0]	man_result_dffe;
	reg	nan_pipe_dffe_0;
	reg	nan_pipe_dffe_1;
	reg	nan_pipe_dffe_2;
	reg	nan_pipe_dffe_3;
	reg	nan_pipe_dffe_4;
	reg	over_under_dffe_0;
	reg	over_under_dffe_1;
	reg	over_under_dffe_2;
	reg	[16:0]	quotient_j_dffe;
	reg	[16:0]	quotient_k_dffe_0;
	reg	[49:0]	remainder_j_dffe_0;
	reg	[49:0]	remainder_j_dffe_1;
	reg	sign_pipe_dffe_0;
	reg	sign_pipe_dffe_1;
	reg	sign_pipe_dffe_2;
	reg	sign_pipe_dffe_3;
	reg	sign_pipe_dffe_4;
	reg	sign_pipe_dffe_5;
	wire  wire_bias_addition_overflow;
	wire  [8:0]   wire_bias_addition_result;
	wire  [8:0]   wire_exp_sub_result;
	wire  [30:0]   wire_quotient_process_result;
	wire  [49:0]   wire_remainder_sub_0_result;
	wire  wire_cmpr2_alb;
	wire  [34:0]   wire_a1_prod_result;
	wire  [33:0]   wire_b1_prod_result;
	wire  [33:0]   wire_q_partial_0_result;
	wire  [33:0]   wire_q_partial_1_result;
	wire  [50:0]   wire_remainder_mult_0_result;
	wire	[7:0]wire_exp_result_muxa_dataout;
	wire	[24:0]wire_man_a_adjusteda_dataout;
	wire	[22:0]wire_man_result_muxa_dataout;
	wire	[8:0]wire_select_bias_2a_dataout;
	wire	[8:0]wire_select_biasa_dataout;
	wire  a_is_infinity_w;
	wire  a_is_nan_w;
	wire  a_zero_b_not;
	wire  [33:0]  b1_dffe_w;
	wire  b_is_infinity_w;
	wire  b_is_nan_w;
	wire  bias_addition_overf_w;
	wire  [7:0]  bias_addition_w;
	wire  both_exp_zeros;
	wire  [8:0]  e0_dffe1_wo;
	wire  [8:0]  e0_w;
	wire  [50:0]  e1_w;
	wire  [7:0]  exp_a_all_one_w;
	wire  [7:0]  exp_a_not_zero_w;
	wire  [7:0]  exp_add_output_all_one;
	wire  [7:0]  exp_add_output_not_zero;
	wire  [7:0]  exp_b_all_one_w;
	wire  [7:0]  exp_b_not_zero_w;
	wire  [7:0]  exp_result_mux_out;
	wire  exp_result_mux_sel_w;
	wire  [7:0]  exp_result_w;
	wire  exp_sign_w;
	wire  [8:0]  exp_sub_a_w;
	wire  [8:0]  exp_sub_b_w;
	wire  [8:0]  exp_sub_w;
	wire  frac_a_smaller_dffe1_wi;
	wire  frac_a_smaller_dffe1_wo;
	wire  frac_a_smaller_w;
	wire  guard_bit;
	wire  [24:0]  man_a_adjusted_w;
	wire  [22:0]  man_a_dffe1_wi;
	wire  [22:0]  man_a_dffe1_wo;
	wire  [22:0]  man_a_not_zero_w;
	wire  [23:0]  man_b_adjusted_w;
	wire  [22:0]  man_b_dffe1_wi;
	wire  [22:0]  man_b_dffe1_wo;
	wire  [22:0]  man_b_not_zero_w;
	wire  [22:0]  man_result_dffe_wi;
	wire  [22:0]  man_result_dffe_wo;
	wire  man_result_mux_select;
	wire  [22:0]  man_result_w;
	wire  [22:0]  man_zeros_w;
	wire  [7:0]  overflow_ones_w;
	wire  overflow_underflow;
	wire  overflow_w;
	wire  [61:0]  quotient_accumulate_w;
	wire  quotient_process_cin_w;
	wire  [99:0]  remainder_j_w;
	wire  round_bit;
	wire  [8:0]  select_bias_out_2_w;
	wire  [8:0]  select_bias_out_w;
	wire  [4:0]  sticky_bits;
	wire  underflow_w;
	wire  [7:0]  underflow_zeros_w;
	wire  [8:0]  value_add_one_w;
	wire  [8:0]  value_normal_w;
	wire  [8:0]  value_zero_w;

	altsyncram   altsyncram3
	( 
	.address_a(datab[22:14]),
	.clock0(clock),
	.clocken0(clk_en),
	.eccstatus(),
	.q_a(wire_altsyncram3_q_a),
	.q_b()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr0(1'b0),
	.aclr1(1'b0),
	.address_b({1{1'b1}}),
	.addressstall_a(1'b0),
	.addressstall_b(1'b0),
	.byteena_a({1{1'b1}}),
	.byteena_b({1{1'b1}}),
	.clock1(1'b1),
	.clocken1(1'b1),
	.clocken2(1'b1),
	.clocken3(1'b1),
	.data_a({9{1'b1}}),
	.data_b({1{1'b1}}),
	.rden_a(1'b1),
	.rden_b(1'b1),
	.wren_a(1'b0),
	.wren_b(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		altsyncram3.init_file = "fpDiv.hex",
		altsyncram3.operation_mode = "ROM",
		altsyncram3.width_a = 9,
		altsyncram3.widthad_a = 9,
		altsyncram3.intended_device_family = "Cyclone II",
		altsyncram3.lpm_type = "altsyncram";
	// synopsys translate_off
	initial
		a_is_infinity_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_is_infinity_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   a_is_infinity_dffe_0 <= a_is_infinity_w;
	// synopsys translate_off
	initial
		a_is_infinity_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_is_infinity_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   a_is_infinity_dffe_1 <= a_is_infinity_dffe_0;
	// synopsys translate_off
	initial
		a_is_infinity_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_is_infinity_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   a_is_infinity_dffe_2 <= a_is_infinity_dffe_1;
	// synopsys translate_off
	initial
		a_is_infinity_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_is_infinity_dffe_3 <= 1'b0;
		else if  (clk_en == 1'b1)   a_is_infinity_dffe_3 <= a_is_infinity_dffe_2;
	// synopsys translate_off
	initial
		a_is_infinity_dffe_4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_is_infinity_dffe_4 <= 1'b0;
		else if  (clk_en == 1'b1)   a_is_infinity_dffe_4 <= a_is_infinity_dffe_3;
	// synopsys translate_off
	initial
		a_zero_b_not_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_zero_b_not_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   a_zero_b_not_dffe_0 <= a_zero_b_not;
	// synopsys translate_off
	initial
		a_zero_b_not_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_zero_b_not_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   a_zero_b_not_dffe_1 <= a_zero_b_not_dffe_0;
	// synopsys translate_off
	initial
		a_zero_b_not_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_zero_b_not_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   a_zero_b_not_dffe_2 <= a_zero_b_not_dffe_1;
	// synopsys translate_off
	initial
		a_zero_b_not_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_zero_b_not_dffe_3 <= 1'b0;
		else if  (clk_en == 1'b1)   a_zero_b_not_dffe_3 <= a_zero_b_not_dffe_2;
	// synopsys translate_off
	initial
		a_zero_b_not_dffe_4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) a_zero_b_not_dffe_4 <= 1'b0;
		else if  (clk_en == 1'b1)   a_zero_b_not_dffe_4 <= a_zero_b_not_dffe_3;
	// synopsys translate_off
	initial
		b1_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) b1_dffe_0 <= 34'b0;
		else if  (clk_en == 1'b1)   b1_dffe_0 <= wire_b1_prod_result;
	// synopsys translate_off
	initial
		b_is_infinity_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) b_is_infinity_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   b_is_infinity_dffe_0 <= b_is_infinity_w;
	// synopsys translate_off
	initial
		b_is_infinity_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) b_is_infinity_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   b_is_infinity_dffe_1 <= b_is_infinity_dffe_0;
	// synopsys translate_off
	initial
		b_is_infinity_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) b_is_infinity_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   b_is_infinity_dffe_2 <= b_is_infinity_dffe_1;
	// synopsys translate_off
	initial
		b_is_infinity_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) b_is_infinity_dffe_3 <= 1'b0;
		else if  (clk_en == 1'b1)   b_is_infinity_dffe_3 <= b_is_infinity_dffe_2;
	// synopsys translate_off
	initial
		b_is_infinity_dffe_4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) b_is_infinity_dffe_4 <= 1'b0;
		else if  (clk_en == 1'b1)   b_is_infinity_dffe_4 <= b_is_infinity_dffe_3;
	// synopsys translate_off
	initial
		both_exp_zeros_dffe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) both_exp_zeros_dffe <= 1'b0;
		else if  (clk_en == 1'b1)   both_exp_zeros_dffe <= ((~ exp_b_not_zero_w[7]) & (~ exp_a_not_zero_w[7]));
	// synopsys translate_off
	initial
		divbyzero_pipe_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) divbyzero_pipe_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   divbyzero_pipe_dffe_0 <= ((((~ exp_b_not_zero_w[7]) & (~ a_is_nan_w)) & exp_a_not_zero_w[7]) & (~ a_is_infinity_w));
	// synopsys translate_off
	initial
		divbyzero_pipe_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) divbyzero_pipe_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   divbyzero_pipe_dffe_1 <= divbyzero_pipe_dffe_0;
	// synopsys translate_off
	initial
		divbyzero_pipe_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) divbyzero_pipe_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   divbyzero_pipe_dffe_2 <= divbyzero_pipe_dffe_1;
	// synopsys translate_off
	initial
		divbyzero_pipe_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) divbyzero_pipe_dffe_3 <= 1'b0;
		else if  (clk_en == 1'b1)   divbyzero_pipe_dffe_3 <= divbyzero_pipe_dffe_2;
	// synopsys translate_off
	initial
		divbyzero_pipe_dffe_4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) divbyzero_pipe_dffe_4 <= 1'b0;
		else if  (clk_en == 1'b1)   divbyzero_pipe_dffe_4 <= divbyzero_pipe_dffe_3;
	// synopsys translate_off
	initial
		e1_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) e1_dffe_0 <= 17'b0;
		else if  (clk_en == 1'b1)   e1_dffe_0 <= e1_w[16:0];
	// synopsys translate_off
	initial
		e1_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) e1_dffe_1 <= 17'b0;
		else if  (clk_en == 1'b1)   e1_dffe_1 <= e1_w[33:17];
	// synopsys translate_off
	initial
		exp_result_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_result_dffe_0 <= 8'b0;
		else if  (clk_en == 1'b1)   exp_result_dffe_0 <= exp_result_mux_out;
	// synopsys translate_off
	initial
		exp_result_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_result_dffe_1 <= 8'b0;
		else if  (clk_en == 1'b1)   exp_result_dffe_1 <= exp_result_dffe_0;
	// synopsys translate_off
	initial
		exp_result_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_result_dffe_2 <= 8'b0;
		else if  (clk_en == 1'b1)   exp_result_dffe_2 <= exp_result_dffe_1;
	// synopsys translate_off
	initial
		exp_result_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) exp_result_dffe_3 <= 8'b0;
		else if  (clk_en == 1'b1)   exp_result_dffe_3 <= exp_result_dffe_2;
	// synopsys translate_off
	initial
		frac_a_smaller_dffe1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) frac_a_smaller_dffe1 <= 1'b0;
		else if  (clk_en == 1'b1)   frac_a_smaller_dffe1 <= frac_a_smaller_dffe1_wi;
	// synopsys translate_off
	initial
		man_a_dffe1_dffe1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) man_a_dffe1_dffe1 <= 23'b0;
		else if  (clk_en == 1'b1)   man_a_dffe1_dffe1 <= man_a_dffe1_wi;
	// synopsys translate_off
	initial
		man_b_dffe1_dffe1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) man_b_dffe1_dffe1 <= 23'b0;
		else if  (clk_en == 1'b1)   man_b_dffe1_dffe1 <= man_b_dffe1_wi;
	// synopsys translate_off
	initial
		man_result_dffe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) man_result_dffe <= 23'b0;
		else if  (clk_en == 1'b1)   man_result_dffe <= man_result_dffe_wi;
	// synopsys translate_off
	initial
		nan_pipe_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) nan_pipe_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   nan_pipe_dffe_0 <= (((a_is_nan_w | b_is_nan_w) | (a_is_infinity_w & b_is_infinity_w)) | ((~ exp_a_not_zero_w[7]) & (~ exp_b_not_zero_w[7])));
	// synopsys translate_off
	initial
		nan_pipe_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) nan_pipe_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   nan_pipe_dffe_1 <= nan_pipe_dffe_0;
	// synopsys translate_off
	initial
		nan_pipe_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) nan_pipe_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   nan_pipe_dffe_2 <= nan_pipe_dffe_1;
	// synopsys translate_off
	initial
		nan_pipe_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) nan_pipe_dffe_3 <= 1'b0;
		else if  (clk_en == 1'b1)   nan_pipe_dffe_3 <= nan_pipe_dffe_2;
	// synopsys translate_off
	initial
		nan_pipe_dffe_4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) nan_pipe_dffe_4 <= 1'b0;
		else if  (clk_en == 1'b1)   nan_pipe_dffe_4 <= nan_pipe_dffe_3;
	// synopsys translate_off
	initial
		over_under_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) over_under_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   over_under_dffe_0 <= overflow_underflow;
	// synopsys translate_off
	initial
		over_under_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) over_under_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   over_under_dffe_1 <= over_under_dffe_0;
	// synopsys translate_off
	initial
		over_under_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) over_under_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   over_under_dffe_2 <= over_under_dffe_1;
	// synopsys translate_off
	initial
		quotient_j_dffe = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) quotient_j_dffe <= 17'b0;
		else if  (clk_en == 1'b1)   quotient_j_dffe <= wire_q_partial_0_result[32:16];
	// synopsys translate_off
	initial
		quotient_k_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) quotient_k_dffe_0 <= 17'b0;
		else if  (clk_en == 1'b1)   quotient_k_dffe_0 <= quotient_accumulate_w[30:14];
	// synopsys translate_off
	initial
		remainder_j_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) remainder_j_dffe_0 <= 50'b0;
		else if  (clk_en == 1'b1)   remainder_j_dffe_0 <= remainder_j_w[49:0];
	// synopsys translate_off
	initial
		remainder_j_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) remainder_j_dffe_1 <= 50'b0;
		else if  (clk_en == 1'b1)   remainder_j_dffe_1 <= remainder_j_dffe_0;
	// synopsys translate_off
	initial
		sign_pipe_dffe_0 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_pipe_dffe_0 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_pipe_dffe_0 <= (dataa[31] ^ datab[31]);
	// synopsys translate_off
	initial
		sign_pipe_dffe_1 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_pipe_dffe_1 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_pipe_dffe_1 <= sign_pipe_dffe_0;
	// synopsys translate_off
	initial
		sign_pipe_dffe_2 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_pipe_dffe_2 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_pipe_dffe_2 <= sign_pipe_dffe_1;
	// synopsys translate_off
	initial
		sign_pipe_dffe_3 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_pipe_dffe_3 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_pipe_dffe_3 <= sign_pipe_dffe_2;
	// synopsys translate_off
	initial
		sign_pipe_dffe_4 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_pipe_dffe_4 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_pipe_dffe_4 <= sign_pipe_dffe_3;
	// synopsys translate_off
	initial
		sign_pipe_dffe_5 = 0;
	// synopsys translate_on
	always @ ( posedge clock or  posedge aclr)
		if (aclr == 1'b1) sign_pipe_dffe_5 <= 1'b0;
		else if  (clk_en == 1'b1)   sign_pipe_dffe_5 <= sign_pipe_dffe_4;
	lpm_add_sub   bias_addition
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.cout(),
	.dataa(exp_sub_w),
	.datab(select_bias_out_2_w),
	.overflow(wire_bias_addition_overflow),
	.result(wire_bias_addition_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		bias_addition.lpm_direction = "ADD",
		bias_addition.lpm_pipeline = 1,
		bias_addition.lpm_representation = "SIGNED",
		bias_addition.lpm_width = 9,
		bias_addition.lpm_type = "lpm_add_sub";
	lpm_add_sub   exp_sub
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.cout(),
	.dataa(exp_sub_a_w),
	.datab(exp_sub_b_w),
	.overflow(),
	.result(wire_exp_sub_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.add_sub(1'b1),
	.cin()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		exp_sub.lpm_direction = "SUB",
		exp_sub.lpm_pipeline = 1,
		exp_sub.lpm_representation = "SIGNED",
		exp_sub.lpm_width = 9,
		exp_sub.lpm_type = "lpm_add_sub";
	lpm_add_sub   quotient_process
	( 
	.cin(quotient_process_cin_w),
	.cout(),
	.dataa({quotient_accumulate_w[61:45], {14{1'b0}}}),
	.datab({{14{1'b0}}, wire_q_partial_1_result[32:22], {6{1'b1}}}),
	.overflow(),
	.result(wire_quotient_process_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		quotient_process.lpm_direction = "ADD",
		quotient_process.lpm_representation = "UNSIGNED",
		quotient_process.lpm_width = 31,
		quotient_process.lpm_type = "lpm_add_sub";
	lpm_add_sub   remainder_sub_0
	( 
	.cout(),
	.dataa({remainder_j_dffe_1[49:15], {15{1'b0}}}),
	.datab(wire_remainder_mult_0_result[49:0]),
	.overflow(),
	.result(wire_remainder_sub_0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.add_sub(1'b1),
	.cin(),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		remainder_sub_0.lpm_direction = "SUB",
		remainder_sub_0.lpm_representation = "UNSIGNED",
		remainder_sub_0.lpm_width = 50,
		remainder_sub_0.lpm_type = "lpm_add_sub";
	lpm_compare   cmpr2
	( 
	.aeb(),
	.agb(),
	.ageb(),
	.alb(wire_cmpr2_alb),
	.aleb(),
	.aneb(),
	.dataa(dataa[22:0]),
	.datab(datab[22:0])
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.aclr(1'b0),
	.clken(1'b1),
	.clock(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		cmpr2.lpm_representation = "UNSIGNED",
		cmpr2.lpm_width = 23,
		cmpr2.lpm_type = "lpm_compare";
	lpm_mult   a1_prod
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(man_a_adjusted_w),
	.datab({1'b1, e0_dffe1_wo}),
	.result(wire_a1_prod_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		a1_prod.lpm_pipeline = 1,
		a1_prod.lpm_representation = "UNSIGNED",
		a1_prod.lpm_widtha = 25,
		a1_prod.lpm_widthb = 10,
		a1_prod.lpm_widthp = 35,
		a1_prod.lpm_type = "lpm_mult",
		a1_prod.lpm_hint = "DEDICATED_MULTIPLIER_CIRCUITRY=YES";
	lpm_mult   b1_prod
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(man_b_adjusted_w),
	.datab({1'b1, e0_dffe1_wo}),
	.result(wire_b1_prod_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		b1_prod.lpm_pipeline = 1,
		b1_prod.lpm_representation = "UNSIGNED",
		b1_prod.lpm_widtha = 24,
		b1_prod.lpm_widthb = 10,
		b1_prod.lpm_widthp = 34,
		b1_prod.lpm_type = "lpm_mult",
		b1_prod.lpm_hint = "DEDICATED_MULTIPLIER_CIRCUITRY=YES";
	lpm_mult   q_partial_0
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(remainder_j_w[49:33]),
	.datab(e1_w[16:0]),
	.result(wire_q_partial_0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		q_partial_0.lpm_pipeline = 1,
		q_partial_0.lpm_representation = "UNSIGNED",
		q_partial_0.lpm_widtha = 17,
		q_partial_0.lpm_widthb = 17,
		q_partial_0.lpm_widthp = 34,
		q_partial_0.lpm_type = "lpm_mult",
		q_partial_0.lpm_hint = "DEDICATED_MULTIPLIER_CIRCUITRY=YES";
	lpm_mult   q_partial_1
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(remainder_j_w[99:83]),
	.datab(e1_w[50:34]),
	.result(wire_q_partial_1_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		q_partial_1.lpm_pipeline = 1,
		q_partial_1.lpm_representation = "UNSIGNED",
		q_partial_1.lpm_widtha = 17,
		q_partial_1.lpm_widthb = 17,
		q_partial_1.lpm_widthp = 34,
		q_partial_1.lpm_type = "lpm_mult",
		q_partial_1.lpm_hint = "DEDICATED_MULTIPLIER_CIRCUITRY=YES";
	lpm_mult   remainder_mult_0
	( 
	.aclr(aclr),
	.clken(clk_en),
	.clock(clock),
	.dataa(b1_dffe_w[33:0]),
	.datab(wire_q_partial_0_result[32:16]),
	.result(wire_remainder_mult_0_result)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.sum({1{1'b0}})
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		remainder_mult_0.lpm_pipeline = 1,
		remainder_mult_0.lpm_representation = "UNSIGNED",
		remainder_mult_0.lpm_widtha = 34,
		remainder_mult_0.lpm_widthb = 17,
		remainder_mult_0.lpm_widthp = 51,
		remainder_mult_0.lpm_type = "lpm_mult",
		remainder_mult_0.lpm_hint = "DEDICATED_MULTIPLIER_CIRCUITRY=YES";
	assign		wire_exp_result_muxa_dataout = (exp_result_mux_sel_w === 1'b1) ? underflow_zeros_w : exp_result_w;
	assign		wire_man_a_adjusteda_dataout = (frac_a_smaller_dffe1_wo === 1'b1) ? {1'b1, man_a_dffe1_wo, 1'b0} : {1'b0, 1'b1, man_a_dffe1_wo};
	assign		wire_man_result_muxa_dataout = (man_result_mux_select === 1'b1) ? {nan_pipe_dffe_4, man_zeros_w[21:0]} : wire_quotient_process_result[28:6];
	assign		wire_select_bias_2a_dataout = (both_exp_zeros === 1'b1) ? value_zero_w : select_bias_out_w;
	assign		wire_select_biasa_dataout = (frac_a_smaller_dffe1_wo === 1'b1) ? value_normal_w : value_add_one_w;
	assign
		a_is_infinity_w = (exp_a_all_one_w[7] & (~ man_a_not_zero_w[22])),
		a_is_nan_w = (exp_a_all_one_w[7] & man_a_not_zero_w[22]),
		a_zero_b_not = (exp_b_not_zero_w[7] & (~ exp_a_not_zero_w[7])),
		b1_dffe_w = {b1_dffe_0},
		b_is_infinity_w = (exp_b_all_one_w[7] & (~ man_b_not_zero_w[22])),
		b_is_nan_w = (exp_b_all_one_w[7] & man_b_not_zero_w[22]),
		bias_addition_overf_w = wire_bias_addition_overflow,
		bias_addition_w = wire_bias_addition_result[7:0],
		both_exp_zeros = both_exp_zeros_dffe,
		e0_dffe1_wo = e0_w,
		e0_w = wire_altsyncram3_q_a,
		e1_w = {e1_dffe_1, e1_dffe_0, (~ wire_b1_prod_result[33:17])},
		exp_a_all_one_w = {(dataa[30] & exp_a_all_one_w[6]), (dataa[29] & exp_a_all_one_w[5]), (dataa[28] & exp_a_all_one_w[4]), (dataa[27] & exp_a_all_one_w[3]), (dataa[26] & exp_a_all_one_w[2]), (dataa[25] & exp_a_all_one_w[1]), (dataa[24] & exp_a_all_one_w[0]), dataa[23]},
		exp_a_not_zero_w = {(dataa[30] | exp_a_not_zero_w[6]), (dataa[29] | exp_a_not_zero_w[5]), (dataa[28] | exp_a_not_zero_w[4]), (dataa[27] | exp_a_not_zero_w[3]), (dataa[26] | exp_a_not_zero_w[2]), (dataa[25] | exp_a_not_zero_w[1]), (dataa[24] | exp_a_not_zero_w[0]), dataa[23]},
		exp_add_output_all_one = {(bias_addition_w[7] & exp_add_output_all_one[6]), (bias_addition_w[6] & exp_add_output_all_one[5]), (bias_addition_w[5] & exp_add_output_all_one[4]), (bias_addition_w[4] & exp_add_output_all_one[3]), (bias_addition_w[3] & exp_add_output_all_one[2]), (bias_addition_w[2] & exp_add_output_all_one[1]), (bias_addition_w[1] & exp_add_output_all_one[0]), bias_addition_w[0]},
		exp_add_output_not_zero = {(bias_addition_w[7] | exp_add_output_not_zero[6]), (bias_addition_w[6] | exp_add_output_not_zero[5]), (bias_addition_w[5] | exp_add_output_not_zero[4]), (bias_addition_w[4] | exp_add_output_not_zero[3]), (bias_addition_w[3] | exp_add_output_not_zero[2]), (bias_addition_w[2] | exp_add_output_not_zero[1]), (bias_addition_w[1] | exp_add_output_not_zero[0]), bias_addition_w[0]},
		exp_b_all_one_w = {(datab[30] & exp_b_all_one_w[6]), (datab[29] & exp_b_all_one_w[5]), (datab[28] & exp_b_all_one_w[4]), (datab[27] & exp_b_all_one_w[3]), (datab[26] & exp_b_all_one_w[2]), (datab[25] & exp_b_all_one_w[1]), (datab[24] & exp_b_all_one_w[0]), datab[23]},
		exp_b_not_zero_w = {(datab[30] | exp_b_not_zero_w[6]), (datab[29] | exp_b_not_zero_w[5]), (datab[28] | exp_b_not_zero_w[4]), (datab[27] | exp_b_not_zero_w[3]), (datab[26] | exp_b_not_zero_w[2]), (datab[25] | exp_b_not_zero_w[1]), (datab[24] | exp_b_not_zero_w[0]), datab[23]},
		exp_result_mux_out = wire_exp_result_muxa_dataout,
		exp_result_mux_sel_w = ((((a_zero_b_not_dffe_1 | b_is_infinity_dffe_1) | ((~ bias_addition_overf_w) & exp_sign_w)) | (((~ exp_add_output_not_zero[7]) & (~ bias_addition_overf_w)) & (~ exp_sign_w))) & (~ nan_pipe_dffe_1)),
		exp_result_w = (({8{((~ bias_addition_overf_w) & (~ exp_sign_w))}} & bias_addition_w) | ({8{(((bias_addition_overf_w | divbyzero_pipe_dffe_1) | nan_pipe_dffe_1) | a_is_infinity_dffe_1)}} & overflow_ones_w)),
		exp_sign_w = wire_bias_addition_result[8],
		exp_sub_a_w = {1'b0, dataa[30:23]},
		exp_sub_b_w = {1'b0, datab[30:23]},
		exp_sub_w = wire_exp_sub_result,
		frac_a_smaller_dffe1_wi = frac_a_smaller_w,
		frac_a_smaller_dffe1_wo = frac_a_smaller_dffe1,
		frac_a_smaller_w = wire_cmpr2_alb,
		guard_bit = wire_q_partial_1_result[22],
		man_a_adjusted_w = wire_man_a_adjusteda_dataout,
		man_a_dffe1_wi = dataa[22:0],
		man_a_dffe1_wo = man_a_dffe1_dffe1,
		man_a_not_zero_w = {(dataa[22] | man_a_not_zero_w[21]), (dataa[21] | man_a_not_zero_w[20]), (dataa[20] | man_a_not_zero_w[19]), (dataa[19] | man_a_not_zero_w[18]), (dataa[18] | man_a_not_zero_w[17]), (dataa[17] | man_a_not_zero_w[16]), (dataa[16] | man_a_not_zero_w[15]), (dataa[15] | man_a_not_zero_w[14]), (dataa[14] | man_a_not_zero_w[13]), (dataa[13] | man_a_not_zero_w[12]), (dataa[12] | man_a_not_zero_w[11]), (dataa[11] | man_a_not_zero_w[10]), (dataa[10] | man_a_not_zero_w[9]), (dataa[9] | man_a_not_zero_w[8]), (dataa[8] | man_a_not_zero_w[7]), (dataa[7] | man_a_not_zero_w[6]), (dataa[6] | man_a_not_zero_w[5]), (dataa[5] | man_a_not_zero_w[4]), (dataa[4] | man_a_not_zero_w[3]), (dataa[3] | man_a_not_zero_w[2]), (dataa[2] | man_a_not_zero_w[1]), (dataa[1] | man_a_not_zero_w[0]), dataa[0]},
		man_b_adjusted_w = {1'b1, man_b_dffe1_wo},
		man_b_dffe1_wi = datab[22:0],
		man_b_dffe1_wo = man_b_dffe1_dffe1,
		man_b_not_zero_w = {(datab[22] | man_b_not_zero_w[21]), (datab[21] | man_b_not_zero_w[20]), (datab[20] | man_b_not_zero_w[19]), (datab[19] | man_b_not_zero_w[18]), (datab[18] | man_b_not_zero_w[17]), (datab[17] | man_b_not_zero_w[16]), (datab[16] | man_b_not_zero_w[15]), (datab[15] | man_b_not_zero_w[14]), (datab[14] | man_b_not_zero_w[13]), (datab[13] | man_b_not_zero_w[12]), (datab[12] | man_b_not_zero_w[11]), (datab[11] | man_b_not_zero_w[10]), (datab[10] | man_b_not_zero_w[9]), (datab[9] | man_b_not_zero_w[8]), (datab[8] | man_b_not_zero_w[7]), (datab[7] | man_b_not_zero_w[6]), (datab[6] | man_b_not_zero_w[5]), (datab[5] | man_b_not_zero_w[4]), (datab[4] | man_b_not_zero_w[3]), (datab[3] | man_b_not_zero_w[2]), (datab[2] | man_b_not_zero_w[1]), (datab[1] | man_b_not_zero_w[0]), datab[0]},
		man_result_dffe_wi = man_result_w,
		man_result_dffe_wo = man_result_dffe,
		man_result_mux_select = (((((over_under_dffe_2 | a_zero_b_not_dffe_4) | nan_pipe_dffe_4) | b_is_infinity_dffe_4) | a_is_infinity_dffe_4) | divbyzero_pipe_dffe_4),
		man_result_w = wire_man_result_muxa_dataout,
		man_zeros_w = {23{1'b0}},
		overflow_ones_w = {8{1'b1}},
		overflow_underflow = (overflow_w | underflow_w),
		overflow_w = ((bias_addition_overf_w | ((exp_add_output_all_one[7] & (~ bias_addition_overf_w)) & (~ exp_sign_w))) & (((~ nan_pipe_dffe_1) & (~ a_is_infinity_dffe_1)) & (~ divbyzero_pipe_dffe_1))),
		quotient_accumulate_w = {quotient_k_dffe_0, {14{1'b0}}, quotient_j_dffe, {14{1'b0}}},
		quotient_process_cin_w = (round_bit & (guard_bit | sticky_bits[4])),
		remainder_j_w = {wire_remainder_sub_0_result[35:0], {14{1'b0}}, wire_a1_prod_result[34:0], {15{1'b0}}},
		result = {sign_pipe_dffe_5, exp_result_dffe_3, man_result_dffe_wo},
		round_bit = wire_q_partial_1_result[21],
		select_bias_out_2_w = wire_select_bias_2a_dataout,
		select_bias_out_w = wire_select_biasa_dataout,
		sticky_bits = {(wire_q_partial_1_result[20] | sticky_bits[3]), (wire_q_partial_1_result[19] | sticky_bits[2]), (wire_q_partial_1_result[18] | sticky_bits[1]), (wire_q_partial_1_result[17] | sticky_bits[0]), wire_q_partial_1_result[16]},
		underflow_w = ((((((~ bias_addition_overf_w) & exp_sign_w) | (((~ exp_add_output_not_zero[7]) & (~ bias_addition_overf_w)) & (~ exp_sign_w))) & (~ nan_pipe_dffe_1)) & (~ a_zero_b_not_dffe_1)) & (~ b_is_infinity_dffe_1)),
		underflow_zeros_w = {8{1'b0}},
		value_add_one_w = 9'b001111111,
		value_normal_w = 9'b001111110,
		value_zero_w = {9{1'b0}};
endmodule //fpDiv_altfp_div_pst_4fe

//synthesis_resources = altsyncram 1 lpm_add_sub 4 lpm_compare 1 lpm_mult 5 mux21 74 reg 339 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  fpDiv_altfp_div_4sh
	( 
	clk_en,
	clock,
	dataa,
	datab,
	result) ;
	input   clk_en;
	input   clock;
	input   [31:0]  dataa;
	input   [31:0]  datab;
	output   [31:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1   clk_en;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire  [31:0]   wire_altfp_div_pst1_result;
	wire aclr;

	fpDiv_altfp_div_pst_4fe   altfp_div_pst1
	( 
	.aclr(aclr),
	.clk_en(clk_en),
	.clock(clock),
	.dataa(dataa),
	.datab(datab),
	.result(wire_altfp_div_pst1_result));
	assign
		aclr = 1'b0,
		result = wire_altfp_div_pst1_result;
endmodule //fpDiv_altfp_div_4sh
//VALID FILE


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module fpDiv (
	clk_en,
	clock,
	dataa,
	datab,
	result);

	input	  clk_en;
	input	  clock;
	input	[31:0]  dataa;
	input	[31:0]  datab;
	output	[31:0]  result;

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	fpDiv_altfp_div_4sh	fpDiv_altfp_div_4sh_component (
				.clk_en (clk_en),
				.clock (clock),
				.datab (datab),
				.dataa (dataa),
				.result (sub_wire0));

endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: DENORMAL_SUPPORT STRING "NO"
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: CONSTANT: OPTIMIZE STRING "SPEED"
// Retrieval info: CONSTANT: PIPELINE NUMERIC "6"
// Retrieval info: CONSTANT: REDUCED_FUNCTIONALITY STRING "NO"
// Retrieval info: CONSTANT: WIDTH_EXP NUMERIC "8"
// Retrieval info: CONSTANT: WIDTH_MAN NUMERIC "23"
// Retrieval info: USED_PORT: clk_en 0 0 0 0 INPUT NODEFVAL "clk_en"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: dataa 0 0 32 0 INPUT NODEFVAL "dataa[31..0]"
// Retrieval info: USED_PORT: datab 0 0 32 0 INPUT NODEFVAL "datab[31..0]"
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: @clk_en 0 0 0 0 clk_en 0 0 0 0
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @dataa 0 0 32 0 dataa 0 0 32 0
// Retrieval info: CONNECT: @datab 0 0 32 0 datab 0 0 32 0
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL fpDiv.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpDiv.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpDiv.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpDiv.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpDiv_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL fpDiv_bb.v FALSE
