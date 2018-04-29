module fpUnit
(
	input clock,
	input clk_en,
	input [2:0] operation,
	input [31:0] dataa,
	input [31:0] datab,
	output [31:0] result,
	output done
);
	localparam ADD = 0, SUB = 1, DIV = 2, MUL = 3, F2I = 4, I2F = 5;
	wire clk_en_add, clk_en_mul, clk_en_div, clk_en_f2i, clk_en_i2f;
	wire done_add, done_mul, done_div, done_f2i, done_i2f;
	wire [31:0] result_add, result_mul, result_div, result_f2i, result_i2f;
	/**
	 * instantite modules
	 */ 
	fpAddWrapper	fadd (
		.add_sub ( operation == ADD ? 0 : 1 ),
		.clk_en ( clk_en_add ),
		.clock ( clock ),
		.dataa ( dataa ),
		.datab ( datab ),
		.result ( result_add ),
		.done( done_add )
	);
	fpMulWrapper	fmul (
		.clk_en ( clk_en_mul ),
		.clock ( clock ),
		.dataa ( dataa ),
		.datab ( datab ),
		.result ( result_mul ),
		.done( done_mul )
	);
	fpDivWrapper	fdiv (
		.clk_en ( clk_en_div ),
		.clock ( clock ),
		.dataa ( dataa ),
		.datab ( datab ),
		.result ( result_div ),
		.done( done_div )
	);
	fpFloat2IntWrapper	fti (
		.clk_en ( clk_en_f2i ),
		.clock ( clock ),
		.dataa ( dataa ),
		.result ( result_f2i ),
		.done( done_f2i )
	);
	fpInt2FloatWrapper	i2f (
		.clk_en ( clk_en_i2f ),
		.clock ( clock ),
		.dataa ( dataa ),
		.result ( result_i2f ),
		.done( done_i2f )
	);
	
	assign done = operation == ADD || operation == SUB ? done_add : 
		(operation == MUL ? done_mul : 
			(operation == DIV ? done_div : 
				(operation == F2I ? done_f2i : done_i2f)
			)
		);
		
	assign result = operation == ADD || operation == SUB ? result_add : 
		(operation == MUL ? result_mul : 
			(operation == DIV ? result_div : 
				(operation == F2I ? result_f2i : result_i2f)
			)
		);
	
	assign clk_en_add = operation == ADD || operation == SUB ? clk_en : 0;
	assign clk_en_div = operation == DIV ? clk_en : 0;
	assign clk_en_mul = operation == MUL ? clk_en : 0;
	assign clk_en_i2f = operation == I2F ? clk_en : 0;
	assign clk_en_f2i = operation == F2I ? clk_en : 0;
	
	
endmodule
