library verilog;
use verilog.vl_types.all;
entity noise_filter is
    generic(
        DATA_WIDTH      : integer := 24;
        N               : integer := 3
    );
    port(
        write           : in     vl_logic;
        clock           : in     vl_logic;
        data_in         : in     vl_logic_vector;
        done            : out    vl_logic;
        sum             : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of N : constant is 1;
end noise_filter;
