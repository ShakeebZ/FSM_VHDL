library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY PCETB is 
END entity PCETB;

architecture tb of PCETB is
component PCE 
    port (
        hardResetPCE : In STD_LOGIC;
        ClkPCE : In STD_Logic;
        programPCE : In STD_Logic;
        toGreenlights : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end component;

SIGNAL hardResetPCETest : STD_LOGIC := '1';
SIGNAL ClkPCETest : STD_LOGIC := '0';
SIGNAL programPCETest : STD_LOGIC := '0';
SIGNAL toGreenlightsTest : STD_LOGIC_VECTOR(3 downto 0);

begin
    process
        begin
            ClkPCETest <= NOT ClkPCETest;
            wait for 50 ns;
        END process;
    
    process
        begin
            programPCETest <= NOT programPCETest;
            wait for 200 ns;
        END process;
    
    process
        begin
            hardResetPCETest <= NOT hardResetPCETest;
            wait for 3200 ns;
        END PROCESS;

    DUT : PCE port map (hardResetPCE => hardResetPCETest,
                        ClkPCE => ClkPCETest,
                        programPCE => programPCETest,
                        toGreenlights => toGreenlightsTest);
END architecture;
    