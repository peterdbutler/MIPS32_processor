library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_REG is
    Port(   I_PC_Update : in STD_LOGIC;
            I_PC        : in STD_LOGIC_VECTOR (31 downto 0);
            O_PC        : out STD_LOGIC_VECTOR (31 downto 0) := x"00000000"
        );
end PC_REG;

architecture Behavioral of PC_REG is
begin
    process ( I_PC_Update )
	begin
        if ( I_PC_Update = '1' ) then
            O_PC <= I_PC;
        end if;
	end process;
end Behavioral;
