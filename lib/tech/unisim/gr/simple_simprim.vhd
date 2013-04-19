
library ieee;
use ieee.std_logic_1164.all;

package simple_simprim is

  component ramb4_generic
  generic ( abits : integer := 10; dbits : integer := 8 );
  port (DI     : in std_logic_vector (dbits-1 downto 0);
        EN     : in std_ulogic;
        WE     : in std_ulogic;
        RST    : in std_ulogic;
        CLK    : in std_ulogic;
        ADDR   : in std_logic_vector (abits-1 downto 0);
        DO     : out std_logic_vector (dbits-1 downto 0)
       );
  end component;

  component ramb4_sx_sx
  generic (abits : integer := 10; dbits : integer := 8 );
  port (DIA    : in std_logic_vector (dbits-1 downto 0);
        DIB    : in std_logic_vector (dbits-1 downto 0);
        ENA    : in std_ulogic;
        ENB    : in std_ulogic;
        WEA    : in std_ulogic;
        WEB    : in std_ulogic;
        RSTA   : in std_ulogic;
        RSTB   : in std_ulogic;
        CLKA   : in std_ulogic;
        CLKB   : in std_ulogic;
        ADDRA  : in std_logic_vector (abits-1 downto 0);
        ADDRB  : in std_logic_vector (abits-1 downto 0);
        DOA    : out std_logic_vector (dbits-1 downto 0);
        DOB    : out std_logic_vector (dbits-1 downto 0)
       );
  end component;

  component ramb16_sx
  generic (abits : integer := 10; dbits : integer := 8 );
  port (
    DO : out std_logic_vector (dbits-1 downto 0);
    ADDR : in std_logic_vector (abits-1 downto 0);
    DI : in std_logic_vector (dbits-1 downto 0);
    EN : in std_ulogic;
    CLK : in std_ulogic;
    WE : in std_ulogic;
    SSR : in std_ulogic);
  end component;


  component ram16_sx_sx
  generic (abits : integer := 10; dbits : integer := 8 );
  port (
   DOA : out std_logic_vector (dbits-1 downto 0);
   DOB : out std_logic_vector (dbits-1 downto 0);
   ADDRA : in std_logic_vector (abits-1 downto 0);
   CLKA : in std_ulogic;
   DIA : in std_logic_vector (dbits-1 downto 0);
   ENA : in std_ulogic;
   WEA : in std_ulogic;
   ADDRB : in std_logic_vector (abits-1 downto 0);
   CLKB : in std_ulogic;
   DIB : in std_logic_vector (dbits-1 downto 0);
   ENB : in std_ulogic;
   WEB : in std_ulogic);
  end component;

end;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ramb4_generic is
  generic ( abits : integer := 10; dbits : integer := 8 );
  port (DI     : in std_logic_vector (dbits-1 downto 0);
        EN     : in std_ulogic;
        WE     : in std_ulogic;
        RST    : in std_ulogic;
        CLK    : in std_ulogic;
        ADDR   : in std_logic_vector (abits-1 downto 0);
        DO     : out std_logic_vector (dbits-1 downto 0)
       );
end;

architecture behavioral of ramb4_generic is
  type mem is array(0 to (2**abits -1))
	of std_logic_vector((dbits -1) downto 0);
begin
  main : process(clk)
  variable memarr : mem;
  begin
    if rising_edge(clk)then
      if (en = '1') and not (is_x(addr)) then
        do <= memarr(to_integer(unsigned(addr)));
      end if;
      if (we and en) = '1' then
        if not is_x(addr) then
   	  memarr(to_integer(unsigned(addr))) := di;
        end if;
      end if;
    end if;
  end process;

end;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ramb16_sx is
  generic ( abits : integer := 10; dbits : integer := 8 );
  port (
    DO : out std_logic_vector (dbits-1 downto 0);
    ADDR : in std_logic_vector (abits-1 downto 0);
    DI : in std_logic_vector (dbits-1 downto 0);
    EN : in std_ulogic;
    CLK : in std_ulogic;
    WE : in std_ulogic;
    SSR : in std_ulogic
  );
end;
architecture behav of ramb16_sx is
begin
  rp : process(clk)
  subtype dword is std_logic_vector(dbits-1 downto 0);
  type dregtype is array (0 to 2**abits -1) of DWord;
  variable rfd : dregtype := (others => (others => '0'));
  begin
    if rising_edge(clk) and not is_x (addr) then
      if en = '1' then
        do <= rfd(to_integer(unsigned(addr)));
        if we = '1' then rfd(to_integer(unsigned(addr))) := di; end if;
      end if;
    end if;
  end process;
end;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram16_sx_sx is
  generic ( abits : integer := 10; dbits : integer := 8 );
  port (
   DOA : out std_logic_vector (dbits-1 downto 0);
   DOB : out std_logic_vector (dbits-1 downto 0);
   ADDRA : in std_logic_vector (abits-1 downto 0);
   CLKA : in std_ulogic;
   DIA : in std_logic_vector (dbits-1 downto 0);
   ENA : in std_ulogic;
   WEA : in std_ulogic;
   ADDRB : in std_logic_vector (abits-1 downto 0);
   CLKB : in std_ulogic;
   DIB : in std_logic_vector (dbits-1 downto 0);
   ENB : in std_ulogic;
   WEB : in std_ulogic
  );
end;

architecture behav of ram16_sx_sx is
    signal async : std_ulogic := '0';
begin

  ramproc : process(clka, clkb)
    subtype dword is std_logic_vector(dbits-1 downto 0);
    type dregtype is array (0 to 2**abits -1) of DWord;
    variable rfd : dregtype := (others => (others => '0'));
  begin

    if rising_edge(clka) and not is_x (addra) then
      if ena = '1' then
        if wea = '1' then
          rfd(to_integer(unsigned(addra))) := dia;
        end if;
        doa <= rfd(to_integer(unsigned(addra)));
      else
        doa <= (others => '1');
      end if;
    end if;

    if rising_edge(clkb) and not is_x (addrb) then
      if enb = '1' then
        if web = '1' then
          rfd(to_integer(unsigned(addrb))) := dib;
        end if;
        dob <= rfd(to_integer(unsigned(addrb)));
      else
        dob <= (others => '1');
      end if;
    end if;

  end process;

end;
