library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity register_file is
    port(
        ReadReg_A, ReadReg_B, WriteReg  : in STD_LOGIC_VECTOR(4 downto 0);
        WriteData                       : in STD_LOGIC_VECTOR(31 downto 0);
        RegWrite                        : in STD_LOGIC;
        ReadData_A, ReadData_B          : out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

architecture behavior of register_file is
    type t_RegFile  is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal reg      : t_RegFile;
    signal addr     : integer;
begin
    process (ReadReg_A, ReadReg_B, WriteReg, WriteData)
        variable ReadAddr_A, ReadAddr_B, WriteAddr : natural range 0 to 31;
    begin
        ReadAddr_A := to_integer(unsigned(ReadReg_A));
        ReadAddr_B := to_integer(unsigned(ReadReg_B));
        WriteAddr  := to_integer(unsigned(WriteReg));

        if (RegWrite = '1') then
            reg(WriteAddr) <= WriteData;
        end if;

        ReadData_A  <= reg(ReadAddr_A);
        ReadData_B  <= reg(ReadAddr_B);        
    end process;
end;
