library verilog;
use verilog.vl_types.all;
entity sinus_altfp_sincos_srrt_gra is
    port(
        address         : in     vl_logic_vector(7 downto 0);
        basefraction    : out    vl_logic_vector(35 downto 0);
        incexponent     : out    vl_logic_vector(7 downto 0);
        incmantissa     : out    vl_logic_vector(55 downto 0)
    );
end sinus_altfp_sincos_srrt_gra;
