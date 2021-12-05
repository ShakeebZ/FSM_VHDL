library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SchedulerTesting is
    port (
        CLOCK_50 : in std_logic;
        SW : in std_logic_vector(17 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4,HEX5,HEX6,HEX7 : out std_logic_vector(6 DOWNTO 0);
        LEDR : out std_logic_vector(17 DOWNTO 0);
        KEY : in std_logic_vector(3 DOWNTO 0)
    );
end SchedulerTesting;

architecture rtl of SchedulerTesting is

component Scheduler IS
port (
        CLKS : in std_logic;
        rstS : in std_logic;
        hard_resetS : in std_logic;
        stop_progS : in std_logic;
        programS : in std_logic_vector(3 downto 0);
        inst_outS : out std_logic_vector(6 downto 0);
        toPCE : out std_logic;
        pauseButtonInputS : in std_logic
    );
end component;

component PreScale is
    port (
        clk : in std_logic;
        mode : in std_logic_vector(1 DOWNTO 0);
        clk_out : out std_logic
    );
end component;

component ControlUnit is
    port (
        clkCU : in std_logic;
        rstCU : in std_logic;
        hard_rstCU : in std_logic;
        instCU : in std_logic_vector(6 DOWNTO 0);
        toSegCU : out twoDArrayCU
    );
end component;

component Custom7Seg is
    port (
        D : IN STD_LOGIC_VECTOR(4 downto 0);
        Y : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

SIGNAL PreScaledClock : std_logic;
SIGNAL CUOutput : twoDArrayCU;
SIGNAL Instructions : std_logic_vector(6 DOWNTO 0);
begin

    PreScalerComponent : PreScale port map(clk => CLOCK_50,
     mode => SW(17 DOWNTO 16),
     clk_out => PreScaledClock
    );

    ControlUnitComponent : ControlUnit port map(
        clkCU => PreScaledClock,
        rstCU => SW(15),
        hard_rstCU => SW(14),
        instCU => Instructions,
        toSegCU => CUOutput
    );

    SchedulerComponent : Scheduler port map(
        CLKS => PreScaledClock,
        rstS => SW(15),
        hard_resetS => SW(14),
        stop_progS => KEY(3),
        programS => SW(3 DOWNTO 0),
        inst_outS => Instructions,
        toPCE => LEDR(0),
        pauseButtonInputS => SW(13),
    );

    Custom7SegComponent0 : Custom7Seg port map(
        D => CUOutput(0),
        Y => HEX0
    );

    Custom7SegComponent1 : Custom7Seg port map(
        D => CUOutput(1),
        Y => HEX1
    );

    Custom7SegComponent2 : Custom7Seg port map(
        D => CUOutput(2),
        Y => HEX2
    );

    Custom7SegComponent3 : Custom7Seg port map(
        D => CUOutput(3),
        Y => HEX3
    );

    Custom7SegComponent4 : Custom7Seg port map(
        D => CUOutput(4),
        Y => HEX4
    );

    Custom7SegComponent5 : Custom7Seg port map(
        D => CUOutput(5),
        Y => HEX5
    );

    Custom7SegComponent6 : Custom7Seg port map(
        D => CUOutput(6),
        Y => HEX6
    );

    Custom7SegComponent7 : Custom7Seg port map(
        D => CUOutput(7),
        Y => HEX7
    );

end architecture;