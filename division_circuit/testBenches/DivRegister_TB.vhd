LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY DivRegister_TB IS
END DivRegister_TB;
 
ARCHITECTURE behavior OF DivRegister_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT DivRegister
    PORT(
		I_REG_Init  :   in  STD_LOGIC;							-- CONTROL signal to let the register init it's contents
        I_REG_Update:   in  STD_LOGIC;							-- CONTROL signal to let the register update it's contents
        I_REG_SLL   :   in  STD_LOGIC;							-- CONTROL signal to let the register perform a shift
        I_REG_LSB   :   in  STD_LOGIC;							-- input to set the LSB after shift
        I_REG_Div   :   in  STD_LOGIC_VECTOR ( 5 downto 0 );	-- Dividend
        I_REG_ALU   :   in  STD_LOGIC_VECTOR ( 5 downto 0 );	-- ALU output
        O_REG_HI    :   out STD_LOGIC_VECTOR ( 5 downto 0 );	-- HI output (Remainder)
        O_REG_LO    :   out STD_LOGIC_VECTOR ( 5 downto 0 )		-- LO output (Quotient)
		);
    END COMPONENT;
    

	--Inputs
	signal I_REG_Init : std_logic;
	signal I_REG_Update : std_logic;
	signal I_REG_SLL : std_logic;
	signal I_REG_LSB : std_logic;
	signal I_REG_Div : std_logic_vector(5 downto 0);
	signal I_REG_ALU : std_logic_vector(5 downto 0);

 	--Outputs
	signal O_REG_HI : std_logic_vector(5 downto 0);
	signal O_REG_LO : std_logic_vector(5 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
	uut: DivRegister PORT MAP (
          I_REG_Init => I_REG_Init,
          I_REG_Update => I_REG_Update,
          I_REG_SLL => I_REG_SLL,
          I_REG_LSB => I_REG_LSB,
          I_REG_Div => I_REG_Div,
          I_REG_ALU => I_REG_ALU,
          O_REG_HI => O_REG_HI,
          O_REG_LO => O_REG_LO
        );

	-- Stimulus process
	stim_proc: process
	begin
	  -- INIT (Step 0)
		I_REG_Div <= "101011";
		
		wait for 50 ns;	
		-- CONTROL inputs
		I_REG_Init <= '1';
		I_REG_SLL <= '0';
		I_REG_Update <= '0';
		wait for 20 ns;
		
		
	-- STEP 1	
	  -- Step 1a: SHIFT
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '1';
		I_REG_Update <= '0';
		
		-- ALU inputs
		wait for 20 ns;
	
	 -- Step 1b: update
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '1';
		
		-- ALU inputs
		I_REG_ALU <= "000001";
		I_REG_LSB <= '0';
		wait for 20 ns;
	
	-- STEP 2
	  -- Step 2a: SHIFT
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '1';
		I_REG_Update <= '0';
		
		-- ALU inputs
		wait for 20 ns;
		
	 -- Step 2b: update
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '1';
		
		-- ALU inputs
		I_REG_ALU <= "000010";
		I_REG_LSB <= '0';
		wait for 20 ns;
	
	-- STEP 3
	  -- Step 3a: SHIFT
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '1';
		I_REG_Update <= '0';
		
		-- ALU inputs
		wait for 20 ns;
		
	 -- Step 3b: update
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '1';
		
		-- ALU inputs
		I_REG_ALU <= "000101";
		I_REG_LSB <= '0';
		wait for 20 ns;
	
	-- STEP 4
	  -- Step 4a: SHIFT
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '1';
		I_REG_Update <= '0';
		
		-- ALU inputs
		wait for 20 ns;
		
	 -- Step 4b: update
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '1';
		
		-- ALU inputs
		I_REG_ALU <= "001010";
		I_REG_LSB <= '0';
		wait for 20 ns;
	
	-- STEP 5
	  -- Step 5a: SHIFT
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '1';
		I_REG_Update <= '0';
		
		-- ALU inputs
		wait for 20 ns;
		
	 -- Step 5b: update
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '1';
		
		-- ALU inputs
		I_REG_ALU <= "001000";
		I_REG_LSB <= '1';
		wait for 20 ns;
			
	-- STEP 6
	  -- Step 6a: SHIFT
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '1';
		I_REG_Update <= '0';
		
		-- ALU inputs
		wait for 20 ns;
		
	 -- Step 6b: update		
		-- ALU inputs
		I_REG_ALU <= "000100";
		I_REG_LSB <= '1';
		-- CONTROL inputs
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '1';
		

		wait for 20 ns;
		
		I_REG_Init <= '0';
		I_REG_SLL <= '0';
		I_REG_Update <= '0';							
		wait;
	end process;

END;
