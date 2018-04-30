library verilog;
use verilog.vl_types.all;
entity fpInt2Float_altpriority_encoder_be8 is
    port(
        data            : in     vl_logic_vector(7 downto 0);
        q               : out    vl_logic_vector(2 downto 0);
        zero            : out    vl_logic
    );
end fpInt2Float_altpriority_encoder_be8;
