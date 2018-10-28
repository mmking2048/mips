library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_memory is
end;

architecture sim of test_memory is
    component memory is
        port(
            MemRead, MemWrite       : in STD_LOGIC;
            Address, WriteData      : in STD_LOGIC_VECTOR(31 downto 0);
            ReadData                : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    signal MemRead, MemWrite               : STD_LOGIC;
    signal Address, WriteData, ReadData    : STD_LOGIC_VECTOR(31 downto 0);
begin
    dut: memory port map(MemRead, MemWrite, Address, WriteData, ReadData);

    process begin
        -- set default memory address
        Address         <= x"00000100";

        MemRead     <= '0';
        MemWrite    <= '1';
        WriteData   <= x"12345678";
        wait for 50 ns;

        MemRead     <= '1';
        MemWrite    <= '0';
        wait for 50 ns;

        assert ReadData = x"12345678";

        wait;
    end process;
end;
