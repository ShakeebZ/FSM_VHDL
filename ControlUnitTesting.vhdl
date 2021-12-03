library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.definitions_package.all;

entity ControlUnitTesting is
    port (
        CLOCK_50 : in std_logic;
        SW : in std_logic_vector(17 DOWNTO 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out std_logic_vector(6 DOWNTO 0)
    );
end ControlUnitTesting;

architecture rtl of ControlUnitTesting is
component ControlUnit port (
    clkCU : in std_logic;
    rstCU : in std_logic;
    hard_rstCU : in std_logic;
    instCU : in std_logic_vector(6 DOWNTO 0);
    toSegCU : out twoDArrayCU
);
end component;

component Custom7Seg 
port (
        D : IN STD_LOGIC_VECTOR(4 downto 0);
        Y : OUT STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

Signal CUSignal : twoDArrayCU;
begin

ControlUnitComponent : ControlUnit port map(instCU => SW(6 DOWNTO 0), clkCU => CLOCK_50, rstCU => SW(17), hard_rstCU => SW(16), toSegCU => CUSignal);

Hex0Component : Custom7Seg port map(D => CUSignal(0), Y => HEX0);
Hex1Component : Custom7Seg port map(D => CUSignal(1), Y => HEX1);
Hex2Component : Custom7Seg port map(D => CUSignal(2), Y => HEX2);
Hex3Component : Custom7Seg port map(D => CUSignal(3), Y => HEX3);
Hex4Component : Custom7Seg port map(D => CUSignal(4), Y => HEX4);
Hex5Component : Custom7Seg port map(D => CUSignal(5), Y => HEX5);
Hex6Component : Custom7Seg port map(D => CUSignal(6), Y => HEX6);
Hex7Component : Custom7Seg port map(D => CUSignal(7), Y => HEX7);

end architecture;