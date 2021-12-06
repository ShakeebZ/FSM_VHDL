library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ToneGenerator_tb is
end ToneGenerator_tb;

architecture sim of ToneGenerator_tb is

component ToneGenerator is
port (
    instTG : in std_logic_vector(6 DOWNTO 0);
    WaveOut : out std_logic
);
end component;

Signal instruction : SIGNED(6 DOWNTO 0);
Signal WaveOutTest : std_logic;
signal clk : std_logic := '0';
begin

    process
    begin
        clk <= NOT clk;
        wait for 25 ns;
    end process;

    DUT : ToneGenerator
    port map (
        instTG => std_logic_vector(instruction),
        WaveOut => WaveOutTest;
        
    );

    SEQUENCER_PROC : process
    begin
        wait for 50 ns;
        instruction <= instruction + 1;

    end process;

end architecture;