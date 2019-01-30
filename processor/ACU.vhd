library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ACU is
Port (
			I_ACU_ALUOp : in  STD_LOGIC_VECTOR ( 1 downto 0);
			I_ACU_Funct : in  STD_LOGIC_VECTOR (5 downto 0);
			O_ACU_CTL   : out STD_LOGIC_VECTOR( 3 downto 0)
			);

end ACU;

architecture Behavioral of ACU is

begin
process(I_ACU_ALUOp)

begin
		
		if I_ACU_ALUOp = "00" then O_ACU_CTL   <= "0010";
		elsif I_ACU_ALUOp = "01" then O_ACU_CTL <= "0110";
		elsif I_ACU_ALUOp = "10" then
			if I_ACU_FUNCT ( 3 downto 0 ) = "0001" then
				O_ACU_CTL <= "0010";
			-- NOTE: Below is for future implementation of extra functionality
			elsif I_ACU_FUNCT ( 3 downto 0 ) = "0000" then
				O_ACU_CTL <= "0010";
			elsif I_ACU_Funct ( 3 downto 0 ) = "0010" then
				O_ACU_CTL <= "0110";
			elsif I_ACU_Funct ( 3 downto 0 ) = "0100" then
				O_ACU_CTL <= "0000";
			elsif I_ACU_Funct ( 3 downto 0 ) = "0101" then
				O_ACU_CTL <= "0001";
			elsif I_ACU_Funct ( 3 downto 0 ) = "1010" then
				O_ACU_CTL <= "0111";
			end if;
		end if;
end process;

end Behavioral;
