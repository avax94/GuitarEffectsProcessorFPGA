`define fdivs 2
`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt
`define fexps 7      //Exp


module distortion #(parameter DATA_WIDTH=16)
   (
    input                           control_key1,
    input                           clk,
    input                           rst,
    input                           cs,
    input signed [(DATA_WIDTH-1):0] data_in,

    input                           my_turn,
    output                          done,
    output [(DATA_WIDTH-1):0]       data_out
    );

   /*
    States
    */
   localparam PASSIVE = 0, DONE = 1;

   /*
    Constants
    */
   localparam MAX_POSITIVE = 16'b0111111111111111, MAX_NEGATIVE = 16'b0000000000000000;

   /*
    Variables
    */
   integer                          state = PASSIVE, state_next;
   reg signed [31:0]                gains [0:2];
   wire signed [31:0]               gain;
   reg [1:0] option_counter, option_counter_next;
   reg signed [DATA_WIDTH-1:0] clipped, clipped_next;
   reg signed [DATA_WIDTH-1:0] positive_threshold = 16'b0010101010101010;
   reg signed [DATA_WIDTH-1:0] negative_threshold = 16'b1101010101010110;

   initial begin
      state = PASSIVE;
      state_next = PASSIVE;
      option_counter= 0;
      option_counter_next = 0;
      gains[0] = 1;
      gains[1] = 4;
      gains[2] = 6;
   end

   /*
    clocked
    */
   always @(posedge clk) begin
      state <= state_next;
      clipped <= clipped_next;
      option_counter <= option_counter_next;
   end
   reg signed [DATA_WIDTH-1:0] data_in_helper;

   /*
    comb
    */
   always @(*) begin
      state_next <= state;
      clipped_next <= clipped;
      option_counter_next <= option_counter;

      if (control_key1) begin
         option_counter_next <= option_counter + 1;

         if (option_counter == 2) begin
            option_counter_next <= 0;
         end
      end

      case(state)
        PASSIVE: begin
           if (my_turn == 1 && cs == 1) begin
              state_next <= DONE;
              data_in_helper = data_in * gain;

              if (data_in_helper < positive_threshold && data_in_helper > negative_threshold) begin
                 clipped_next <= 2 * data_in_helper;
              end
              if (data_in_helper >= positive_threshold && data_in_helper < 2 * positive_threshold) begin
                 clipped_next <= MAX_POSITIVE - (2 * positive_threshold - data_in_helper) / 3;
              end
              if (data_in_helper <= negative_threshold && data_in_helper > 2 * negative_threshold) begin
                 clipped_next <= MAX_NEGATIVE - (2 * negative_threshold - data_in_helper) / 3;
              end
              if (data_in_helper >= 2 * positive_threshold) begin
                 clipped_next <= MAX_POSITIVE;
              end
              if (data_in_helper <= 2 * negative_threshold) begin
                 clipped_next <= MAX_NEGATIVE;
              end
           end
        end
        DONE: begin
           state_next <= PASSIVE;
        end
      endcase // case (state)
   end

   assign gain = gains[option_counter];
   assign data_out = clipped[DATA_WIDTH-1:0];
   assign done = state == DONE;
endmodule
