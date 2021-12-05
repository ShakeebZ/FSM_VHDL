library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

entity ControlUnit is
    port (
        clkCU : in std_logic;
        rstCU : in std_logic;
        hard_rstCU : in std_logic;
        instCU : in std_logic_vector(6 DOWNTO 0);
        toSegCU : out twoDArrayCU
    );
end ControlUnit;

architecture rtl of ControlUnit is

begin

--PROCESS(rising_edge(clk))
--begin
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00000") when (hard_rstCU = '1' OR instCU = "0000000" 
        OR (rstCU = '1' AND instCU(6) /= '1' AND instCU(5) /= '1')) ELSE
         ("00000","00000","00000","00000","00000","00000","00000","01010") when instCU = "0000001" ELSE --Program 1 Start
         ("00000","00000","00000","00000","00000","00000","01010","10001") when instCU = "0000010" ELSE
         ("00000","00000","00000","00000","00000","01010","10001","01011") when instCU = "0000011" ELSE
         ("00000","00000","00000","00000","01010","10001","01011","00000") when instCU = "0000100" ELSE
         ("00000","00000","00000","01010","10001","01011","00000","10110") when instCU = "0000101" ELSE
         ("00000","00000","01010","10001","01011","00000","10110","01010") when instCU = "0000110" ELSE
         ("00000","01010","10001","01011","00000","10110","01010","01110") when instCU = "0000111" ELSE
         ("01010","10001","01011","00000","10110","01010","01110","00000") when instCU = "0001000" ELSE
         ("10001","01011","00000","10110","01010","01110","00000","10100") when instCU = "0001001" ELSE
         ("01011","00000","10110","01010","01110","00000","10100","10101") when instCU = "0001010" ELSE
         ("00000","10110","01010","01110","00000","10100","10101","00101") when instCU = "0001011" ELSE
         ("10110","01010","01110","00000","10100","10101","00101","01111") when instCU = "0001100" ELSE
         ("01010","01110","00000","10100","10101","00101","01111","01111") when instCU = "0001101" ELSE
         ("01110","00000","10100","10101","00101","01111","01111","00101") when instCU = "0001110" ELSE
         ("00000","10100","10101","00101","01111","01111","00101","01111") when instCU = "0001111" ELSE
         ("10100","10101","00101","01111","01111","00101","01111","01101") when instCU = "0010000" ELSE
         ("10101","00101","01111","01111","00101","01111","01101","00000") when instCU = "0010001" ELSE
         ("00101","01111","01111","00101","01111","01101","00000","10010") when instCU = "0010010" ELSE
         ("01111","01111","00101","01111","01101","00000","10010","10000") when instCU = "0010011" ELSE
         ("01111","00101","01111","01101","00000","10010","10000","01111") when instCU = "0010100" ELSE
         ("00101","01111","01101","00000","10010","10000","01111","00000") when instCU = "0010101" ELSE
         ("01111","01101","00000","10010","10000","01111","00000","00000") when instCU = "0010110" ELSE
         ("01101","00000","10010","10000","01111","00000","00000","01111") when instCU = "0010111" ELSE
         ("00000","10010","10000","01111","00000","00000","01111","10000") when instCU = "0011000" ELSE
         ("10010","10000","01111","00000","00000","01111","10000","00000") when instCU = "0011001" ELSE
         ("10000","01111","00000","00000","01111","10000","00000","00000") when instCU = "0011010" ELSE
         ("01111","00000","00000","01111","10000","00000","00000","00000") when instCU = "0011011" ELSE
         ("00000","00000","01111","10000","00000","00000","00000","00000") when instCU = "0011100" ELSE
         ("00000","01111","10000","00000","00000","00000","00000","00000") when instCU = "0011101" ELSE
         ("01111","10000","00000","00000","00000","00000","00000","00000") when instCU = "0011110" ELSE
         ("10000","00000","00000","00000","00000","00000","00000","00000") when instCU = "0011111" ELSE -- Program 1 End
         ("00000","00000","00000","00000","00000","00000","00000","00111") when instCU = "0100000" ELSE -- Program 2 Start
         ("00000","00000","00000","00000","00000","00000","00111","01001") when instCU = "0100001" ELSE
			
         ("00000","00000","00000","00000","00000","00111","01001","01001") when instCU = "0100010" ELSE
			
         ("00000","00000","00000","00000","00111","01001","01001","11000") when instCU = "0100011" ELSE
         ("00000","00000","00000","00111","01001","01001","11000","00000") when instCU = "0100100" ELSE
         ("00000","00000","00111","01001","01001","11000","00000","00000") when instCU = "0100101" ELSE
         ("00000","00111","01001","01001","11000","00000","00000","00000") when instCU = "0100110" ELSE
         ("00111","01001","01001","11000","00000","00000","00000","00000") when instCU = "0100111" ELSE
         ("01001","01001","11000","00000","00000","00000","00000","00000") when instCU = "0101000" ELSE
         ("01001","11000","00000","00000","00000","00000","00000","00000") when instCU = "0101001" ELSE
         ("11000","00000","00000","00000","00000","00000","00000","00000") when instCU = "0101010" ELSE-- Program 2 End
         ("01000","00000","00000","00000","00000","00000","00000","00000") when instCU = "0101011" ELSE -- Program 3 Start
         ("01001","01000","00000","00000","00000","00000","00000","00000") when instCU = "0101100" ELSE
         ("01001","01001","01000","00000","00000","00000","00000","00000") when instCU = "0101101" ELSE
         ("10101","01001","01001","01000","00000","00000","00000","00000") when instCU = "0101110" ELSE
         ("00000","10101","01001","01001","01000","00000","00000","00000") when instCU = "0101111" ELSE
         ("00000","00000","10101","01001","01001","01000","00000","00000") when instCU = "0110000" ELSE
         ("00000","00000","00000","10101","01001","01001","01000","00000") when instCU = "0110001" ELSE
         ("00000","00000","00000","00000","10101","01001","01001","01000") when instCU = "0110010" ELSE
         ("00000","00000","00000","00000","00000","10101","01001","01001") when instCU = "0110011" ELSE
         ("00000","00000","00000","00000","00000","00000","10101","01001") when instCU = "0110100" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","10101") when instCU = "0110101" ELSE -- Program 3 End
         ("00000","00000","00000","00000","00000","00000","00000","00001") when instCU = "1100000" ELSE -- Program 4 Start
         ("00000","00000","00000","00000","00000","00000","00000","00100") when instCU = "1100001" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","00010") when instCU = "1100010" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","00110") when instCU = "1100011" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","00001") when instCU = "1100100" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","00011") when instCU = "1100101" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","10111") when instCU = "1100110" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","00101") when instCU = "1100111" ELSE
         ("00000","00000","00000","00000","00000","00000","00000","00001") when instCU = "1101000" ELSE
         ("00000","00000","00000","00000","00000","00000","00001","00000") when instCU = "1101001" ELSE
         ("00000","00000","00000","00000","00000","00000","00100","00000") when instCU = "1101010" ELSE
         ("00000","00000","00000","00000","00000","00000","00010","00000") when instCU = "1101011" ELSE
         ("00000","00000","00000","00000","00000","00000","00110","00000") when instCU = "1101100" ELSE 
         ("00000","00000","00000","00000","00000","00000","00001","00000") when instCU = "1101101" ELSE
         ("00000","00000","00000","00000","00000","00000","00011","00000") when instCU = "1101110" ELSE
         ("00000","00000","00000","00000","00000","00000","10111","00000") when instCU = "1101111" ELSE
         ("00000","00000","00000","00000","00000","00000","00101","00000") when instCU = "1110000" ELSE
         ("00000","00000","00000","00000","00000","00000","00001","00000") when instCU = "1110001" ELSE -- Program 4 End
         ("00000","00000","00000","00000","01100","01010","00101","11000") when instCU = "1110010" ELSE -- Error Message         
			("00000","00000","00000","00000","00000","00000","00000","00000");

--END PROCESS;

end architecture;