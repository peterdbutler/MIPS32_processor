library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCU is
    Port ( I_BCU_BEQ : in  STD_LOGIC;
           I_BCU_BNE : in  STD_LOGIC;
           I_BCU_EQ : in  STD_LOGIC;
           O_BCU_Branch : out  STD_LOGIC);
end BCU;

architecture Behavioral of BCU is

begin
--    process ( I_BCU_EQ )
--    begin
--        if ( I_BCU_BEQ = '1' and I_BCU_BNE = '0' and I_BCU_EQ = '1' ) then
--            O_BCU_Branch <= '1';
--        elsif ( I_BCU_BEQ = '0' and I_BCU_BNE = '1' and I_BCU_EQ = '0' ) then
--            O_BCU_Branch <= '1';
--        else
--            O_BCU_Branch <= '0';
--        end if;
--    end process;
     --O_MUX_Out <= I_MUX_1 when I_MUX_Sel = '1' else I_Mux_0;
     O_BCU_Branch <= '1' when I_BCU_BEQ = '1' and I_BCU_BNE = '0' and I_BCU_EQ = '1' else
     '1' when I_BCU_BEQ = '0' and I_BCU_BNE = '1' and I_BCU_EQ = '0' else '0';

end Behavioral;
