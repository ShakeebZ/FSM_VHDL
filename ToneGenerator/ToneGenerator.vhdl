-- Does not work, only emits error sound if initially set to the error instruction
-- When initial instruction is not the error instruction, no sound is emitted even if the instruction is later set to the error instruction

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ToneGenerator is
    port (
        instTG : in std_logic_vector(6 DOWNTO 0);
		  WaveOut : out std_logic
    );
end ToneGenerator;

architecture rtl of ToneGenerator is

SIGNAL Accumulator : SIGNED(21 DOWNTO 0) := (others => '0');

begin

Accumulator <= (others => '0') when instTG /= "1110010" -- Accumulator is set to 0 if the instruction is not the error instruction
ELSE "0000001111111111111111" + Accumulator; -- Runs when instTG is the error instruction

WaveOut <= std_logic(Accumulator(21));

end architecture;