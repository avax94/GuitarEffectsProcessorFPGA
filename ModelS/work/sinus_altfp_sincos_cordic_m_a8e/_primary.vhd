library verilog;
use verilog.vl_types.all;
entity sinus_altfp_sincos_cordic_m_a8e is
    port(
        aclr            : in     vl_logic;
        clken           : in     vl_logic;
        clock           : in     vl_logic;
        indexbit        : in     vl_logic;
        radians         : in     vl_logic_vector(33 downto 0);
        sincos          : out    vl_logic_vector(33 downto 0);
        sincosbit       : in     vl_logic
    );
end sinus_altfp_sincos_cordic_m_a8e;
