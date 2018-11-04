library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

-- memory
entity memory is
    port(
        MemRead, MemWrite   : in STD_LOGIC;
        Address, WriteData  : in STD_LOGIC_VECTOR(31 downto 0);
        ReadData            : out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

architecture behavior of memory is
    -- size of memory may vary
    -- here it is assumed to be 4K
    -- memory is byte addressible
    -- assume memory accesses are word size
    -- vhdl integer size only goes up to 2**31 - 1
    -- if full address space is required, need 2
    -- arrays and mux them together
    type t_Memory is array (0 to 4095) of STD_LOGIC_VECTOR(7 downto 0);
    signal mem      : t_Memory;
    signal addr     : integer;
begin
    process (MemWrite, WriteData, Address)
        variable addr: natural range 0 to 4095;
    begin
        -- address needs to be truncated
        -- if higher address range is required, second
        -- array is needed and muxed based on first bit
        addr := to_integer(unsigned(Address));

        if (MemWrite = '1') then
            mem(addr)       <= WriteData(31 downto 24) after 1 ns;
            mem(addr + 1)   <= WriteData(23 downto 16) after 1 ns;
            mem(addr + 2)   <= WriteData(15 downto 8)  after 1 ns;
            mem(addr + 3)   <= WriteData(7 downto 0)   after 1 ns;
        end if;

        ReadData(31 downto 24)  <= mem(addr)     after 1 ns;
        ReadData(23 downto 16)  <= mem(addr + 1) after 1 ns;
        ReadData(15 downto 8)   <= mem(addr + 2) after 1 ns;
        ReadData(7 downto 0)    <= mem(addr + 3) after 1 ns;
    end process;
end;