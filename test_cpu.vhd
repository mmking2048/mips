library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_cpu_lw is
end;

architecture sim of test_cpu_lw is
    component cpu is
        port(
            ALUOp, ALUSrcB              : in STD_LOGIC_VECTOR(1 downto 0);
            PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA, clk
                                        : in STD_LOGIC
        );
    end component;

    signal ALUOp, ALUSrcB               : STD_LOGIC_VECTOR(1 downto 0);
    signal PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
           MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA
                                        : STD_LOGIC;
    signal clk                          : STD_LOGIC := '0';
begin
    dut: cpu port map(ALUOp, ALUSrcB, PCSource, PCWriteCond, PCWrite,
                    IorD, MemRead, MemWrite, MemToReg, IRWrite, RegDst,
                    RegWrite, ALUSrcA, clk);

    clk             <= not clk after 25 ns;

    process begin
        -- setup
        -- write instruction into memory location 0
        -- 8E4B 012C
        -- write data into register $s2
        -- R18 (x12): 0000 0000
        -- write data into memory
        -- x12C: DEAD BEEF

        -- cycle 1: IF
        PCWrite     <= '1';
        PCWriteCond <= '0';
        IorD        <= '1';
        MemRead     <= '1';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '1';
        PCSource    <= '0';
        ALUOp       <= "10";
        ALUSrcA     <= '0';
        ALUSrcB     <= "01";
        RegWrite    <= '0';
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 2: ID/RR
        PCWrite     <= '0';
        IRWrite     <= '0';
        ALUSrcB     <= "11";
        RegDst      <= '0';

        wait for 50 ns;
        
        -- cycle 3: EX
        ALUSrcA     <= '1';
        ALUSrcB     <= "10";

        wait for 50 ns;

        -- cycle 4: MEM
        IorD        <= '1';

        wait for 50 ns;

        -- cycle 5: WB
        MemToReg    <= '1';
        RegWrite    <= '1';

        wait for 50 ns;

        -- check register file entry 11 (xB)
        -- value should be DEAD BEEF
        wait;
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_cpu_sw is
end;

architecture sim of test_cpu_sw is
    component cpu is
        port(
            ALUOp, ALUSrcB              : in STD_LOGIC_VECTOR(1 downto 0);
            PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA, clk
                                        : in STD_LOGIC
        );
    end component;

    signal ALUOp, ALUSrcB               : STD_LOGIC_VECTOR(1 downto 0);
    signal PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
           MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA
                                        : STD_LOGIC;
    signal clk                          : STD_LOGIC := '0';
begin
    dut: cpu port map(ALUOp, ALUSrcB, PCSource, PCWriteCond, PCWrite,
                    IorD, MemRead, MemWrite, MemToReg, IRWrite, RegDst,
                    RegWrite, ALUSrcA, clk);

    clk             <= not clk after 25 ns;
    process begin
        -- setup
        -- write instruction into memory location 0
        -- AEEE 0190
        -- write data into register $t6 and $s7
        -- R14 (xE): DEAD BEEF
        -- R23 (x17): 0000 0000
        
        -- cycle 1: IF
        PCWrite     <= '1';
        PCWriteCond <= '0';
        IorD        <= '1';
        MemRead     <= '1';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '1';
        PCSource    <= '0';
        ALUOp       <= "10";
        ALUSrcA     <= '0';
        ALUSrcB     <= "01";
        RegWrite    <= '0';
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 2: ID/RR
        PCWrite     <= '0';
        IRWrite     <= '0';
        ALUSrcB     <= "11";
        RegDst      <= '0';

        -- cycle 3: EX
        ALUSrcA     <= '1';
        ALUSrcB     <= "10";

        wait for 50 ns;

        -- cycle 4: MEM
        IorD        <= '1';
        MemWrite    <= '1';

        wait for 50 ns;

        -- check memory location x190
        -- value should be DEAD BEEF
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_cpu_add is
end;

architecture sim of test_cpu_add is
    component cpu is
        port(
            ALUOp, ALUSrcB              : in STD_LOGIC_VECTOR(1 downto 0);
            PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA, clk
                                        : in STD_LOGIC
        );
    end component;

    signal ALUOp, ALUSrcB               : STD_LOGIC_VECTOR(1 downto 0);
    signal PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
           MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA
                                        : STD_LOGIC;
    signal clk                          : STD_LOGIC := '0';
begin
    process begin
        -- setup
        -- write instruction into memory location 0
        -- 0170 0190
        -- write data into register $t3, $s1
        -- R11 (xB): 0000 0001
        -- R17 (x11): 0000 0002
        
        -- cycle 1: IF
        PCWrite     <= '1';
        PCWriteCond <= '0';
        IorD        <= '1';
        MemRead     <= '1';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '1';
        PCSource    <= '0';
        ALUOp       <= "10";
        ALUSrcA     <= '0';
        ALUSrcB     <= "01";
        RegWrite    <= '0';
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 2: ID/RR
        PCWrite     <= '0';
        IRWrite     <= '0';
        ALUSrcB     <= "11";
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 3: EX
        ALUSrcA     <= '1';
        ALUSrcB     <= "00";

        -- cycle 4: WB
        MemToReg    <= '0';
        RegWrite    <= '1';

        -- check register $t5
        -- R13 (xD): 0000 0003
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_cpu_beq is
end;

architecture sim of test_cpu_beq is
    component cpu is
        port(
            ALUOp, ALUSrcB              : in STD_LOGIC_VECTOR(1 downto 0);
            PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA, clk
                                        : in STD_LOGIC
        );
    end component;

    signal ALUOp, ALUSrcB               : STD_LOGIC_VECTOR(1 downto 0);
    signal PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
           MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA
                                        : STD_LOGIC;
    signal clk                          : STD_LOGIC := '0';
begin
    dut: cpu port map(ALUOp, ALUSrcB, PCSource, PCWriteCond, PCWrite,
                    IorD, MemRead, MemWrite, MemToReg, IRWrite, RegDst,
                    RegWrite, ALUSrcA, clk);

    clk             <= not clk after 25 ns;
    process begin
        -- setup
        -- write instruction into memory location 0
        -- 11B6 00C8
        -- write data into register $s6, $t5
        -- R22 (x16): 1111 1111
        -- R13 (xD): 1111 1111
        
        -- cycle 1: IF
        PCWrite     <= '1';
        PCWriteCond <= '0';
        IorD        <= '1';
        MemRead     <= '1';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '1';
        PCSource    <= '0';
        ALUOp       <= "10";
        ALUSrcA     <= '0';
        ALUSrcB     <= "01";
        RegWrite    <= '0';
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 2: ID/RR
        PCWrite     <= '0';
        IRWrite     <= '0';
        ALUSrcB     <= "11";
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 3: EX
        ALUOp       <= "11";
        ALUSrcA     <= '1';
        ALUSrcB     <= "00";
        PCWriteCond <= '1';

        -- check PC: value should be branch address
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_cpu_subi is
end;

architecture sim of test_cpu_subi is
    component cpu is
        port(
            ALUOp, ALUSrcB              : in STD_LOGIC_VECTOR(1 downto 0);
            PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA, clk
                                        : in STD_LOGIC
        );
    end component;

    signal ALUOp, ALUSrcB               : STD_LOGIC_VECTOR(1 downto 0);
    signal PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
           MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA
                                        : STD_LOGIC;
    signal clk                          : STD_LOGIC := '0';
begin
    dut: cpu port map(ALUOp, ALUSrcB, PCSource, PCWriteCond, PCWrite,
                    IorD, MemRead, MemWrite, MemToReg, IRWrite, RegDst,
                    RegWrite, ALUSrcA, clk);

    clk             <= not clk after 25 ns;
    process begin
        -- setup
        
        -- cycle 1: IF
        PCWrite     <= '1';
        PCWriteCond <= '0';
        IorD        <= '1';
        MemRead     <= '1';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '1';
        PCSource    <= '0';
        ALUOp       <= "10";
        ALUSrcA     <= '0';
        ALUSrcB     <= "01";
        RegWrite    <= '0';
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 2: ID/RR
        PCWrite     <= '0';
        IRWrite     <= '0';
        ALUSrcB     <= "11";
        RegDst      <= '0';

        wait for 50 ns;

        -- check
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity test_cpu_ori is
end;

architecture sim of test_cpu_ori is
    component cpu is
        port(
            ALUOp, ALUSrcB              : in STD_LOGIC_VECTOR(1 downto 0);
            PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
                MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA, clk
                                        : in STD_LOGIC
        );
    end component;

    signal ALUOp, ALUSrcB               : STD_LOGIC_VECTOR(1 downto 0);
    signal PCSource, PCWriteCond, PCWrite, IorD, MemRead, MemWrite,
           MemToReg, IRWrite, RegDst, RegWrite, ALUSrcA
                                        : STD_LOGIC;
    signal clk                          : STD_LOGIC := '0';
begin
    dut: cpu port map(ALUOp, ALUSrcB, PCSource, PCWriteCond, PCWrite,
                    IorD, MemRead, MemWrite, MemToReg, IRWrite, RegDst,
                    RegWrite, ALUSrcA, clk);

    clk             <= not clk after 25 ns;
    process begin
        -- setup
        
        -- cycle 1: IF
        PCWrite     <= '1';
        PCWriteCond <= '0';
        IorD        <= '1';
        MemRead     <= '1';
        MemWrite    <= '0';
        MemToReg    <= '0';
        IRWrite     <= '1';
        PCSource    <= '0';
        ALUOp       <= "10";
        ALUSrcA     <= '0';
        ALUSrcB     <= "01";
        RegWrite    <= '0';
        RegDst      <= '0';

        wait for 50 ns;

        -- cycle 2: ID/RR
        PCWrite     <= '0';
        IRWrite     <= '0';
        ALUSrcB     <= "11";
        RegDst      <= '0';

        wait for 50 ns;

        -- check
    end process;
end;
