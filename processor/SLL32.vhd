library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SLL32 is
    Port ( I_INS : in  STD_LOGIC_VECTOR (31 downto 0);
           O_INS : out  STD_LOGIC_VECTOR (31 downto 0));
end SLL32;

architecture Behavioral of SLL32 is

begin
    process( I_INS )
    begin
        O_INS(31 downto 2) <= I_INS(29 downto 0);
        O_INS(1 downto 0) <= "00";
    end process;

end Behavioral;
