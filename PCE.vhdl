library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PCE is
    port (
        hardResetPCE : In STD_LOGIC;
        ClkPCE : In STD_Logic;
        programPCE : In STD_Logic;
        toGreenlights : OUT STD_LOGIC_VECTOR(3 downto 0)
    );
end PCE;

architecture behaviour of PCE is   
    signal counter : unsigned(3 downto 0); 

    begin
        process(ClkPCE)
		  BEGIN
            if (hardResetPCE = '1') then
                counter <= "0000";
            else 
                if (rising_edge(ClkPCE) AND programPCE = '1' ) then
                    counter <= counter + 1;
                end if;
            end if;
        end process;

    toGreenlights <= std_logic_vector(counter);

end architecture behaviour;