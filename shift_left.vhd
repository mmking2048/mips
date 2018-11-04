library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity shift_left is
    generic(
        K           : integer := 32;
        S           : integer := 2
    );
    port(
        input       : in STD_LOGIC_VECTOR(K-1 downto 0);
        output      : out STD_LOGIC_VECTOR(K-1 downto 0)
    );
end;

architecture behavior of shift_left is
begin
    output(K-1 downto S) <= input(K-S-1 downto 0);
    output(1 downto 0) <= "00";
end;

