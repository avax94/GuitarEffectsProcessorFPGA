library verilog;
use verilog.vl_types.all;
entity sinus_altfp_sincos_cordic_atan_68b is
    port(
        arctan          : out    vl_logic_vector(33 downto 0);
        indexbit        : in     vl_logic
    );
end sinus_altfp_sincos_cordic_atan_68b;
