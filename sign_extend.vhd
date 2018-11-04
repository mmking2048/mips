library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity sign_extend is
    port(
        input       : in STD_LOGIC_VECTOR(15 downto 0);
        output      : out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

architecture behavior of sign_extend is
begin
    output <= std_logic_vector(resize(signed(input), 32));
end;
