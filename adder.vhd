library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- half adder
entity half_adder is
    port(
        a, b        : in STD_LOGIC;
        sum, carry  : out STD_LOGIC
    );
end;

architecture behavior of half_adder is
begin
    sum     <= a XOR b after 1 ns;
    carry   <= a AND b after 1 ns;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- full adder
entity adder is
    port(
        a, b, cin   : in STD_LOGIC;
        sum, carry  : out STD_LOGIC
    );
end;

architecture struct of adder is
    component half_adder
        port(
            a, b        : in STD_LOGIC;
            sum, carry  : out STD_LOGIC
        );
    end component;
    signal sum_part, carry_1, carry_2
                    : STD_LOGIC;
begin
    half_1: half_adder port map(a, b, sum_part, carry_1);
    half_2: half_adder port map(sum_part, cin, sum, carry_2);
    carry   <= carry_1 OR carry_2;
end;
