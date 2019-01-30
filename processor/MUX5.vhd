library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX5 is
	Port (
			I_MUX_0		: in 	STD_LOGIC_VECTOR (4 downto 0);
			I_MUX_1		: in 	STD_LOGIC_VECTOR (4 downto 0);
			I_MUX_Sel	: in 	STD_LOGIC;
			O_MUX_Out	: out   STD_LOGIC_VECTOR (4 downto 0)
			);
end MUX5;

architecture Behavioral of MUX5 is

begin
--	process(I_MUX_Sel)-- MUX only triggered by change in Sel
--	begin
--		if I_MUX_Sel = '0' then
--            O_MUX_Out <= I_MUX_0;
--		elsif I_MUX_Sel = '1' then
--            O_MUX_Out <= I_MUX_1;
--		end if;
--		
--	end process;
O_MUX_Out <= I_MUX_1 when I_MUX_Sel = '1' else I_Mux_0;

end Behavioral;

