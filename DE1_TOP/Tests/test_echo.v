// vsim -L altera_mf_ver -L lpm_ver work.test_echo
`timescale 1 us/ 1 us
module test_echo();
   wire [15:0] sram_data_out;
   wire        sram_available;
   wire [15:0] sram_data_in;
   wire [11:0] sram_offset;
   wire        sram_wr;
   wire        sram_rd;
   wire        sram_read_finish;
   wire        sram_write_finish;
   reg         clk;
   reg         rst;
   integer     sram_i;
   reg         echo_should_save;
   reg         echo_cs;
   reg         echo_my_turn;
   reg [15:0]  echo_data_in;
   wire        echo_done;
   wire [15:0]  echo_data_out;
   reg         manual;
   reg [15:0]  manual_sram_data_in;
   reg [11:0]  manual_sram_offset;
   reg         manual_sram_wr;
   reg         manual_sram_rd;
   reg [15:0]  manual_sram_data_out;
   wire [15:0] echo_sram_data_out;
   reg         echo_sram_read_finish;
   wire        echo_sram_wr;
   wire        echo_sram_rd;
   wire [15:0] echo_sram_data_in;
   wire [11:0] echo_sram_offset;
   assign sram_data_in = manual ? manual_sram_data_in : echo_sram_data_out;
   assign sram_offset = manual ? manual_sram_offset : echo_sram_offset;
   assign sram_wr = manual ? manual_sram_wr : echo_sram_wr;
   assign sram_rd = manual ? manual_sram_rd : echo_sram_rd;

   smart_ram smv1 (
                   // port map - connectisim:/test_echo/sram_data_inon between master ports and signals/registers
	           .data_in(sram_data_in),
	           .offset(sram_offset),
	           .wr(sram_wr),
	           .rd(sram_rd),
	           .read_finish(sram_read_finish),
	           .write_finish(sram_write_finish),
	           .data_out(sram_data_out),
	           .available(sram_available),
	           .clk(clk),
	           .rst(rst)
                   );

   echo #(
          .DATA_WIDTH(16),
          .ADDR_WIDTH(12),
          .OFFSET(0))
   ech (
        /* smart_ram interface */
        .sram_data_in(sram_data_out),
	      .sram_write_finish(sram_write_finish),
        .sram_read_finish(sram_read_finish),
        .sram_wr(echo_sram_wr),
        .sram_rd(echo_sram_rd),
        .sram_data_out(echo_sram_data_out),
        .sram_offset(echo_sram_offset),
        /* end */

        .should_save(echo_should_save),
        .clk(clk),
        .rst(reset),
        .cs(echo_cs),
        .my_turn(echo_my_turn),
        .data_in(echo_data_in),
        .done(echo_done),
        .data_out(echo_data_out));

   initial begin
      rst = 1;
      #30;
      rst = 0;
      clk = 0;
   end

   always begin
      clk = ~clk;
      #2.5;
   end

   always begin
      manual = 1;
      manual_sram_data_in = 2;
      manual_sram_offset = 0;
      manual_sram_wr = 1;
      @(posedge sram_write_finish);
      manual_sram_data_in = 32;
      @(posedge sram_write_finish);
      manual_sram_data_in = 142;
      @(posedge sram_write_finish);
      manual = 0;
      manual_sram_wr = 0;
      @(posedge clk);
      echo_data_in = 142;
      echo_my_turn = 1;
      echo_cs = 1;
      echo_should_save = 0;
      @(posedge echo_done)
      echo_data_in = 142;
      echo_should_save = 1;
      @(posedge echo_done)
      echo_data_in = 200;
      echo_should_save = 1;
      @(posedge echo_done)

      $stop;
   end

endmodule
