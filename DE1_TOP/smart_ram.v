module smart_ram
  #(
    // Parameter Declarations
    parameter ADDR_WIDTH = 13,
    parameter DATA_WIDTH = 16
    )
   (
    // Input Ports
    input [DATA_WIDTH-1:0]  data_in,
    input [ADDR_WIDTH-1:0]  offset,
    input                   wr,
    input                   rd,

    input                   clk,
    input                   rst,

    output [DATA_WIDTH-1:0] data_out,
    output                  write_finish,
    output                  read_finish,
    output                  available,

    /* external interface */
    output wire [15:0]      SRAM_DQ,
    output wire [17:0]      SRAM_ADDR,
    output wire             SRAM_LB_N,
    output wire             SRAM_UB_N,
    output wire             SRAM_CE_N,
    output wire             SRAM_OE_N,
    output wire             SRAM_WE_N
    );

   reg [2:0]                state, state_next;
   reg                      wrfinish, wrfinish_next, rdfinish, rdfinish_next;
   wire [ADDR_WIDTH-1:0]    address;
   wire [DATA_WIDTH-1:0]    q;
   reg                      wrreg;
   reg                      wrreg_next;
   reg                      rdreg;
   reg                      rdreg_next;
   reg [ADDR_WIDTH-1:0]     curr_address;
   reg [ADDR_WIDTH-1:0]     curr_address_next;
   reg [DATA_WIDTH-1:0]     data_out_reg;
   reg [DATA_WIDTH-1:0]     data_out_reg_next;
   reg [ADDR_WIDTH-1:0]     offset_reg, offset_reg_next;
   localparam INIT = 0, READ = 1, WRITE = 2, DONE = 3, WAITING = 4, WAITING2 = 5;

   initial begin
      curr_address = 0;
      wrreg = 0;
      rdreg = 0;
      state_next = INIT;
      data_out_reg = 0;
      data_out_reg_next = 0;
      wrreg_next = 0;
      rdreg_next = 0;
      curr_address_next = 0;
      wrfinish_next = 0;
      rdfinish_next = 0;
      state = INIT;
      wrfinish = 0;
      rdfinish = 0;
   end

   reg [DATA_WIDTH-1:0] data_ram;
   reg [DATA_WIDTH-1:0] data_ram_next;
   wire [DATA_WIDTH-1:0] data_ram_out;
   wire                  readdatavalid;

   sram
     r (
        .clk(clk),           //        clock_reset.clk
        .reset(rst),         //  clock_reset_reset.reset
        .SRAM_DQ(SRAM_DQ),       // external_interface.export
        .SRAM_ADDR(SRAM_ADDR),     //                   .export
        .SRAM_LB_N(SRAM_LB_N),     //                   .export
        .SRAM_UB_N(SRAM_UB_N),     //                   .export
        .SRAM_CE_N(SRAM_CE_N),     //                   .export
        .SRAM_OE_N(SRAM_OE_N),     //                   .export
        .SRAM_WE_N(SRAM_WE_N),     //                   .export
        .address(address),       //  avalon_sram_slave.address
        .byteenable(2'b11),    //                   .byteenable
        .read(rdreg),          //                   .read
        .write(wrreg),         //                   .write
        .writedata(data_ram),     //                   .writedata
        .readdata(data_ram_out),      //                   .readdata
        .readdatavalid(readdatavalid)  //                   .readdatavalid
        );

   always @(*) begin
      wrfinish_next <= 0;
      rdfinish_next <= 0;
      state_next <= state;
      wrreg_next <= wrreg;
      rdreg_next <= rdreg;
      data_ram_next <= data_ram;
      data_out_reg_next <= data_out_reg;
      curr_address_next <= curr_address;
      offset_reg_next <= offset_reg;

      if(state == INIT) begin
         if(wr == 1) begin
            offset_reg_next <= offset;
            wrreg_next <= 1;
            state_next <= WRITE;
            data_ram_next <= data_in;
         end
         else if(rd == 1) begin

            offset_reg_next <= offset + 2;
            rdreg_next <= 1;
            state_next <= WAITING;
         end
      end
      else if (state == WAITING) begin
         state_next <= WAITING2;
      end
      else if (state == WAITING2) begin
         state_next <= READ;
      end
      else if(state == READ) begin
         data_out_reg_next <= data_ram_out;
         state_next <= DONE;
      end
      else if(state == WRITE) begin
         state_next <= DONE;
         wrreg_next <= 0;

         if (offset_reg == 0) begin
            curr_address_next <= curr_address + 2;
         end
      end
      else if(state == DONE) begin
         state_next <= INIT;
         wrfinish_next <= 1;
         rdfinish_next <= 1;
      end
   end

   always @(posedge clk) begin
      state <= state_next;
      offset_reg <= offset_reg_next;
      data_ram <= data_ram_next;
      wrreg <= wrreg_next;
      rdreg <= rdreg_next;
      data_out_reg <= data_out_reg_next;
      curr_address <= curr_address_next;
      rdfinish <= rdfinish_next;
      wrfinish <= wrfinish_next;
   end

   wire [ADDR_WIDTH:0] address_calculated;
   assign write_finish = wrfinish;
   assign read_finish = rdfinish;
   assign data_out = data_out_reg;
   // multiply by two because we are writing 16 bit data in 8 bit locations
   assign address_calculated = (curr_address - offset_reg);
   assign address = curr_address - offset_reg;
   assign available = state == INIT;
endmodule
