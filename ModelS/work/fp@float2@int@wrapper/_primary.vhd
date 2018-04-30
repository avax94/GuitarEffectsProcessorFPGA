library verilog;
use verilog.vl_types.all;
entity fpFloat2IntWrapper is
    port(
        clock           : in     vl_logic;
        clk_en          : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0);
        done            : out    vl_logic
    );
end fpFloat2IntWrapper;
