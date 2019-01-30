library IEEE;
use IEEE.STD_LOGIC_1164.all;

package DivControl is
	type DIV_CONTROL_STATE is (
		en,		-- turn on control
		init,	-- initialize HI, LO
		shift,	-- shift register values by 1.
		ALU,	-- ALU compares A (HI), B (Divisor)
		update,	-- update HI, LO with new values
		term	-- terminate the division hardware
	);
end DivControl;

package body DivControl is
end DivControl;
