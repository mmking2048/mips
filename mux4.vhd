library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux4 is
    generic(
        K           : integer  := 32
    );
    port(
        a, b, c, d  : in STD_LOGIC_VECTOR(K-1 downto 0);
        sel         : in STD_LOGIC_VECTOR(1 downto 0);
        output      : out STD_LOGIC_VECTOR(K-1 downto 0)
    );
end;

architecture struct of mux4 is
    component mux2 is
        generic(
            K: integer  := 32
        );
        port(
            a, b        : in STD_LOGIC_VECTOR(K-1 downto 0);
            sel         : in STD_LOGIC;
            output      : out STD_LOGIC_VECTOR(K-1 downto 0)
        );
    end component;

    signal tmp_1, tmp_2 : STD_LOGIC_VECTOR(K-1 downto 0); 
begin
    mux_1: mux2 port map(a, b, sel(0), tmp_1);
    mux_2: mux2 port map(c, d, sel(0), tmp_2);
    mux_3: mux2 port map(tmp_1, tmp_2, sel(1), output);
end;
