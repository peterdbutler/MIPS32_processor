library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.DivControl.all;

entity Control is
	Port (
		I_CTL_CLK	:	in 	STD_LOGIC;
		I_CTL_EN	:	in 	STD_LOGIC;
		O_CTL_INI	:	out	STD_LOGIC;
		O_CTL_SLL	:	out	STD_LOGIC;
		O_CTL_ALU	:	out	STD_LOGIC;
		O_CTL_RMD	:	out	STD_LOGIC
	);
end Control;

architecture Behavioral of Control is
	signal state : DIV_CONTROL_STATE := en;
	signal counter	:	integer :=0;
begin
	process ( I_CTL_CLK )
	begin
		if rising_edge ( I_CTL_CLK ) then
			if ( I_CTL_EN = '1' ) then
				if ( state = en ) then
					counter <= counter+1;
					state <= init;
				elsif ( state = init ) then
					state <= shift;
				elsif ( state = shift ) then
					state <= ALU;
				elsif ( state = ALU ) then
					state <= update;	
				elsif ( state = update ) then
					if ( counter < 6 ) then		-- '<' is inclusive??
						counter <= counter+1;
						state <= shift;
					else
						state <= term;
					end if;	
				end if;
			else
				if ( state = en ) then
					state <= en;
				else
					state <= term;
				end if;
			end if;
		end if;
	end process;
	
	process ( state )
	begin
		if ( state = en ) or ( state = term ) then
			O_CTL_INI <= '0';
			O_CTL_SLL <= '0';
			O_CTL_ALU <= '0';
			O_CTL_RMD <= '0';
		
		elsif ( state = init ) then
			O_CTL_INI <= '1';
			O_CTL_SLL <= '0';
			O_CTL_ALU <= '0';
			O_CTL_RMD <= '0';
		
		elsif ( state = shift ) then
			O_CTL_INI <= '0';
			O_CTL_SLL <= '1';
			O_CTL_ALU <= '0';
			O_CTL_RMD <= '0';
		
		elsif ( state = ALU ) then
			O_CTL_INI <= '0';
			O_CTL_SLL <= '0';
			O_CTL_ALU <= '1';
			O_CTL_RMD <= '0';
		
		elsif ( state = update ) then
			O_CTL_INI <= '0';
			O_CTL_SLL <= '0';
			O_CTL_ALU <= '0';
			O_CTL_RMD <= '1';
		end if;	
	end process;
	
end Behavioral;

