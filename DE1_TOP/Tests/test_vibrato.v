// vsim -L altera_mf_ver -L lpm_ver work.test_vibrato
`timescale 1 ps/ 1 ps
module test_vibrato();
   reg clk;
   reg rst;
   reg         manual;
   reg [15:0]  manual_sram_data_in;
   reg [12:0]  manual_sram_offset;
   reg         manual_sram_wr;
   reg         manual_sram_rd;
   reg [15:0]  manual_sram_data_out;
   wire        vibrato_sram_rd;
   wire [12:0] vibrato_sram_offset;
   reg         vibrato_my_turn;
   wire        vibrato_done;
   wire [15:0] vibrato_data_out;
   wire [15:0] sram_data_in;
   wire [12:0] sram_offset;
   wire        sram_wr;
   wire        sram_rd;
   wire [15:0] sram_data_out;
   wire        sram_write_finish;
   wire        sram_read_finish;
   wire        sram_available;

   smart_ram smv1 (.data_in(sram_data_in),
                   .offset(sram_offset),
                   .wr(sram_wr),
                   .rd(sram_rd),
                   .clk(clk),
                   .rst(0),
                   .data_out(sram_data_out),
                   .write_finish(sram_write_finish),
                   .read_finish(sram_read_finish),
                   .available(sram_available));

   vibrato vibrr (.sram_data_in(sram_data_out),
                  .sram_read_finish(sram_read_finish),
                  .sram_rd(vibrato_sram_rd),
                  .sram_offset(vibrato_sram_offset),
                  .clk(clk),
                  .rst(0),
                  .cs(1),
                  .my_turn(vibrato_my_turn),
                  .done(vibrato_done),
                  .data_out(vibrato_data_out),
	          .modfreq(32'b00111000110110100111010000001110));

   assign sram_data_in = manual_sram_data_in;
   assign sram_offset = manual ? manual_sram_offset : vibrato_sram_offset;
   assign sram_wr = manual_sram_wr;
   assign sram_rd = manual ? manual_sram_rd : vibrato_sram_rd;

   initial begin
      clk = 0;
   end

   always begin
      clk = ~clk;
      #2.5;
   end

   integer     i_v;
   always begin
      //write to sram
      manual <= 1;
      manual_sram_wr <= 1;
      manual_sram_offset <= 0;

      for(i_v = 0; i_v < 1 << 13; i_v = i_v + 1)
	begin
	   manual_sram_data_in  <= i_v;
	   @(posedge sram_write_finish);
	end
      manual_sram_wr <= 0;
      manual <= 0;
      @(posedge clk);
      vibrato_my_turn <= 1;

      @(posedge vibrato_done);
      @(posedge vibrato_done);
      @(posedge vibrato_done);
      @(posedge vibrato_done);
      @(posedge vibrato_done);
      @(posedge vibrato_done);

      $stop;
   end

endmodule
