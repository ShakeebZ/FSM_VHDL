library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ASIP is
    port (
        clkASIP, rstASIP, hard_rstASIP, stop_progASIP : in std_logic;
        programASIP : in std_logic_vector(3 DOWNTO 0);
        to_hex : out twoDArray;
        pauseButtonInputASIP : in std_logic;
        pce_out : out std_logic_vector(3 downto 0)

    );
end ASIP;

architecture rtl of ASIP is

begin

end architecture;