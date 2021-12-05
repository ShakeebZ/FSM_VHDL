library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ASIP is
    port (
        clkASIP, rstASIP, hard_rstASIP, stop_progASIP : in std_logic;
        programASIP : in std_logic_vector(3 DOWNTO 0);
        to_hex : out twoDArrayIO;
        pauseButtonInputASIP : in std_logic;
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

begin

ControlUnitASIP : ControlUnit port map(
    clkCU => clkASIP,
    rstCU => rstASIP,
    hard_rstCU => hard_rstASIP,
    instCU => instD, -- Dunno if this will work
    toSegCU => toSegIO -- Dunno if this will work Pt2
    );
DatapathASIP : ControlUnit port map(
    clkD => clkASIP,
    rstD => rstASIP,
    hard_rstD => hard_rstASIP,
    stop_progD => stop_progASIP,
    instD => instCU, -- Dunno if this will work
    pce_output => pce_out
);
IO_ControllerASIP : IO_Controller port map(
    toSegIO => toSegCU, -- Dunno if this will work Pt2
    toHexIO => to_hex
);

end architecture;