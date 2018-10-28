library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_MISC.all;

-- one bit ALU
-- supports add, neg, or
-- op, neg, and Cin are control signals
entity alu1 is
    port(
        a, b, op, neg, Cin      : in STD_LOGIC;
        output, Cout            : out STD_LOGIC
    );
end;

architecture behavior of alu1 is
    component adder
        port(
            a, b, cin       : in STD_LOGIC;
            sum, carry      : out STD_LOGIC
        );
    end component;
    signal not_b, input_b, out_or, out_add
                            : STD_LOGIC;
begin
    not_b       <= NOT b;
    input_b     <= fun_MUX2x1(b, not_b, neg);
    out_or      <= a OR b;
    add: adder port map(a, input_b, Cin, out_add, Cout);
    output      <= fun_MUX2x1(out_or, out_add, op);
end;