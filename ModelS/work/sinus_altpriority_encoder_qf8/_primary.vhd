library verilog;
use verilog.vl_types.all;
entity sinus_altpriority_encoder_qf8 is
    port(
        data            : in     vl_logic_vector(31 downto 0);
        q               : out    vl_logic_vector(4 downto 0);
        zero            : out    vl_logic
    );
end sinus_altpriority_encoder_qf8;
