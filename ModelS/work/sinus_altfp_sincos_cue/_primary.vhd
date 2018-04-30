library verilog;
use verilog.vl_types.all;
entity sinus_altfp_sincos_cue is
    port(
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end sinus_altfp_sincos_cue;
