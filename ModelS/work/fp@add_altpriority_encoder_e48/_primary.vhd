library verilog;
use verilog.vl_types.all;
entity fpAdd_altpriority_encoder_e48 is
    port(
        data            : in     vl_logic_vector(31 downto 0);
        q               : out    vl_logic_vector(4 downto 0)
    );
end fpAdd_altpriority_encoder_e48;