//TODO you have to make sure AUDIO and EFFECTS dont read/wr in same clock cycle

module echo
#(
	parameter DATA_WIDTH=16,
	parameter ADDR_WIDTH = 12,
	parameter OFFSET = 2048,
	parameter N = 3
)
(
	/* smart_ram interface */
	input [DATA_WIDTH-1:0]    sram_data_in,
	input                     sram_read_finish,
	input                     sram_write_finish,
	output                    sram_wr,
	output                    sram_rd,
	output [DATA_WIDTH-1:0]   sram_data_out,
	output [(ADDR_WIDTH-1):0] sram_offset,
	/* end */

	input                     should_save,
	input                     clk,
	input                     rst,
	input                     cs,
	input                     my_turn,
	input [DATA_WIDTH-1:0]    data_in,
	output                    done,
	output                    available,
        output [DATA_WIDTH-1:0]   what_i_read
		  ,
        output [(DATA_WIDTH-1):0] data_out
);

reg [DATA_WIDTH-1:0] sr_data_out, sr_data_out_next;
reg [ADDR_WIDTH-1:0] sr_offset, sr_offset_next;
reg sr_wr, sr_wr_next;
reg sr_rd, sr_rd_next;
reg [DATA_WIDTH-1:0] data_out_reg, data_out_reg_next;

localparam PASSIVE = 0, GETDATA_AND_CALCULATE = 1, SAVE = 2, DONE = 3;

reg [1:0] state, state_next;

initial
begin
	state = PASSIVE;
end

always @(*)
begin
	state_next <= state;
	sr_offset_next <= sr_offset;
	sr_data_out_next <= sr_data_out;
	data_out_reg_next <= data_out_reg;
	sr_rd_next <= 0;
	sr_wr_next <= 0;

	casex(state)
	PASSIVE:
	begin
		if(cs == 1 && my_turn == 1)
		begin
			state_next <= GETDATA_AND_CALCULATE;
			// prepare for reading from sram
			sr_rd_next <= 1;
			sr_offset_next <= OFFSET;
		end
	end
	GETDATA_AND_CALCULATE:
	begin
		if (sram_read_finish)
		begin
			data_out_reg_next <= data_in + {{N{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:N]};
			state_next <= DONE;
                   what_i_read_reg <= sram_data_in[DATA_WIDTH-1];

			if (should_save)
			begin
				sr_offset_next <= 1;
				sr_wr_next <= 1;
				sr_data_out_next <= data_in + {{1{sram_data_in[DATA_WIDTH-1]}}, sram_data_in[DATA_WIDTH-1:1]};
				state_next <= SAVE;
			end

		end
	end
        SAVE:
        begin
           if (sram_write_finish) begin
              state_next <= DONE;
           end
        end
	DONE:
	begin
		state_next <= PASSIVE;
	end
	endcase
end
reg [DATA_WIDTH-1:0] what_i_read_reg;
assign what_i_read = what_i_read_reg;
/* Take action based on state */
reg [(DATA_WIDTH-1):0] sum;
integer i;

always @(posedge clk)
begin
	state <= state_next;
	data_out_reg <= data_out_reg_next;
	sr_wr <= sr_wr_next;
	sr_rd <= sr_rd_next;
	sr_offset <= sr_offset_next;
	sr_data_out <= sr_data_out_next;
end

assign available = state == PASSIVE;
assign sram_offset = sr_offset;
assign sram_wr = sr_wr;
assign sram_rd = sr_rd;
assign sram_data_out = sr_data_out;
assign data_out = data_out_reg;
assign done = state == DONE;
endmodule
