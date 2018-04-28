// megafunction wizard: %Audio v13.0%
// GENERATION: XML
// audio_core.v

// Generated using ACDS version 13.0sp1 232 at 2018.04.28.12:24:39

`timescale 1 ps / 1 ps
module audio_core (
		input  wire        clk,                          //                 clock_reset.clk
		input  wire        reset,                        //           clock_reset_reset.reset
		input  wire        from_adc_left_channel_ready,  //  avalon_left_channel_source.ready
		output wire [15:0] from_adc_left_channel_data,   //                            .data
		output wire        from_adc_left_channel_valid,  //                            .valid
		input  wire        from_adc_right_channel_ready, // avalon_right_channel_source.ready
		output wire [15:0] from_adc_right_channel_data,  //                            .data
		output wire        from_adc_right_channel_valid, //                            .valid
		input  wire [15:0] to_dac_left_channel_data,     //    avalon_left_channel_sink.data
		input  wire        to_dac_left_channel_valid,    //                            .valid
		output wire        to_dac_left_channel_ready,    //                            .ready
		input  wire [15:0] to_dac_right_channel_data,    //   avalon_right_channel_sink.data
		input  wire        to_dac_right_channel_valid,   //                            .valid
		output wire        to_dac_right_channel_ready,   //                            .ready
		input  wire        AUD_ADCDAT,                   //          external_interface.export
		input  wire        AUD_ADCLRCK,                  //                            .export
		input  wire        AUD_BCLK,                     //                            .export
		output wire        AUD_DACDAT,                   //                            .export
		input  wire        AUD_DACLRCK                   //                            .export
	);

	audio_core_0002 audio_core_inst (
		.clk                          (clk),                          //                 clock_reset.clk
		.reset                        (reset),                        //           clock_reset_reset.reset
		.from_adc_left_channel_ready  (from_adc_left_channel_ready),  //  avalon_left_channel_source.ready
		.from_adc_left_channel_data   (from_adc_left_channel_data),   //                            .data
		.from_adc_left_channel_valid  (from_adc_left_channel_valid),  //                            .valid
		.from_adc_right_channel_ready (from_adc_right_channel_ready), // avalon_right_channel_source.ready
		.from_adc_right_channel_data  (from_adc_right_channel_data),  //                            .data
		.from_adc_right_channel_valid (from_adc_right_channel_valid), //                            .valid
		.to_dac_left_channel_data     (to_dac_left_channel_data),     //    avalon_left_channel_sink.data
		.to_dac_left_channel_valid    (to_dac_left_channel_valid),    //                            .valid
		.to_dac_left_channel_ready    (to_dac_left_channel_ready),    //                            .ready
		.to_dac_right_channel_data    (to_dac_right_channel_data),    //   avalon_right_channel_sink.data
		.to_dac_right_channel_valid   (to_dac_right_channel_valid),   //                            .valid
		.to_dac_right_channel_ready   (to_dac_right_channel_ready),   //                            .ready
		.AUD_ADCDAT                   (AUD_ADCDAT),                   //          external_interface.export
		.AUD_ADCLRCK                  (AUD_ADCLRCK),                  //                            .export
		.AUD_BCLK                     (AUD_BCLK),                     //                            .export
		.AUD_DACDAT                   (AUD_DACDAT),                   //                            .export
		.AUD_DACLRCK                  (AUD_DACLRCK)                   //                            .export
	);

endmodule
// Retrieval info: <?xml version="1.0"?>
//<!--
//	Generated by Altera MegaWizard Launcher Utility version 1.0
//	************************************************************
//	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//	************************************************************
//	Copyright (C) 1991-2018 Altera Corporation
//	Any megafunction design, and related net list (encrypted or decrypted),
//	support information, device programming or simulation file, and any other
//	associated documentation or information provided by Altera or a partner
//	under Altera's Megafunction Partnership Program may be used only to
//	program PLD devices (but not masked PLD devices) from Altera.  Any other
//	use of such megafunction design, net list, support information, device
//	programming or simulation file, or any other related documentation or
//	information is prohibited for any other purpose, including, but not
//	limited to modification, reverse engineering, de-compiling, or use with
//	any other silicon devices, unless such use is explicitly licensed under
//	a separate agreement with Altera or a megafunction partner.  Title to
//	the intellectual property, including patents, copyrights, trademarks,
//	trade secrets, or maskworks, embodied in any such megafunction design,
//	net list, support information, device programming or simulation file, or
//	any other related documentation or information provided by Altera or a
//	megafunction partner, remains with Altera, the megafunction partner, or
//	their respective licensors.  No other licenses, including any licenses
//	needed under any third party's intellectual property, are provided herein.
//-->
// Retrieval info: <instance entity-name="altera_up_avalon_audio" version="13.0" >
// Retrieval info: 	<generic name="avalon_bus_type" value="Streaming" />
// Retrieval info: 	<generic name="audio_in" value="true" />
// Retrieval info: 	<generic name="audio_out" value="true" />
// Retrieval info: 	<generic name="dw" value="16" />
// Retrieval info: 	<generic name="AUTO_CLOCK_RESET_CLOCK_RATE" value="-1" />
// Retrieval info: 	<generic name="AUTO_DEVICE_FAMILY" value="Cyclone II" />
// Retrieval info: </instance>
// IPFS_FILES : audio_core.vo
// RELATED_FILES: audio_core.v, altera_up_audio_bit_counter.v, altera_up_audio_in_deserializer.v, altera_up_audio_out_serializer.v, altera_up_clock_edge.v, altera_up_sync_fifo.v, audio_core_0002.v
