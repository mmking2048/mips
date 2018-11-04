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
    -- 2 input mux
    component mux2 is
        generic(
            K           : integer  := 32
        );
        port(
            a, b        : in STD_LOGIC_VECTOR(K-1 downto 0);
            sel         : in STD_LOGIC;
            output      : out STD_LOGIC_VECTOR(K-1 downto 0)
        );
    end component;

    -- 4 input mux
    component mux4 is
        generic(
            K: integer  := 32
        );
        port(
            a, b, c, d  : in STD_LOGIC_VECTOR(31 downto 0);
            sel         : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- alu
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- memory for instructions and data
    component memory is
        port(
            MemRead, MemWrite   : in STD_LOGIC;
            Address, WriteData  : in STD_LOGIC_VECTOR(31 downto 0);
            ReadData            : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- shift left by 2 bits (sll)
    component shift_left is
        generic(
            K           : integer := 32;
            S           : integer := 2
        );
        port(
            input       : in STD_LOGIC_VECTOR(K-1 downto 0);
            output      : out STD_LOGIC_VECTOR(K-1 downto 0)
        );
    end component;

    -- sign extension
    component sign_extend is
        port(
            input       : in STD_LOGIC_VECTOR(15 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- register file
    component register_file is
        port(
            ReadReg_A, ReadReg_B, WriteReg  : in STD_LOGIC_VECTOR(4 downto 0);
            WriteData                       : in STD_LOGIC_VECTOR(31 downto 0);
            RegWrite                        : in STD_LOGIC;
            ReadData_A, ReadData_B          : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    -- registers
    signal PC, instruction, memData, A, B, ALUOut
                    : STD_LOGIC_VECTOR(31 downto 0);
    -- intermediate signals
    signal addr, WriteData, ALU_A, ALU_B, ALU_OUT, extended, offset, jump_addr
                    : STD_LOGIC_VECTOR(31 downto 0);
    signal WriteReg : STD_LOGIC_VECTOR(4 downto 0);
begin
    IorD_Mux:       mux2 port map(PC, ALUOut, IorD, addr);
    RegDst_Mux:     mux2
                        generic map(5)
                        port map(instruction(20 downto 16), instruction(15 downto 11), RegDst, WriteReg);
    MemToReg_Mux:   mux2 port map(ALUOut, memData, MemToReg, WriteData);
    ALUSrcA_Mux:    mux2 port map(PC, A, ALUSrcA, ALU_A);
    ALUSrcB_Mux:    mux4 port map(B, x"00000004", extended, offset, ALUSrcB, ALU_B);
    PCSource_Mux:   mux4 port map(ALU_OUT, ALUOut, jump_addr, jump_addr, PCSource, PC);

    Extend:         sign_extend port map(instruction(15 downto 0), extended);
    Shift_1:        shift_left port map(extended, offset);
    Shift_2:        shift_left
                        generic map(26)
                        port map(instruction(25 downto 0), jump_addr);

    Mem:            memory port map(MemRead, MemWrite, addr, WriteData, instruction);
    Reg:            register_file port map(instruction(25 downto 21), instruction(20 downto 16),
                                           WriteReg, WriteData, RegWrite, A, B);
    ALU_1:          alu port map(ALU_A, ALU_B, ALUOp, ALU_OUT);
end;