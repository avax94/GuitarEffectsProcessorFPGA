//TODO you have to make sure AUDIO and EFFECTS dont read/wr in same clock cycle

module echo
  #(
    parameter DATA_WIDTH=16,
    parameter ADDR_WIDTH = 12,
    parameter OFFSET = 2048,
	 parameter SAMPLERATE = 48000,
    parameter N = 3
    )
   (
    /* control signals */
    input                         offset_control_key,
    input                         gain_control_key,
    /* smart_ram interface */
    input signed [DATA_WIDTH-1:0] sram_data_in,
    input                         sram_read_finish,
    input                         sram_write_finish,
    output                        sram_wr,
    output                        sram_rd,
    output [DATA_WIDTH-1:0]       sram_data_out,
    output [(ADDR_WIDTH-1):0]     sram_offset,
    /* end */

    input                         should_save,
    input                         clk,
    input                         rst,
    input                         cs,
    input                         my_turn,
    input signed [DATA_WIDTH-1:0] data_in,
    output                        done,
    output                        available,
    output [(DATA_WIDTH-1):0]     data_out
    );

   reg signed [DATA_WIDTH-1:0]    sram_data_helper;
   reg [DATA_WIDTH-1:0]           sr_data_out, sr_data_out_next;
   reg [ADDR_WIDTH-1:0]           sr_offset, sr_offset_next;
   reg                            sr_wr, sr_wr_next;
   reg                            sr_rd, sr_rd_next;
   reg [DATA_WIDTH-1:0]           data_out_reg, data_out_reg_next;
   reg [1:0]                      state, state_next;
   reg [31:0]                     offsets [0:7];
   wire [31:0]                    offset;
   wire signed [31:0]             gain;
   reg signed [31:0]              gains [0:3];
   reg [2:0]                      offset_option_counter, offset_option_counter_next;
   reg [1:0]                      gain_option_counter, gain_option_counter_next;

/*
    states
    */
   localparam PASSIVE = 0, GETDATA_AND_CALCULATE = 1, SAVE = 2, DONE = 3;

   initial begin
      state = PASSIVE;
      offset_option_counter = 0;
      offset_option_counter_next = 0;
      gain_option_counter = 0;
      gain_option_counter_next = 0;

      offsets[0] = 50;
      offsets[1] = 75;
      offsets[2] = 100;
      offsets[4] = 125;
      offsets[5] = 150;
      offsets[6] = 175;
      offsets[7] = 200;

      gains[0] = 8;
      gains[1] = 4;
      gains[2] = 2;
      gains[3] = 1;
   end

   function reg [ADDR_WIDTH-1:0] delay_to_off(input [31:0] dly); begin //ms;
      delay_to_off = 4 * dly * SAMPLERATE / 1000; // multiply it by two cuz memory address must be even number
   end
   endfunction

   always @(*) begin
      state_next <= state;
      sr_offset_next <= sr_offset;
      sr_data_out_next <= sr_data_out;
      data_out_reg_next <= data_out_reg;
      sr_rd_next <= 0;
      sr_wr_next <= 0;
      offset_option_counter_next <= offset_option_counter;
      gain_option_counter_next <= gain_option_counter_next;

      if (offset_control_key) begin
         // its ok to just always add 1 since we only use 3 bits in this register and we have 8 values
         offset_option_counter_next <= offset_option_counter + 1;
      end

      if (gain_control_key) begin
         // its ok to just always add 1 since we only use 2 bits in this register and we have 4 values
         gain_option_counter_next <= gain_option_counter + 1;
      end

      casex(state)
        PASSIVE: begin
           if(cs == 1 && my_turn == 1) begin
              state_next <= GETDATA_AND_CALCULATE;
              // prepare for reading from sram
              sr_rd_next <= 1;
              sr_offset_next <= delay_to_off(offset);
           end
        end
        GETDATA_AND_CALCULATE: begin
           if (sram_read_finish) begin
              sram_data_helper = sram_data_in / gain;

              data_out_reg_next <= data_in + {{N{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:N]};
              state_next <= DONE;

              if (should_save)
                begin
                   sr_offset_next <= 1;
                   sr_wr_next <= 1;
                   sr_data_out_next <= data_in + {{1{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:1]};
                   state_next <= SAVE;
                end
           end
        end
        SAVE: begin
           if (sram_write_finish) begin
              state_next <= DONE;
           end
        end
        DONE: begin
           state_next <= PASSIVE;
        end
      endcase
   end
   /* Take action based on state */
   reg [(DATA_WIDTH-1):0] sum;
   integer                i;

   always @(posedge clk) begin
      offset_option_counter <= offset_option_counter_next;
      gain_option_counter <= gain_option_counter_next;
      state <= state_next;
      data_out_reg <= data_out_reg_next;
      sr_wr <= sr_wr_next;
      sr_rd <= sr_rd_next;
      sr_offset <= sr_offset_next;
      sr_data_out <= sr_data_out_next;
   end

   assign gain = gains[gain_option_counter];
   assign offset = offsets[offset_option_counter];
   assign available = state == PASSIVE;
   assign sram_offset = sr_offset;
   assign sram_wr = sr_wr;
   assign sram_rd = sr_rd;
   assign sram_data_out = sr_data_out;
   assign data_out = data_out_reg;
   assign done = state == DONE;
endmodule
