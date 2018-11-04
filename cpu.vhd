library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- 32-bit cpu
-- inputs are control signals
entity cpu is
    port(
        PCSource, ALUOp, ALUSrcB    : in STD_LOGIC_VECTOR(1 downto 0);
        PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemToReg,
            IRWrite, RegDst, RegWrite, ALUSrcA
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

    component memory is
        port(
            MemRead, MemWrite   : in STD_LOGIC;
            Address, WriteData  : in STD_LOGIC_VECTOR(31 downto 0);
            ReadData            : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    type t_RegFile  is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);

    signal reg      : t_RegFile;
    signal pc, instruction, memData, A, B, ALUOut
                    : STD_LOGIC_VECTOR(31 downto 0);
begin
    IorD_Mux:
    RegDst_Mux:
    MemToReg_Mux:
    ALUSrcA_Mux:
    ALUSrcB_Mux:
    PCSource_Mux:
end;