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
    type programType is (program1, program2, program3, program4, programError, programIdle);

    signal current_state : state;
    signal currentProgram, nextProgram : programType;
    signal incrementor : std_logic;
    signal iteratorProgram1 : unsigned(6 downto 0) := "0000000"; --program1's start
    signal iteratorProgram2 : unsigned(6 downto 0) := "0011111"; --program2's start
    signal iteratorProgram3 : unsigned(6 downto 0) := "0101010"; --program3's start
    signal iteratorProgram4 : unsigned(6 downto 0) := "1011111"; --program4's start
    signal ProgramErrorOutput : unsigned(6 downto 0) := "1110001"; --error's instruction
    
begin
    PROCESS(rstS, hard_resetS) --resets everything
        begin
            current_state <= idle;
    END Process;

    PROCESS(CLKS) --increments through instructions in respective program type
    begin
        if (rising_edge(CLKS) AND (currentProgram = program1) AND (current_state = running)) THEN --instructions = 32, n-1 = 31, 31st will be seperate to set state to idle and program to programNone
            iteratorProgram1 <= iteratorProgram1 + 1;
            inst_outS <= std_logic_vector(iteratorProgram1);
            if (iteratorProgram1 = "0011111") THEN
                toPCE <= '1';
                current_state <= idle;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program2) AND (current_state = running)) THEN
            iteratorProgram2 <= iteratorProgram2 + 1;
            inst_outS <= std_logic_vector(iteratorProgram2);
            if (iteratorProgram2 = "0101010") THEN
                toPCE <= '1';
                current_state <= Idle
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program3) AND (current_state = running)) THEN
            inst_outS <= std_logic_vector(iteratorProgram3);
            iteratorProgram3 <= iteratorProgram3 + 1;
            if (iteratorProgram3 = "0110101") THEN
                 toPCE <= '1';
                 current_state <= idle;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program4) AND (current_state = running)) THEN
            iteratorProgram4 <= iteratorProgram4 + 1;
            inst_outS <= std_logic_vector(iteratorProgram4);
            if (iteratorProgram4 = "1110001") THEN
                toPCE <= '1';
                current_state <= idle;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = programError) AND (current_state = running)) THEN
            inst_outS <= std_logic_vector(ProgramErrorOutput);
            current_state <= idle;
        else 
            insts_outS <= std_logic_vector("0000000");
            current_state <= Idle;
            end if;
    end process;


    PROCESS(nextProgram, CLKS) --reads to see if there is a change in next state, if there is, then check current state's status
        begin
            if (rising_edge(CLKS)) THEN
                if (current_state = idle AND nextProgram /= currentProgram) THEN
                    current_state <= running;
                    currentProgram <= nextProgram;
                elsif (current_state = idle AND nextProgram = currentProgram) THEN 
                    current_state <= running; --program is already busy with another program running, thus continue with that program till idle
                    currentProgram <= currentProgram;
                end if;
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
                if (stop_progS) THEN
                    nextProgram <= programIdle;
                else 
                    nextProgram <= program4;
                end if;
            elsif (programS <= "0000") THEN
                nextProgram <= programIdle;
            else
                nextProgram <= programError;
            end if;
        end process;
end architecture;