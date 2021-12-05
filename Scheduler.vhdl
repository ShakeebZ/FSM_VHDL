library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;

entity Scheduler is
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
end Scheduler;

architecture behaviour of Scheduler IS
    type state is (idle, running);
    type programType is (program1, program2, program3, program4, programError, programIdle, programReset);

    signal current_state, next_state : state;
    signal currentProgram, nextProgram : programType;
    signal incrementor : std_logic;
    signal iteratorProgram1 : unsigned(6 downto 0) := "0000000"; --program1's start
    signal iteratorProgram2 : unsigned(6 downto 0) := "0011111"; --program2's start
    signal iteratorProgram3 : unsigned(6 downto 0) := "0101010"; --program3's start
    signal iteratorProgram4 : unsigned(6 downto 0) := "1011111"; --program4's start
    signal ProgramErrorOutput : unsigned(6 downto 0) := "1110001"; --error's instruction
    
begin

    PROCESS(CLKS)
    begin
			if(rising_edge(CLKS)) THEN
				if (next_state = idle AND nextProgram /= currentProgram AND (rstS /= '1' OR  hard_resetS /= '1')) THEN -- different selection and is idle
					current_state <= running;
					currentProgram <= nextProgram;
				elsif (next_state = idle AND nextProgram = currentProgram AND (rstS /= '1' OR  hard_resetS /= '1')) THEN -- same selection and is idle
					current_state <= running;
					currentProgram <= currentProgram;
				elsif (pauseButtonInputS = '1') THEN -- pause button pressed
					currentProgram <= currentProgram;
					current_state <= idle;
				elsif ((rstS = '1' OR  hard_resetS = '1')) THEN -- reset pressed
					current_state <= idle;
					currentProgram <= programReset;
				elsif (next_state = running AND (iteratorProgram1 /= "0011111" OR iteratorProgram2 /= "0101010" OR iteratorProgram3 /= "1110001" OR iteratorProgram4 /= "1110001")) THEN 
				--running but not at end of each program yet
					
					current_state <= running;
					currentProgram <= currentProgram;
				else --
					current_state <= idle;
					currentProgram <= ProgramError;
				end if;
			end if;
		end process;
		
	
	PROCESS(CLKS)
	BEGIN
			if (rising_edge(CLKS) AND current_state = running) THEN -- is currently running and clock edge
				if (currentProgram = program1 AND (rstS /= '1' OR hard_resetS /= '1')) THEN -- first program
					next_state <= current_state;
					iteratorProgram1 <= iteratorProgram1 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram1); -- output
					if (iteratorProgram1 = "0011111") THEN -- end reached
						iteratorProgram1 <= "0000000"; -- reset to beginning
						toPCE <= '1'; -- output to PCE
						next_state <= idle; -- reset to idle state after running
					end if;
				elsif (currentProgram = program2 AND (rstS /= '1' OR hard_resetS /= '1')) THEN -- second program
					next_state <= current_state; 
					iteratorProgram2 <= iteratorProgram2 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram2); -- output
					if (iteratorProgram2 = "0101010") THEN -- end reached
						iteratorProgram2 <= "0011111"; -- reset to beginning
						toPCE <= '1'; -- output to PCE
						next_state <= idle; -- reset to idle state after running
					end if;
				elsif (currentProgram = program3 AND (rstS /= '1' OR hard_resetS /= '1')) THEN
					next_state <= current_state;
					iteratorProgram3 <= iteratorProgram3 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram3); -- output
					if (iteratorProgram3 = "0110101") THEN -- end reached
						iteratorProgram3 <= "0101010"; -- reset to beginning
						toPCE <= '1'; -- output to PCE
						next_state <= idle; -- reset to idle state after running
					end if;
				elsif (currentProgram = program4 AND (rstS /= '1' OR hard_resetS /= '1')) THEN
					next_state <= current_state;
					iteratorProgram4 <= iteratorProgram4 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram4); -- end reached
					if (iteratorProgram4 = "1110001") THEN --end reached
						iteratorProgram4 <= "1011111"; -- reset to beginning
						toPCE <= '1'; -- output to PCE
						next_state <= idle; -- reset to idle state after running
					end if;
				end if;
					
			elsif (rising_edge(CLKS) AND current_state = idle) THEN -- rising edge and is idle whilst pause is pressed
					if (pauseButtonInputS = '1') THEN
						if (currentProgram = program1) THEN
							inst_outS <= std_logic_vector(iteratorProgram1);
						elsif (currentProgram = program2) THEN
							inst_outS <= std_logic_vector(iteratorProgram2);
						elsif (currentProgram = program3) THEN
							inst_outS <= std_logic_vector(iteratorProgram3);
						elsif (currentProgram = program4) THEN
							inst_outS <= std_logic_vector(iteratorProgram4);
						else 
							inst_outS <= "0000000";
						end if;
			elsif ((rstS = '1' OR hard_resetS = '1') OR currentProgram = programReset) THEN
					iteratorProgram1 <= "0000000";
					iteratorProgram2 <= "0011111";
					iteratorProgram3 <= "0101010";
					iteratorProgram4 <= "1011111";
					inst_outS <= "0000000";
					next_state <= idle;
			elsif (currentProgram = programError) THEN
					inst_outS <= std_logic_vector(ProgramErrorOutput); -- output? 
					next_state <= idle; -- returns to idle, then reads error and repeat cycle
			else 
				inst_outS <= "0000000";
				next_state <= idle;
				end if;
			end if;
    end process;
	 
	 
    PROCESS(clks) --reads input, then assigns program type
        begin
				if (rising_edge(clks)) THEN
					if (programS = "0001") THEN
						 nextProgram <= program1;
					elsif (programS = "0010") THEN
						 nextProgram <= program2;
					elsif (programS = "0100") THEN
						 nextProgram <= program3;
					elsif (programS = "1000") THEN
						 if (stop_progS = '0') THEN
							  nextProgram <= programIdle;
						 else 
							  nextProgram <= program4;
						 end if;
					elsif (hard_resetS = '1' OR rstS = '1') THEN
						 nextProgram <= programReset;
					elsif (programS = "0000") THEN
						nextProgram <= programIdle;
					else
						 nextProgram <= programError;
					end if;
				end if;
        end process;
	
end architecture;