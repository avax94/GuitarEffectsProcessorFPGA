// --------------------------------------------------------------------
// Copyright (c) 2005 by Terasic Technologies Inc.
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development
//   Kits made by Terasic.  Other use of this code, including the selling
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use
//   or functionality of this code.
//
// --------------------------------------------------------------------
//
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:     DE1 TOP LEVEL
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 06/04/24  :|      Initial Revision
// --------------------------------------------------------------------

module DE1_TOP
  (
   ////////////////////         Clock Input             ////////////////////
   CLOCK_24,                                            //      24 MHz
   CLOCK_27,                                            //      27 MHz
   CLOCK_50,                                            //      50 MHz
   EXT_CLOCK,                                           //      External Clock
   ////////////////////         Push Button             ////////////////////
   KEY,                                                         //      Pushbutton[3:0]
   ////////////////////         DPDT Switch             ////////////////////
   SW,                                                          //      Toggle Switch[9:0]
   ////////////////////         7-SEG Dispaly   ////////////////////
   HEX0,                                                        //      Seven Segment Digit 0
   HEX1,                                                        //      Seven Segment Digit 1
   HEX2,                                                        //      Seven Segment Digit 2
   HEX3,                                                        //      Seven Segment Digit 3
   ////////////////////////     LED             ////////////////////////
   LEDG,                                                        //      LED Green[7:0]
   LEDR,                                                        //      LED Red[9:0]
   ////////////////////////     UART    ////////////////////////
   UART_TXD,                                            //      UART Transmitter
   UART_RXD,                                            //      UART Receiver
   /////////////////////        SDRAM Interface                 ////////////////
   DRAM_DQ,                                             //      SDRAM Data bus 16 Bits
   DRAM_ADDR,                                           //      SDRAM Address bus 12 Bits
   DRAM_LDQM,                                           //      SDRAM Low-byte Data Mask
   DRAM_UDQM,                                           //      SDRAM High-byte Data Mask
   DRAM_WE_N,                                           //      SDRAM Write Enable
   DRAM_CAS_N,                                          //      SDRAM Column Address Strobe
   DRAM_RAS_N,                                          //      SDRAM Row Address Strobe
   DRAM_CS_N,                                           //      SDRAM Chip Select
   DRAM_BA_0,                                           //      SDRAM Bank Address 0
   DRAM_BA_1,                                           //      SDRAM Bank Address 0
   DRAM_CLK,                                            //      SDRAM Clock
   DRAM_CKE,                                            //      SDRAM Clock Enable
   ////////////////////         Flash Interface                 ////////////////
   FL_DQ,                                                       //      FLASH Data bus 8 Bits
   FL_ADDR,                                             //      FLASH Address bus 22 Bits
   FL_WE_N,                                             //      FLASH Write Enable
   FL_RST_N,                                            //      FLASH Reset
   FL_OE_N,                                             //      FLASH Output Enable
   FL_CE_N,                                             //      FLASH Chip Enable
   ////////////////////         SRAM Interface          ////////////////
   SRAM_DQ,                                             //      SRAM Data bus 16 Bits
   SRAM_ADDR,                                           //      SRAM Address bus 18 Bits
   SRAM_UB_N,                                           //      SRAM High-byte Data Mask
   SRAM_LB_N,                                           //      SRAM Low-byte Data Mask
   SRAM_WE_N,                                           //      SRAM Write Enable
   SRAM_CE_N,                                           //      SRAM Chip Enable
   SRAM_OE_N,                                           //      SRAM Output Enable
   ////////////////////         SD_Card Interface       ////////////////
   SD_DAT,                                                      //      SD Card Data
   SD_DAT3,                                             //      SD Card Data 3
   SD_CMD,                                                      //      SD Card Command Signal
   SD_CLK,                                                      //      SD Card Clock
   ////////////////////         USB JTAG link   ////////////////////
   TDI,                                                         // CPLD -> FPGA (data in)
   TCK,                                                         // CPLD -> FPGA (clk)
   TCS,                                                         // CPLD -> FPGA (CS)
   TDO,                                                         // FPGA -> CPLD (data out)
   ////////////////////         I2C             ////////////////////////////
   I2C_SDAT,                                            //      I2C Data
   I2C_SCLK,                                            //      I2C Clock
   ////////////////////         PS2             ////////////////////////////
   PS2_DAT,                                             //      PS2 Data
   PS2_CLK,                                             //      PS2 Clock
   ////////////////////         VGA             ////////////////////////////
   VGA_HS,                                                      //      VGA H_SYNC
   VGA_VS,                                                      //      VGA V_SYNC
   VGA_R,                                               //      VGA Red[3:0]
   VGA_G,                                                       //      VGA Green[3:0]
   VGA_B,                                               //      VGA Blue[3:0]
   ////////////////     Audio CODEC             ////////////////////////
   AUD_ADCLRCK,                                         //      Audio CODEC ADC LR Clock
   AUD_ADCDAT,                                          //      Audio CODEC ADC Data
   AUD_DACLRCK,                                         //      Audio CODEC DAC LR Clock
   AUD_DACDAT,                                          //      Audio CODEC DAC Data
   AUD_BCLK,                                            //      Audio CODEC Bit-Stream Clock
   AUD_XCK,                                             //      Audio CODEC Chip Clock
   ////////////////////         GPIO    ////////////////////////////
   GPIO_0,                                                      //      GPIO Connection 0
   GPIO_1                                                       //      GPIO Connection 1
   );

   ////////////////////////     Clock Input             ////////////////////////
  input         [1:0]   CLOCK_24;                               //      24 MHz
   input [1:0]          CLOCK_27;                               //      27 MHz
   input                CLOCK_50;                               //      50 MHz
   input                EXT_CLOCK;                              //      External Clock
   ////////////////////////     Push Button             ////////////////////////
   input [3:0]          KEY;                                    //      Pushbutton[3:0]
   ////////////////////////     DPDT Switch             ////////////////////////
   input [9:0]          SW;                                             //      Toggle Switch[9:0]
   ////////////////////////     7-SEG Dispaly   ////////////////////////
   output [6:0]         HEX0;                                   //      Seven Segment Digit 0
   output [6:0]         HEX1;                                   //      Seven Segment Digit 1
   output [6:0]         HEX2;                                   //      Seven Segment Digit 2
   output [6:0]         HEX3;                                   //      Seven Segment Digit 3
   ////////////////////////////         LED             ////////////////////////////
   output [7:0]         LEDG;                                   //      LED Green[7:0]
   output [9:0]         LEDR;                                   //      LED Red[9:0]
   ////////////////////////////         UART    ////////////////////////////
   output               UART_TXD;                               //      UART Transmitter
   input                UART_RXD;                               //      UART Receiver
   ///////////////////////              SDRAM Interface         ////////////////////////
   inout [15:0]         DRAM_DQ;                                //      SDRAM Data bus 16 Bits
   output [11:0]        DRAM_ADDR;                              //      SDRAM Address bus 12 Bits
   output               DRAM_LDQM;                              //      SDRAM Low-byte Data Mask
   output               DRAM_UDQM;                              //      SDRAM High-byte Data Mask
   output               DRAM_WE_N;                              //      SDRAM Write Enable
   output               DRAM_CAS_N;                             //      SDRAM Column Address Strobe
   output               DRAM_RAS_N;                             //      SDRAM Row Address Strobe
   output               DRAM_CS_N;                              //      SDRAM Chip Select
   output               DRAM_BA_0;                              //      SDRAM Bank Address 0
   output               DRAM_BA_1;                              //      SDRAM Bank Address 0
   output               DRAM_CLK;                               //      SDRAM Clock
   output               DRAM_CKE;                               //      SDRAM Clock Enable
   ////////////////////////     Flash Interface         ////////////////////////
   inout [7:0]          FL_DQ;                                  //      FLASH Data bus 8 Bits
   output [21:0]        FL_ADDR;                                //      FLASH Address bus 22 Bits
   output               FL_WE_N;                                //      FLASH Write Enable
   output               FL_RST_N;                               //      FLASH Reset
   output               FL_OE_N;                                //      FLASH Output Enable
   output               FL_CE_N;                                //      FLASH Chip Enable
   ////////////////////////     SRAM Interface  ////////////////////////
   inout [15:0]         SRAM_DQ;                                //      SRAM Data bus 16 Bits
   output [17:0]        SRAM_ADDR;                              //      SRAM Address bus 18 Bits
   output               SRAM_UB_N;                              //      SRAM High-byte Data Mask
   output               SRAM_LB_N;                              //      SRAM Low-byte Data Mask
   output               SRAM_WE_N;                              //      SRAM Write Enable
   output               SRAM_CE_N;                              //      SRAM Chip Enable
   output               SRAM_OE_N;                              //      SRAM Output Enable
   ////////////////////         SD Card Interface       ////////////////////////
   inout                SD_DAT;                                         //      SD Card Data
   inout                SD_DAT3;                                //      SD Card Data 3
   inout                SD_CMD;                                         //      SD Card Command Signal
   output               SD_CLK;                                         //      SD Card Clock
   ////////////////////////     I2C             ////////////////////////////////
   inout                I2C_SDAT;                               //      I2C Data
   output               I2C_SCLK;                               //      I2C Clock
   ////////////////////////     PS2             ////////////////////////////////
   input                PS2_DAT;                                //      PS2 Data
   input                PS2_CLK;                                //      PS2 Clock
   ////////////////////         USB JTAG link   ////////////////////////////
   input                TDI;                                    // CPLD -> FPGA (data in)
   input                TCK;                                    // CPLD -> FPGA (clk)
   input                TCS;                                    // CPLD -> FPGA (CS)
   output               TDO;                                    // FPGA -> CPLD (data out)
   ////////////////////////     VGA                     ////////////////////////////
   output               VGA_HS;                                         //      VGA H_SYNC
   output               VGA_VS;                                         //      VGA V_SYNC
   output [3:0]         VGA_R;                                  //      VGA Red[3:0]
   output [3:0]         VGA_G;                                  //      VGA Green[3:0]
   output [3:0]         VGA_B;                                  //      VGA Blue[3:0]
   ////////////////////         Audio CODEC             ////////////////////////////
   inout                AUD_ADCLRCK;                    //      Audio CODEC ADC LR Clock
   input                AUD_ADCDAT;                             //      Audio CODEC ADC Data
   inout                AUD_DACLRCK;                    //      Audio CODEC DAC LR Clock
   output               AUD_DACDAT;                             //      Audio CODEC DAC Data
   inout                AUD_BCLK;                               //      Audio CODEC Bit-Stream Clock
   output               AUD_XCK;                                //      Audio CODEC Chip Clock
   ////////////////////////     GPIO    ////////////////////////////////
   inout [35:0]         GPIO_0;                                         //      GPIO Connection 0
   inout [35:0]         GPIO_1;                                         //      GPIO Connection 1

   function reg [6:0] digit_to_display(input [3:0] digit); begin
      casex(digit)
        0: begin
          //                    6543210
          digit_to_display = 7'b1000000;
        end
        1: begin
          //                    6543210
          digit_to_display = 7'b1111001;
        end
        2: begin
          //                    6543210
          digit_to_display = 7'b0100100;
        end
        3: begin
          //                    6543210
          digit_to_display = 7'b0110000;
        end
        4: begin
          //                    6543210
          digit_to_display = 7'b0011001;
        end
        5: begin
          //                    6543210
          digit_to_display = 7'b0010010;
        end
        6: begin
          //                    6543210
          digit_to_display = 7'b0000010;
        end
        7: begin
          //                    6543210
          digit_to_display = 7'b1111000;
        end
        8: begin
          //                    6543210
          digit_to_display = 7'b0000000;
        end
        9: begin
          //                    6543210
          digit_to_display = 7'b0011000;
        end
      endcase
   end
   endfunction

   //   All inout port turn to tri-state
   assign       DRAM_DQ                 =       16'hzzzz;
   assign       FL_DQ           =       8'hzz;
   assign       SRAM_DQ                 =       16'hzzzz;
   assign       SD_DAT          =       1'bz;
   assign       I2C_SDAT        =       1'bz;
   assign       AUD_ADCLRCK     =       1'bz;
   assign       AUD_DACLRCK     =       1'bz;
   assign       AUD_BCLK        =       1'bz;
   assign       GPIO_0          =       36'hzzzzzzzzz;
   assign       GPIO_1          =       36'hzzzzzzzzz;

   /* Initialize helper modules */
   wire [31:0]          fpu_dataa;
   wire [31:0]          fpu_datab;
   wire [2:0]           fpu_operation;
   wire                 fpu_clk_en;
   wire                 fpu_done;
   wire [31:0]          fpu_result;
   wire                 reset = ~KEY[1];
   fpUnit u0 (
              .dataa(fpu_dataa),
              .datab(fpu_datab),
              .operation(fpu_operation),
              .clock(CLOCK_50),
              .clk_en(fpu_clk_en),
              .done(fpu_done),
              .result(fpu_result)
              );

   wire                 sinus_clk_en_value;
   wire [31:0]          sinus_data_value;
   wire [31:0]          sinus_result_value;
   wire                 sinus_done_value;
   sin iSinus (
               .clock(CLOCK_50),
               .clk_en(sinus_clk_en_value),
               .data(sinus_data_value),
               .result(sinus_result_value),
               .done(sinus_done_value)
               );

   wire                 sram_available;
   wire [DATA_WIDTH-1:0] sram_data_in;
   reg [DATA_WIDTH-1:0]  sram_data_in_reg, sram_data_in_reg_next;
   wire [ADDR_WIDTH-1:0] sram_offset;
   reg                   sram_offset_reg, sram_offset_reg_next;
   reg                   sram_wr_reg, sram_wr_reg_next;
   reg                   sram_rd_reg, sram_rd_reg_next;
   wire [DATA_WIDTH-1:0] sram_data_out;
   wire                  sram_wr;
   wire                  sram_rd;
   wire                  sram_read_finish;
   wire                  sram_write_finish;

   smart_ram
     #(.ADDR_WIDTH(ADDR_WIDTH),
       .DATA_WIDTH(DATA_WIDTH))
   smv1 (.data_in(sram_data_in),
         .offset(sram_offset),
         .wr(sram_wr),
         .rd(sram_rd),
         .read_finish(sram_read_finish),
         .write_finish(sram_write_finish),
         .data_out(sram_data_out),
         .available(sram_available),
         .clk(CLOCK_50),
         .rst(reset),
         /* external interface */
         .SRAM_DQ(SRAM_DQ),
         .SRAM_ADDR(SRAM_ADDR),
         .SRAM_LB_N(SRAM_LB_N),
         .SRAM_UB_N(SRAM_UB_N),
         .SRAM_CE_N(SRAM_CE_N),
         .SRAM_OE_N(SRAM_OE_N),
         .SRAM_WE_N(SRAM_WE_N)
         );

   /* Initialize audio codec */
   reg [DATA_WIDTH-1:0]  writedata_left;
   reg [DATA_WIDTH-1:0]  writedata_right;
   wire                  valid_w_left, valid_w_right;
   wire                  ready_w_left, ready_w_right;
   wire [DATA_WIDTH-1:0] readdata_left;
   wire [DATA_WIDTH-1:0] readdata_right;
   wire                  ready_left_adc;
   wire                  ready_right_adc;
   wire                  valid_left;
   wire                  valid_right;

   audio_core ac(
                 .clk(CLOCK_50),                          //                 clock_reset.clk
                 .reset(reset),                        //           clock_reset_reset.reset
                 .from_adc_left_channel_ready(ready_left_adc),  //  avalon_left_channel_source.ready
                 .from_adc_left_channel_data(readdata_left),   //                            .data
                 .from_adc_left_channel_valid(valid_left),  //                            .valid
                 .from_adc_right_channel_ready(ready_right_adc), // avalon_right_channel_source.ready
                 .from_adc_right_channel_data(readdata_right),  //                            .data
                 .from_adc_right_channel_valid(valid_right), //                            .valid
                 .to_dac_left_channel_data(writedata_left),     //    avalon_left_channel_sink.data
                 .to_dac_left_channel_valid(valid_w_left),    //                            .valid
                 .to_dac_left_channel_ready(ready_w_left),    //                            .ready
                 .to_dac_right_channel_data(writedata_right),    //   avalon_right_channel_sink.data
                 .to_dac_right_channel_valid(valid_w_right),   //                            .valid
                 .to_dac_right_channel_ready(ready_w_right),   //                            .ready
                 .AUD_ADCDAT(AUD_ADCDAT),                   //          external_interface.export
                 .AUD_ADCLRCK(AUD_ADCLRCK),                  //                            .export
                 .AUD_BCLK(AUD_BCLK),                     //                            .export
                 .AUD_DACDAT(AUD_DACDAT),                   //                            .export
                 .AUD_DACLRCK(AUD_DACLRCK)                   //                            .export
                 );

   av_config avconfig (
                       .clk(CLOCK_50),         //            clock_reset.clk
                       .reset(reset),       //      clock_reset_reset.reset
                       .I2C_SDAT(I2C_SDAT),    //     external_interface.export
                       .I2C_SCLK(I2C_SCLK)    //                       .export
                       );

   audio_clock_gen gen (
                        .CLOCK_50(CLOCK_50),    //       clk_in_primary.clk
                        .reset(reset),       // clk_in_primary_reset.reset
                        .CLOCK_27(CLOCK_27),    //     clk_in_secondary.clk
                        .AUD_CLK(AUD_XCK)      //            audio_clk.clk
                        );

   /*
    Initialize distortion effect
    */
   wire                  distortion_done;
   wire [DATA_WIDTH-1:0] distortion_data_out;
   wire [1:0]            distortion_available_options;
   wire [2:0]            distortion_control;

   distortion #(
                .DATA_WIDTH(DATA_WIDTH)
                )
   distt (
          .available_options(distortion_available_options),
          .distortion_option_output(distortion_control),
          .control_key1(current_selection == DISTORTION_CONTROL && rising_edge_button2),
          .cs(SW[7]      ),
          .my_turn(state_left_prev == WAHWAH && state_left == DISTORTION),
          .data_in(data_left_r),
          // 2000 / (48000 * 48000)
          .done(distortion_done),
          .data_out(distortion_data_out),
          .clk(CLOCK_50),
          .rst(0)
          );
//   wire                  distortion_sram_rd;
//   wire                  distortion_done;
//   wire [DATA_WIDTH-1:0] distortion_data_out;
//   wire [31:0]           distortion_fp_dataa;
//   wire [31:0]           distortion_fp_datab;
//   wire [2:0]            distortion_fp_operation;
//   wire                  distortion_fp_clk_en;
//
//   distortion_sigmoid #(.DATA_WIDTH(DATA_WIDTH),
//             .ADDR_WIDTH(ADDR_WIDTH)
//                        )
//   ds (.modfreq_control_key(current_selection == DISTORTION_CONTROL && rising_edge_button2),
//       .delay_control_key(current_selection == DISTORTION_CONTROL && rising_edge_button3),
//       .clk(CLOCK_50),
//       .rst(reset),
//       .cs(SW[7]),
//       .my_turn(state_left_prev == WAHWAH && state_left == DISTORTION),
//       .done(distortion_done),
//       .data_in(data_left_r),
//       .data_out(distortion_data_out),
//       .fp_dataa(distortion_fp_dataa),
//       .fp_datab(distortion_fp_datab),
//       .fp_operation(distortion_fp_operation),
//       .fp_clk_en(distortion_fp_clk_en),
//       .fp_done(fpu_done),
//       .fp_result(fpu_result)
//       );


   /*
    Initialize wahwah effect
    */
   wire                  wahwah_done;
   wire [DATA_WIDTH-1:0] wahwah_data_out;
   wire [31:0]           wahwah_sinus_angle;
   wire                  wahwah_sinus_clk_en;
   wire [31:0]           wahwah_fp_dataa;
   wire [31:0]           wahwah_fp_datab;
   wire [2:0]            wahwah_fp_operation;
   wire                  wahwah_fp_clk_en;
   wire [31:0]           stt, substt;
   wire [1:0]            wahwah_available_options;
   wire [2:0]            wahwah_freq_option;
   wire [2:0]            wahwah_delta_option;

   wah_wah #(
             .DATA_WIDTH(DATA_WIDTH)
             )
   wahwah (.freq_option_output(wahwah_freq_option),
           .delta_option_output(wahwah_delta_option),
           .available_options(wahwah_available_options),
           .freq_control_key(current_selection == WAHWAH_CONTROL && rising_edge_button2),
           .delta_control_key(current_selection == WAHWAH_CONTROL && rising_edge_button3),
           .sinus_done(sinus_done_value),
           .sinus_result(sinus_result_value),
           .sinus_angle(wahwah_sinus_angle),
           .sinus_clk_en(wahwah_sinus_clk_en),
           .cs(SW[6]),
           .my_turn(state_left_prev == TREMOLO && state_left == WAHWAH),
           .data_in(data_left_r),
           .done(wahwah_done),
           .data_out(wahwah_data_out),
           .clk(CLOCK_50),
           .rst(0),
           .fp_dataa(wahwah_fp_dataa),
           .fp_datab(wahwah_fp_datab),
           .fp_operation(wahwah_fp_operation),
           .fp_clk_en(wahwah_fp_clk_en),
           .fp_done(fpu_done),
           .fp_result(fpu_result),
           .st(stt),
           .st_next(substt)
           );
   /*
    Initialize tremolo effect
    */
   wire [1:0]            tremolo_available_options;
   wire                  tremolo_done;
   wire [DATA_WIDTH-1:0] tremolo_data_out;
   wire [31:0]           tremolo_sinus_angle;
   wire                  tremolo_sinus_clk_en;
   wire [31:0]           tremolo_fp_dataa;
   wire [31:0]           tremolo_fp_datab;
   wire [2:0]            tremolo_fp_operation;
   wire                  tremolo_fp_clk_en;
   wire [2:0]            tremolo_alpha_option;
   wire [2:0]            tremolo_modfreq_option;
   tremolo #(
             .DATA_WIDTH(DATA_WIDTH),
             .ADDR_WIDTH(ADDR_WIDTH)
             )
   tremolo (.alpha_option_output(tremolo_alpha_option),
            .modfreq_option_output(tremolo_modfreq_option),
            .available_options(tremolo_available_options),
            .alpha_control_key(current_selection == TREMOLO_CONTROL && rising_edge_button2),
            .modfreq_control_key(current_selection == TREMOLO_CONTROL && rising_edge_button3),
            .sinus_done(sinus_done_value),
            .sinus_result(sinus_result_value),
            .sinus_angle(tremolo_sinus_angle),
            .sinus_clk_en(tremolo_sinus_clk_en),
            .cs(SW[5]),
            .my_turn(state_left_prev == CHORUS && state_left == TREMOLO),
            .data_in(data_left_r),
            .done(tremolo_done),
            .data_out(tremolo_data_out),
            .clk(CLOCK_50),
            .rst(0),
            .fp_dataa(tremolo_fp_dataa),
            .fp_datab(tremolo_fp_datab),
            .fp_operation(tremolo_fp_operation),
            .fp_clk_en(tremolo_fp_clk_en),
            .fp_done(fpu_done),
            .fp_result(fpu_result)
            );

   /*
    Initialize chorus effect
    */
   wire [1:0]            chorus_available_options;
   wire                  chorus_sram_rd;
   wire                  chorus_done;
   wire [ADDR_WIDTH-1:0] chorus_sram_offset;
   wire [DATA_WIDTH-1:0] chorus_data_out;
   chorus #(
            .DATA_WIDTH(DATA_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .SAMPLERATE(48000),
            .N(50000)
            )
   ch (
       .available_options(chorus_available_options),
       .sram_data_in(sram_data_out),
       .sram_read_finish(sram_read_finish),
       .sram_rd(chorus_sram_rd),
       .sram_offset(chorus_sram_offset),
       .cs(SW[4]),
       .my_turn(state_left_prev == VIBRATO && state_left == CHORUS),
       .data_in(data_left_r),
       .done(chorus_done),
       .data_out(chorus_data_out),
       .clk(CLOCK_50),
       .rst(0)
       );


   /*
    Initialize vibrato effect
    */
   wire [1:0]            vibrato_available_options;
   wire                  vibrato_sram_rd;
   wire                  vibrato_done;
   wire [ADDR_WIDTH-1:0] vibrato_sram_offset;
   wire [DATA_WIDTH-1:0] vibrato_data_out;
   wire [31:0]           vibrato_sinus_angle;
   wire                  vibrato_sinus_clk_en;
   wire [31:0]           vibrato_fp_dataa;
   wire [31:0]           vibrato_fp_datab;
   wire [2:0]            vibrato_fp_operation;
   wire                  vibrato_fp_clk_en;
   wire [2:0]            vibrato_modfreq_option;
   wire [2:0]            vibrato_delay_option;

   vibrato #(.DATA_WIDTH(DATA_WIDTH),
             .ADDR_WIDTH(ADDR_WIDTH)
             )
   vib (.available_options(vibrato_available_options),
        .modfreq_control_key(current_selection == VIBRATO_CONTROL && rising_edge_button2),
        .delay_control_key(current_selection == VIBRATO_CONTROL && rising_edge_button3),
        .modfreq_option_output(vibrato_modfreq_option),
        .delay_option_output(vibrato_delay_option),
        .sinus_done(sinus_done_value),
        .sinus_result(sinus_result_value),
        .sinus_angle(vibrato_sinus_angle),
        .sinus_clk_en(vibrato_sinus_clk_en),
        .sram_data_in(sram_data_out),
        .sram_read_finish(sram_read_finish),
        .sram_rd(vibrato_sram_rd),
        .sram_offset(vibrato_sram_offset),
        .clk(CLOCK_50),
        .rst(reset),
        .cs(SW[3]        ),
        .my_turn(state_left_prev == ECHO && state_left==VIBRATO),
        .done(vibrato_done),
        .data_out(vibrato_data_out),
        .fp_dataa(vibrato_fp_dataa),
        .fp_datab(vibrato_fp_datab),
        .fp_operation(vibrato_fp_operation),
        .fp_clk_en(vibrato_fp_clk_en),
        .fp_done(fpu_done),
        .fp_result(fpu_result)
        );

   /*
    Initialize echo effect
    */
   wire                  echo_available_options;
   wire                  echo_should_save;
   wire                  echo_available;
   wire                  echo_sram_rd;
   wire [ADDR_WIDTH-1:0] echo_sram_offset;
   wire [DATA_WIDTH-1:0] echo_sram_data_out;
   wire                  echo_sram_wr;
   wire [2:0]            echo_gain_option;
   wire [2:0]            echo_offset_option;
   reg                   echo_cs;
   reg                   echo_my_turn;
   reg [DATA_WIDTH-1:0]  echo_data_in;
   wire                  echo_done;
   wire [DATA_WIDTH-1:0] echo_data_out;

   echo #(.DATA_WIDTH(DATA_WIDTH),
          .ADDR_WIDTH(ADDR_WIDTH),
          .SAMPLERATE(48000))
   ech (.offset_option_output(echo_offset_option),
        .gain_option_output(echo_gain_option),
        .available_options(echo_available_options),
        .offset_control_key(current_selection == ECHO_CONTROL && rising_edge_button2),
        .gain_control_key(current_selection == ECHO_CONTROL && rising_edge_button3),
        .sram_data_in(sram_data_out),
        .sram_write_finish(sram_write_finish),
        .sram_read_finish(sram_read_finish),
        .sram_wr(echo_sram_wr),
        .sram_rd(echo_sram_rd),
        .sram_data_out(echo_sram_data_out),
        .sram_offset(echo_sram_offset),
        .should_save(SW[0]),
        .clk(CLOCK_50),
        .rst(reset),
        .cs(1),
        .my_turn(state_left_prev == ACK_SAVE && state_left==ECHO),
        .data_in(data_left),
        .done(echo_done),
        .available(echo_available),
        .data_out(echo_data_out));


   localparam READ_LATENCY = 0;
   localparam DATA_WIDTH = 16;
   localparam ADDR_WIDTH = 18;
   localparam N = 6;
   localparam READING = 0, SAVING = 1, PROCESSING = 2, WRITING = 3, DONE = 4, FILTER_NOISE = 5, VIBRATO = 6, CHORUS = 7, RAMREADING = 8, ACK_SAVE = 9, TREMOLO = 10, ECHO = 11, WAHWAH = 12, DISTORTION = 13;
   /*
    Control constants
    */
   localparam ECHO_CONTROL = 10'b0000000100, VIBRATO_CONTROL = 10'b0000001000, CHORUS_CONTROL = 10'b0000010000, TREMOLO_CONTROL = 10'b0000100000, WAHWAH_CONTROL = 10'b0001000000, DISTORTION_CONTROL = 10'b0010000000;

   reg [9:0]            current_selection, current_selection_next;
   reg [3:0]             state_left, state_right, state_left_next, state_right_next, state_left_prev;
   reg [DATA_WIDTH-1:0]  data_left, data_left_r, data_right, data_right_r;
   reg                   ready_left_r, ready_right_r;
   reg                   ready_left, ready_right;
   reg                   valid_output_left_r, valid_output_left;
   reg                   valid_output_right_r, valid_output_right;
   reg [DATA_WIDTH-1:0]  data_out, data_out_next;
   integer               counter_left, counter_left_next;
   integer               counter_right, counter_right_next;

   initial  begin
      current_selection = ECHO_CONTROL;
      current_selection_next = ECHO_CONTROL;
      state_left = READING;
      state_right = READING;
      valid_output_left = 0;
      valid_output_right = 0;
      data_left = 0;
      data_right = 0;
      counter_right = 0;
      sram_offset_reg = 0;
   end

   wire done_filter;
   wire [DATA_WIDTH-1:0] filterd_data;
   noise_filter #(DATA_WIDTH, N)
   nf
     (
      .clock(CLOCK_50),
      .write(state_left_prev == READING && state_left == FILTER_NOISE),
      .data_in(data_left),
      .done(done_filter),
      .sum(filterd_data)
      );

   // Koristimo 3 stanje - READING, WRITING i DONE
   // U READING stanju cekamo signal VALID_LEFT i VALID RIGHT iz audio kontrolera.
   // Kada dobijemo taj signal citamo audio sample iz audio kontrolera i prelazimo u stanje WRITING
   // U stanju WRITING cekamo signal READY iz audio kontrolera. Kada se postavi signal READY iz audio kontrolera a mi smo u WRITING stanju
   // U sledecem taktu ocekujemo upis na izlaz, pa odmah menjamo stanje u DONE.
   // U stanju DONE se sinhronizuju levi i desni ulaz/izlaz. Kada obe strane (leva i desna) dodju do stanja DONE
   // idemo u stanje READY i ponavljamo ciklus u krug
   always @(*) begin
      state_left_next <= state_left;
      state_right_next <= state_right;
      data_left <= data_left_r;
      data_right <= data_right_r;
      valid_output_left <= 0;
      valid_output_right <= 0;
      sram_wr_reg_next <= 0;
      sram_rd_reg_next <= 0;
      sram_offset_reg_next <= sram_offset_reg;
      sram_data_in_reg_next <= sram_data_in_reg;

      // Kada iz audio kontrolera dobijamo izlazni signal VALID i kada smo READY da primimo signal menjamo stanje i citamo signal sa izlaza
      if (ready_left_adc == 1 && valid_left == 1 && state_left == READING) begin
         state_left_next <= FILTER_NOISE;
         // data_left <= { 1'b0, readdata_left[(DATA_WIDTH-1):1] }; // ### PROBLEMATICAN  ### red
         data_left <= readdata_left; // ### Ovo radi ####
      end

      if (ready_right_adc == 1 && valid_right == 1 && state_right == READING) begin
         state_right_next <= PROCESSING;
         // data_right <= { 1'b0, readdata_right[(DATA_WIDTH-1):1] }; // ### PROBLEMATICAN  ### red

         data_right <= readdata_right; // ### Ovo radi ####
      end

      if (state_left == FILTER_NOISE) begin
         if (SW[1] == 0) begin
            state_left_next <= SAVING;
         end
         else if (done_filter) begin
            data_left <= filterd_data;
            state_left_next <= SAVING;
         end
      end

      if (state_left == SAVING) begin
         sram_wr_reg_next <= 1;
         sram_offset_reg_next <= 0;
         sram_data_in_reg_next <= data_left_r;
         state_left_next <= ACK_SAVE;
      end

      if (state_left == ACK_SAVE) begin
         if (sram_write_finish) begin
            state_left_next <= ECHO;
         end
      end

      if (state_left == ECHO) begin
         if (SW[2] == 0) begin
            state_left_next <= VIBRATO;
         end
         else if (echo_done) begin
            state_left_next <= VIBRATO;
            data_left <= echo_data_out;
         end
      end

      if (state_left == VIBRATO) begin
         if (SW[3] == 0) begin
            state_left_next <= CHORUS;
         end
         else if (vibrato_done) begin
            state_left_next <= CHORUS;
            data_left <= vibrato_data_out;
         end
      end

      if (state_left == CHORUS) begin
         if (SW[4] == 0) begin
            state_left_next <= TREMOLO;
         end
         else if (chorus_done) begin
            state_left_next <= TREMOLO;
            data_left <= chorus_data_out;
         end
      end

      if (state_left == TREMOLO) begin
         if (SW[5] == 0) begin
            state_left_next <= WAHWAH;
         end
         else if (tremolo_done) begin
            state_left_next <= WAHWAH;
            data_left <= tremolo_data_out;
         end
      end

      if (state_left == WAHWAH) begin
         if (SW[6] == 0) begin
            state_left_next <= DISTORTION;
         end
         else if (wahwah_done) begin
            state_left_next <= DISTORTION;
            data_left <= wahwah_data_out;
         end
      end

      if (state_left == DISTORTION) begin
         if (SW[7] == 0) begin
            state_left_next <= WRITING;
         end
         else if (distortion_done) begin
            state_left_next <= WRITING;
            data_left <= distortion_data_out;
         end
      end

      // We only use one channel - so just wait for LEFT channel to go to WRITING or DONE
      if (state_right == PROCESSING) begin
         if (state_left == WRITING || state_left == DONE) begin
            data_right <= data_left_r;
            state_right_next <= WRITING;
         end
      end

      // Kada dodjemo do stanja WRITING vec imamo spreman signal za izlaz
      if (state_left == WRITING) begin
         valid_output_left <= 1;
      end

      if (state_right == WRITING) begin
         valid_output_right <= 1;
      end

      // Kada dobijemo signal READY iz AUDIO kontrolera i setovali smo VALID spremni smo za upis
      // i menjamo stanje u DONE
      if (valid_output_left_r == 1 && ready_w_left == 1) begin
         state_left_next <= DONE;
         valid_output_left <= 0;
      end

      if (valid_output_right_r == 1 && ready_w_right == 1) begin
         state_right_next <= DONE;
         valid_output_right <= 0;
      end

      if (state_right == DONE && state_left == DONE) begin
         state_left_next <= READING;
         state_right_next <= READING;
      end
   end

   always @(posedge CLOCK_50) begin
      current_selection <= current_selection_next;
      state_left_prev <= state_left;
      state_left <= state_left_next;
      state_right <= state_right_next;
      valid_output_left_r <= valid_output_left;
      valid_output_right_r <= valid_output_right;
      data_left_r <= data_left;
      data_right_r <= data_left;
      writedata_left <= data_left;
      writedata_right <= data_left;
      sram_data_in_reg <= sram_data_in_reg_next;
      sram_wr_reg <= sram_wr_reg_next;
      sram_rd_reg <= sram_rd_reg_next;
      sram_offset_reg <= sram_offset_reg_next;
   end

   reg [ADDR_WIDTH-1:0] sram_offset_value;
   reg                  sram_rd_value, sram_wr_value;
   reg [DATA_WIDTH-1:0] sram_data_in_value;


   always @(*) begin
      casex(state_left)
        SAVING,
        ACK_SAVE: begin
           sram_data_in_value <= sram_data_in_reg;
           sram_offset_value <= sram_offset_reg;
           sram_wr_value <= sram_wr_reg;
           sram_rd_value <= sram_rd_reg;
        end
        ECHO: begin
           sram_data_in_value <= echo_sram_data_out;
           sram_offset_value <= echo_sram_offset;
           sram_wr_value <= echo_sram_wr;
           sram_rd_value <= echo_sram_rd;
        end
        VIBRATO: begin
           sram_data_in_value <= {{DATA_WIDTH{1'bz}}};
           sram_offset_value <= vibrato_sram_offset;
           sram_wr_value <= 0;
           sram_rd_value <= vibrato_sram_rd;
        end
        CHORUS: begin
           sram_data_in_value <= {{DATA_WIDTH{1'bz}}};
           sram_offset_value <= chorus_sram_offset;
           sram_wr_value <= 0;
           sram_rd_value <= chorus_sram_rd;
        end
        default: begin
           sram_data_in_value <= sram_data_in_reg;
           sram_offset_value <= sram_offset_reg;
           sram_wr_value <= sram_wr_reg;
           sram_rd_value <= sram_rd_reg;
        end
      endcase
   end

   reg [31:0] sinus_data_reg;
   reg        sinus_clk_en_reg;

   always @(*) begin
      casex(state_left)
        VIBRATO: begin
           sinus_data_reg <= vibrato_sinus_angle;
           sinus_clk_en_reg <= vibrato_sinus_clk_en;
        end
        TREMOLO: begin
           sinus_data_reg <= tremolo_sinus_angle;
           sinus_clk_en_reg <= tremolo_sinus_clk_en;
        end
        WAHWAH: begin
           sinus_data_reg <= wahwah_sinus_angle;
           sinus_clk_en_reg <= wahwah_sinus_clk_en;
        end
        default: begin
           sinus_data_reg <= 32'bz;
           sinus_clk_en_reg <= 1'bz;
        end
      endcase
   end

   reg [31:0]                   fpu_dataa_reg;
   reg [31:0]                   fpu_datab_reg;
   reg [2:0]                    fpu_operation_reg;
   reg                          fpu_clk_en_reg;

   always @(*) begin
      casex(state_left)
        VIBRATO: begin
           fpu_dataa_reg <= vibrato_fp_dataa;
           fpu_datab_reg <= vibrato_fp_datab;
           fpu_operation_reg <= vibrato_fp_operation;
           fpu_clk_en_reg <= vibrato_fp_clk_en;
        end
        TREMOLO: begin
           fpu_dataa_reg <= tremolo_fp_dataa;
           fpu_datab_reg <= tremolo_fp_datab;
           fpu_operation_reg <= tremolo_fp_operation;
           fpu_clk_en_reg <= tremolo_fp_clk_en;
        end
        WAHWAH: begin
           fpu_dataa_reg <= wahwah_fp_dataa;
           fpu_datab_reg <= wahwah_fp_datab;
           fpu_operation_reg <= wahwah_fp_operation;
           fpu_clk_en_reg <= wahwah_fp_clk_en;
        end
        default:
          begin
             fpu_dataa_reg <= 32'bz;
             fpu_datab_reg <= 32'bz;
             fpu_operation_reg <= 3'bz;
             fpu_clk_en_reg <= 1'bz;
          end
      endcase
   end

   reg button0, prev_button0;
   wire rising_edge_button0;
   reg  button1, prev_button1;
   wire rising_edge_button1;
   reg  button2, prev_button2;
   wire rising_edge_button2;
   reg  button3, prev_button3;
   wire rising_edge_button3;
   reg  button4, prev_button4;
   wire rising_edge_button4;

   always @(posedge CLOCK_50) begin
      button0 <= KEY[0];
      button1 <= KEY[1];
      button2 <= KEY[2];
      button3 <= KEY[3];

      prev_button0 <= button0;
      prev_button1 <= button1;
      prev_button2 <= button2;
      prev_button3 <= button3;

      prev_button0 <= button0;
      prev_button1 <= button1;
      prev_button2 <= button2;
      prev_button3 <= button3;
   end

   reg [1:0] current_available_options;

   always @(*) begin
      casex(current_selection)
        ECHO_CONTROL: begin
           current_available_options <= echo_available_options;
        end
        VIBRATO_CONTROL: begin
           current_available_options <= vibrato_available_options;
        end
        CHORUS_CONTROL: begin
           current_available_options <= chorus_available_options;
        end
        TREMOLO_CONTROL: begin
           current_available_options <= tremolo_available_options;
        end
        WAHWAH_CONTROL: begin
           current_available_options <= wahwah_available_options;
        end
        DISTORTION_CONTROL: begin
           current_available_options <= distortion_available_options;
        end
        default: begin
        end
      endcase
   end

   reg [2:0] first_option, second_option;

   always @(*) begin
      casex(current_selection)
        ECHO_CONTROL: begin
           first_option <= echo_offset_option;
           second_option <= echo_gain_option;
        end
        VIBRATO_CONTROL: begin
           first_option <= vibrato_modfreq_option;
           second_option <= vibrato_delay_option;
        end
        CHORUS_CONTROL: begin
           first_option <= 0;
           second_option <= 0;
        end
        TREMOLO_CONTROL: begin
           first_option <= tremolo_alpha_option;
           second_option <= tremolo_modfreq_option;
        end
        WAHWAH_CONTROL: begin
           first_option <= wahwah_freq_option;
           second_option <= wahwah_delta_option;
        end
        DISTORTION_CONTROL: begin
           first_option <= distortion_control;
           second_option <= 0;
        end
        default: begin
           first_option <= 0;
           second_option <= 0;
        end
      endcase
   end


   always @(*) begin
      current_selection_next <= current_selection;

      if (rising_edge_button0) begin
         current_selection_next <= current_selection << 1;

         if (current_selection == DISTORTION_CONTROL) begin
            current_selection_next <= ECHO_CONTROL;
         end
      end
   end


   assign rising_edge_button0 = prev_button0 == 0 && button0 == 1;
   assign rising_edge_button1 = prev_button1 == 0 && button1 == 1;
   assign rising_edge_button2 = prev_button2 == 0 && button2 == 1;
   assign rising_edge_button3 = prev_button3 == 0 && button3 == 1;

   assign fpu_dataa = fpu_dataa_reg;
   assign fpu_datab = fpu_datab_reg;
   assign fpu_operation = fpu_operation_reg;
   assign fpu_clk_en = fpu_clk_en_reg;

   assign sinus_clk_en_value = sinus_clk_en_reg;
   assign sinus_data_value = sinus_data_reg;

   assign LEDR[9:0] = current_selection;
   assign LEDG[5] = current_available_options[0];
   assign LEDG[7] = current_available_options[1];
	assign HEX3 = digit_to_display(0);
	assign HEX2 = digit_to_display(second_option);
   assign HEX1 = digit_to_display(0);
   assign HEX0 = digit_to_display(first_option);

   assign sram_data_in = sram_data_in_value;
   assign sram_offset = sram_offset_value;
   assign sram_wr = sram_wr_value;
   assign sram_rd = sram_rd_value;

   assign ready_left_adc = state_left == READING; // Kad god je stanje reading spremni smo za citanje
   assign ready_right_adc = state_right == READING; // Kad god je stanje reading spremni smo za citanje
   assign valid_w_right = valid_output_right_r;
   assign valid_w_left = valid_output_left_r;
endmodule
