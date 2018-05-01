module chorus
#(
	parameter DATA_WIDTH=16,
)
(
	input                     clk,
	input                     rst,
	input                     cs,
	input                     my_turn,
	input [DATA_WIDTH-1:0]    data_in,
	output                    done,
	output [(DATA_WIDTH-1):0] data_out
);


signed reg [DATA_WIDTH-1:0] dataa, dataa_next;

localparam PASSIVE = 0, DISTORTION = 1;

reg [2:0] state, state_next;
reg [3:0] index_first, index_second, index_third;
integer counter;

/*
	sync
*/


always @(posedge clk)
begin
	state <= state_next;
	data_out_reg <= data_out_reg_next;
	sr_rd <= sr_rd_next;
	sr_offset <= sr_offset_next;
end

integer helperIdx;
/*
	comb
*/
always @(*)
begin
	state_next <= state;
	sr_offset_next <= sr_offset;
	data_out_reg_next <= data_out_reg;
	sr_rd_next <= 0;

	casex(state)
	PASSIVE:
	begin
		if(cs == 1 && my_turn == 1)
		begin
			state_next <= GET_FIRST;
			data_out_reg_next <= {{2{data_in[DATA_WIDTH-1]}}, data_in[DATA_WIDTH-1:0]};
			
			// prepare for reading from sram for first vocal
			sr_rd_next <= 1;
			helperIdx = index_first;
			sr_offset_next <= delays[helperIdx];
		end
	end
	GET_FIRST:
	begin
		if (sram_read_finish)
		begin
			state_next <= GET_SECOND;
			data_out_reg_next <= data_out_reg + {{2{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]};
			
			// prepare for reading from sram for second vocal
			sr_rd_next <= 1;
			sr_offset_next <= delays[index_second];
		end
	end
	GET_SECOND:
	begin
		if (sram_read_finish)
		begin
			data_out_reg_next <= data_out_reg + {{2{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]};
			state_next <= GET_THIRD;

			// prepare for reading from sram for third vocal
			sr_rd_next <= 1;
			sr_offset_next <= delays[index_third];
		end
	end
	GET_THIRD:
	begin
		if (sram_read_finish)
		begin
			data_out_reg_next <= data_out_reg + {{2{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:0]};
			state_next <= DONE;
		end
	end
	DONE:
	begin
		state_next <= PASSIVE;
	end
	endcase
end

assign sram_offset = sr_offset;
assign sram_rd = sr_rd;
assign data_out = data_out_reg[DATA_WIDTH+2-1:2];
assign done = state == DONE;
endmodule
