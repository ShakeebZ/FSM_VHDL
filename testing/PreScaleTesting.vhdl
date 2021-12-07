library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PreScaleTesting is
    port (
        CLOCK_50 : in std_logic;
        SW : in std_logic_vector(1 DOWNTO 0);
        LEDR : out std_logic_vector(17 DOWNTO 0)
    );
end PreScaleTesting;

architecture rtl of PreScaleTesting is
component PreScale port (
    clk : in std_logic;
    mode : in std_logic_vector(1 DOWNTO 0);
    clk_out : out std_logic
);
END COMPONENT;
begin
--Connecting the switches directly to the mode and the clock out port to an led to ensure correct functionality
PreScaleTestingComponent : PreScale port map(clk => CLOCK_50, mode => SW(1 DOWNTO 0), clk_out => LEDR(0));

end architecture;