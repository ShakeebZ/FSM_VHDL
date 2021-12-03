library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;


entity SMDB is
    port (
        Clock_50 : IN  std_logic;
        SW : in std_logic_vector(17 downto 0);
        key : In std_logic_vector(3 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out std_logic_vector(7 downto 0);
        LEDG : out std_logic_vector(7 downto 0);
        LEDR : out std_logic_vector(17 downto 0)
    );
end SMDB;

architecture structure of SMDB is

COMPONENT ASIP
    port (
        clkASIP, rstASIP, hard_rstASIP, stop_progASIP : in std_logic;
        programASIP : in std_logic_vector(3 DOWNTO 0);
        to_hex : out twoDArray;
        pce_out : out std_logic_vector(3 downto 0)
    );
END COMPONENT ASIP;

COMPONENT Prescale
port (
    clk : in std_logic;
    mode : in std_logic_vector(1 DOWNTO 0);
    clk_out : out std_logic
);
END COMPONENT Prescale;

COMPONENT debouncer
    generic ( -- ask question on this
        timeout_cycles : positive
        );
    port (
        clk : in std_logic;
        rst : in std_logic;
        switch : in std_logic;
        switch_debounced : out std_logic
    );
END COMPONENT debouncer;

SIGNAL alteredClock : std_logic; 
SIGNAL signalToHexes : twoDArray;
SIGNAL switch_debouncedResult : std_logic_vector(8 downto 0);
SIGNAL Key_DebouncedResult : std_logic_vector(3 downto 0);

begin
    HEX0 <= signalToHexes(0);
    HEX1 <= signalToHexes(1);
    HEX2 <= signalToHexes(2);
    HEX3 <= signalToHexes(3);
    HEX4 <= signalToHexes(4);
    HEX5 <= signalToHexes(5);
    HEX6 <= signalToHexes(6);
    HEX7 <= signalToHexes(7);

    prescaleClock : Prescale Port Map (CLK => Clock_50, 
                                    mode => switch_debouncedResult(4) & switch_debouncedResult(5),
                                    clk_out =>  alteredClock);
    
    ASIP_ent : ASIP Port Map (clkASIP => alteredClock,
                            rstASIP => Key_DebouncedResult(1),
                            hard_rstASIP => SWitch_DebouncedResult(7),
                            stop_proASIP => Key_debouncedResult(0),
                            programASIP => switch_debouncedResult(3 downto 0),
                            to_hex => signalToHexes,
                            pce_out => LEDG(3 downto 0));

    debounceSwitch0 : debouncer Port Map (clk => alteredClock,--choice
        rst => SW(15),
        switch => SW(0),
        switch_debounced => switch_debouncedResult(0));

    debounceSwitch1 : debouncer Port Map (clk => alteredClock,--choice
        rst => SW(15),
        switch => SW(1),
        switch_debounced => switch_debouncedResult(1));
        
    debounceSwitch2 : debouncer Port Map (clk => alteredClock,--choice
        rst => SW(15),
        switch => SW(2),
        switch_debounced => switch_debouncedResult(2));
    
    debounceSwitch3 : debouncer Port Map (clk => alteredClock,--choice
        rst => SW(15),
        switch => SW(3),
        switch_debounced => switch_debouncedResult(3));

    debounceSwitch17 : debouncer Port Map (clk => alteredClock,--speed
        rst => SW(15),
        switch => SW(17),
        switch_debounced => switch_debouncedResult(4));

    debounceSwitch16 : debouncer Port Map (clk => alteredClock,--speed
        rst => SW(15),
        switch => SW(16),
        switch_debounced => switch_debouncedResult(5));

    debounceSwitch15 : debouncer Port Map (clk => alteredClock,--soft reset
        rst => SW(15),
        switch => SW(15),
        switch_debounced => switch_debouncedResult(6));

    debounceSwitch14 : debouncer Port Map (clk => alteredClock, --hard reset
        rst => SW(15),
        switch => SW(14),
        switch_debounced => switch_debouncedResult(7));
    
    debounceKey4 : debouncer Port Map (clk => alteredClock, --stop program
        rst => SW(15),
        switch => key(4),
        switch_debounced => key_debouncedResult(0));


end architecture;