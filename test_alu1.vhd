library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test addition for 1-bit ALU
entity test_alu1_add is
end;

architecture sim of test_alu1_add is
    component alu1 is
        port(
            a, b, ALUOp, neg, Cin   : in STD_LOGIC;
            output, Cout            : out STD_LOGIC
        );
    end component;
    signal a, b, ALUOp, neg, Cin, output, Cout  : STD_LOGIC;
begin
    dut: alu1 port map(a, b, ALUOp, neg, Cin, output, Cout);
    
    -- set control to addition
    ALUOp   <= '1';
    neg     <= '0';
    Cin     <= '0';

    process begin
        a   <= '0';
        b   <= '0';
        wait for 10 ns;
        assert output = '0' report "0 + 0 failed";
        assert Cout = '0' report "0 + 0 failed";

        a   <= '0';
        b   <= '1';
        wait for 10 ns;
        assert output = '1' report "0 + 1 failed";
        assert Cout = '0' report "0 + 1 failed";

        a   <= '1';
        b   <= '0';
        wait for 10 ns;
        assert output = '1' report "1 + 0 failed";
        assert Cout = '0' report "1 + 0 failed";

        a   <= '1';
        b   <= '1';
        wait for 10 ns;
        assert output = '0' report "1 + 1 failed";
        assert Cout = '1' report "1 + 1 failed";
        
        wait;
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test subtraction for 1-bit ALU
entity test_alu1_sub is
end;

architecture sim of test_alu1_sub is
    component alu1 is
        port(
            a, b, ALUOp, neg, Cin   : in STD_LOGIC;
            output, Cout            : out STD_LOGIC
        );
    end component;
    signal a, b, ALUOp, neg, Cin, output, Cout  : STD_LOGIC;
begin
    dut: alu1 port map(a, b, ALUOp, neg, Cin, output, Cout);
    
    -- set control to subtraction
    ALUOp   <= '1';
    neg     <= '1';
    Cin     <= '1';

    process begin
        a   <= '0';
        b   <= '0';
        wait for 10 ns;
        assert output = '0' report "0 - 0 failed";
        assert Cout = '1' report "0 - 0 failed";

        a   <= '0';
        b   <= '1';
        wait for 10 ns;
        assert output = '1' report "0 - 1 failed";
        assert Cout = '0' report "0 - 1 failed";

        a   <= '1';
        b   <= '0';
        wait for 10 ns;
        assert output = '1' report "1 - 0 failed";
        assert Cout = '1' report "1 - 0 failed";

        a   <= '1';
        b   <= '1';
        wait for 10 ns;
        assert output = '0' report "1 - 1 failed";
        assert Cout = '1' report "1 - 1 failed";
        
        wait;
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test or for 1-bit ALU
-- note that Cout is meaningless in this test
entity test_alu1_or is
end;

architecture sim of test_alu1_or is
    component alu1 is
        port(
            a, b, ALUOp, neg, Cin   : in STD_LOGIC;
            output, Cout            : out STD_LOGIC
        );
    end component;
        signal a, b, ALUOp, neg, Cin, output, Cout  : STD_LOGIC;
begin
    dut: alu1 port map(a, b, ALUOp, neg, Cin, output, Cout);

    -- set control to or
    ALUOp   <= '0';
    neg     <= '0';
    Cin     <= '0';

    process begin
        a   <= '0';
        b   <= '0';
        wait for 10 ns;
        assert output = '0' report "0 or 0 failed";

        a   <= '0';
        b   <= '1';
        wait for 10 ns;
        assert output = '1' report "0 or 1 failed";

        a   <= '1';
        b   <= '0';
        wait for 10 ns;
        assert output = '1' report "1 or 0 failed";

        a   <= '1';
        b   <= '1';
        wait for 10 ns;
        assert output = '1' report "1 or 1 failed";

        wait;
    end process;
end;