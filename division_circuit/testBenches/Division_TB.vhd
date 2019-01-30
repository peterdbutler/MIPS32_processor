LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;

ENTITY Division_Division_sch_tb IS
END Division_Division_sch_tb;

ARCHITECTURE behavioral OF Division_Division_sch_tb IS 

   COMPONENT Division
   PORT( I_CLK			:	IN	STD_LOGIC; 
          I_EN			:	IN	STD_LOGIC; 
          I_Dividend	:	IN	STD_LOGIC_VECTOR (5 DOWNTO 0); 
          O_Quotient	:	OUT	STD_LOGIC_VECTOR (5 DOWNTO 0); 
          O_Remainder	:	OUT	STD_LOGIC_VECTOR (5 DOWNTO 0); 
          I_Divisor		:	IN	STD_LOGIC_VECTOR (5 DOWNTO 0));
   END COMPONENT;

   SIGNAL I_CLK			:	STD_LOGIC;
   SIGNAL I_EN			:	STD_LOGIC;
   SIGNAL I_Dividend	:	STD_LOGIC_VECTOR (5 DOWNTO 0);
   SIGNAL O_Quotient	:	STD_LOGIC_VECTOR (5 DOWNTO 0);
   SIGNAL O_Remainder	:	STD_LOGIC_VECTOR (5 DOWNTO 0);
   SIGNAL I_Divisor		:	STD_LOGIC_VECTOR (5 DOWNTO 0);
   
   -- clock
   signal I_CLK_PERIOD	: time := 20 ns;

BEGIN

   UUT: Division PORT MAP(
		I_CLK => I_CLK, 
		I_EN => I_EN, 
		I_Dividend => I_Dividend, 
		O_Quotient => O_Quotient, 
		O_Remainder => O_Remainder, 
		I_Divisor => I_Divisor
   );
   
   	clock : process
	begin
		I_CLK <= '0';
		wait for I_CLK_PERIOD/2;
		I_CLK <= '1';
		wait for I_CLK_PERIOD/2;
	end process clock;
	
	tb : PROCESS
	BEGIN
		wait for 50 ns;
		I_EN <= '1';
		I_Divisor <="001101";
		I_Dividend <="101011";
		wait for 500 ns;
		I_EN <='0';
		WAIT;
	END PROCESS;

END;
