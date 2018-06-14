library verilog;
use verilog.vl_types.all;
entity smart_ram is
    generic(
        ADDR_WIDTH      : integer := 13;
        DATA_WIDTH      : integer := 16
    );
    port(
        data_in         : in     vl_logic_vector;
        offset          : in     vl_logic_vector;
        wr              : in     vl_logic;
        rd              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        data_out        : out    vl_logic_vector;
        write_finish    : out    vl_logic;
        read_finish     : out    vl_logic;
        available       : out    vl_logic;
        SRAM_DQ         : out    vl_logic_vector(15 downto 0);
        SRAM_ADDR       : out    vl_logic_vector(17 downto 0);
        SRAM_LB_N       : out    vl_logic;
        SRAM_UB_N       : out    vl_logic;
        SRAM_CE_N       : out    vl_logic;
        SRAM_OE_N       : out    vl_logic;
        SRAM_WE_N       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
end smart_ram;
