library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Custom7SegTesting is
    port (
        SW : in std_logic_vector(17 downto 0);
        HEX0 : OUT std_logic_vector(6 downto 0)
    );
end Custom7SegTesting;

architecture rtl of Custom7SegTesting is
component Custom7Seg
    port(
    D : IN STD_LOGIC_VECTOR(4 downto 0);
    Y : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end component;
begin
    DUT1 : Custom7Seg Port Map(D => SW(4 downto 0), Y => HEX0);
    
end architecture;