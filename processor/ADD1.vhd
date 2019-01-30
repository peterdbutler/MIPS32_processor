library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity ADD1 is
	Port (
			I_ADD1_A	: in STD_LOGIC_VECTOR  (31 downto 0);
			O_ADD1_Out  : out STD_LOGIC_VECTOR (31 downto 0)
			);
end ADD1;

architecture Behavioral of ADD1 is
		begin	
			process(I_ADD1_A)
		
		begin
			O_ADD1_Out <= std_logic_vector(to_unsigned(to_integer(unsigned( I_ADD1_A )) + 4, 32));
end process;

end Behavioral;

