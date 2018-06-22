`define fsubs 0
`define fadds 1
`define fmuls 3
`define floatis 5   //intToFloat
`define fixsi 4      //FloatToInt

module vibrato_t
  #(
    parameter DATA_WIDTH=16,
    parameter ADDR_WIDTH = 13,
    parameter SAMPLERATE = 48000, //Hz
    parameter CLOCK_FREQ = 50, // MHz   parameter MODFREQ = 5, //Hz
    parameter DELAY = 5
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
    input [3:0]               modfreq_option, //float

    input                     my_turn,
    output                    done,
    output [(DATA_WIDTH-1):0] data_out,
    output [1:0]              state_out,
    output                    clock_out,
    output [31:0]             delay_out
    );

   // Converts offest in miliseconds to actual delay in ram memory
   function reg [ADDR_WIDTH-1:0] delay_to_off(input [31:0] dly); begin //ms;
      delay_to_off = 2 * dly * SAMPLERATE / 1000;
   end
   endfunction

   /*
    states
    */
   localparam PASSIVE = 0, READ_DELAY = 1, DONE = 2;
   /*
    Helper variables
    */
   localparam MAX_DELAY = (2 * DELAY) + 1;
   /*
    variables
    */
   reg [DATA_WIDTH-1:0] result_vibrato;
   reg                  sram_rd_reg;
   reg [ADDR_WIDTH-1:0] sram_offset_reg;
   reg [31:0]           freq_counters [0:4];
   reg                  generated_clock, generated_clock_next;
   reg                  prev_generated_clock;
   wire [31:0]          freq_counter;
   integer              delay, delay_next;
   reg                  started_action;
   reg [1:0]            state, state_next;
   integer              counter, counter_next;
   reg                  direction;
   reg                  direction_next;

   initial begin
      state = PASSIVE;
      state_next = PASSIVE;
      counter = 0;
      delay = DELAY;
      delay_next = DELAY;
      prev_generated_clock = 0;
      direction = 1;
      direction_next = 1;
      generated_clock = 0;
      // 48KHz / 5Hz / (MAX_DELAY * 2)
      freq_counters[0] = 960;
      // 48KHz / 7Hz / (MAX_DELAY)
      freq_counters[1] = 685;
      // 48KHz / 9Hz / (MAX_DELAY)
      freq_counters[2] = 533;
      // 48KHz / 11Hz / (MAX_DELAY)
      freq_counters[3] = 436;
      // 48KHz / 13Hz / (MAX_DELAY)
      freq_counters[4] = 369;
   end
   /*
    clock generator
    */
   always @(posedge clk) begin
      counter <= counter_next;
      prev_generated_clock <= generated_clock;
      generated_clock <= generated_clock_next;
      direction <= direction_next;
   end

   always @(*) begin
      delay_next <= delay;
      counter_next <= counter;
      generated_clock_next <= generated_clock;
      direction_next <= direction;

      if (my_turn) begin
	 counter_next <= counter + 1;

	 if (counter >= freq_counter)
	   begin
	      counter_next <= 0;
	   end

	 if (counter >= freq_counter) begin
	    if (generated_clock == 1) begin
	       generated_clock_next <= 0;
	    end
	    else begin
	       generated_clock_next <= 1;
	    end
	 end
      end

      // only on positive newly generated clock edge update delay
      if (prev_generated_clock == 0 && generated_clock == 1) begin
	 if (direction == 1) begin
	    delay_next <= delay + 1;
	 end
	 else begin
	    delay_next <= delay - 1;
	 end

	 if (delay >= 2 * DELAY) begin
	    direction_next <= 0;
	 end
	 else if (delay <= 0) begin
	    direction_next <= 1;
	 end
      end
   end

   always @(posedge clk) begin
      state <= state_next;
      delay <= delay_next;
   end

   always @(posedge clk) begin
      sram_rd_reg <= 0;

      case(state)
        READ_DELAY: begin
           if(started_action == 0) begin
              started_action <= 1;
              sram_rd_reg <= 1;
              // Value of delay goes from 0 to 2 * DELAY, but we want delays
              // from -DELAY to +DELAY
              sram_offset_reg <= delay_to_off(delay);
           end

           if (sram_read_finish) begin
              started_action <= 0;
              result_vibrato <= sram_data_in; // critical path
           end
        end // case: READ_DELAY
      endcase
   end

   /*
    comb
    */
   always @(*) begin
      state_next <= state;

      case(state)
        PASSIVE: begin
           if(cs == 1 && my_turn == 1) begin
              state_next <= READ_DELAY;
           end
        end
        READ_DELAY: begin
           if(sram_read_finish == 1) begin
              state_next <= DONE;
           end
        end
        DONE: begin
           state_next <= PASSIVE;
        end
      endcase
   end

   assign freq_counter = freq_counters[modfreq_option];
   assign sram_rd = sram_rd_reg;
   assign sram_offset = sram_offset_reg;
   assign data_out = result_vibrato;
   assign done = state == DONE;
   assign clock_out = generated_clock;
   assign state_out = state;
   assign delay_out = {prev_generated_clock, generated_clock} ;
endmodule
