library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity JCU is
    Port ( I_JCU_Ins : in  STD_LOGIC_VECTOR (25 downto 0);
           I_JCU_PC : in  STD_LOGIC_VECTOR (3 downto 0);
           O_JCU_Jump : out  STD_LOGIC_VECTOR (31 downto 0));
end JCU;

architecture Behavioral of JCU is

begin
    process ( I_JCU_Ins, I_JCU_PC )
    begin
        O_JCU_Jump(31 downto 28) <= I_JCU_PC(3 downto 0);
        O_JCU_Jump(27 downto 2) <= I_JCU_INS(25 downto 0);
        O_JCU_Jump(1 downto 0) <= "00";
    end process;
end Behavioral;
