library verilog;
use verilog.vl_types.all;
entity l6q2a is
    port(
        op              : out    vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        oe              : in     vl_logic;
        add             : in     vl_logic_vector(4 downto 0)
    );
end l6q2a;
