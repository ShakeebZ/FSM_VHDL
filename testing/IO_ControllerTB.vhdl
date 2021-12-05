library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE work.definitions_package.all;

entity IO_ControllerTB is
end ENtity;

architecture structure of IO_ControllerTB is
	SIGNAL toSeg : twoDArrayCU := ("00000","00000","00000","00000","00000","00000","00000","00000");
	SIGNAL clock : std_logic := '0';
	SIGNAL toHEX : twoDArrayIO;
	SIGNAL A, B, C : unsigned(4 downto 0) := (others=>'0');
    component Custom7Seg is
        port (
            D : IN STD_LOGIC_VECTOR(4 downto 0);
            Y : OUT STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;
begin

	process
		begin
			clock <= not clock;
			wait for 10 ns;
		end process;
		
	process(clock)
		begin
		if(rising_edge(clock)) THEN
			A <= A + 1;
			B <= B - 1;
			C <= C + 4;
			toSeg <= (std_logic_vector(A),
					std_logic_vector(B),
					std_logic_vector(C),
					std_logic_vector(C),
					std_logic_vector(B),
					std_logic_vector(A),
					std_logic_vector(A),
					std_logic_vector(C));
		end if;
	end process;
		
		 forgenerate: for i in 0 to 7 generate
			  segDecoded : Custom7Seg PORT MAP(D => toSeg(i), Y => toHex(i));
		 end generate;
end architecture;