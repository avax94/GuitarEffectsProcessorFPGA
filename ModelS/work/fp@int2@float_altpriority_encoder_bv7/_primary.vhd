library verilog;
use verilog.vl_types.all;
entity fpInt2Float_altpriority_encoder_bv7 is
    port(
        data            : in     vl_logic_vector(7 downto 0);
        q               : out    vl_logic_vector(2 downto 0)
    );
end fpInt2Float_altpriority_encoder_bv7;
