
-- The ToneGeneratorTesting file initializes a signal instruction to be "1110010" (our error case) then flips every bit every second.
-- This should result in a noise emitting for one second, then no noise, etc.
-- Due to our ToneGenerator not working as intended, this testing file failed.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ToneGeneratorTesting is
        port (
		  AUD_ADCDAT : out std_logic
    );
end ToneGeneratorTesting;

architecture rtl of ToneGeneratorTesting is

component ToneGenerator IS
    port (
        instTG : in std_logic_vector(6 DOWNTO 0);
		  WaveOut : out std_logic
    );
end component;

SIGNAL instruction : std_logic_vector(6 DOWNTO 0) := ("1110010");

begin

PROCESS
BEGIN
instruction(0) <= NOT instruction(0) ;
instruction(1) <= NOT instruction(1) ;
instruction(2) <= NOT instruction(2) ;
instruction(3) <= NOT instruction(3) ;
instruction(4) <= NOT instruction(4) ;
instruction(5) <= NOT instruction(5) ;
instruction(6) <= NOT instruction(6) ;
wait for 1 sec;
END PROCESS;

ToneGeneratorComponent : ToneGenerator     port map(
        instTG => instruction,
		  WaveOut => AUD_ADCDAT
    );
end architecture;