LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

USE work.DivControl.all;

ENTITY Control_TB IS
END Control_TB;

ARCHITECTURE behavior OF Control_TB IS 

	-- Component Declaration
	COMPONENT Control
	PORT(
		I_CTL_CLK	:	in 	STD_LOGIC;
		I_CTL_EN		:	in 	STD_LOGIC;
		O_CTL_INI	:	out	STD_LOGIC;
		O_CTL_SLL	:	out	STD_LOGIC;
		O_CTL_ALU	:	out	STD_LOGIC;
		O_CTL_RMD	:	out	STD_LOGIC
	);
	END COMPONENT;
	
	-- inputs
	signal I_CTL_CLK	:	STD_LOGIC;
	signal I_CTL_EN	:	STD_LOGIC;	
	
	-- outputs
	signal O_CTL_INI	:	STD_LOGIC;
	signal O_CTL_SLL	:	STD_LOGIC;
	signal O_CTL_ALU	:	STD_LOGIC;
	signal O_CTL_RMD	:	STD_LOGIC;
	
	-- constant
	signal I_CTL_CLK_PERIOD : time := 10 ns;
	
BEGIN

	-- Component Instantiation
	uut: Control PORT MAP(
		I_CTL_CLK => I_CTL_CLK,
		I_CTL_EN => I_CTL_EN,
		O_CTL_INI => O_CTL_INI,
		O_CTL_SLL => O_CTL_SLL,
		O_CTL_ALU => O_CTL_ALU,
		O_CTL_RMD => O_CTL_RMD
	);

	--  Test Bench Statements
	clock : process
	begin
		I_CTL_CLK <= '0';
		wait for I_CTL_CLK_PERIOD/2;
		I_CTL_CLK <= '1';
		wait for I_CTL_CLK_PERIOD/2;
	end process clock;
		
	tb : PROCESS
	BEGIN

		wait for 50 ns; 
		I_CTL_EN <= '1';
		wait for 300 ns;
		I_CTL_EN <= '0';
		wait;
	END PROCESS tb;
	--  End Test Bench 

END;
