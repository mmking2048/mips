library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test addition for 1-bit ALU
entity test_alu_add is
end;

architecture sim of test_alu_add is
    component alu is
        port(
            a, b        : in STD_LOGIC_VECTOR(31 downto 0);
            ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0);
            zero        : out STD_LOGIC
        );
    end component;
    signal a, b, output : STD_LOGIC_VECTOR(31 downto 0);
    signal zero         : STD_LOGIC;
    signal ALUOp        : STD_LOGIC_VECTOR(1 downto 0);
begin
    dut: alu port map(a, b, ALUOp, output, zero);

    -- set control to addition
    ALUOp   <= "10";

    process begin
        a   <= "00000000000000000000000000000000";
        b   <= "00000000000000000000000000000000";
        wait for 150 ns;
        assert output = "00000000000000000000000000000000" report "0 + 0 failed";
        assert zero = '1' report "0 + 0 zero detection failed";

        a   <= "00000000000000000000000000000001";
        b   <= "00000000000000000000000000000001";
        wait for 150 ns;
        assert output = "00000000000000000000000000000010" report "1 + 1 failed";
        assert zero = '0' report "1 + 1 zero detection failed";

        a   <= "10101010101010101010101010101010";
        b   <= "01010101010101010101010101010101";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0xAAAA AAAA + 0x5555 5555 failed";
        assert zero = '0' report "0xAAAA AAAA + 0x5555 5555 zero detection failed";

        a   <= "01010101010101010101010101010101";
        b   <= "10101010101010101010101010101010";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0x5555 5555 + 0xAAAA AAAA failed";
        assert zero = '0' report "0x5555 5555 + 0xAAAA AAAA zero detection failed";

        a   <= "11111111111111111111111111111111";
        b   <= "11111111111111111111111111111111";
        wait for 150 ns;
        assert output = "11111111111111111111111111111110" report "0xFFFF FFFF + 0xFFFF FFFF failed";
        assert zero = '0' report "0xFFFF FFFF + 0xFFFF FFFF zero detection failed";

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
            ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0);
            zero        : out STD_LOGIC
        );
    end component;
    signal a, b, output : STD_LOGIC_VECTOR(31 downto 0);
    signal zero         : STD_LOGIC;
    signal ALUOp        : STD_LOGIC_VECTOR(1 downto 0);
begin
    dut: alu port map(a, b, ALUOp, output, zero);

    -- set control to subtraction
    ALUOp   <= "11";

    process begin
        a   <= "00000000000000000000000000000000";
        b   <= "00000000000000000000000000000000";
        wait for 150 ns;
        assert output = "00000000000000000000000000000000" report "0 - 0 failed";
        assert zero = '1' report "0 - 0 zero detection failed";

        a   <= "00000000000000000000000000000010";
        b   <= "00000000000000000000000000000001";
        wait for 150 ns;
        assert output = "00000000000000000000000000000001" report "2 - 1 failed";
        assert zero = '0' report "2 - 1 zero detection failed";

        a   <= "00000000000000000000000000000001";
        b   <= "00000000000000000000000000000010";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "1 - 2 failed";
        assert zero = '0' report "1 - 2 zero detection failed";

        a   <= "10101010101010101010101010101010";
        b   <= "01010101010101010101010101010101";
        wait for 150 ns;
        assert output = "01010101010101010101010101010101" report "0xAAAA AAAA - 0x5555 5555 failed";
        assert zero = '0' report "0xAAAA AAAA - 0x5555 5555 zero detection failed";

        a   <= "01010101010101010101010101010101";
        b   <= "10101010101010101010101010101010";
        wait for 150 ns;
        assert output = "10101010101010101010101010101011" report "0x5555 5555 - 0xAAAA AAAA failed";
        assert zero = '0' report "0x5555 5555 - 0xAAAA AAAA zero detection failed";

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
            ALUOp       : in STD_LOGIC_VECTOR(1 downto 0);
            output      : out STD_LOGIC_VECTOR(31 downto 0);
            zero        : out STD_LOGIC
        );
    end component;
    signal a, b, output : STD_LOGIC_VECTOR(31 downto 0);
    signal zero         : STD_LOGIC;
    signal ALUOp        : STD_LOGIC_VECTOR(1 downto 0);
begin
    dut: alu port map(a, b, ALUOp, output, zero);

    -- set control to or
    ALUOp   <= "00";

    process begin
        a   <= "00000000000000000000000000000000";
        b   <= "00000000000000000000000000000000";
        wait for 150 ns;
        assert output = "00000000000000000000000000000000" report "0 or 0 failed";
        assert zero = '1' report "0 or 0 zero detection failed";

        a   <= "00000000000000000000000000000010";
        b   <= "00000000000000000000000000000001";
        wait for 150 ns;
        assert output = "00000000000000000000000000000011" report "2 or 1 failed";
        assert zero = '0' report "2 or 1 zero detection failed";

        a   <= "10101010101010101010101010101010";
        b   <= "01010101010101010101010101010101";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0xAAAA AAAA or 0x5555 5555 failed";
        assert zero = '0' report "0xAAAA AAAA or 0x5555 5555 zero detection failed";

        a   <= "01010101010101010101010101010101";
        b   <= "10101010101010101010101010101010";
        wait for 150 ns;
        assert output = "11111111111111111111111111111111" report "0x5555 5555 or 0xAAAA AAAA failed";
        assert zero = '0' report "0x5555 5555 or 0xAAAA AAAA zero detection failed";

        wait;
    end process;
end;
