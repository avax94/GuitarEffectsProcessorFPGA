`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt


module tremolo #(
                 parameter DATA_WIDTH=16,
                 parameter ADDR_WIDTH = 13
                 )
   (
    /* control signals */
    input                     alpha_control_key,
    input                     modfreq_control_key,
    input                     clk,
    input                     rst,
    input                     cs,
    input [(DATA_WIDTH-1):0]  data_in,

    input                     my_turn,
    output                    done,
    output [(DATA_WIDTH-1):0] data_out,

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
    input [31:0]              fp_result
    );
   /*
    variables
    */
   reg                        started, started_next;

   reg [31:0]                 dataa;
   reg [31:0]                 datab;
   reg [2:0]                  operation;
   reg                        clk_enFA = 0;
   reg [31:0]                 angle;
   reg                        clk_en_sin;

   /*
    states
    */
   localparam CALCULATE_ANGLE = 0, CALCULATE_SINUS = 1, MULTIPLY_SINUS_WITH_ALPHA = 2, COMPUTE_RESULT = 3, DONE = 4;
   /*
    CALCULATE_ANGLE substates
    */
   localparam PASSIVE = 0,  CONVERT_TO_FLOAT = 1, MULTIPLY_FIRST = 2, MULTIPLY_SECOND = 3;
   /*
    COMPUTE_RESULT substates
    */
   localparam  CONV_INPUT_TO_FLOAT = 1, SCALE_INPUT = 2, CONVERT_TO_INT = 3, ADD = 4;

   /*
    Helper variables
    */
   localparam TWO_PI = 32'b01000000110010010000111111011011, DATA_WIDTH_DIFF = 32 - DATA_WIDTH;
   integer                    state = CALCULATE_ANGLE, state_next;
   integer                    substate = CONVERT_TO_FLOAT, substate_next;
   integer                    sin_arg = 1, sin_arg_next = 1;
   reg [31:0]                 result_tremolo;
   reg [31:0]                 alphas [0:7];
   reg [31:0]                 modfreqs [0:7];
   wire [31:0]                modfreq;
   wire [31:0]                alpha;
   reg [2:0]                  alpha_option, alpha_option_next;
   reg [2:0]                  modfreq_option, modfreq_option_next;

   initial begin
      state = CALCULATE_ANGLE;
      state_next = CALCULATE_ANGLE;
      substate_next = PASSIVE;
      substate = PASSIVE;
      modfreq_option = 0;
      modfreq_option_next = 0;
      alpha_option = 0;
      alpha_option_next = 0;

      // 0.0
      alphas[0] = 32'b00000000000000000000000000000000;
      // 0.2
      alphas[1] = 32'b00111110010011001100110011001101;
      // 0.35
      alphas[2] = 32'b00111110101100110011001100110011;
      // 0.5
      alphas[3] = 32'b00111111000000000000000000000000;
      // 0.65
      alphas[4] = 32'b00111111001001100110011001100110;
      // 0.75
      alphas[5] = 32'b00111111010000000000000000000000;
      // 0.85
      alphas[6] = 32'b00111111010110011001100110011010;
      // 1.00
      alphas[7] = 32'b00111111100000000000000000000000;

      // 5Hz / 48KHz
      modfreqs[0] = 32'b00111000110110100111010000001101;
      // 7Hz / 48KHz
      modfreqs[1] = 32'b00111001000110001110101011010110;
      // 9Hz / 48KHz
      modfreqs[2] = 32'b00111001010001001001101110100110;
      // 11Hz / 48KHz
      modfreqs[3] = 32'b00111001011100000100110001110101;
      // 13Hz / 48KHz
      modfreqs[4] = 32'b00111001100011011111111010100010;
      // 15Hz / 48KHz
      modfreqs[5] = 32'b00111001101000111101011100001010;
      // 17Hz / 48KHz
      modfreqs[6] = 32'b00111001101110011010111101110010;
      // 20Hz / 48KHz
      modfreqs[7] = 32'b00111001110110100111010000001110;
   end

   always @(posedge clk) begin
      state <= state_next;
      substate <= substate_next;
      sin_arg <= sin_arg_next;
      modfreq_option <= modfreq_option_next;
      alpha_option <= alpha_option_next;
   end

   reg        started_action = 0;

   task useFA;
      input [31:0] data1;
      input [31:0] data2;
      input [2:0]  op;
      output [31:0] r;
      begin
         if(started_action == 0) begin

            started_action <= 1;
            dataa <= data1;
            datab <= data2;
            operation <= op;
            clk_enFA <= 1;
         end
         else begin
            clk_enFA <= 0;

            if(fp_done == 1) begin
               started_action <= 0;
            end
         end

         r = fp_result;
      end
   endtask

   reg [31:0] sin_val;
   reg [31:0] cont1;
   reg [31:0] data_in_reg;
   reg [31:0] data_in_float;
   reg [31:0] modifier;
   reg [31:0] data_in_scaled;

   always @(posedge clk) begin
      case(state)
        CALCULATE_ANGLE: begin //2*pi*counter*modfreq
           case(substate)
             PASSIVE: begin
                data_in_reg <= {{DATA_WIDTH_DIFF{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]};
             end
             CONVERT_TO_FLOAT: begin
                useFA(sin_arg, sin_arg, `floatis, cont1);
             end
             MULTIPLY_FIRST: begin
                useFA(cont1, TWO_PI, `fmuls, cont1);
             end
             MULTIPLY_SECOND: begin
                useFA(cont1, modfreq, `fmuls, angle);
             end
           endcase
        end
        CALCULATE_SINUS: begin
           if(started_action == 0) begin
              clk_en_sin <= 1;
              started_action <= 1;
           end
           else begin
              if(sinus_done == 1) begin
                 clk_en_sin <= 0;
                 started_action <= 0;
                 sin_val <= sinus_result;
              end
           end
        end
        MULTIPLY_SINUS_WITH_ALPHA: begin // alpha * sin_val
           useFA(sin_val, alpha, `fmuls, modifier);
        end
        COMPUTE_RESULT: begin
           case(substate)
             CONV_INPUT_TO_FLOAT: begin //int_to_float(data_in_reg)
                useFA(data_in_reg, data_in_reg, `floatis, data_in_float);
             end
             SCALE_INPUT: begin
                useFA(data_in_float, modifier, `fmuls, data_in_scaled);
             end
             CONVERT_TO_INT: begin
                useFA(data_in_scaled, data_in_scaled, `fixsi, data_in_scaled);
             end
             ADD: begin
                result_tremolo <= data_in_scaled + data_in_reg;
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

        case(state)
          CALCULATE_ANGLE: begin
             case(substate)
               PASSIVE: begin
                  if(cs == 1 && my_turn == 1) begin
                     substate_next <= CONVERT_TO_FLOAT;
                  end
               end
               CONVERT_TO_FLOAT, MULTIPLY_FIRST: begin
                  if(fp_done == 1)
                    substate_next <= substate + 1;
               end
               MULTIPLY_SECOND:
                 if(fp_done == 1) begin
                    substate_next <= PASSIVE;
                    state_next <= CALCULATE_SINUS;
                    sin_arg_next <= sin_arg + 1; // for next input
                 end
             endcase
          end
          CALCULATE_SINUS: begin
             if(sinus_done == 1) begin
                state_next <= MULTIPLY_SINUS_WITH_ALPHA;
             end
          end
          MULTIPLY_SINUS_WITH_ALPHA: begin
             if(fp_done == 1) begin
                state_next <= COMPUTE_RESULT;
             end
          end
          COMPUTE_RESULT: begin
             case(substate)
               PASSIVE: begin
                  substate_next <= CONV_INPUT_TO_FLOAT;
               end
               CONV_INPUT_TO_FLOAT, SCALE_INPUT, CONVERT_TO_INT: begin
                  if(fp_done == 1)
                    substate_next <= substate + 1;
               end
               ADD: begin
                  substate_next <= PASSIVE;
                  state_next <= DONE;
               end
             endcase
          end
          DONE: begin
             state_next <= CALCULATE_ANGLE;
          end
        endcase
     end

   always @(*) begin
      alpha_option_next <= alpha_option;
      modfreq_option_next <= modfreq_option;

      if (alpha_control_key) begin
         alpha_option_next <= alpha_option + 1;
      end

      if (modfreq_control_key) begin
         modfreq_option_next <= modfreq_option + 1;
      end
   end

   assign fp_dataa = dataa;
   assign fp_datab = datab;
   assign fp_operation = operation;
   assign fp_clk_en = clk_enFA;

   assign sinus_angle = angle;
   assign sinus_clk_en = clk_en_sin;

   assign alpha = alphas[alpha_option];
   assign modfreq = modfreqs[modfreq_option];
   assign data_out = result_tremolo[DATA_WIDTH-1:0];
   assign done = state == DONE;
endmodule
