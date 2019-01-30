Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.FSM_Control.all;

entity FSM is
    Port (
        I_FSM_CLK   : in    STD_LOGIC;
        I_FSM_EN    : in    STD_LOGIC;
        I_FSM_INST  : in    STD_LOGIC_VECTOR( 31 downto 0 );
        O_FSM_IF    : out   STD_LOGIC;
        O_FSM_ID    : out   STD_LOGIC;
        O_FSM_EX    : out   STD_LOGIC;
        O_FSM_ME    : out   STD_LOGIC;
        O_FSM_WB    : out   STD_LOGIC
        );
end FSM;

architecture Behavioral of FSM is
    signal state : FSM_Control_State := en;
begin
    process ( I_FSM_CLK )
    begin
        if rising_edge ( I_FSM_CLK ) then
            if ( I_FSM_EN = '1' ) then
                if ( state = en ) then state <= FCH;
                elsif ( state = FCH) then state <= ID;
                elsif ( state = ID ) then
                    if ( I_FSM_INST = x"0000000c" ) then
                        --  SYSCALL EXIT
                        state <= TERM;
                    else
                        state <= EX;        
                    end if;
                elsif ( state = EX ) then state <= ME;
                elsif ( state = ME ) then state <= WB;
                elsif ( state = WB ) then state <= FCH;
                end if;
            else
                if ( state = en ) then state <= en;
                else
                    state <= term;
                end if;
            end if;
        end if;
    end process;

    process ( state )
    begin
        if ( state = EN ) or ( state = term ) then
            O_FSM_IF <= '0';
            O_FSM_ID <= '0';
            O_FSM_EX <= '0';
            O_FSM_ME <= '0';
            O_FSM_WB <= '0';
        elsif ( state = FCH ) then
            O_FSM_IF <= '1';
            O_FSM_ID <= '0';
            O_FSM_EX <= '0';
            O_FSM_ME <= '0';
            O_FSM_WB <= '0';
        elsif ( state = ID ) then
            O_FSM_IF <= '0';
            O_FSM_ID <= '1';
            O_FSM_EX <= '0';
            O_FSM_ME <= '0';
            O_FSM_WB <= '0';
        elsif ( state = EX ) then
            O_FSM_IF <= '0';
            O_FSM_ID <= '0';
            O_FSM_EX <= '1';
            O_FSM_ME <= '0';
            O_FSM_WB <= '0';
        elsif ( state = ME ) then
            O_FSM_IF <= '0';
            O_FSM_ID <= '0';
            O_FSM_EX <= '0';
            O_FSM_ME <= '1';
            O_FSM_WB <= '0';
        elsif ( state = WB ) then
            O_FSM_IF <= '0';
            O_FSM_ID <= '0';
            O_FSM_EX <= '0';
            O_FSM_ME <= '0';
            O_FSM_WB <= '1';
        end if;
    end process;

end Behavioral;

