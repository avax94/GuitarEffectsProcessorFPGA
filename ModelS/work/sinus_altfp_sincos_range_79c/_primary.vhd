library verilog;
use verilog.vl_types.all;
entity sinus_altfp_sincos_range_79c is
    port(
        aclr            : in     vl_logic;
        circle          : out    vl_logic_vector(35 downto 0);
        clken           : in     vl_logic;
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        negcircle       : out    vl_logic_vector(35 downto 0)
    );
end sinus_altfp_sincos_range_79c;
