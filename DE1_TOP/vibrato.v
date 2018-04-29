`define fdivs 2
`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt


module vibrato
#(
	parameter DATA_WIDTH=24,
	parameter ADDR_WIDTH = 12,
	parameter SAMPLERATE = 48000, //Hz
	parameter CLOCK_FREQ = 50, // MHz	parameter MODFREQ = 5, //Hz
	parameter DELAY = 5
	)
(
	/* smart_ram interface */
	input [DATA_WIDTH-1:0]    sram_data_in,
	input                     sram_read_finish,
	output                    sram_rd,
	output [(ADDR_WIDTH-1):0] sram_offset,
	/* end */

	input clk,
	input rst,
	input cs,
	input [31:0] modfreq, //float

	input my_turn,
	output done,
	output [(DATA_WIDTH-1):0] data_out
);

	function reg [ADDR_WIDTH-1:0] delay_to_off(input [31:0] dly); //ms;
	begin
		delay_to_off = dly * SAMPLERATE / 1000;
	end
	endfunction


	/*
		variables
	*/
	localparam NUM_TO_ADD = 1;

	reg started, started_next;

	reg [ADDR_WIDTH*NUM_TO_ADD-1: 0] offset_input ;
	reg my_turn_delay;

	reg [31:0] dataa;
	reg [31:0] datab;
	reg [7:0] operation;
	reg startFA = 0;
	reg clk_enFA = 0;
	wire doneFA;
	wire [31:0] resultFA;
	wire [31:0] dummyFA;
	fpUnit u0 (
	  .dataa     (dataa),     // s1.dataa
	  .datab     (datab),     //   .datab
	  .operation         (operation),         //   .n
	  .clock       (clk),
	  .clk_en    (clk_enFA),
	  .done      (doneFA),
	  .result    (resultFA)
	);

	 reg [31:0] angle;
	 wire [31:0] result_sin;
	 reg clk_en_sin;
	 wire done_sin;

	 sin s1 (
		.clock(clk),
		.data(angle),
		.result(result_sin),
		.clk_en(clk_en_sin),
		.done(done_sin)
	 );

	/*
		states
	*/
	localparam CALCULATE_ANGLE = 0, CALCULATE_SINUS = 1, INTERPRET_RESULTS = 2, INTERPOLATION = 3, DONE = 4;
	/*
		CALCULATE_ANGLE substates
	*/
	localparam PASSIVE = 0,  CONVERT_TO_FLOAT = 1, MULTIPLY_FIRST = 2, MULTIPLY_SECOND = 3, MULTIPLY_THIRD = 4;
	/*
		INTERPRET_RESULTS substates
	*/
	localparam  CONV_TO_FLOAT1 = 1, MUL_1 = 2, CONV_TO_FLOAT2 = 3, ADD_1 = 4, CONVERT_TO_INT = 5,  CONV_TO_FLOAT = 6, SUB = 7;
	/*
		INTERPOLATION substates
	*/
	localparam READ_DELAY = 1, CONV_TO_F = 2, INTER_MUL1= 3, CONV_TO_F_1 = 4, SUB_1 = 5, INTER_MUL2 = 6, INTER_ADD = 7, INTER_TOINT = 8;

	/*
		Helper variables
	*/
	localparam TWO_PI = 32'b01000000110010010000111111011011, INTERPOLATION_COUNT = 2, DATA_WIDTH_DIFF = 32 - DATA_WIDTH;
	integer state = CALCULATE_ANGLE, state_next;
	integer substate = CONVERT_TO_FLOAT, substate_next;
	integer counter, counter_next;
	integer sin_arg = 1, sin_arg_next = 1;
	reg [31:0] result_vibrato;
	always @(posedge clk)
	begin
		state <= state_next;
		substate <= substate_next;
		counter <= counter_next;
		sin_arg <= sin_arg_next;
	end

	reg [31:0] cont1;
	reg [31:0] cont2;
	reg [31:0] sin_val;
	reg started_action = 0;
	reg [31:0] zeiger;
	reg [31:0] delay_c;
	reg [31:0] frac;
	/*
		state actions
	*/

	task useFA;
		input [31:0] data1;
		input [31:0] data2;
		input [2:0] op;
		output [31:0] r;
	begin
		if(started_action == 0)
		begin
			started_action <= 1;
			dataa <= data1;
			datab <= data2;
			operation <= op;
			clk_enFA <= 1;
		end
		else
		begin
			if(doneFA == 1)
			begin
				started_action <= 0;
				clk_enFA <= 0;
				startFA <= 0;
			end
		end

		r = resultFA;
	end
	endtask

	reg [31:0] first_delay, second_delay, one_f;
	reg sram_rd_reg, sram_rd_reg_next;
	reg sram_offset_reg, sram_offset_reg_next;

	always @(posedge clk)
	begin
		sram_rd_reg <= 0;

		case(state)
		CALCULATE_ANGLE: //2*pi*counter*modfreq
		begin
			case(substate)
			CONVERT_TO_FLOAT:
			begin
				useFA(sin_arg, sin_arg, `floatis, cont1);
			end
			MULTIPLY_FIRST:
			begin
				useFA(cont1, TWO_PI, `fmuls, cont1);
			end
			MULTIPLY_SECOND:
			begin
				useFA(cont1, modfreq, `fmuls, angle);
			end
			endcase
		end
		CALCULATE_SINUS:
		begin
			if(started_action == 0)
			begin
				clk_en_sin <= 1;
				started_action <= 1;
			end
			else
			begin
				if(done_sin == 1)
				begin
					clk_en_sin <= 0;
					started_action <= 0;
					sin_val <= result_sin;
				end
			end
		end
		INTERPRET_RESULTS: //1 + DELAY + DELAY*sin_val
		begin
			case(substate)
			CONV_TO_FLOAT1:
			begin
				useFA(DELAY, DELAY, `floatis, cont1);
			end
			MUL_1:
			begin
				useFA(cont1, sin_val, `fmuls, cont1);
			end
			CONV_TO_FLOAT2:
			begin
				useFA(1+DELAY, 1+DELAY, `floatis, cont2);
			end
			ADD_1:
			begin
				useFA(cont1, cont2, `fadds, zeiger);
			end
			CONVERT_TO_INT:
			begin
				useFA(zeiger, zeiger, `fixsi, delay_c);
			end
			CONV_TO_FLOAT:
			begin
				useFA(delay_c, delay_c, `floatis, cont1);
			end
			SUB:
			begin
				useFA(zeiger, cont1, `fsubs, frac);
			end
			endcase
		end
		INTERPOLATION: //delay(x + 1) * frac + delay(x) * (1-frac)
		begin
			case(substate)
			READ_DELAY:
			begin
				if(started_action == 0)
				begin
					started_action <= 1;
					sram_rd_reg <= 1;

					if(counter == INTERPOLATION_COUNT - 1)
						sram_offset_reg <= delay_to_off(delay_c + 1);
					else
						sram_offset_reg <= delay_to_off(delay_c);
				end

				if(sram_read_finish)
				begin
					started_action <= 0;
					cont1 <= {{DATA_WIDTH_DIFF{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]}; // critical path
				end
			end
			CONV_TO_F: //int_to_float(delay)
			begin
				useFA(cont1, cont1, `floatis, cont1);
			end
			INTER_MUL1:
			begin
				useFA(cont1, frac, `fmuls, first_delay);
			end
			CONV_TO_F_1: //int_to_float(1)
			begin
				useFA(1, 1, `floatis, one_f);
			end
			SUB_1: //1-frac
			begin
				useFA(one_f, frac, `fsubs, second_delay);
			end
			INTER_MUL2: //(1-frac)*delay(x)
			begin
				useFA(second_delay, cont1, `fmuls, second_delay);
			end
			INTER_ADD:
			begin
				useFA(first_delay, second_delay, `fadds, result_vibrato);
			end
			INTER_TOINT:
			begin
				useFA(result_vibrato, result_vibrato, `fixsi, result_vibrato);
			end
			endcase
		end
		endcase
	end

	/*
		comb
	*/
	always @(*)
	begin
			state_next <= state;
			sin_arg_next <= sin_arg;
			substate_next <= substate;
			counter_next <= counter;

			case(state)
			CALCULATE_ANGLE:
			begin
				case(substate)
				PASSIVE:
				begin
					if(cs == 1 && my_turn == 1)
					begin
						substate_next <= CONVERT_TO_FLOAT;
					end
				end
				CONVERT_TO_FLOAT, MULTIPLY_FIRST:
				begin
					if(doneFA == 1)
						substate_next <= substate + 1;
				end
				MULTIPLY_SECOND:
					if(doneFA == 1)
					begin
						substate_next <= PASSIVE;
						state_next <= CALCULATE_SINUS;
						sin_arg_next <= sin_arg + 1; // for next input
					end
				endcase
			end
			CALCULATE_SINUS:
			begin
				if(done_sin == 1)
				begin
					state_next <= INTERPRET_RESULTS;
					counter_next <= INTERPOLATION_COUNT;
				end
			end
			INTERPRET_RESULTS:
			begin
				case(substate)
				PASSIVE:
				begin
					substate_next <= CONV_TO_FLOAT1;
				end
				CONV_TO_FLOAT1, MUL_1, CONV_TO_FLOAT2, ADD_1, CONVERT_TO_INT, CONV_TO_FLOAT:
				begin
					if(doneFA == 1)
						substate_next <= substate + 1;
				end
				SUB:
				begin
					if(doneFA == 1)
					begin
						substate_next <= PASSIVE;
						state_next <= INTERPOLATION;
					end
				end
				endcase
			end
			INTERPOLATION:
			begin
				case(substate)
					PASSIVE:
					begin
						substate_next <= READ_DELAY;
						counter_next <= 0;
					end
					READ_DELAY:
					begin
						if(sram_read_finish == 1)
						begin
							substate_next <= CONV_TO_F;
							counter_next <= counter + 1;
						end
					end
					CONV_TO_F:
					begin
						if(doneFA == 1)
						begin
							if(counter == INTERPOLATION_COUNT)
								substate_next <= CONV_TO_F_1;
							else
								substate_next <= INTER_MUL1;
						end
					end
					INTER_MUL1:
					begin
						if(doneFA == 1)
						begin
							substate_next <= READ_DELAY;
						end
					end
					CONV_TO_F_1, SUB_1, INTER_MUL2, INTER_ADD:
					begin
						if(doneFA == 1)
						begin
							substate_next <= substate + 1;
						end
					end
					INTER_TOINT:
					begin
						if(doneFA == 1)
						begin
							substate_next <= PASSIVE;
							state_next <= DONE;
						end
					end
					endcase
			end
			DONE:
			begin
				state_next <= CALCULATE_ANGLE;
			end
			endcase
	end

	assign sram_rd = sram_rd_reg;
	assign sram_offset = sram_offset_reg;
	assign data_out = result_vibrato;
	assign done = state == DONE;
endmodule
