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
    type state is (idle, running, transition);
    type programType is (program1, program2, program3, program4, programError);

    signal current_state : state;
    signal currentProgram, nextProgram : programType;
    signal incrementor : std_logic;
    signal iteratorProgram1 : unsigned(6 downto 0) := "0000001"; --program1's start
    signal iteratorProgram2 : unsigned(6 downto 0) := "0100000"; --program2's start
    signal iteratorProgram3 : unsigned(6 downto 0) := "0101011"; --program3's start
    signal iteratorProgram4 : unsigned(6 downto 0) := "1100000"; --program4's start
    signal ProgramErrorOutput : unsigned(6 downto 0) := "1110010"; --error's instruction
    

begin
    PROCESS(rstS, hard_resetS) --resets everything
        begin
            current_state <= idle;
    END Process;

    PROCESS(CLKS) --increments through instructions in respective program type
    begin
        if (rising_edge(CLKS) AND (currentProgram = program1) AND (current_state = running)) THEN --instructions = 32, n-1 = 31, 31st will be seperate to set state to idle and program to programNone
            inst_outS <= std_logic_vector(iteratorProgram1);
            iteratorProgram1 <= iteratorProgram1 + 1;
            if (iteratorProgram1 = "0011111") THEN
                toPCE <= '1';
                iteratorProgram1 <= "0000000";
                current_state <= transition;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program2) AND (current_state = running)) THEN
            inst_outS <= std_logic_vector(iteratorProgram2);
            iteratorProgram2 <= iteratorProgram2 + 1;
            if (iteratorProgram2 = "0101010") THEN
                toPCE <= '1';
                iteratorProgram2 <= "0000000";
                current_state <= transition;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program3) AND (current_state = running)) THEN
            inst_outS <= std_logic_vector(iteratorProgram3);
            iteratorProgram3 <= iteratorProgram3 + 1;
            if (iteratorProgram3 = "0110101") THEN
                toPCE <= '1';
                iteratorProgram3 <= "0000000";
                current_state <= transition;
            end if;
        elsif (rising_edge(CLKS) AND (currentProgram = program4) AND (current_state = running)) THEN
            inst_outS <= std_logic_vector(iteratorProgram4);
            iteratorProgram4 <= iteratorProgram4 + 1;
            if (iteratorProgram4 = "1110001") THEN
                toPCE <= '1';
                iteratorProgram4 <= "1100000";
                current_state <= running;
            end if;
        elsif (rising_edge(CLKS) AND (currentProgram = programError) AND (current_state = running)) THEN
            inst_outS <= std_logic_vector(ProgramErrorOutput);
            current_state <= transition;
            ProgramErrorOutput <= "0000000";


        elsif (rising_edge(CLKS) AND (currentProgram = program1) AND (current_state = transition)) THEN
            inst_outS <= std_logic_vector(iteratorProgram1);
            iteratorProgram1 <= "0000001";
            current_state <= idle;
        elsif (rising_edge(CLKS) AND (currentProgram = program2) AND (current_state = transition)) THEN
            inst_outS <= std_logic_vector(iteratorProgram2);
            iteratorProgram2 <= "0100000";
            current_state <= idle; 
        elsif (rising_edge(CLKS) AND (currentProgram = program3) AND (current_state = transition)) THEN
            inst_outS <= std_logic_vector(iteratorProgram3);
            iteratorProgram3 <= "0101011";
            current_state <= idle;
        elsif (rising_edge(CLKS) AND (currentProgram = programError) AND (current_state = transition)) THEN
            inst_outS <= std_logic_vector(ProgramErrorOutput);
            ProgramErrorOutput <= "1110010";
            current_state <= idle;
        end if;
        toPCE <= '0';
    end process;

    PROCESS(nextProgram) --reads to see if there is a change in next state, if there is, then check current state's status
            begin
                if (current_state = idle) THEN
                    current_state <= running;
                    currentProgram <= nextProgram;
                else 
                    current_state <= current_state; --program is already busy with another program running, thus continue with that program till idle
                end if;
    END PROCESS;

    PROCESS(programS) --reads input, then assigns program type
        begin
            if (programS = "0001") THEN
                nextProgram <= program1;
            elsif (programS = "0010") THEN
                nextProgram <= program2;
            elsif (programS = "0100") THEN
                nextProgram <= program3;
            elsif (programS = "1000") THEN
                nextProgram <= program4;
            else
                nextProgram <= programError;
            end if;
        end process;
end architecture;