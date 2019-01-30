library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use STD.textio.all;

entity RAM is
    Port ( I_RAM_EN     : in  STD_LOGIC;
           I_RAM_RE     : in  STD_LOGIC;
           I_RAM_WE     : in  STD_LOGIC;
           I_RAM_ADDR   : in  STD_LOGIC_VECTOR (31 downto 0);
           I_RAM_DATA   : in  STD_LOGIC_VECTOR (31 downto 0);
           O_RAM_DATA   : out STD_LOGIC_VECTOR (31 downto 0));
end RAM;

architecture Behavioral of RAM is

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
    signal mem : mem_array := init_mem("RAM_init.txt");
begin
    --  RAM functionality:
    process(I_RAM_EN)
        variable ADDR_AS_INT : INTEGER;
    begin
        if I_RAM_EN = '1' then

            -- Read enable functionality:
            if  I_RAM_RE = '1' then
                if I_RAM_ADDR(31 downto 8) = x"000020" then
                    ADDR_AS_INT := to_integer( UNSIGNED(I_RAM_ADDR(7 downto 0)) ); 
                    for i in 0 to 3 loop
                        O_RAM_DATA((31-i*8) downto (24-i*8)) <= mem(ADDR_AS_INT+i);
                    end loop;
                end if;
            end if;

            -- Write enable functionality:
            if I_RAM_WE = '1' then
                if I_RAM_ADDR(31 downto 8) = x"000020" then
                    ADDR_AS_INT := to_integer( UNSIGNED(I_RAM_ADDR(7 downto 0)) ); 
                    for i in 0 to 3 loop
                        mem(ADDR_AS_INT+i) <= I_RAM_DATA((31-i*8) downto (24-i*8));
                    end loop;
                end if;
            end if;

        end if;
    end process;
end Behavioral;
