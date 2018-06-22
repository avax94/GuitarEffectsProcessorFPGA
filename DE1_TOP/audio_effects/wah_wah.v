`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt
`define ficmp 6      //CMP


module wah_wah
  #(
    parameter DATA_WIDTH=16
    )
   (
    /* sinus interface */
    input                     sinus_done,
    input [31:0]              sinus_result,
    output [31:0]             sinus_angle,
    output                    sinus_clk_en,
    /* fpUnit interface */
    output [31:0]             fp_dataa,
    output [31:0]             fp_datab,
    output [2:0]              fp_operation,
    output                    fp_clk_en,
    input                     fp_done,
    input [31:0]              fp_result,

    input [(DATA_WIDTH-1):0]  data_in,
    input                     clk,
    input                     rst,
    input                     cs,
    input [31:0]              delta,

    input                     my_turn,
    output                    done,
    output [(DATA_WIDTH-1):0] data_out,
	 output [31:0] st,
	 output [31:0] st_next
    );

   reg [31:0]                 dataa;
   reg [31:0]                 datab;
   reg [2:0]                  operation;
   reg                        clk_enFA = 0;
   reg [31:0]                 angle;
   reg                        clk_en_sin;

   /*
    states
    */
   localparam PASSIVE = 127, CALCULATE_F1 = 1, CALCULATE_YH = 2, CALCULATE_YB = 3, CALCULATE_YL = 4, CONVERT_RESULT_TO_INT = 5, MODIFY_FREQUENCY = 6, DONE = 7;
   /*
    CALCULATE_F1 substates
    */
   localparam CALCULATE_SINUS_ANGLE = 1, CALCULATE_SINUS = 2, MULTIPLY_WITH_TWO = 3;
   /*
    CALCULATE_YH substates
    */
   localparam CONVERT_INPUT_TO_FLOAT = 1, SUB_YL_PREV = 2, SUB_YB_PREV = 3;
   /*
    CALCULATE_YB substates
    */
   localparam MULTIPLY_YH_WITH_F1 = 1, ADD_YB_PREV = 2;
   /*
    CALCULATE_YL substates
    */
   localparam MULTIPLY_YB_WITH_F1 = 1, ADD_YL_PREV = 2;
   /*
    MODIFY_FREQUENCY substates
    */
   localparam COMPARE_WITH_MINF = 1, COMPARE_WITH_MAXF = 2, MODIFY_FREQ = 3;

   /*
    Helper variables
    */
   localparam PI = 32'b01000000010010010000111111011011, TWO_FLOAT = 32'b01000000000000000000000000000000, LESS = {29'b0, 1'b1, 2'b0}, GREATER = {30'b0, 1'b1, 1'b0}, DATA_WIDTH_DIFF = 32 - DATA_WIDTH;
   integer                    state, state_next;
   integer                    substate, substate_next;
   reg [31:0]                 result_wahwah;
   reg                        started_action;

   task useFA;
      input [31:0] data1;
      input [31:0] data2;
      input [2:0]  op;
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
	      if(fp_done == 1)
		begin
		   started_action <= 0;
		   clk_enFA <= 0;
		end
	   end

	 r = fp_result;
      end
   endtask

   reg [31:0]           min_freq = 32'b00111100001010101010101010101011; // 500 / 48000
   reg [31:0]           max_freq = 32'b00111101110101010101010101010101; // 5000 / 48000
   reg [31:0]           current_frequency = 32'b00111100001010101010101010101011;
   reg [31:0]           sin_val, F1;
   reg [31:0]           yh, yb, yb_prev, yl, yl_prev;
   reg [31:0]           input_float, cont1, cmp_result;
   reg [2:0]            op, op_next;

   initial begin
      state = PASSIVE;
      state_next = PASSIVE;
      substate_next = PASSIVE;
      substate = PASSIVE;
      op = `fadds;
      op_next = `fadds;
      F1 = 0;
      angle = 0;
      sin_val = 0;
      yh = 0;
      yb = 0;
      yb_prev = 0;
      yl = 0;
      yl_prev = 0;
   end

   always @(posedge clk) begin
      state <= state_next;
      substate <= substate_next;
      op <= op_next;
   end

   always @(posedge clk) begin
      case(state)
        CALCULATE_F1: begin // F1 = 2*sin(PI*current_frequency)
           case(substate)
           CALCULATE_SINUS_ANGLE: begin
              useFA(current_frequency, PI, `fmuls, angle);
           end
           CALCULATE_SINUS: begin
	      if(started_action == 0) begin
		 clk_en_sin <= 1;
		 started_action <= 1;
	      end
	      else begin
		 if(sinus_done)  begin
		    clk_en_sin <= 0;
		    started_action <= 0;
		    sin_val <= sinus_result;
		 end
	      end
           end // case: CALCULATE_SINUS
           MULTIPLY_WITH_TWO: begin
              useFA(sin_val, TWO_FLOAT, `fmuls, F1);
           end
           endcase
        end // case: CALCULATE_F1
        CALCULATE_YH: begin // x[n] - yl[n-1] - yb[n-1]
           case(substate)
           CONVERT_INPUT_TO_FLOAT: begin
              useFA({{DATA_WIDTH_DIFF{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]}, {{DATA_WIDTH_DIFF{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]}, `floatis, input_float);
           end
           SUB_YL_PREV: begin
              useFA(input_float, yl_prev, `fsubs, cont1);
           end
           SUB_YB_PREV: begin
              useFA(cont1, yb_prev, `fsubs, yh);
           end
           endcase
        end
        CALCULATE_YB: begin // yh[n]*F1 + yb[n-1]
           case(substate)
           MULTIPLY_YH_WITH_F1: begin
              useFA(yh, F1, `fmuls, cont1);
           end
           ADD_YB_PREV: begin
              useFA(cont1, yb_prev, `fadds, yb);
           end
           endcase // case (substate)
        end
        CALCULATE_YL: begin // yb[n]*F1 + yl[n-1]
           case(substate)
           MULTIPLY_YB_WITH_F1: begin
              useFA(yb, F1, `fmuls, cont1);
           end
           ADD_YL_PREV: begin
              useFA(cont1, yl_prev, `fadds, yl);
           end
           endcase
        end
        CONVERT_RESULT_TO_INT: begin
           useFA(yb, yb, `fixsi, result_wahwah);
        end
        MODIFY_FREQUENCY: begin
           case(substate)
           COMPARE_WITH_MINF: begin
              useFA(current_frequency, min_freq, `ficmp, cmp_result);
           end
           COMPARE_WITH_MAXF: begin
              useFA(current_frequency, max_freq, `ficmp, cmp_result);
           end
           MODIFY_FREQ: begin
              useFA(current_frequency, delta, op, current_frequency);
           end
           endcase
        end
	DONE: begin
	   yb_prev <= yb;
	   yl_prev <= yl;
	end
	endcase
     end

   /*
    comb
    */
   always @(posedge clk) begin
      state_next <= state;
      substate_next <= substate;
      op_next <= op;

      case(state)
        PASSIVE: begin
	   if(cs == 1 && my_turn == 1)  begin
	      state_next <= CALCULATE_F1;
              substate_next <= CALCULATE_SINUS_ANGLE;
	   end
	end
        CALCULATE_F1: begin
           case(substate)
           CALCULATE_SINUS_ANGLE: begin
              if (fp_done) begin
                substate_next <= CALCULATE_SINUS;
              end
           end
           CALCULATE_SINUS: begin
	      if(sinus_done)  begin
	         substate_next <= MULTIPLY_WITH_TWO;
              end
           end // case: CALCULATE_SINUS
           MULTIPLY_WITH_TWO: begin
              if (fp_done) begin
                 state_next <= CALCULATE_YH;
                 substate_next <= CONVERT_INPUT_TO_FLOAT;
              end
           end
           endcase
        end // case: CALCULATE_F1
        CALCULATE_YH: begin
           case(substate)
           CONVERT_INPUT_TO_FLOAT, SUB_YL_PREV: begin
              if (fp_done) begin
                 substate_next <= substate + 1;
              end
           end
           SUB_YB_PREV: begin
              if (fp_done) begin
                 state_next <= CALCULATE_YB;
                 substate_next <= MULTIPLY_YH_WITH_F1;
              end
           end
           endcase
        end
        CALCULATE_YB: begin
           case(substate)
           MULTIPLY_YH_WITH_F1: begin
              if (fp_done) begin
                 substate_next <= ADD_YB_PREV;
              end
           end
           ADD_YB_PREV: begin
              if (fp_done) begin
                 state_next <= CALCULATE_YL;
                 substate_next <= MULTIPLY_YB_WITH_F1;
              end
           end
           endcase // case (substate)
        end
        CALCULATE_YL: begin
           case(substate)
           MULTIPLY_YB_WITH_F1: begin
              if (fp_done) begin
                 substate_next <= ADD_YL_PREV;
              end
           end
           ADD_YL_PREV: begin
              if (fp_done) begin
                 state_next <= CONVERT_RESULT_TO_INT;
              end
           end
           endcase
        end
        CONVERT_RESULT_TO_INT: begin
           if (fp_done) begin
              state_next <= MODIFY_FREQUENCY;
              substate_next <= COMPARE_WITH_MINF;
           end
        end
        MODIFY_FREQUENCY: begin
           case(substate)       //
           COMPARE_WITH_MINF: begin
              if (fp_done) begin
                 if (fp_result & LESS) begin
                    op_next <= `fadds;
                    substate_next <= MODIFY_FREQ;
                 end
                 else begin
                    substate_next <= COMPARE_WITH_MAXF;
                 end
              end
           end
           COMPARE_WITH_MAXF: begin
              if (fp_done) begin
                 if (fp_result & GREATER) begin
                    op_next <= `fsubs;
                 end

                 substate_next <= MODIFY_FREQ;
              end
           end
           MODIFY_FREQ: begin
              if (fp_done) begin
                 state_next <= DONE;
              end
           end
           endcase
        end // case: MODIFY_FREQUENCY
        DONE: begin
           state_next <= PASSIVE;
           substate_next <= PASSIVE;
        end
	endcase
     end

   assign fp_dataa = dataa;
   assign fp_datab = datab;
   assign fp_operation = operation;
   assign fp_clk_en = clk_enFA;

   assign sinus_angle = angle;
   assign sinus_clk_en = clk_en_sin;
	assign st = current_frequency;
	assign st_next = op;
   assign data_out = result_wahwah[DATA_WIDTH-1:0];
   assign done = state == DONE;
endmodule
