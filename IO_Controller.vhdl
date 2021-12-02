library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity IO_Controller is
    port (
        toSeg : IN std_logic_vector(39 downto 0);
        toHex : OUT std_logic_vector(55 downto 0)
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
    
    segDecoded0 : Custom7Seg PORT MAP(D => toSeg(4 DOWNTO 0), Y => toHex(6 DOWNTO 0));
    segDecoded1 : Custom7Seg PORT MAP(D => toSeg(9 DOWNTO 5), Y => toHex(13 DOWNTO 7));
    segDecoded2 : Custom7Seg PORT MAP(D => toSeg(14 DOWNTO 10), Y => toHex(20 DOWNTO 14));
    segDecoded3 : Custom7Seg PORT MAP(D => toSeg(19 DOWNTO 15), Y => toHex(27 DOWNTO 21));
    segDecoded4 : Custom7Seg PORT MAP(D => toSeg(24 DOWNTO 20), Y => toHex(34 DOWNTO 28));
    segDecoded5 : Custom7Seg PORT MAP(D => toSeg(29 DOWNTO 25), Y => toHex(41 DOWNTO 35));
    segDecoded6 : Custom7Seg PORT MAP(D => toSeg(34 DOWNTO 30), Y => toHex(48 DOWNTO 42));
    segDecoded7 : Custom7Seg PORT MAP(D => toSeg(39 DOWNTO 35), Y => toHex(55 DOWNTO 49));

end architecture;