library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DivRegister is
Port (  I_REG_Init  :   in  STD_LOGIC;							-- CONTROL signal to let the register init it's contents
        I_REG_Update:   in  STD_LOGIC;							-- CONTROL signal to let the register update it's contents
        I_REG_SLL   :   in  STD_LOGIC;							-- CONTROL signal to let the register perform a shift
        I_REG_LSB   :   in  STD_LOGIC;							-- input to set the LSB after shift
        I_REG_Div   :   in  STD_LOGIC_VECTOR ( 5 downto 0 );	-- Dividend
        I_REG_ALU   :   in  STD_LOGIC_VECTOR ( 5 downto 0 );	-- ALU output
        O_REG_HI    :   out STD_LOGIC_VECTOR ( 5 downto 0 );	-- HI output (Remainder)
        O_REG_LO    :   out STD_LOGIC_VECTOR ( 5 downto 0 )		-- LO output (Quotient)
        );
end DivRegister;

architecture Behavioral of DivRegister is
	
begin
    process ( I_REG_Init, I_REG_SLL, I_REG_UPDATE )
		variable REG_LO	: STD_LOGIC_VECTOR ( 5 downto 0 );
		variable REG_HI : STD_LOGIC_VECTOR ( 5 downto 0 );
    begin
		-- INITIALIZATION
		if ( I_Reg_Init = '1' ) then
			-- init variables:
			REG_LO( 5 downto 0 ) := I_REG_DIV( 5 downto 0 );
			REG_HI( 5 downto 0 ) := "000000";
			-- init outputs:
			O_REG_HI( 5 downto 0 ) <= REG_HI( 5 downto 0 );
			O_REG_LO( 5 downto 0 ) <= REG_LO( 5 downto 0 );
		end if;
		
		-- SHIFT
		if ( I_REG_SLL = '1' ) then
			-- shift variables
			REG_HI( 5 downto 1 ) := REG_HI( 4 downto 0 );
			REG_HI( 0 ) := REG_LO ( 5 );
			REG_LO( 5 downto 1 ) := REG_LO( 4 downto 0 );
			REG_LO( 0 ) := 'U';
			-- shift outputs
			O_REG_HI( 5 downto 0 ) <= REG_HI( 5 downto 0 );
			O_REG_LO( 5 downto 0 ) <= REG_LO( 5 downto 0 );
        end if;
		
		-- UPDATE
		if ( I_REG_Update = '1' ) then
			-- update variables
			REG_LO( 0 ) := I_REG_LSB;
			REG_HI( 5 downto 0 ) := I_REG_ALU;
			-- update outputs
			O_REG_HI <= REG_HI( 5 downto 0 );
			O_REG_LO <= REG_LO( 5 downto 0 );
		end if;

    end process;
end Behavioral;