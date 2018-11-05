library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity reg is
    port(
        input   : in STD_LOGIC_VECTOR(31 downto 0);
        output  : out STD_LOGIC_VECTOR(31 downto 0);
        clk     : in STD_LOGIC
    );
end;

architecture behavior of reg is
    signal data : STD_LOGIC_VECTOR(31 downto 0);
begin
    data        <= input when clk = '0';
    output      <= data  when clk = '1';
end;
