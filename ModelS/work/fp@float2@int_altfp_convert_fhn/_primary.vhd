library verilog;
use verilog.vl_types.all;
entity fpFloat2Int_altfp_convert_fhn is
    port(
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end fpFloat2Int_altfp_convert_fhn;
