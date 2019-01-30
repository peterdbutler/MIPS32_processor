library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity ADD2 is
	Port (
			I_ADD2_A		: in		STD_LOGIC_VECTOR (31 downto 0);
			I_ADD2_B		: in 		STD_LOGIC_VECTOR (31 downto 0);
			O_ADD2_Out	: out		STD_LOGIC_VECTOR (31 downto 0)
			);
end ADD2;
 
architecture Behavioral of ADD2 is
    --signal A : integer;
    --signal B : integer;
-- module adds sign extended pc and pc + 4
begin 
	--process(I_ADD2_A,I_ADD2_B)
	--begin
    --A <= to_integer( unsigned ( I_ADD2_A ( 31 downto 0 ) ) );
    --B <= to_integer ( unsigned ( I_ADD2_B( 31 downto 0 ) ) );
	O_ADD2_Out <= std_logic_vector(unsigned(I_ADD2_A) + unsigned(I_ADD2_B) );
--end process;
 
end Behavioral;
