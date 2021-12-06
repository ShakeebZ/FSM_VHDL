library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PreScale is
    port (
        clk : in std_logic;
        mode : in std_logic_vector(1 DOWNTO 0);
		  disable : in std_logic; -- Pause button (disables the clock)
        clk_out : out std_logic
    );
end PreScale;

architecture rtl of PreScale is
Signal CounterNormal : SIGNED(24 DOWNTO 0) := (others => '0');
SIGNAL CounterSlow : SIGNED(25 DOWNTO 0) := (others => '0');
SIGNAL CounterFast : Signed(23 DOWNTO 0) := (others => '0');
SIGNAL CounterVeryFast : Signed(22 DOWNTO 0) := (others => '0');
BEGIN
PROCESS(clk)
BEGIN
if (rising_edge(clk)) THEN
    CounterNormal <= CounterNormal + 1;
    CounterSlow <= CounterSlow + 1;
    CounterFast <= CounterFast + 1;
    CounterVeryFast <= CounterVeryFast + 1;
END IF;
END PROCESS;

clk_out <= STD_LOGIC(CounterNormal(24)) WHEN mode = "00" AND disable = '0' ELSE
        STD_LOGIC(CounterSlow(25)) WHEN mode = "01" AND disable = '0' ELSE
        STD_LOGIC(CounterFast(23)) WHEN mode = "10" AND disable = '0' ELSE
        STD_LOGIC(CounterVeryFast(22)) WHEN mode = "11" AND disable = '0' ELSE
        '0';
end architecture;