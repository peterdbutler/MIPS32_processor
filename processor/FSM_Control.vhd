library IEEE;
use IEEE.STD_LOGIC_1164.all;

package FSM_Control is
	type FSM_Control_State is (
		EN,     -- Initialize the module		
	    FCH,	-- Instruction Fetch
		ID,     -- Instruction Decode
		EX,     -- Execute ALU Arthmetic
		ME,     -- Memory Read/Write
		WB,     -- Write Back
        TERM    -- terminate the division hardware
	);
end FSM_Control;

package body FSM_Control is
end FSM_Control;
