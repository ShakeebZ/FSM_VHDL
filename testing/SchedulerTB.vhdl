library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;

entity SchedulerTB is
end SchedulerTB;

architecture tb of SchedulerTB IS
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
	 
	 signal ClkSTest : std_logic := '0';
	 signal rstSTest : std_logic := '0';
	 signal hard_resetSTest : std_logic := '0';
	 signal stop_progSTest : std_logic := '0'; 
	 signal programSTest : unsigned(3 downto 0) := "0100";
	 signal inst_outSTest : std_logic_vector(6 downto 0);
	 signal toPCETest : std_logic;
	
	 begin
		process
		begin
			CLKSTest <= NOT CLKSTest;
			wait for 25 ns;
		end process;
		
		process 
		begin
			rstSTest <= NOT rstSTest;
			wait for 1000 ns;
		end process;
		
		process
		begin
			hard_resetSTest <= NOT hard_resetSTest;
			wait for 1500 ns;
		end process;
	 
		process
		begin
			stop_progSTest <= NOT stop_progSTest;
			wait for 2000 ns;
		end process;
		
		DUT1: scheduler port map(CLKS => CLKSTest,
									rstS => rstSTest,
									hard_resetS => hard_resetSTest,
									stop_progS => stop_progSTest,
									programS => std_logic_vector(programSTest),
									inst_outS => inst_outSTest,
									toPCE => toPCETest);
end architecture;
	 