library verilog;
use verilog.vl_types.all;
entity vibrato is
    generic(
        DATA_WIDTH      : integer := 16;
        ADDR_WIDTH      : integer := 13;
        SAMPLERATE      : integer := 48000;
        CLOCK_FREQ      : integer := 50;
        DELAY           : integer := 5
    );
    port(
        sram_data_in    : in     vl_logic_vector;
        sram_read_finish: in     vl_logic;
        sram_rd         : out    vl_logic;
        sram_offset     : out    vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        cs              : in     vl_logic;
        modfreq         : in     vl_logic_vector(31 downto 0);
        my_turn         : in     vl_logic;
        done            : out    vl_logic;
        data_out        : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of SAMPLERATE : constant is 1;
    attribute mti_svvh_generic_type of CLOCK_FREQ : constant is 1;
    attribute mti_svvh_generic_type of DELAY : constant is 1;
end vibrato;
