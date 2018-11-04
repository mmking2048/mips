library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux2 is
    port(
        a, b        : in STD_LOGIC_VECTOR(31 downto 0);
        sel         : in STD_LOGIC;
        output      : out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

architecture behavior of mux2 is
begin
    output <=   a when sel = "0" else
                b;
end;
