library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test addition for 1-bit ALU
entity test_alu_add is
end;

architecture sim of test_alu_add is
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp, neg  : in STD_LOGIC;
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    signal a, b, output : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp, neg   : STD_LOGIC;
begin
    dut: alu port map(a, b, ALUOp, neg, output);

    -- set control to addition
    ALUOp   <= '1';
    neg     <= '0';

    process begin
        a   <= "00000000000000000000000000000000";
        b   <= "00000000000000000000000000000000";
        wait for 150 ns;
        assert output = "00000000000000000000000000000000" report "0 + 0 failed";

        a   <= "00000000000000000000000000000001";
        b   <= "00000000000000000000000000000001";
        wait for 150 ns;
        assert output = "00000000000000000000000000000010" report "1 + 1 failed";

        a   <= "10101010101010101010101010101010";
        b   <= "01010101010101010101010101010101";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0xAAAA AAAA + 0x5555 5555 failed";

        a   <= "01010101010101010101010101010101";
        b   <= "10101010101010101010101010101010";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0x5555 5555 + 0xAAAA AAAA failed";

        a   <= "11111111111111111111111111111111";
        b   <= "11111111111111111111111111111111";
        wait for 150 ns;
        assert output = "11111111111111111111111111111110" report "0xFFFF FFFF + 0xFFFF FFFF failed";

        wait;
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test subtraction for 1-bit ALU
entity test_alu_sub is
end;

architecture sim of test_alu_sub is
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp, neg  : in STD_LOGIC;
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    signal a, b, output : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp, neg   : STD_LOGIC;
begin
    dut: alu port map(a, b, ALUOp, neg, output);

    -- set control to subtraction
    ALUOp   <= '1';
    neg     <= '1';

    process begin
        a   <= "00000000000000000000000000000000";
        b   <= "00000000000000000000000000000000";
        wait for 150 ns;
        assert output = "00000000000000000000000000000000" report "0 - 0 failed";

        a   <= "00000000000000000000000000000010";
        b   <= "00000000000000000000000000000001";
        wait for 150 ns;
        assert output = "00000000000000000000000000000001" report "2 - 1 failed";

        a   <= "00000000000000000000000000000001";
        b   <= "00000000000000000000000000000010";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "1 - 2 failed";

        a   <= "10101010101010101010101010101010";
        b   <= "01010101010101010101010101010101";
        wait for 150 ns;
        assert output = "01010101010101010101010101010101" report "0xAAAA AAAA - 0x5555 5555 failed";

        a   <= "01010101010101010101010101010101";
        b   <= "10101010101010101010101010101010";
        wait for 150 ns;
        assert output = "10101010101010101010101010101011" report "0x5555 5555 - 0xAAAA AAAA failed";

        wait;
    end process;
end;

library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test or for 1-bit ALU
entity test_alu_or is
end;

architecture sim of test_alu_or is
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp, neg  : in STD_LOGIC;
            output      : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;
    signal a, b, output : STD_LOGIC_VECTOR(31 downto 0);
    signal ALUOp, neg   : STD_LOGIC;
begin
    dut: alu port map(a, b, ALUOp, neg, output);

    -- set control to or
    ALUOp   <= '0';
    neg     <= '0';

    process begin
        a   <= "00000000000000000000000000000000";
        b   <= "00000000000000000000000000000000";
        wait for 150 ns;
        assert output = "00000000000000000000000000000000" report "0 or 0 failed";

        a   <= "00000000000000000000000000000010";
        b   <= "00000000000000000000000000000001";
        wait for 150 ns;
        assert output = "00000000000000000000000000000011" report "2 or 1 failed";

        a   <= "10101010101010101010101010101010";
        b   <= "01010101010101010101010101010101";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0xAAAA AAAA or 0x5555 5555 failed";

        a   <= "01010101010101010101010101010101";
        b   <= "10101010101010101010101010101010";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0x5555 5555 or 0xAAAA AAAA failed";

        wait;
    end process;
end;
