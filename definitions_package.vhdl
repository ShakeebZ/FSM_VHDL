LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
package definitions_package is
-- Package Declaration Section (examples below)
CONSTANT N : INTEGER := 8;
TYPE bus_width IS ARRAY (0 to 2) OF UNSIGNED(N-1 DOWNTO 0);
type twoDArrayIO IS array (7 downto 0) of std_logic_vector(6 downto 0); -- 7seg display * 8 hex displays
type twoDArrayCU IS array (7 DOWNTO 0) of std_logic_vector(4 downto 0);
end package definitions_package;
package body definitions_package is
--blank, include any implementations here, if necessary

end package body definitions_package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use std.textio.all;
use std.env.finish;

entity dutent_tb is
end dutent_tb;

architecture sim of dutent_tb is

    constant clk_hz : integer := 100e6;
    constant clk_period : time := 1 sec / clk_hz;

    signal clk : std_logic := '1';
    signal rst : std_logic := '1';

begin

    clk <= not clk after clk_period / 2;

    DUT : entity work.dutent(rtl)
    port map (
        clk => clk,
        rst => rst,
        
    );

    SEQUENCER_PROC : process
    begin
        wait for clk_period * 2;

        rst <= '0';

        wait for clk_period * 10;
        assert false
            report "Replace this with your test cases"
            severity failure;

        finish;
    end process;

end architecture;