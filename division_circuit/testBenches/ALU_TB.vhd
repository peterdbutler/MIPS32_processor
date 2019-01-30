LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY ALU_TB IS
END ALU_TB;
 
ARCHITECTURE behavior OF ALU_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT ALU
    PORT(
         I_ALU_EN : IN  std_logic;
         I_ALU_A : IN  std_logic_vector(5 downto 0);
         I_ALU_B : IN  std_logic_vector(5 downto 0);
         O_ALU_Out : OUT  std_logic_vector(5 downto 0);
         O_ALU_Flag : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal I_ALU_EN : std_logic := '0';
   signal I_ALU_A : std_logic_vector(5 downto 0) := (others => '0');
   signal I_ALU_B : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal O_ALU_Out : std_logic_vector(5 downto 0);
   signal O_ALU_Flag : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          I_ALU_EN => I_ALU_EN,
          I_ALU_A => I_ALU_A,
          I_ALU_B => I_ALU_B,
          O_ALU_Out => O_ALU_Out,
          O_ALU_Flag => O_ALU_Flag
        );

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 50 ns;	
		I_ALU_EN <= '1';
		I_ALU_A <= "000001";
		I_ALU_B <= "001101";
		wait for 10 ns;
		I_ALU_EN <= '0';
		wait for 10 ns;
		
		I_ALU_EN <= '1';
		I_ALU_A <= "000010";
		I_ALU_B <= "001101";
		wait for 10 ns;
		I_ALU_EN <= '0';
		wait for 10 ns;
		
		I_ALU_EN <= '1';
		I_ALU_A <= "000101";
		I_ALU_B <= "001101";
		wait for 10 ns;
		I_ALU_EN <= '0';
		wait for 10 ns;
		
		I_ALU_EN <= '1';
		I_ALU_A <= "001010";
		I_ALU_B <= "001101";
		wait for 10 ns;
		I_ALU_EN <= '0';
		wait for 10 ns;		
				
		I_ALU_EN <= '1';
		I_ALU_A <= "010101";
		I_ALU_B <= "001101";
		wait for 10 ns;
		I_ALU_EN <= '0';
		wait for 10 ns;
				
		I_ALU_EN <= '1';
		I_ALU_A <= "010001";
		I_ALU_B <= "001101";
		wait for 10 ns;
		
		I_ALU_EN <= '0';
		
		wait;
   end process;	

END;
