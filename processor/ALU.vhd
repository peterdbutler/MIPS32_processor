library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( I_ALU_EN : in  STD_LOGIC;
           I_ALU_CTL : in  STD_LOGIC_VECTOR (3 downto 0);
           I_ALU_A : in  STD_LOGIC_VECTOR (31 downto 0);
           I_ALU_B : in  STD_LOGIC_VECTOR (31 downto 0);
           O_ALU_Out : out  STD_LOGIC_VECTOR (31 downto 0):= X"00000000";
           O_ALU_Zero : out  STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

begin
    process( I_ALU_EN )
    begin
        if ( I_ALU_EN = '1' ) then
            if ( I_ALU_CTL = "0010" ) then
                --  addition
                O_ALU_Zero <= '0';
                O_ALU_Out <= STD_LOGIC_VECTOR(unsigned(I_ALU_A)+unsigned(I_ALU_B));
            elsif ( I_ALU_CTL = "0110" ) then
                --  subtraction
                if ( I_ALU_A = I_ALU_B ) then
                    O_ALU_ZERO <= '1';
                else
                    O_ALU_ZERO <= '0';
                end if;
                O_ALU_Out <= STD_LOGIC_VECTOR(unsigned(I_ALU_A)-unsigned(I_ALU_B));

            --  Unused, but implemented nontheless...
            elsif ( I_ALU_CTL = "0000" ) then
                -- and
                O_ALU_ZERO <= '0';
                O_ALU_OUT <= ( I_ALU_A AND I_ALU_B );
            elsif ( I_ALU_CTL = "0001" ) then
                -- or
                O_ALU_ZERO <= '0';
                O_ALU_OUT <= ( I_ALU_A OR I_ALU_B );
            end if;
        end if;
    end process;

end Behavioral;
