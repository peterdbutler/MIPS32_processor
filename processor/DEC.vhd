library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DEC is
	Port(
		I_DEC_EN	: in STD_LOGIC;
		I_DEC_Opcode	: in STD_LOGIC_VECTOR (5 downto 0);
		O_DEC_RegDst	: out STD_LOGIC;
		O_DEC_Jump		: out STD_LOGIC;
		O_DEC_Beq		: out STD_LOGIC;
		O_DEC_Bne		: out STD_LOGIC;
		O_DEC_MemRead	: out STD_LOGIC;
		O_DEC_MemtoReg	: out STD_LOGIC;
		O_DEC_ALUOp		: out STD_LOGIC_VECTOR (1 downto 0);
		O_DEC_MemWrite	: out STD_LOGIC;
		O_DEC_ALUSrc	: out STD_LOGIC;
		O_DEC_RegWrite	: out STD_LOGIC
		
	);
end DEC;

architecture Behavioral of DEC is

begin
	process(I_DEC_EN)
	begin
	if I_DEC_EN = '1' then
		if I_DEC_Opcode = "000000" then		--addu
			O_DEC_RegDst <= '1';
			O_DEC_Jump <= '0';
			O_DEC_beq <= '0';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '0';
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "10";
			O_DEC_MemWrite <= '0';
			O_DEC_ALUSrc <= '0';
			O_DEC_RegWrite <= '1';
			
		elsif I_DEC_Opcode = "001000" then --addi
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '0';
			O_DEC_beq <= '0';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '0';
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "00";
			O_DEC_MemWrite <= '0';
			O_DEC_ALUSrc <= '1';
			O_DEC_RegWrite <= '1';
				
		elsif I_DEC_Opcode = "001001" then --addiu
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '0';
			O_DEC_beq <= '0';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '0';
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "00";
			O_DEC_MemWrite <= '0';
			O_DEC_ALUSrc <= '1';
			O_DEC_RegWrite <= '1';
			
		elsif I_DEC_Opcode = "000010" then    -- j
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '1';
			O_DEC_beq <= '0';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '0';
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "00";
			O_DEC_MemWrite <= '0';
			O_DEC_ALUSrc <= '0';
			O_DEC_RegWrite <= '0';
			
		elsif I_DEC_Opcode = "000101" then --bne
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '0';
			O_DEC_beq <= '0';
			O_DEC_Bne <= '1';
			O_DEC_MemRead <= '0'; 
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "01";
			O_DEC_MemWrite <= '0'; 
			O_DEC_ALUSrc <= '0';
			O_DEC_RegWrite <= '0';
			
		elsif I_DEC_Opcode <= "000100" then -- beq
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '0';
			O_DEC_beq <= '1';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '0';
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "01";
			O_DEC_MemWrite <= '0';
			O_DEC_ALUSrc <= '0';
			O_DEC_RegWrite <= '0';
		
		elsif I_DEC_Opcode = "101011" then    -- sw
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '0';
			O_DEC_Beq <= '0';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '0';
			O_DEC_MemtoReg <= '0';
			O_DEC_ALUOp <= "00";
			O_DEC_MemWrite <= '1';
			O_DEC_ALUSrc <= '1';
			O_DEC_RegWrite <= '0';

		elsif I_DEC_Opcode = "100011" then     -- lw
			O_DEC_RegDst <= '0';
			O_DEC_Jump <= '0';
			O_DEC_beq <= '0';
			O_DEC_Bne <= '0';
			O_DEC_MemRead <= '1';
			O_DEC_MemtoReg <= '1';
			O_DEC_ALUOp <= "00";
			O_DEC_MemWrite <= '0';
			O_DEC_ALUSrc <= '1';
			O_DEC_RegWrite <= '1';

		end if;
	end if;
	end process;
end Behavioral;


