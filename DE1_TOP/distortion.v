`define fdivs 2
`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt
`define fexps 7      //Exp


module distortion #(
	         parameter DATA_WIDTH=16
                 )
   (
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
    Variables
    */
   integer state = PASSIVE, state_next;

   initial begin
      state = PASSIVE;
      state_next = PASSIVE;
   end


   reg signed [DATA_WIDTH-1:0] clipped, clipped_next;
   reg signed [DATA_WIDTH-1:0] threshold = 16'b0100000000000000;


   /*
    clocked
    */
   always @(posedge clk) begin
      state <= state_next;
      clipped <= clipped_next;
   end

   /*
    comb
    */
   always @(*) begin
      state_next <= state;
      clipped_next <= clipped;

      case(state)
	PASSIVE: begin
           if (my_turn == 1 && cs == 1) begin
              state_next <= DONE;

              if (data_in > 0 && data_in > threshold) begin
                 clipped_next <= threshold;
              end
              else if (data_in < 0 && data_in < -threshold) begin
                 clipped_next <= -threshold;
              end
              else begin
                 clipped_next <= data_in;
              end
           end
	end
	DONE: begin
           state_next <= PASSIVE;
        end
      endcase
   end

   assign data_out = clipped[DATA_WIDTH-1:0];
   assign done = state == DONE;
endmodule
