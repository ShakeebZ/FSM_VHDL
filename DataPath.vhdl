library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is
    port (
        clkD, rstD, hard_rstD, stop_progD : in std_logic;
        programD : in std_logic_vector(3 DOWNTO 0);
        instD : out std_logic_vector(6 DOWNTO 0);
        pce : out std_logic_vector(3 DOWNTO 0)
    );
end Datapath;

architecture rtl of Datapath is
component PCE 
PORT (
    hardResetPCE : In STD_LOGIC;
    ClkPCE : In STD_Logic;
    programPCE : In STD_Logic;
    toGreenlights : OUT STD_LOGIC_VECTOR(3 downto 0)
);
end component;

component Scheduler
port (
        CLKS : in std_logic;
        rstS : in std_logic;
        hard_resetS : in std_logic;
        stop_progS : in std_logic;
        programS : in std_logic_vector(3 downto 0);
        inst_outS : out std_logic_vector(6 downto 0);
        toPCE : out std_logic
    );
end component;

SIGNAL PCESignal : std_logic;
begin

PCEComponent : PCE port map (hardResetPCE => hard_rstD, ClkPCE => clkD, programPCE => PCESignal, toGreenlights => pce);
SchedulerComponent : Scheduler port map (CLKS => clkD, rstS => rstD, hard_resetS => hard_rstD, stop_progS => stop_progD, programS => programD, inst_outS => instD, toPCE =>PCESignal);

end architecture;