library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- 32-bit cpu
-- inputs are control signals
entity cpu is
    port(
        PCSource, ALUOp, ALUSrcB    : in STD_LOGIC_VECTOR(1 downto 0);
        PCWriteCond, PCWrite, IorD, MemRead, MemWrite, MemToReg,
            IRWrite, RegDst, RegWrite, ALUSrcA, clk
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

    component reg is
        port(
            input   : in STD_LOGIC_VECTOR(31 downto 0);
            output  : out STD_LOGIC_VECTOR(31 downto 0);
            clk     : in STD_LOGIC
        );
    end component;

    -- alu
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0);
            zero        : out STD_LOGIC
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

    -- signals for registers
    signal PC_in, PC_out, instr_in, instr_out, memData_in, memData_out, A_in, A_out,
           B_in, B_out, ALUOut_in, ALUOut_out
                            : STD_LOGIC_VECTOR(31 downto 0);

    -- intermediate signals
    signal addr, WriteData, ALU_A, ALU_B, extended, offset, jump_addr
                            : STD_LOGIC_VECTOR(31 downto 0);
    
    signal WriteReg         : STD_LOGIC_VECTOR(4 downto 0);
    signal zero             : STD_LOGIC;
begin
    -- registers
    PCReg           : reg port map(PC_in, PC_out, clk);
    IReg            : reg port map(instr_in, instr_out, clk);
    MemDataReg      : reg port map(memData_in, memData_out, clk);
    AReg            : reg port map(A_in, A_out, clk);
    BReg            : reg port map(B_in, B_out, clk);
    ALUOutReg       : reg port map(ALUOut_in, ALUOut_out, clk);

    -- muxes
    IorD_Mux        : mux2 port map(PC_out, ALUOut_in, IorD, addr);
    RegDst_Mux      : mux2
                        generic map(5)
                        port map(instr_out(20 downto 16), instr_out(15 downto 11), RegDst, WriteReg);
    MemToReg_Mux    : mux2 port map(ALUOut_out, memData_out, MemToReg, WriteData);
    ALUSrcA_Mux     : mux2 port map(PC_out, A_out, ALUSrcA, ALU_A);
    ALUSrcB_Mux     : mux4 port map(B_out, x"00000004", extended, offset, ALUSrcB, ALU_B);
    PCSource_Mux    : mux4 port map(ALUOut_in, ALUOut_out, jump_addr, jump_addr, PCSource, PC_in);

    Extend          : sign_extend port map(instr_out(15 downto 0), extended);
    Shift_1         : shift_left port map(extended, offset);
    Shift_2         : shift_left
                        generic map(26)
                        port map(instr_out(25 downto 0), jump_addr);

    Mem             : memory port map(MemRead, MemWrite, addr, WriteData, memData_in);
    RegFile         : register_file port map(instr_out(25 downto 21), instr_out(20 downto 16),
                                           WriteReg, WriteData, RegWrite, A_in, B_in);
    ALU_1           : alu port map(ALU_A, ALU_B, ALUOp, ALUOut_in, zero);
    
    instr_in        <= memData_in;
end;