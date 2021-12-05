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
    type programType is (program1, program2, program3, program4, programError, programIdle);

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
				if (next_state = idle AND nextProgram /= currentProgram) THEN
					current_state <= running;
					currentProgram <= nextProgram;
				elsif (next_state = idle AND nextProgram = currentProgram) THEN
					current_state <= running;
					currentProgram <= currentProgram;
				elsif (pauseButtonInputS = '1') THEN
					currentProgram <= currentProgram;
					current_state <= idle;
				elsif (next_state = running AND (iteratorProgram1 /= "0011111" OR iteratorProgram2 /= "0101010" OR iteratorProgram3 /= "1110001" OR iteratorProgram4 /= "1110001")) THEN
					current_state <= running;
					currentProgram <= currentProgram;
				else 
					current_state <= idle;
				end if;
			end if;
		end process;
		
	
	PROCESS(CLKS)
	BEGIN
			if (rising_edge(CLKS) AND current_state = running) THEN
				if (currentProgram = program1) THEN
					next_state <= current_state;
					iteratorProgram1 <= iteratorProgram1 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram1);
					if (iteratorProgram1 = "0011111") THEN
						iteratorProgram1 <= "0000000";
						toPCE <= '1';
						next_state <= idle;
					end if;
				elsif (currentProgram = program2) THEN
					next_state <= current_state;
					iteratorProgram2 <= iteratorProgram2 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram2);
					if (iteratorProgram2 = "0101010") THEN
						iteratorProgram1 <= "0011111";
						toPCE <= '1';
						next_state <= idle;
					end if;
				elsif (currentProgram = program3) THEN
					next_state <= current_state;
					iteratorProgram3 <= iteratorProgram3 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram3);
					if (iteratorProgram3 = "0110101") THEN
						iteratorProgram1 <= "0101010";
						toPCE <= '1';
						next_state <= idle;
					end if;
				elsif (currentProgram = program4) THEN
					next_state <= current_state;
					iteratorProgram4 <= iteratorProgram4 + 1;
					toPCE <= '0';
					inst_outS <= std_logic_vector(iteratorProgram4);
					if (iteratorProgram4 = "1110001") THEN
						iteratorProgram1 <= "1011111";
						toPCE <= '1';
						next_state <= idle;
					end if;
				elsif (currentProgram = programError) THEN
					inst_outS <= std_logic_vector(ProgramErrorOutput);
					next_state <= idle;
				else 
					inst_outS <= "0000000";
					next_state <= Idle;
            end if;
			elsif (rising_edge(CLKS) AND current_state = idle) THEN
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
					else 
						inst_outS <= "0000000";
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
						 if (stop_progS = '1') THEN
							  nextProgram <= programIdle;
						 else 
							  nextProgram <= program4;
						 end if;
					elsif (programS <= "0000" OR hard_resetS = '1' OR rstS = '1') THEN
						 nextProgram <= programIdle;
					else
						 nextProgram <= programError;
					end if;
				end if;
        end process;
	
end architecture;