library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

entity ASIP is
    port (
        clkASIP, rstASIP, hard_rstASIP, stop_progASIP : in std_logic;
        programASIP : in std_logic_vector(3 DOWNTO 0);
        to_hex : out twoDArrayIO;
        pce_out : out std_logic_vector(3 downto 0)
    );
end ASIP;

architecture rtl of ASIP is

component ControlUnit IS
port (
        clkCU : in std_logic;
        rstCU : in std_logic;
        hard_rstCU : in std_logic;
        instCU : in std_logic_vector(6 DOWNTO 0);
        toSegCU : out twoDArrayCU
    );
end component;

component Datapath is
    port (
        clkD, rstD, hard_rstD, stop_progD : in std_logic;
        programD : in std_logic_vector(3 DOWNTO 0);
        instD : out std_logic_vector(6 DOWNTO 0);
        pce_output : out std_logic_vector(3 DOWNTO 0)
    );
end component;

component IO_Controller is
    port (
        toSegIO : IN twoDArrayCU;
        toHexIO : OUT twoDArrayIO
    );
end component;

SIGNAL instSignal : std_logic_vector(6 downto 0);
SIGNAL toSegSignal : twoDArrayCU;

begin
--Component Instantiations
ControlUnitASIP : ControlUnit port map(
    clkCU => clkASIP,
    rstCU => rstASIP,
    hard_rstCU => hard_rstASIP,
    instCU => instSignal,
    toSegCU => toSegSignal
    );
DatapathASIP : Datapath port map(
    clkD => clkASIP,
    rstD => rstASIP,
    hard_rstD => hard_rstASIP,
    stop_progD => stop_progASIP,
    instD => instSignal,
	 programD => programASIP,
    pce_output => pce_out
);
IO_ControllerASIP : IO_Controller port map(
    toSegIO => toSegSignal,
    toHexIO => to_hex
);

end architecture;