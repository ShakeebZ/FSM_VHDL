library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Custom7Seg is
    port (
        D : IN STD_LOGIC_VECTOR(4 downto 0);
        Y : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end Custom7Seg;

architecture behaviour of Custom7Seg is
begin
    Y <= "1111111" WHEN (D = "00000") ELSE --Blank
        "0111111" WHEN D = "00001" ELSE -- Middle Line
        "1111110" WHEN D = "00010" ELSE -- Top Line
        "1101111" WHEN D = "00011" ELSE -- LeftBot Line
        "1011111" WHEN D = "00100" ELSE -- LeftTop Line
        "1111011" WHEN D = "00101" ELSE -- RightBot Line / Letter I
        "1111101" WHEN D = "00110" ELSE -- RightTop Line
        "1111000" WHEN D = "00111" ELSE -- Snake Head LeftFacing
        "1001110" WHEN D = "01000" ELSE -- Snake Head RightFacing
        "1001000" WHEN D = "01001" ELSE -- Snake Bump

        "0001000" WHEN D = "01010" ELSE -- Letter A
        "0000110" WHEN D = "01011" ELSE -- Letter E
        "0001110" WHEN D = "01100" ELSE -- Letter F
        "0010000" WHEN D = "01101" ELSE -- Letter g
        "0001001" WHEN D = "01110" ELSE -- Letter H
        "0101011" WHEN D = "01111" ELSE -- Letter n
        "1000000" WHEN D = "10000" ELSE -- Letter O
        "0101111" WHEN D = "10001" ELSE -- Letter r
        "0010010" WHEN D = "10010" ELSE -- Letter S
        "1000001" WHEN D = "10011" ELSE -- Letter U

        "1000011" WHEN D = "10100" ELSE -- Letter W leftside
        "1110001" WHEN D = "10101" ELSE -- Letter W rightside/Tail of right snake

        "0010001" WHEN D = "10110" ELSE -- Letter y
        "1110111" WHEN D = "10111" ELSE --Bottom Line   
        "1000111" WHEN D = "11000" ELSE -- Tail of left facing snake
        
        "0000000";

end architecture behaviour;