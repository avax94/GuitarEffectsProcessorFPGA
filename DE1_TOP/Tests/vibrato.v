// vsim -L altera_mf_ver -L lpm_ver work.test_echo
`timescale 1 us/ 1 us
module test_vibrato();

/* vibrato test */
reg [23:0] data_in_sv;
reg wr_v;
wire rd_v;
wire read_finish_sv;
wire write_finish_sv;
wire [31:0] data_out_sv;

wire [24-1:0] data_out_vibrato;
wire done_vibrato;
reg [23:0] data_in_vibrato;
wire [12:0] offset_output_v;
reg cs_vib;
reg my_turn_vib;

smart_ram smv1 (
// port map - connection between master ports and signals/registers   
	.data_in(data_in_sv),
	.offset(offset_output_v),
	.wr(wr_v),
	.rd(rd_v),
	.read_finish(read_finish_sv),
	.write_finish(write_finish_sv),
	.data_out(data_out_sv),
	.clk(clk),
	.rst(0)
);

vibrato vibrr (
	.data_in(data_out_sv),
	.rd_finish(read_finish_sv),
	.rd(rd_v),
	.offset(offset_output_v),
	.clk(clk),
	.rst(0),
	.cs(cs_vib),
	.my_turn(my_turn_vib),
	.done(done_vibrato),
	.data_out(data_out_vibrato),
	.modfreq(32'b00111000110110100111010000001110)
);
integer i_v;
always 
begin
	//write to sram
	wr_v <= 1;
	for(i_v = 0; i_v < 1 << 12; i_v = i_v + 1)
	begin
		data_in_sv <= i_v;
		@(posedge write_finish_sv);
	end
	wr_v <= 0;
  @(posedge clk);
	cs_vib <= 1;
	my_turn_vib <= 1;
	
	@(posedge done_vibrato);
	@(posedge done_vibrato);
	@(posedge done_vibrato);
	@(posedge done_vibrato);
	@(posedge done_vibrato);
	@(posedge done_vibrato);
end

endmodule
