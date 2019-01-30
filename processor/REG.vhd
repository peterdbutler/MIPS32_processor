library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.textio.all;

entity REG is
	Port(
	I_REG_EN				: in STD_LOGIC;
	I_REG_WE				: in STD_LOGIC;
	I_REG_SEL_RS		: in STD_LOGIC_VECTOR (4 downto 0);
	I_REG_SEL_RT		: in STD_LOGIC_VECTOR (4 downto 0);
	I_REG_SEL_RD		: in STD_LOGIC_VECTOR (4 downto 0);
	I_REG_DATA_RD		: in STD_LOGIC_VECTOR (31 downto 0);
	O_REG_DATA_A		: out STD_LOGIC_VECTOR (31 downto 0);
	O_REG_DATA_B		: out STD_LOGIC_VECTOR (31 downto 0)
	);
end REG;

architecture Behavioral of REG is

	type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	
    -- testing;
    --signal reg: reg_array;
    
	    ------- FILE IO Function ------
    impure function init_buf(FILE_NAME : in string) return reg_array is 
        constant LINE_NUM : integer := 31;
        file fp: text;  
        variable temp_reg : reg_array := (others => x"00000000");
        variable line_cache : line;
        variable word_cache : bit_vector (31 downto 0) := x"00000000";
    begin
        file_open(fp, FILE_NAME, read_mode); 
        for i in 0 to LINE_NUM loop
            if endfile(fp) then
                exit;
            else
                readline(fp, line_cache);
                read(line_cache, word_cache);
                temp_reg(i) := to_stdlogicvector(word_cache);
            end if;
        end loop;
        file_close(fp);
        return temp_reg;
    end function;
    ------- END FILE IO Function ------
    
	 signal reg : reg_array := init_buf("reg_init.txt"); 
begin
	process(I_REG_EN)
		variable REG_NUM1 : integer;    -- RD
		variable REG_NUM2 : integer;    -- RS
		variable REG_NUM3 : integer;    -- RT
	begin
        -- testing:
--        if reg(0) = "UUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU" then
--            reg <= init_buf( "reg_inti.txt" );
--        end if;
		if I_REG_EN = '1' then
			if I_REG_WE = '1' then
				REG_NUM1 := to_integer(unsigned(I_REG_SEL_RD));
				reg(REG_NUM1)<= I_REG_DATA_RD;
			end if;
				REG_NUM2 := to_integer(unsigned(I_REG_SEL_RS));
				O_REG_DATA_A <= reg(REG_NUM2);
				REG_NUM3 := to_integer(unsigned(I_REG_SEL_RT));
				O_REG_DATA_B <= reg(REG_NUM3);
		end if;
	end process;

end Behavioral;
