library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Scheduler is
    port (
        CLKS : in std_logic;
        rstS : in std_logic;
        hard_resetS : in std_logic;
        stop_progS : in std_logic;
        programS : in std_logic_vector(3 downto 0);
        inst_outS : out std_logic_vector(5 downto 0);
        toPCE : out std_logic
    );
end Scheduler;

architecture rtl of Scheduler
    type state is (idle, running, transition);
    type programType is (program1, program2, program3, program4, programError);

    signal program_state : state;
    signal currentProgram, nextProgram : programType;
    signal incrementor;
    signal toControlUnit : unsigned(5 downto 0);
    signal toIO_Controller : std_logic_vector(39 downto 0);
    signal iteratorProgram1 : unsigned(5 downto 0) := "000001"; --program1's start
    signal iteratorProgram2 : unsigned(5 downto 0) := "100000"; --program2's start
    signal iteratorProgram3 : unsigned(5 downto 0) := "101011"; --program3's start

    component PCE 
        PORT (
            hardResetPCE : In STD_LOGIC;
            ClkPCE : In STD_Logic;
            programPCE : In STD_Logic;
            toGreenlights : OUT STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    component ControlUnit
        port (
            clkCU : in std_logic;
            rstCU : in std_logic;
            hard_rstCU : in std_logic;
            instCU : in std_logic_vector(5 DOWNTO 0);
            toSegCU : out std_logic_vector(39 DOWNTO 0)
        );
    end component;

    component IO_Controller
        port (
            toSeg : IN std_logic_vector(39 downto 0);
            toHex : OUT twoDArray
        );
    end component;


begin
    PROCESS(rstS, hard_resetS) --resets everything
        begin
            program_state <= idle;
    END Process;

    PROCESS(CLKS)) --increments through instructions in respective program type
    begin
        if (rising_edge(CLKS) AND (currentProgram = program1) AND (current_state = running)) THEN --instructions = 32, n-1 = 31, 31st will be seperate to set state to idle and program to programNone
            toControlUnit <= std_logic(iteratorProgram1);
            iteratorProgram1 <= iteratorProgram1 + 1;
            if (iteratorProgram1 = "011111") THEN
                iteratorProgram1 = "000000";
                current_state = transition;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program2) AND (current_state = running)) THEN
            toControlUnit <= std_logic(iteratorProgram2);
            iteratorProgram2 <= iteratorProgram2 + 1;
            if (iteratorProgram2 = "101010")
                iteratorProgram2 = "000000";
                current_state = transition;
            end if;

        elsif (rising_edge(CLKS) AND (currentProgram = program3) AND (current_state = running)) THEN
            toControlUnit <= std_logic(iteratorProgram3);
            iteratorProgram3 <= iteratorProgram3 + 1;
            if (iteratorProgram3 = "110101") THEN
                iteratorProgram3 = "000000";
                current_state = transition;
            end if;
        

        elsif (rising_edge(CLKS) AND (currentProgram = program1) AND (current_state = transition)) THEN
            toControlUnit <= std_logic(iteratorProgram1);
            iteratorProgram1 <= "000001";
            current_state = idle;
        elsif (rising_edge(CLKS) AND (currentProgram = program2) AND (current_state = transition)) THEN
            toControlUnit <= std_logic(iteratorProgram2);
            iteratorProgram2 <= "100000";
            current_state = idle; 
        elsif (rising_edge(CLKS) AND (currentProgram = program3) AND (current_state = transition)) THEN
            toControlUnit <= std_logic(iteratorProgram3);
            iteratorProgram3 <= "101011";
            current_state = idle;
        end if;
    end process;

    PROCESS(nextProgram) --reads to see if there is a change in next state, if there is, then check current state's status
            begin
                if (program_State = idle) THEN
                    program_State <= running;
                    currentProgram <= nextProgram;
                else 
                    program_State <= program_State; --program is already busy with another program running, thus continue with that program till idle
                end if;
    END PROCESS;

    PROCESS(programS) --reads input, then assigns program type
        begin
            if (programS = "0001") THEN
                nextProgram = program1;
            elsif (programS = "0010") THEN
                nextProgram = program2;
            elsif (programS = "0100") THEN
                nextProgram = program3;
            elsif (programS = "1000") THEN
                nextProgram = program4;
            else
                nextProgram = programError;
            end if;
        end process;
    
ControlUnitEnt : ControlUnit port map (clkCU => CLKS, --need to figure out where/what to instantiate
                                    rstCU => rstS,
                                    hard_rstCU => hard_resetS,
                                    instCU => iteratorProgram1,
                                    toSegCU => toIO_Controller)

end architecture