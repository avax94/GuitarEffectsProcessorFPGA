library verilog;
use verilog.vl_types.all;
entity fpAdd_altpriority_encoder_nh8 is
    port(
        data            : in     vl_logic_vector(1 downto 0);
        q               : out    vl_logic_vector(0 downto 0);
        zero            : out    vl_logic
    );
end fpAdd_altpriority_encoder_nh8;
