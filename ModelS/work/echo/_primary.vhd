library verilog;
use verilog.vl_types.all;
entity echo is
    generic(
        DATA_WIDTH      : integer := 16;
        ADDR_WIDTH      : integer := 12;
        OFFSET          : integer := 2048
    );
    port(
        sram_data_in    : in     vl_logic_vector;
        sram_read_finish: in     vl_logic;
        sram_write_finish: in     vl_logic;
        sram_wr         : out    vl_logic;
        sram_rd         : out    vl_logic;
        sram_data_out   : out    vl_logic_vector;
        sram_offset     : out    vl_logic_vector;
        should_save     : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        cs              : in     vl_logic;
        my_turn         : in     vl_logic;
        data_in         : in     vl_logic_vector;
        done            : out    vl_logic;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of OFFSET : constant is 1;
end echo;
