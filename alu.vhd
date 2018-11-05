library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_MISC.all;

-- full 32-bit ALU
-- note this uses ripple carry adder
-- op is the control signal
-- upper bit represents op, lower represents neg
entity alu is
    port(
        a, b        : in STD_LOGIC_VECTOR(31 downto 0);
        ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
        output      : out STD_LOGIC_VECTOR(31 downto 0);
        zero        : out STD_LOGIC
    );
end;

-- make a 32-bit ALU by stacking 32 1-bit ALUs
architecture struct of alu is
    component alu1
        port(
            a, b, op, neg, Cin  : in STD_LOGIC;
            output, Cout        : out STD_LOGIC
        );
    end component;
    signal carry, alu_out   : STD_LOGIC_VECTOR(31 downto 0);
    signal op, neg          : STD_LOGIC;
begin
    op  <= ALUOp(1);
    neg <= ALUOp(0);

    alu_0:  alu1 port map(a(0), b(0), op, neg, neg, alu_out(0), carry(0));
    alu_1:  alu1 port map(a(1), b(1), op, neg, carry(0), alu_out(1), carry(1));
    alu_2:  alu1 port map(a(2), b(2), op, neg, carry(1), alu_out(2), carry(2));
    alu_3:  alu1 port map(a(3), b(3), op, neg, carry(2), alu_out(3), carry(3));
    alu_4:  alu1 port map(a(4), b(4), op, neg, carry(3), alu_out(4), carry(4));
    alu_5:  alu1 port map(a(5), b(5), op, neg, carry(4), alu_out(5), carry(5));
    alu_6:  alu1 port map(a(6), b(6), op, neg, carry(5), alu_out(6), carry(6));
    alu_7:  alu1 port map(a(7), b(7), op, neg, carry(6), alu_out(7), carry(7));
    alu_8:  alu1 port map(a(8), b(8), op, neg, carry(7), alu_out(8), carry(8));
    alu_9:  alu1 port map(a(9), b(9), op, neg, carry(8), alu_out(9), carry(9));
    alu_10: alu1 port map(a(10), b(10), op, neg, carry(9), alu_out(10), carry(10));
    alu_11: alu1 port map(a(11), b(11), op, neg, carry(10), alu_out(11), carry(11));
    alu_12: alu1 port map(a(12), b(12), op, neg, carry(11), alu_out(12), carry(12));
    alu_13: alu1 port map(a(13), b(13), op, neg, carry(12), alu_out(13), carry(13));
    alu_14: alu1 port map(a(14), b(14), op, neg, carry(13), alu_out(14), carry(14));
    alu_15: alu1 port map(a(15), b(15), op, neg, carry(14), alu_out(15), carry(15));
    alu_16: alu1 port map(a(16), b(16), op, neg, carry(15), alu_out(16), carry(16));
    alu_17: alu1 port map(a(17), b(17), op, neg, carry(16), alu_out(17), carry(17));
    alu_18: alu1 port map(a(18), b(18), op, neg, carry(17), alu_out(18), carry(18));
    alu_19: alu1 port map(a(19), b(19), op, neg, carry(18), alu_out(19), carry(19));
    alu_20: alu1 port map(a(20), b(20), op, neg, carry(19), alu_out(20), carry(20));
    alu_21: alu1 port map(a(21), b(21), op, neg, carry(20), alu_out(21), carry(21));
    alu_22: alu1 port map(a(22), b(22), op, neg, carry(21), alu_out(22), carry(22));
    alu_23: alu1 port map(a(23), b(23), op, neg, carry(22), alu_out(23), carry(23));
    alu_24: alu1 port map(a(24), b(24), op, neg, carry(23), alu_out(24), carry(24));
    alu_25: alu1 port map(a(25), b(25), op, neg, carry(24), alu_out(25), carry(25));
    alu_26: alu1 port map(a(26), b(26), op, neg, carry(25), alu_out(26), carry(26));
    alu_27: alu1 port map(a(27), b(27), op, neg, carry(26), alu_out(27), carry(27));
    alu_28: alu1 port map(a(28), b(28), op, neg, carry(27), alu_out(28), carry(28));
    alu_29: alu1 port map(a(29), b(29), op, neg, carry(28), alu_out(29), carry(29));
    alu_30: alu1 port map(a(30), b(30), op, neg, carry(29), alu_out(30), carry(30));
    alu_31: alu1 port map(a(31), b(31), op, neg, carry(30), alu_out(31), carry(31));

    output <= alu_out;
    zero <= nor_reduce(alu_out);
end;