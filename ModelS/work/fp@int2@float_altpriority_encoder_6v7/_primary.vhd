library verilog;
use verilog.vl_types.all;
entity fpInt2Float_altpriority_encoder_6v7 is
    port(
        data            : in     vl_logic_vector(3 downto 0);
        q               : out    vl_logic_vector(1 downto 0)
    );
end fpInt2Float_altpriority_encoder_6v7;
