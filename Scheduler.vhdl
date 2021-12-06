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
        toPCE : out std_logic
    );
end Scheduler;

architecture behaviour of Scheduler IS
    type state is (idle, running);
    type programType is (program1, program2, program3, program4, programError, programIdle, programReset);

    signal current_state, next_state : state;
    signal currentProgram, nextProgram : programType;
    signal incrementor : std_logic;
    signal iteratorProgram1 : unsigned(6 downto 0) := "0000001"; --program1's start
    signal iteratorProgram2 : unsigned(6 downto 0) := "0100000"; --program2's start
    signal iteratorProgram3 : unsigned(6 downto 0) := "0101011"; --program3's start
    signal iteratorProgram4 : unsigned(6 downto 0) := "1100000"; --program4's start
    signal ProgramErrorOutput : unsigned(6 downto 0) := "1110010"; --error's instruction
    
begin
--0011111
--0101010
--0110101
--1110001
	PROCESS(programS)
	begin
		if (programS = "0001") THEN
			nextProgram <= program1;
			next_state <= running;
		elsif (programS = "0010") THEN
			nextProgram <= program2;
			next_state <= running;
		elsif (programS = "0100") THEN
			nextProgram <= program3;
			next_state <= running;
		elsif (programS = "1000") THEN
			nextProgram <= program4;
			next_state <= running;
		elsif (programS = "0000") THEN
			nextProgram <= programIdle;
			next_state <= idle;
		else
			nextProgram <= currentProgram;
			next_state <= current_state;
		end if;
	end PROCESS;

	
	PROCESS(CLKS, hard_resetS, rstS, stop_progS)
		begin
		if (hard_resetS /= '1' AND rstS /= '1') THEN

			if (rising_edge(CLKS) AND current_state = idle) THEN
				currentProgram <= nextProgram;
				toPCE <= '0';
				if (currentProgram = program1) THEN
					current_state <= next_state; --sets current state to be running / initiailization
					iteratorProgram1 <= "0000001";
				elsif (currentProgram = program2) THEN
					current_state <= next_state; --sets current state to be running / initiailization
					iteratorProgram2 <= "0100000";
				elsif (currentProgram = program3) THEN
					current_state <= next_state; --sets current state to be running / initiailization
					iteratorProgram3 <= "0101011";
				elsif (currentProgram = program4) THEN
					if (stop_progS /= '0') THEN
						current_state <= next_state; --sets current state to be running / initiailization
						iteratorProgram4 <= "1100000";
					else
						current_state <= idle;
						iteratorProgram4 <= "1100000";
						inst_outS <= "0000000";
					end if;
				elsif (currentProgram = programError) THEN
						current_state <= running;
						inst_outS <= std_logic_vector(ProgramErrorOutput);
				elsif (currentProgram = programIdle) THEN
					inst_outS <= "0000000";
					current_state <= idle;
				end if;
			elsif (rising_edge(CLKS) AND current_state = running) THEN -- iterates till end of instruction set for program
				toPCE <= '0';
				currentProgram <= nextProgram;
				if (currentProgram = program1) THEN
					iteratorProgram1 <= iteratorProgram1 + 1;
					inst_outS <= std_logic_vector(iteratorProgram1);
					if (iteratorProgram1 = "0011111") THEN
						current_state <= idle;
						iteratorProgram1 <= "0000001";
						toPCE <= '1';
					end if;
				elsif (currentProgram = program2) THEN
					iteratorProgram2 <= iteratorProgram2 + 1;
					inst_outS <= std_logic_vector(iteratorProgram2);
					if (iteratorProgram2 = "0011111") THEN
						current_state <= idle;
						iteratorProgram2 <= "0100000";
						toPCE <= '1';
					end if;
				elsif (currentProgram = program3) THEN
					iteratorProgram3 <= iteratorProgram3 + 1;
					inst_outS <= std_logic_vector(iteratorProgram3);
					if (iteratorProgram3 = "0110101") THEN
						current_state <= idle;
						iteratorProgram3 <= "0101011";
						toPCE <= '1';
					end if;
				elsif (currentProgram = program4) THEN
					if (stop_progS /= '0') THEN
						iteratorProgram4 <= iteratorProgram4 + 1;
						inst_outS <= std_logic_vector(iteratorProgram4);
						if (iteratorProgram4 = "1110001") THEN
							current_state <= running;
							iteratorProgram4 <= "1100000";
							toPCE <= '1';
						end if;
					else
						current_state <= idle;
						inst_outS <= "0000000";
						toPCE <= '0';
						iteratorProgram4 <= "1100000";
					end if;
				elsif (currentProgram = programError) THEN
					current_state <= idle;
					inst_outS <= "0000000";
				else
					current_state <= idle;
					inst_outS <= "0000000";
				end if;
			end if;
		elsif (stop_progS = '0' AND currentProgram = program4) THEN
			toPCE <= '0';
			iteratorProgram4 <= "1100000";
			current_state <= idle;
			inst_outS <= "0000000";				
		else
			toPCE <= '0';
			if (hard_resetS = '1') THEN
				iteratorProgram1 <= "0000001";
				iteratorProgram2 <= "0100000";
				iteratorProgram3 <= "0101011";
				iteratorProgram4 <= "1100000";
				inst_outS <= "0000000";
				current_state <= idle;
			elsif (rstS = '1') THEN
				iteratorProgram1 <= "0000001";
				iteratorProgram2 <= "0100000";
				iteratorProgram3 <= "0101011";
				inst_outS <= "0000000";
				current_state <= idle;
			end if;
		end if;
	end PROCESS;

end architecture;
