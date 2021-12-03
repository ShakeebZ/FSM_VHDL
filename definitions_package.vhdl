LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
package definitions_package is
-- Package Declaration Section (examples below)
CONSTANT N : INTEGER := 8;
TYPE bus_width IS ARRAY (0 to 2) OF UNSIGNED(N-1 DOWNTO 0);
type twoDArrayIO IS array (7 downto 0) of std_logic_vector(N-2 downto 0); -- 7seg display * 8 hex displays
type twoDArrayCU IS array (7 DOWNTO 0) of std_logic_vector(4 downto 0);
end package definitions_package;
package body definitions_package is
--blank, include any implementations here, if necessary

end package body definitions_package;