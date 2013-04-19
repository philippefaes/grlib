------------------------------------------------------
-- Program-Memory
------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all; 
use std.textio.all;

-- Important NOTE:
-- ---------------
--
-- The ROM_BITS generic controls the size of the internal
-- ROM. The ROM is located in upper part of program memory
-- and is initialized by the given (intel-).hex-file.
-- If there's no such file, everything is filled up with
-- 'null'. Everything before the ROM is always nulled.
-- If you don't want a System-ROM, just set ROM_BITS to 0.

entity prgmem is
   generic ( 
      INIT_FILE_NAME : string;                          -- => init file for rom
      PRGM_MEM       : positive  := 12;                 -- => 4k word
      MEM_WIDTH      : positive  := 32
   );
   port (
      -- common signals
      clk               : in std_logic;                 -- normal system clock
      reset             : in std_logic;

      -- access (r)
      addr		: in std_logic_vector(PRGM_MEM-1 downto 0);
      data		: out std_logic_vector(MEM_WIDTH-1 downto 0)
   );
end entity;

architecture Behavioral of prgmem is
   -- some constants
   constant MEM_DEPTH 	: positive := 2**PRGM_MEM;
--   constant MEM_WIDTH	: positive := ; 
--   constant ROM_DEPTH   : positive := 2**ROM_BITS ;
--   constant ROM_POS     : integer  := rom_start(PRGM_MEM, ROM_BITS);
   
   -- declare memory type
   type MEM_TYPE is array(0 to MEM_DEPTH - 1) of std_logic_vector(MEM_WIDTH-1 downto 0);
   
   type BYTE_STRING is array(1 downto 0) of character;
   type WORD_STRING is array(3 downto 0) of character;
   
   function CHAR_TO_INT ( char : in character) return integer is
      variable r : integer := 0;
   begin
      case char is
         when 'A' => r := 10;
         when 'B' => r := 11;
         when 'C' => r := 12;
         when 'D' => r := 13;
         when 'E' => r := 14;
         when 'F' => r := 15;
         when 'a' => r := 10;
         when 'b' => r := 11;
         when 'c' => r := 12;
         when 'd' => r := 13;
         when 'e' => r := 14;
         when 'f' => r := 15;
         when '1' => r := 1;
         when '2' => r := 2;
         when '3' => r := 3;
         when '4' => r := 4;
         when '5' => r := 5;
         when '6' => r := 6;
         when '7' => r := 7;
         when '8' => r := 8;
         when '9' => r := 9;
         when others => null;
      end case;
      return r;
   end function;
   
   function BYTE_TO_INT ( bytechars : in string(1 to 2)) return integer is
   begin
      return CHAR_TO_INT(bytechars(1))*16+CHAR_TO_INT(bytechars(2));
   end function;

   function WORD_TO_INT ( wordchars : in string(1 to 4)) return integer is
   begin
      return BYTE_TO_INT(wordchars(1) & wordchars(2))*256+BYTE_TO_INT(wordchars(3) & wordchars(4));
   end function;
   -- function for loading the init values
   impure function InitRamFromFile (file_name : in string) return MEM_TYPE is
      FILE init_file       : text;-- is in file_name;
      
      variable rline       : line;
      variable memory      : MEM_TYPE;
      
--      variable offs        : integer := 0;
      variable count       : integer;
      variable linemode    : integer;
      variable addr        : integer;
      variable tmp_chr     : character;
      variable tmp_byte    : string(1 to 2);--BYTE_STRING;
      variable tmp_word    : string(1 to 4);--WORD_STRING;
      variable tmp_addr    : integer;
      variable tmp_v       : std_logic_vector(MEM_WIDTH-1 downto 0);
   begin
      -- first just null everything
      for i in 0 to MEM_DEPTH-1 loop
         memory(i) := (others => '0');
      end loop;
      
      file_open(init_file, file_name, READ_MODE);
      -- read rom file
      while (not endfile(init_file))  loop
         readline (init_file, rline);
         exit when endfile (init_file);
         read (rline, tmp_chr);
         if tmp_chr = ':' then --beginning of line is correct
         --how much to read
            read (rline, tmp_byte);
            count := BYTE_TO_INT(tmp_byte);
            --addr
            read (rline, tmp_word);
            addr := WORD_TO_INT(tmp_word);
				--line mode
            read (rline, tmp_byte);
            linemode := BYTE_TO_INT(tmp_byte);
            if linemode = 0 then
               -- loop every PROGRAM-WORD
               for i in 0 to (count/(MEM_WIDTH/8) - 1) loop
                  tmp_v := (others=>'0');
                  -- loop for every BYTE IN PROGRAM-WORD
                  for j in 0 to MEM_WIDTH/8-1 loop
                     read (rline, tmp_byte);
                     tmp_v((j+1)*8-1 downto j*8) := std_logic_vector(to_unsigned(BYTE_TO_INT(tmp_byte),8));
                  end loop;
                  -- store in memory
                  memory(addr/(MEM_WIDTH/8) + i) := tmp_v;
               end loop; 
            end if;
			end if;
      end loop;
      file_close(init_file);
      return memory;
   end function;
   
   -- define memory and initialize it
   signal memory        : MEM_TYPE := InitRamFromFile(INIT_FILE_NAME);
   signal mem_addr      : std_logic_vector(PRGM_MEM-1 downto 0);
   signal mem_doa       : std_logic_vector(15 downto 0);
   signal mem_we        : std_logic;
   
   -- output register
   signal reg_cmd_out	: std_logic_vector(MEM_WIDTH-1 downto 0);
   signal reg_const_out : std_logic_vector(MEM_WIDTH-1 downto 0);
   signal reg_lpmspm    : std_logic_vector(MEM_WIDTH-1 downto 0);
begin

   mem_addr <= addr;

   ---------------------------------------------------
   -- infering the block ram
   process(clk)
   begin
      if clk'event and clk = '1' then
	data <= memory(to_integer(unsigned(addr)));
      end if;
   end process;
end architecture;
