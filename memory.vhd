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
    -- here it is assumed to be 1K
    -- memory is byte addressible
    -- assume memory accesses are word size
    type t_Memory is array (0 to 1023) of STD_LOGIC_VECTOR(7 downto 0);
    signal mem      : t_Memory;
    signal addr     : integer;
begin
    addr            <= to_integer(unsigned(Address));
    
    mem(addr)       <= WriteData(31 downto 24)  when MemWrite = '1' else mem(addr)      after 1 ns;
    mem(addr + 1)   <= WriteData(23 downto 16)  when MemWrite = '1' else mem(addr + 1)  after 1 ns;
    mem(addr + 2)   <= WriteData(15 downto 8)   when MemWrite = '1' else mem(addr + 2)  after 1 ns;
    mem(addr + 3)   <= WriteData(7 downto 0)    when MemWrite = '1' else mem(addr + 3)  after 1 ns;

    ReadData(31 downto 24)  <= mem(addr)        when MemRead = '1' else "ZZZZZZZZ" after 1 ns;
    ReadData(23 downto 16)  <= mem(addr + 1)    when MemRead = '1' else "ZZZZZZZZ" after 1 ns;
    ReadData(15 downto 8)   <= mem(addr + 2)    when MemRead = '1' else "ZZZZZZZZ" after 1 ns;
    ReadData(7 downto 0)    <= mem(addr + 3)    when MemRead = '1' else "ZZZZZZZZ" after 1 ns;
end;