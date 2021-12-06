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

PROCESS(clkCU)
begin
if (hard_rstCU = '1') THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00000");
elsif(rstCU = '1' AND instCU(6) /= '1' AND instCU(5) /= '1') THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00000");
elsif(instCU = "0000001" AND rising_edge(clkCU)) THEN
toSegCU <=     ("00000","00000","00000","00000","00000","00000","00000","01010"); --Program 1 Start
elsif(instCU = "0000010" AND rising_edge(clkCU)) THEN
toSegCU <=  ("00000","00000","00000","00000","00000","00000","01010","10001");
elsif(instCU = "0000011" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","01010","10001","01011");
elsif(instCU = "0000100" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","01010","10001","01011","00000");
elsif(instCU = "0000101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","01010","10001","01011","00000","10110");
elsif(instCU = "0000110" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","01010","10001","01011","00000","10110","01010");
elsif(instCU = "0000111" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","01010","10001","01011","00000","10110","01010","01110");
elsif(instCU = "0001000" AND rising_edge(clkCU)) THEN
toSegCU <= ("01010","10001","01011","00000","10110","01010","01110","00000");
elsif(instCU = "0001001" AND rising_edge(clkCU)) THEN
toSegCU <= ("10001","01011","00000","10110","01010","01110","00000","10100");
elsif(instCU = "0001010" AND rising_edge(clkCU)) THEN
toSegCU <= ("01011","00000","10110","01010","01110","00000","10100","10101");
elsif(instCU = "0001011" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","10110","01010","01110","00000","10100","10101","00101");
elsif(instCU = "0001100" AND rising_edge(clkCU)) THEN
toSegCU <= ("10110","01010","01110","00000","10100","10101","00101","01111");
elsif(instCU = "0001101" AND rising_edge(clkCU)) THEN
toSegCU <= ("01010","01110","00000","10100","10101","00101","01111","01111");
elsif(instCU = "0001110" AND rising_edge(clkCU)) THEN
toSegCU <= ("01110","00000","10100","10101","00101","01111","01111","00101");
elsif(instCU = "0001111" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","10100","10101","00101","01111","01111","00101","01111");
elsif(instCU = "0010000" AND rising_edge(clkCU)) THEN
toSegCU <= ("10100","10101","00101","01111","01111","00101","01111","01101");
elsif(instCU = "0010001" AND rising_edge(clkCU)) THEN
toSegCU <= ("10101","00101","01111","01111","00101","01111","01101","00000");
elsif(instCU = "0010010" AND rising_edge(clkCU)) THEN
toSegCU <= ("00101","01111","01111","00101","01111","01101","00000","10010");
elsif(instCU = "0010011" AND rising_edge(clkCU)) THEN
toSegCU <= ("01111","01111","00101","01111","01101","00000","10010","10000");
elsif(instCU = "0010100" AND rising_edge(clkCU)) THEN
toSegCU <= ("01111","00101","01111","01101","00000","10010","10000","01111");
elsif(instCU = "0010101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00101","01111","01101","00000","10010","10000","01111","00000");
elsif(instCU = "0010110" AND rising_edge(clkCU)) THEN
toSegCU <= ("01111","01101","00000","10010","10000","01111","00000","00000");
elsif(instCU = "0010111" AND rising_edge(clkCU)) THEN
toSegCU <= ("01101","00000","10010","10000","01111","00000","00000","01111");
elsif(instCU = "0011000" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","10010","10000","01111","00000","00000","01111","10000");
elsif(instCU = "0011001" AND rising_edge(clkCU)) THEN
toSegCU <= ("10010","10000","01111","00000","00000","01111","10000","00000");
elsif(instCU = "0011010" AND rising_edge(clkCU)) THEN
toSegCU <= ("10000","01111","00000","00000","01111","10000","00000","00000");
elsif(instCU = "0011011" AND rising_edge(clkCU)) THEN
toSegCU <= ("01111","00000","00000","01111","10000","00000","00000","00000");
elsif(instCU = "0011100" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","01111","10000","00000","00000","00000","00000");
elsif(instCU = "0011101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","01111","10000","00000","00000","00000","00000","00000");
elsif(instCU = "0011110" AND rising_edge(clkCU)) THEN
toSegCU <= ("01111","10000","00000","00000","00000","00000","00000","00000");
elsif(instCU = "0011111" AND rising_edge(clkCU)) THEN -- Program 1 End
toSegCU <= ("10000","00000","00000","00000","00000","00000","00000","00000");
elsif(instCU = "0100000" AND rising_edge(clkCU)) THEN -- Program 2 Start
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00111"); 
elsif(instCU = "0100001" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00111","01001");
elsif(instCU = "0100010" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00111","01001","01001");
elsif(instCU = "0100011" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00111","01001","01001","11000");
elsif(instCU = "0100100" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00111","01001","01001","11000","00000");
elsif(instCU = "0100101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00111","01001","01001","11000","00000","00000");
elsif(instCU = "0100110" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00111","01001","01001","11000","00000","00000","00000");
elsif(instCU = "0100111" AND rising_edge(clkCU)) THEN
toSegCU <= ("00111","01001","01001","11000","00000","00000","00000","00000");
elsif(instCU = "0101000" AND rising_edge(clkCU)) THEN
toSegCU ("01001","01001","11000","00000","00000","00000","00000","00000");
elsif(instCU = "0101001" AND rising_edge(clkCU)) THEN
toSegCU <= ("01001","11000","00000","00000","00000","00000","00000","00000");
elsif(instCU = "0101010" AND rising_edge(clkCU) ) THEN
toSegCU <= ("11000","00000","00000","00000","00000","00000","00000","00000"); -- Program 2 End
elsif(instCU = "0101011" AND rising_edge(clkCU)) THEN
toSegCU <= ("01000","00000","00000","00000","00000","00000","00000","00000"); -- Program 3 Start
elsif(instCU = "0101100" AND rising_edge(clkCU) ) THEN
toSegCU <= ("01001","01000","00000","00000","00000","00000","00000","00000");
elsif(instCU = "0101101" AND rising_edge(clkCU)) THEN
toSegCU <= ("01001","01001","01000","00000","00000","00000","00000","00000");
elsif(instCU = "0101110" AND rising_edge(clkCU)) THEN
toSegCU <= ("10101","01001","01001","01000","00000","00000","00000","00000");
elsif(instCU = "0101111" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","10101","01001","01001","01000","00000","00000","00000");
elsif(instCU = "0110000" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","10101","01001","01001","01000","00000","00000");
elsif( instCU = "0110001" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","10101","01001","01001","01000","00000");
elsif (instCU = "0110010" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","10101","01001","01001","01000");
elsif( instCU = "0110011" AND rising_edge(clkCU) ) THEN
toSegCU <= ("00000","00000","00000","00000","00000","10101","01001","01001");
elsif(instCU = "0110100" AND rising_edge(clkCU)) THEN
toSegCU <=  ("00000","00000","00000","00000","00000","00000","10101","01001");
elsif(instCU = "0110101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","10101"); -- Program 3 End
elsif(instCU = "1100000" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00001"); -- Program 4 Start
elsif(instCU = "1100001" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00100");
elsif(instCU = "1100010" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00010");
elsif(instCU = "1100011" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00110");
elsif(instCU = "1100100" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00001");
elsif(instCU = "1100101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00011");
elsif(instCU = "1100110" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","10111");
elsif(instCU = "1100111" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00101");
elsif(instCU = "1101000" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00001");
elsif(instCU = "1101001" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00001","00000");
elsif(instCU = "1101010" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00100","00000");
elsif(instCU = "1101011" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00010","00000");
elsif(instCU = "1101100" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00110","00000");
elsif(instCU = "1101101" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00001","00000");
elsif(instCU = "1101110" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00011","00000");
elsif(instCU = "1101111" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","10111","00000");
elsif(instCU = "1110000" AND rising_edge(clkCU)) THEN      
toSegCU <= ("00000","00000","00000","00000","00000","00000","00101","00000");
elsif(instCU = "1110001" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","00000","00000","00001","00000"); -- Program 4 End
elsif(instCU = "1110010" AND rising_edge(clkCU)) THEN
toSegCU <= ("00000","00000","00000","00000","01100","01010","00101","11000"); -- Error Message         
else
toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00000");

end if;
END PROCESS;

--toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00000") when (hard_rstCU = '1' OR ((instCU = "0000000" AND (rising_edge(clkCU)))
--        OR (rstCU = '1' AND instCU(6) /= '1' AND instCU(5) /= '1'))) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","01010") when instCU = "0000001" AND rising_edge(clkCU) ELSE --Program 1 Start
--         ("00000","00000","00000","00000","00000","00000","01010","10001") when instCU = "0000010" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","01010","10001","01011") when instCU = "0000011" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","01010","10001","01011","00000") when instCU = "0000100" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","01010","10001","01011","00000","10110") when instCU = "0000101" AND rising_edge(clkCU) ELSE
--         ("00000","00000","01010","10001","01011","00000","10110","01010") when instCU = "0000110" AND rising_edge(clkCU) ELSE
--         ("00000","01010","10001","01011","00000","10110","01010","01110") when instCU = "0000111" AND rising_edge(clkCU) ELSE
--         ("01010","10001","01011","00000","10110","01010","01110","00000") when instCU = "0001000" AND rising_edge(clkCU) ELSE
--         ("10001","01011","00000","10110","01010","01110","00000","10100") when instCU = "0001001" AND rising_edge(clkCU) ELSE
--         ("01011","00000","10110","01010","01110","00000","10100","10101") when instCU = "0001010" AND rising_edge(clkCU) ELSE
--         ("00000","10110","01010","01110","00000","10100","10101","00101") when instCU = "0001011" AND rising_edge(clkCU) ELSE
--         ("10110","01010","01110","00000","10100","10101","00101","01111") when instCU = "0001100" AND rising_edge(clkCU) ELSE
--         ("01010","01110","00000","10100","10101","00101","01111","01111") when instCU = "0001101" AND rising_edge(clkCU) ELSE
--         ("01110","00000","10100","10101","00101","01111","01111","00101") when instCU = "0001110" AND rising_edge(clkCU) ELSE
--         ("00000","10100","10101","00101","01111","01111","00101","01111") when instCU = "0001111" AND rising_edge(clkCU) ELSE
--         ("10100","10101","00101","01111","01111","00101","01111","01101") when instCU = "0010000" AND rising_edge(clkCU) ELSE
--         ("10101","00101","01111","01111","00101","01111","01101","00000") when instCU = "0010001" AND rising_edge(clkCU) ELSE
--         ("00101","01111","01111","00101","01111","01101","00000","10010") when instCU = "0010010" AND rising_edge(clkCU) ELSE
--         ("01111","01111","00101","01111","01101","00000","10010","10000") when instCU = "0010011" AND rising_edge(clkCU) ELSE
--         ("01111","00101","01111","01101","00000","10010","10000","01111") when instCU = "0010100" AND rising_edge(clkCU) ELSE
--         ("00101","01111","01101","00000","10010","10000","01111","00000") when instCU = "0010101" AND rising_edge(clkCU) ELSE
--         ("01111","01101","00000","10010","10000","01111","00000","00000") when instCU = "0010110" AND rising_edge(clkCU) ELSE
--         ("01101","00000","10010","10000","01111","00000","00000","01111") when instCU = "0010111" AND rising_edge(clkCU) ELSE
--         ("00000","10010","10000","01111","00000","00000","01111","10000") when instCU = "0011000" AND rising_edge(clkCU) ELSE
--         ("10010","10000","01111","00000","00000","01111","10000","00000") when instCU = "0011001" AND rising_edge(clkCU) ELSE
--         ("10000","01111","00000","00000","01111","10000","00000","00000") when instCU = "0011010" AND rising_edge(clkCU) ELSE
--         ("01111","00000","00000","01111","10000","00000","00000","00000") when instCU = "0011011" AND rising_edge(clkCU) ELSE
--         ("00000","00000","01111","10000","00000","00000","00000","00000") when instCU = "0011100" AND rising_edge(clkCU) ELSE
--         ("00000","01111","10000","00000","00000","00000","00000","00000") when instCU = "0011101" AND rising_edge(clkCU) ELSE
--         ("01111","10000","00000","00000","00000","00000","00000","00000") when instCU = "0011110" AND rising_edge(clkCU) ELSE
--         ("10000","00000","00000","00000","00000","00000","00000","00000") when instCU = "0011111" AND rising_edge(clkCU) ELSE -- Program 1 End
--         ("00000","00000","00000","00000","00000","00000","00000","00111") when instCU = "0100000" AND rising_edge(clkCU) ELSE -- Program 2 Start
--         ("00000","00000","00000","00000","00000","00000","00111","01001") when instCU = "0100001" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00111","01001","01001") when instCU = "0100010" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00111","01001","01001","11000") when instCU = "0100011" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00111","01001","01001","11000","00000") when instCU = "0100100" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00111","01001","01001","11000","00000","00000") when instCU = "0100101" AND rising_edge(clkCU) ELSE
--         ("00000","00111","01001","01001","11000","00000","00000","00000") when instCU = "0100110" AND rising_edge(clkCU) ELSE
--         ("00111","01001","01001","11000","00000","00000","00000","00000") when instCU = "0100111" AND rising_edge(clkCU) ELSE
--         ("01001","01001","11000","00000","00000","00000","00000","00000") when instCU = "0101000" AND rising_edge(clkCU) ELSE
--         ("01001","11000","00000","00000","00000","00000","00000","00000") when instCU = "0101001" AND rising_edge(clkCU) ELSE
--         ("11000","00000","00000","00000","00000","00000","00000","00000") when instCU = "0101010" AND rising_edge(clkCU) ELSE -- Program 2 End
--         ("01000","00000","00000","00000","00000","00000","00000","00000") when instCU = "0101011" AND rising_edge(clkCU) ELSE -- Program 3 Start
--         ("01001","01000","00000","00000","00000","00000","00000","00000") when instCU = "0101100" AND rising_edge(clkCU) ELSE
--         ("01001","01001","01000","00000","00000","00000","00000","00000") when instCU = "0101101" AND rising_edge(clkCU) ELSE
--         ("10101","01001","01001","01000","00000","00000","00000","00000") when instCU = "0101110" AND rising_edge(clkCU) ELSE
--         ("00000","10101","01001","01001","01000","00000","00000","00000") when instCU = "0101111" AND rising_edge(clkCU) ELSE
--         ("00000","00000","10101","01001","01001","01000","00000","00000") when instCU = "0110000" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","10101","01001","01001","01000","00000") when instCU = "0110001" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","10101","01001","01001","01000") when instCU = "0110010" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","10101","01001","01001") when instCU = "0110011" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","10101","01001") when instCU = "0110100" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","10101") when instCU = "0110101" AND rising_edge(clkCU) ELSE -- Program 3 End
--         ("00000","00000","00000","00000","00000","00000","00000","00001") when instCU = "1100000" AND rising_edge(clkCU) ELSE -- Program 4 Start
--         ("00000","00000","00000","00000","00000","00000","00000","00100") when instCU = "1100001" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","00010") when instCU = "1100010" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","00110") when instCU = "1100011" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","00001") when instCU = "1100100" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","00011") when instCU = "1100101" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","10111") when instCU = "1100110" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","00101") when instCU = "1100111" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00000","00001") when instCU = "1101000" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00001","00000") when instCU = "1101001" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00100","00000") when instCU = "1101010" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00010","00000") when instCU = "1101011" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00110","00000") when instCU = "1101100" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00001","00000") when instCU = "1101101" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00011","00000") when instCU = "1101110" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","10111","00000") when instCU = "1101111" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00101","00000") when instCU = "1110000" AND rising_edge(clkCU) ELSE
--         ("00000","00000","00000","00000","00000","00000","00001","00000") when instCU = "1110001" AND rising_edge(clkCU) ELSE -- Program 4 End
--         ("00000","00000","00000","00000","01100","01010","00101","11000") when instCU = "1110010" AND rising_edge(clkCU) ELSE -- Error Message         
--			("00000","00000","00000","00000","00000","00000","00000","00000");


--PROCESS(rising_edge(clkCU))
--BEGIN
--
--if (hard_rstCU = '1' OR instCU = "0000000" OR (rstCU = '1' AND instCU(6) /= '1' AND instCU(5) /= '1')) THEN
--toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","00000");
--elsif(instCU = "0000001") THEN
--toSegCU <= ("00000","00000","00000","00000","00000","00000","00000","01010");
--elsif() THEN
--toSegCU <=
--elsif()
--
--END PROCESS;
			
			
end architecture;