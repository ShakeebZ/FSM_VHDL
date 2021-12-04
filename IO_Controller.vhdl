library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;

entity IO_Controller is
    port (
        toSeg : IN twoDArrayCU;
        toHex : OUT twoDArrayIO
    );
end IO_Controller;

architecture structure of IO_Controller is

    component Custom7Seg is
        port (
            D : IN STD_LOGIC_VECTOR(4 downto 0);
            Y : OUT STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;
begin

    for i in 0 to 7 generate
        segDecoded : Custom7Seg PORT MAP(D => toSeg(i), Y => toHex(i));
    end generate;
end architecture;