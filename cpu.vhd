library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- 32-bit cpu
-- inputs are control signals
entity cpu is
    port(
        ALUOp, ALUSrcB  : in STD_LOGIC_VECTOR(1 downto 0);
        RegDst, MemToReg, MemRead, MemWrite, ALUSrcA, RegWrite
                        : in STD_LOGIC
    );
end;

architecture struct of cpu is
    -- alu
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    type t_RegFile  is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    
    signal reg      : t_RegFile;
    signal pc       : STD_LOGIC_VECTOR(31 downto 0);
begin

end;