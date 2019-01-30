library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity EXT is
    Port ( 
        I_EXT_16    : in STD_LOGIC_VECTOR (15 downto 0);
        O_EXT_32    : out STD_LOGIC_VECTOR (31 downto 0)
	 );
end EXT;

architecture Behavioral of EXT is
begin
	process ( I_EXT_16 ) 	
    begin
        O_EXT_32(15 downto 0) <= I_EXT_16(15 downto 0);
        O_EXT_32(31 downto 16) <= (others => I_EXT_16(15));
    end process;
end Behavioral;
