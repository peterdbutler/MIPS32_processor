library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textio.all; 
use ieee.numeric_std.all;
 
entity ROM is
Port (
		I_ROM_EN    : in  STD_LOGIC;
		I_ROM_ADDR  : in  STD_LOGIC_VECTOR (31 downto 0);
		O_ROM_DATA  : out STD_LOGIC_VECTOR (31 downto 0)
		);
end ROM;

architecture Behavioral of ROM is

    type mem_array is array (0 to 255) of STD_LOGIC_VECTOR(7 downto 0);
    constant LINE_NUM : integer := 64;

    ------- INITIALIZE MEM Function ------
    impure function init_mem(FILE_NAME : in string) return mem_array is 
        file     fp         : text;  
        variable temp_mem   : mem_array := (others => x"00");
        variable line_cache : line;
        variable byte_cache : bit_vector (31 downto 0) := x"00000000";
    begin
        file_open(fp, FILE_NAME, read_mode);
        for i in 0 to LINE_NUM loop
            if endfile(fp) then
                exit;
            else
                readline(fp, line_cache);
                read(line_cache, byte_cache);
                for j in 0 to 3 loop
                    temp_mem(4*i+j) :=
                            to_stdlogicvector(byte_cache((31-j*8) downto (24-j*8)));
                end loop;
            end if;
        end loop;
        file_close(fp);
        return temp_mem;
    end function;
    ------ END INITIALIZE MEM Function -----

    -- init mem:
    signal mem : mem_array := init_mem("fibonacci.bin");

	begin
		process(I_ROM_EN)
		
		begin
			
			if I_ROM_EN ='1' then
                for i in 0 to 3 loop
                    O_ROM_DATA((31-i*8) downto (24-i*8)) <= mem(to_integer(unsigned(I_ROM_ADDR))+i);
                end loop;                
			end if;
		end process;
end Behavioral;
