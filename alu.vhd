library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- full 32-bit ALU
-- note this uses ripple carry adder
entity alu is
    port(
        a, b        : in STD_LOGIC_VECTOR(31 downto 0);
        ALUOp, Cin  : in STD_LOGIC;
        output      : out STD_LOGIC_VECTOR(31 downto 0)
    );
end;

-- make a 32-bit ALU by stacking 32 1-bit ALUs
architecture struct of alu is
    component alu1
        port(
            a, b, ALUOp, Cin    : in STD_LOGIC;
            output, Cout        : out STD_LOGIC
        );
    end component;
    signal carry    : STD_LOGIC_VECTOR(31 downto 0);
begin
    alu_0:  alu1 port map(a(0), b(0), ALUOp, Cin, output(0), carry(0));
    alu_1:  alu1 port map(a(1), b(1), ALUOp, carry(0), output(1), carry(1));
    alu_2:  alu1 port map(a(2), b(2), ALUOp, carry(1), output(2), carry(2));
    alu_3:  alu1 port map(a(3), b(3), ALUOp, carry(2), output(3), carry(3));
    alu_4:  alu1 port map(a(4), b(4), ALUOp, carry(3), output(4), carry(4));
    alu_5:  alu1 port map(a(5), b(5), ALUOp, carry(4), output(5), carry(5));
    alu_6:  alu1 port map(a(6), b(6), ALUOp, carry(5), output(6), carry(6));
    alu_7:  alu1 port map(a(7), b(7), ALUOp, carry(6), output(7), carry(7));
    alu_8:  alu1 port map(a(8), b(8), ALUOp, carry(7), output(8), carry(8));
    alu_9:  alu1 port map(a(9), b(9), ALUOp, carry(8), output(9), carry(9));
    alu_10: alu1 port map(a(10), b(10), ALUOp, carry(9), output(10), carry(10));
    alu_11: alu1 port map(a(11), b(11), ALUOp, carry(10), output(11), carry(11));
    alu_12: alu1 port map(a(12), b(12), ALUOp, carry(11), output(12), carry(12));
    alu_13: alu1 port map(a(13), b(13), ALUOp, carry(12), output(13), carry(13));
    alu_14: alu1 port map(a(14), b(14), ALUOp, carry(13), output(14), carry(14));
    alu_15: alu1 port map(a(15), b(15), ALUOp, carry(14), output(15), carry(15));
    alu_16: alu1 port map(a(16), b(16), ALUOp, carry(15), output(16), carry(16));
    alu_17: alu1 port map(a(17), b(17), ALUOp, carry(16), output(17), carry(17));
    alu_18: alu1 port map(a(18), b(18), ALUOp, carry(17), output(18), carry(18));
    alu_19: alu1 port map(a(19), b(19), ALUOp, carry(18), output(19), carry(19));
    alu_20: alu1 port map(a(20), b(20), ALUOp, carry(19), output(20), carry(20));
    alu_21: alu1 port map(a(21), b(21), ALUOp, carry(20), output(21), carry(21));
    alu_22: alu1 port map(a(22), b(22), ALUOp, carry(21), output(22), carry(22));
    alu_23: alu1 port map(a(23), b(23), ALUOp, carry(22), output(23), carry(23));
    alu_24: alu1 port map(a(24), b(24), ALUOp, carry(23), output(24), carry(24));
    alu_25: alu1 port map(a(25), b(25), ALUOp, carry(24), output(25), carry(25));
    alu_26: alu1 port map(a(26), b(26), ALUOp, carry(25), output(26), carry(26));
    alu_27: alu1 port map(a(27), b(27), ALUOp, carry(26), output(27), carry(27));
    alu_28: alu1 port map(a(28), b(28), ALUOp, carry(27), output(28), carry(28));
    alu_29: alu1 port map(a(29), b(29), ALUOp, carry(28), output(29), carry(29));
    alu_30: alu1 port map(a(30), b(30), ALUOp, carry(29), output(30), carry(30));
    alu_31: alu1 port map(a(31), b(31), ALUOp, carry(30), output(31), carry(31));
end;