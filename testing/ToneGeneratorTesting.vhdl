library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ToneGeneratorTesting is
    port (
        AUD_DACDAT : out std_logic
    );
end ToneGeneratorTesting;

architecture rtl of ToneGeneratorTesting is

component ToneGenerator IS
port (
        instTG : in std_logic_vector(6 DOWNTO 0);
        AUD_DACDAT : out std_logic
    );
end component;

begin

ToneGeneratorComponent : ToneGenerator port map(
    instTG => "1110010",
    AUD_DACDAT => AUD_DACDAT
);

end architecture;