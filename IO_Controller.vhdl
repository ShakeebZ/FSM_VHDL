library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;

entity IO_Controller is
    port (
        toSeg : IN twoDArray;
        toHex : OUT twoDArray
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

    segDecoded0 : Custom7Seg PORT MAP(D => toSeg(0), Y => toHex(0));
    segDecoded1 : Custom7Seg PORT MAP(D => toSeg(1), Y => toHex(1));
    segDecoded2 : Custom7Seg PORT MAP(D => toSeg(2), Y => toHex(2));
    segDecoded3 : Custom7Seg PORT MAP(D => toSeg(3), Y => toHex(3));
    segDecoded4 : Custom7Seg PORT MAP(D => toSeg(4), Y => toHex(4));
    segDecoded5 : Custom7Seg PORT MAP(D => toSeg(5), Y => toHex(5));
    segDecoded6 : Custom7Seg PORT MAP(D => toSeg(6), Y => toHex(6));
    segDecoded7 : Custom7Seg PORT MAP(D => toSeg(7), Y => toHex(7));

end architecture;