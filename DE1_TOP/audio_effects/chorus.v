module chorus
  #(
    parameter DATA_WIDTH=16,
    parameter ADDR_WIDTH = 13,
    parameter SAMPLERATE = 48000,
    parameter N = 10
    )
   (
    /* smart_ram interface */
    input [DATA_WIDTH-1:0]    sram_data_in,
    input                     sram_read_finish,
    output                    sram_rd,
    output [(ADDR_WIDTH-1):0] sram_offset,
    /* end */

    input                     clk,
    input                     rst,
    input                     cs,
    input                     my_turn,
    input [DATA_WIDTH-1:0]    data_in,
    output                    done,
    output [(DATA_WIDTH-1):0] data_out
    );

   function reg [ADDR_WIDTH-1:0] delay_to_off(input [31:0] dly); begin //ms;
      delay_to_off = 2 * dly * SAMPLERATE / 1000; // multiply it by two cuz memory address must be even number
   end
   endfunction

   reg [ADDR_WIDTH-1:0] sr_offset, sr_offset_next;
   reg                  sr_rd, sr_rd_next;
   reg [DATA_WIDTH + 2 - 1:0] data_out_reg, data_out_reg_next;

   localparam PASSIVE = 0, GET_FIRST = 1, GET_SECOND = 2, GET_THIRD = 3, DONE = 4;

   reg [2:0]                  state, state_next;
   reg [3:0]                  index_first, index_second, index_third;
   integer                    counter;
   /*
    Array of Delays between 10 and 25 ms
    */

   integer                    i;
   reg [ADDR_WIDTH-1:0]       delays [0:15];
   initial begin
      state = PASSIVE;
      for (i=0;i<16;i=i+1)
        delays[i] = delay_to_off(i + 10);

      // Pick random 3 initial values
      index_first = 3;
      index_second = 8;
      index_third = 13;
      counter = N;
   end

   /*
    sync
    */
   always @(posedge clk) begin
      if (state == DONE) begin
         counter <= counter - 1;
         if (counter == 0) begin
            counter <= N;
            index_first <= (index_first + 2) % 16;
            index_second <= (index_second - 4) % 16;
            index_third <= (index_third + 1) % 16;
         end
      end
   end

   always @(posedge clk) begin
      state <= state_next;
      data_out_reg <= data_out_reg_next;
      sr_rd <= sr_rd_next;
      sr_offset <= sr_offset_next;
   end

   /*
    comb
    */
   always @(*) begin
      state_next <= state;
      sr_offset_next <= sr_offset;
      data_out_reg_next <= data_out_reg;
      sr_rd_next <= 0;

      casex(state)
        PASSIVE: begin
           if(cs == 1 && my_turn == 1) begin
              state_next <= GET_FIRST;
              data_out_reg_next <= {{2{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]};

              // prepare for reading from sram for first vocal
              sr_rd_next <= 1;
              sr_offset_next <= delays[index_first];
           end
        end
        GET_FIRST: begin
           if (sram_read_finish) begin
              state_next <= GET_SECOND;
              data_out_reg_next <= data_out_reg + {{2{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]};

              // prepare for reading from sram for second vocal
              sr_rd_next <= 1;
              sr_offset_next <= delays[index_second];
           end
        end
        GET_SECOND: begin
           if (sram_read_finish) begin
              data_out_reg_next <= data_out_reg + {{2{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]};
              state_next <= GET_THIRD;

              // prepare for reading from sram for third vocal
              sr_rd_next <= 1;
              sr_offset_next <= delays[index_third];
           end
        end
        GET_THIRD: begin
           if (sram_read_finish) begin
              data_out_reg_next <= data_out_reg + {{2{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]};
              state_next <= DONE;
           end
        end
        DONE: begin
           state_next <= PASSIVE;
        end
      endcase
   end

   assign sram_offset = sr_offset;
   assign sram_rd = sr_rd;
   assign data_out = data_out_reg[DATA_WIDTH+2-1:2];
   assign done = state == DONE;
endmodule
