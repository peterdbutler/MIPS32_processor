LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY CCSiMP32_CCSiMP32_sch_tb IS
END CCSiMP32_CCSiMP32_sch_tb;
ARCHITECTURE behavioral OF CCSiMP32_CCSiMP32_sch_tb IS 

   COMPONENT CCSiMP32
   PORT( I_CLK	:	IN	STD_LOGIC; 
          I_EN	:	IN	STD_LOGIC);
   END COMPONENT;

   SIGNAL I_CLK	:	STD_LOGIC;
   SIGNAL I_EN	:	STD_LOGIC;
   
   constant I_CLK_period : time := 10 ns;
BEGIN

   UUT: CCSiMP32 PORT MAP(
		I_CLK => I_CLK, 
		I_EN => I_EN
   );
   
   I_CLK_process : process
   begin
        I_CLK <= '0';
        wait for I_CLK_period/2;
        I_CLK <= '1';
        wait for I_CLK_period/2;
   end process;

   tb : PROCESS
   BEGIN
        I_EN <= '1';
      WAIT; -- will wait forever
   END PROCESS;

END;
