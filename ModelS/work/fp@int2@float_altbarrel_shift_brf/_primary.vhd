library verilog;
use verilog.vl_types.all;
entity fpInt2Float_altbarrel_shift_brf is
    port(
        aclr            : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        distance        : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end fpInt2Float_altbarrel_shift_brf;
