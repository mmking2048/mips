library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- test program for adder
entity test_adder is
end;

architecture sim of test_adder is
    component adder is
        port(
            a, b, cin   : in STD_LOGIC;
            sum, carry  : out STD_LOGIC
        );
    end component;
    signal a, b, cin, sum, carry    : STD_LOGIC;
begin
    dut: adder port map(a, b, cin, sum, carry);

    process begin
        a   <= '0';
        b   <= '0';
        cin <= '0';
        wait for 10 ns;
        assert sum = '0' report "0 + 0 + 0 failed";
        assert carry = '0' report "0 + 0 + 0 failed";

        a   <= '0';
        b   <= '0';
        cin <= '1';
        wait for 10 ns;
        assert sum = '1' report "0 + 0 + 1 failed";
        assert carry = '0' report "0 + 0 + 1 failed";

        a   <= '0';
        b   <= '1';
        cin <= '0';
        wait for 10 ns;
        assert sum = '1' report "0 + 1 + 0 failed";
        assert carry = '0' report "0 + 1 + 0 failed";

        a   <= '0';
        b   <= '1';
        cin <= '1';
        wait for 10 ns;
        assert sum = '0' report "0 + 1 + 1 failed";
        assert carry = '1' report "0 + 1 + 1 failed";

        a   <= '1';
        b   <= '0';
        cin <= '0';
        wait for 10 ns;
        assert sum = '1' report "1 + 0 + 0 failed";
        assert carry = '0' report "0 + 0 + 0 failed";

        a   <= '1';
        b   <= '0';
        cin <= '1';
        wait for 10 ns;
        assert sum = '0' report "1 + 0 + 1 failed";
        assert carry = '1' report "1 + 0 + 1 failed";

        a   <= '1';
        b   <= '1';
        cin <= '0';
        wait for 10 ns;
        assert sum = '0' report "1 + 1 + 0 failed";
        assert carry = '1' report "1 + 1 + 0 failed";

        a   <= '1';
        b   <= '1';
        cin <= '1';
        wait for 10 ns;
        assert sum = '1' report "1 + 1 + 1 failed";
        assert carry = '1' report "1 + 1 + 1 failed";

        wait;
    end process;
end;
