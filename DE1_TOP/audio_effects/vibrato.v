`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt


module vibrato
  #(
    parameter DATA_WIDTH=16,
    parameter ADDR_WIDTH = 13
    )
   (
    /* control interface */
    input modfreq_control_key,
    input delay_control_key,
    /* smart_ram interface */
    input [DATA_WIDTH-1:0]    sram_data_in,
    input                     sram_read_finish,
    output                    sram_rd,
    output [(ADDR_WIDTH-1):0] sram_offset,
    /* end */
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

    input                     clk,
    input                     rst,
    input                     cs,

    input                     my_turn,
    output                    done,
    output [(DATA_WIDTH-1):0] data_out,
    output [31:0]             vibrato_state_out,
    output [31:0]             vibrato_substate_out
    );

   /*
    variables
    */
   localparam NUM_TO_ADD = 1;

   reg started, started_next;
   reg [2:0] modfreq_option, modfreq_option_next;
   reg [2:0] delay_option, delay_option_next;
   reg                              my_turn_delay;
   wire [31:0]                      modfreq;
   reg [31:0]                       dataa;
   reg [31:0]                       datab;
   reg [2:0]                        operation;
   reg                              clk_enFA = 0;
   reg [31:0]                       angle;
   reg                              clk_en_sin;

   /*
    states
    */
   localparam CALCULATE_ANGLE = 0, CALCULATE_SINUS = 1, CALCULATE_DELAY = 2, READ_DELAY = 3, DONE = 4;
   /*
    CALCULATE_ANGLE substates
    */
   localparam PASSIVE = 0,  CONVERT_TO_FLOAT = 1, MULTIPLY_FIRST = 2, MULTIPLY_SECOND = 3, MULTIPLY_THIRD = 4;
   /*
    CALCULATE_DELAY substates
    */
   localparam  SINUS_DELAY = 1, CONV_TO_INT = 2, ADD = 3;

   /*
    Helper variables
    */
   localparam TWO_PI = 32'b01000000110010010000111111011011;
   integer                          state = CALCULATE_ANGLE, state_next;
   integer                          substate = CONVERT_TO_FLOAT, substate_next;
   integer                          sin_arg = 1, sin_arg_next = 1;

   reg [31:0]                       modfreqs [0:7];

   reg [DATA_WIDTH-1:0]             result_vibrato;
   reg [31:0]                       delays_float [0:7];
   reg [31:0]                       delays_int   [0:7];
   wire [31:0]                      delay_float;
   wire [31:0]                      delay_int;

   initial begin
      modfreq_option = 0;
      modfreq_option_next = 0;
      delay_option = 0;
      delay_option_next = 0;
      sin_arg = 1;
      sin_arg_next = 1;
      state = CALCULATE_ANGLE;
      state_next = CALCULATE_ANGLE;
      substate_next = PASSIVE;
      substate = PASSIVE;
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

      // Formula - DelayInMiliseconds * SampleRateInHerz / MilisecondsInSeconds
      // 5 * 48000 / 1000
      delays_int[0] = 32'b00000000000000000000000011110000;
      delays_float[0] = 32'b01000011011100000000000000000000;

      // 6 * 48000 / 1000
      delays_int[1] = 32'b00000000000000000000000100100000;
      delays_float[1] = 32'b01000011100100000000000000000000;

      // 7 * 48000 / 1000
      delays_int[2] = 32'b00000000000000000000000101010000;
      delays_float[2] = 32'b01000011101010000000000000000000;

      // 8 * 48000 / 1000
      delays_int[3] = 32'b00000000000000000000000110000000;
      delays_float[3] = 32'b01000011110000000000000000000000;

      // 9 * 48000 / 1000
      delays_int[4] = 32'b00000000000000000000000110110000;
      delays_float[4] = 32'b01000011110110000000000000000000;

      // 10 * 48000 / 1000
      delays_int[5] = 32'b00000000000000000000000111100000;
      delays_float[5] = 32'b01000011111100000000000000000000;

      // 11 * 48000 / 1000
      delays_int[6] = 32'b00000000000000000000001000010000;
      delays_float[6] = 32'b01000100000001000000000000000000;

      // 12 * 48000 / 1000
      delays_int[7] = 32'b00000000000000000000001001000000;
      delays_float[7] = 32'b01000100000100000000000000000000;
   end


   always @(posedge clk) begin
      modfreq_option <= modfreq_option_next;
      delay_option <= delay_option_next;
      state <= state_next;
      substate <= substate_next;
      sin_arg <= sin_arg_next;
   end

   reg [31:0] cont1;
   reg [31:0] cont2;
   reg [31:0] sin_val;
   reg        started_action = 0;
   reg [31:0] delay_c;

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
              clk_enFA <= 0;

              if(fp_done == 1) begin
                 started_action <= 0;
              end
           end

         r = fp_result;
      end
   endtask

   reg [31:0] first_delay, second_delay, one_f;
   reg        sram_rd_reg, sram_rd_reg_next;
   reg [ADDR_WIDTH-1:0] sram_offset_reg, sram_offset_reg_next;

   always @(posedge clk) begin
      sram_rd_reg <= 0;

      case(state)
        CALCULATE_ANGLE: begin //2*pi*counter*modfreq
           case(substate)
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
              clk_en_sin <= 0;

              if(sinus_done == 1) begin
                 clk_en_sin <= 0;
                 started_action <= 0;
                 sin_val <= sinus_result;
              end
           end
        end
        CALCULATE_DELAY: begin //1 + DELAY_IN_NUMBER_OF_SAMPLES + DELAY_IN_NUMBER_OF_SAMPLES*sin_val
           case(substate)
             SINUS_DELAY: begin
                useFA(delay_float, sin_val, `fmuls, cont1);
             end
             CONV_TO_INT: begin
                useFA(cont1, cont1, `fixsi, cont1);
             end
             ADD: begin
                delay_c <= 1 + delay_int + cont1;
             end
           endcase
        end
        READ_DELAY: begin
           if(started_action == 0) begin
              started_action <= 1;
              sram_rd_reg <= 1;

              sram_offset_reg <= delay_c * 2;
           end

           if(sram_read_finish) begin
              started_action <= 0;
              result_vibrato <= sram_data_in[DATA_WIDTH-1:0]; // critical path
           end
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
               MULTIPLY_SECOND: begin
                  if(fp_done == 1) begin
                     substate_next <= PASSIVE;
                     state_next <= CALCULATE_SINUS;
                     sin_arg_next <= sin_arg + 1; // for next input

                     if (sin_arg == 47999) begin
                        sin_arg_next <= 0;
                     end
                  end // if (fp_done == 1)
               end
             endcase
          end
          CALCULATE_SINUS: begin
             if(sinus_done == 1) begin
                state_next <= CALCULATE_DELAY;
             end
          end
          CALCULATE_DELAY: begin
             case(substate)
               PASSIVE: begin
                  substate_next <= SINUS_DELAY;
               end
               SINUS_DELAY, CONV_TO_INT: begin
                  if(fp_done == 1)
                    substate_next <= substate + 1;
               end
               ADD: begin
                  substate_next <= PASSIVE;
                  state_next <= READ_DELAY;
               end
             endcase
          end
          READ_DELAY: begin
             if(sram_read_finish == 1) begin
                substate_next <= PASSIVE;
                state_next <= DONE;
             end
          end
          DONE: begin
             state_next <= CALCULATE_ANGLE;
          end
        endcase
     end

   always @(*) begin
      modfreq_option_next <= modfreq_option;
      delay_option_next <= delay_option;

      if (modfreq_control_key) begin
         modfreq_option_next <= modfreq_option + 1;
      end
      if (delay_control_key) begin
         delay_option_next <= delay_option + 1;
      end
   end

   assign fp_dataa = dataa;
   assign fp_datab = datab;
   assign fp_operation = operation;
   assign fp_clk_en = clk_enFA;

   assign delay_int = delays_int[delay_option];
   assign delay_float = delays_float[delay_option];
   assign sinus_angle = angle;
   assign sinus_clk_en = clk_en_sin;
   assign modfreq = modfreqs[modfreq_option];
   assign sram_rd = sram_rd_reg;
   assign sram_offset = sram_offset_reg;
   assign data_out = result_vibrato[DATA_WIDTH-1:0];
   assign done = state == DONE;
   assign vibrato_state_out = sram_data_in[7:0];
   assign vibrato_substate_out = sram_data_in[15:8];
endmodule
