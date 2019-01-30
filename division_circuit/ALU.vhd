library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
	port (	I_ALU_EN	:	in	STD_LOGIC;							-- CONTROL signal to input ALU
			I_ALU_A		:	in	STD_LOGIC_VECTOR( 5 downto 0 );		-- HI_REG/Remainder input
			I_ALU_B		: 	in	STD_LOGIC_VECTOR( 5 downto 0 );		-- DIVISOR (CONSTANT!)
			O_ALU_Out	:	out	STD_LOGIC_VECTOR( 5 downto 0 );		-- ALU Output
			O_ALU_Flag	:	out	STD_LOGIC							-- LSB flag
	);
	
end ALU;

architecture Behavioral of ALU is
begin
	process ( I_ALU_EN )
	begin
		if ( I_ALU_EN = '1' ) then
			if ( I_ALU_A < I_ALU_B ) then
				O_ALU_Out <= I_ALU_A;
				O_ALU_Flag <= '0';
			else
				O_ALU_Out <= STD_LOGIC_VECTOR ( unsigned ( I_ALU_A ) - unsigned ( I_ALU_B ) );
				O_ALU_Flag <= '1';
			end if;
		end if;
	end process;
	
end Behavioral;