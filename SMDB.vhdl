library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;


entity SMDB is
    port (
        Clock_50 : IN  std_logic;
        SW : in std_logic_vector(17 downto 0);
        key : In std_logic_vector(3 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out std_logic_vector(6 downto 0);
        LEDG : out std_logic_vector(7 downto 0);
		  LEDR : out std_logic_vector(17 DOWNTO 0)
    );
end SMDB;

architecture structure of SMDB is

COMPONENT ASIP
    port (
        clkASIP, rstASIP, hard_rstASIP, stop_progASIP : in std_logic;
        programASIP : in std_logic_vector(3 DOWNTO 0);
        to_hex : out twoDArrayIO;
        pce_out : out std_logic_vector(3 downto 0)
    );
END COMPONENT ASIP;

COMPONENT Prescale
    port (
        clk : in std_logic;
        mode : in std_logic_vector(1 DOWNTO 0);
		  disable : in std_logic;
        clk_out : out std_logic
    );
END COMPONENT Prescale;

COMPONENT debouncer
    generic ( -- ask question on this
        timeout_cycles : positive := 1000
        );
    port (
        clk : in std_logic;
        rst : in std_logic;
        switch : in std_logic;
        switch_debounced : out std_logic
    );
END COMPONENT debouncer;

SIGNAL alteredClock : std_logic; 
SIGNAL signalToHexes : twoDArrayIO;
SIGNAL switch_debouncedResult : std_logic_vector(8 downto 0);
SIGNAL Key_DebouncedResult : std_logic_vector(3 downto 0);
SIGNAL OrResult : std_logic;

begin
    HEX0 <= signalToHexes(0);
    HEX1 <= signalToHexes(1);
    HEX2 <= signalToHexes(2);
    HEX3 <= signalToHexes(3);
    HEX4 <= signalToHexes(4);
    HEX5 <= signalToHexes(5);
    HEX6 <= signalToHexes(6);
    HEX7 <= signalToHexes(7);
    
	 -- Instantiating all components.
	 
    ASIP_ent : ASIP Port Map (clkASIP => alteredClock,
                            rstASIP => switch_debouncedResult(6),
                            hard_rstASIP => SWitch_DebouncedResult(7),
                            stop_progASIP => Key_debouncedResult(0),
                            programASIP => switch_debouncedResult(3 downto 0),
                            to_hex => signalToHexes,
                            pce_out => LEDG(3 downto 0)
									 );


    PreScaler0 : PreScale port map(clk => CLOCK_50,
     mode(1) => switch_debouncedResult(4),
	  mode(0) => switch_debouncedResult(5),
	  disable => SW(13), -- Pause button (disables the clock)
     clk_out => alteredClock
    );
	 
	 

    deb0 : debouncer Port Map (clk => CLOCK_50,--choice
        rst => OrResult,
        switch => SW(1),
        switch_debounced => switch_debouncedResult(0));

    deb1: debouncer Port Map (clk => CLOCK_50,--choice
        rst => OrResult,
        switch => SW(2),
        switch_debounced => switch_debouncedResult(1));
        
    deb2: debouncer Port Map (clk => CLOCK_50,--choice
        rst => OrResult,
        switch => SW(3),
        switch_debounced => switch_debouncedResult(2));
    
    deb3: debouncer Port Map (clk => CLOCK_50,--choice
        rst => OrResult,
        switch => SW(4),
        switch_debounced => switch_debouncedResult(3));

    deb4: debouncer Port Map (clk => CLOCK_50,--speed
        rst => OrResult,
        switch => SW(17),
        switch_debounced => switch_debouncedResult(4));

    deb5: debouncer Port Map (clk => CLOCK_50,--speed
        rst => OrResult,
        switch => SW(16),
        switch_debounced => switch_debouncedResult(5));

    deb6: debouncer Port Map (clk => CLOCK_50,--soft reset
        rst => OrResult,
        switch => SW(15),
        switch_debounced => switch_debouncedResult(6));

    deb7: debouncer Port Map (clk => CLOCK_50, --hard reset
        rst => OrResult,
        switch => SW(14),
        switch_debounced => switch_debouncedResult(7));
    
    
    deb8: debouncer Port Map (clk => CLOCK_50, --stop program
        rst => OrResult,
        switch => key(3),
        switch_debounced => key_debouncedResult(0));

    OrResult <= SW(17) OR SW(16);

end architecture;