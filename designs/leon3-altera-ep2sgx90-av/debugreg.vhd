-- debugreg.vhd
-- very simple readable and adressable 64 bit (2x 32 bit)
-- purpose: debug output

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
entity debugreg is
  port (
    clk : in std_logic;
    rst_n : in std_logic;
    bus_addr : in std_logic_vector(2 downto 0);
    bus_datai : in std_logic_vector(31 downto 0);
    bus_datao : out std_logic_vector(31 downto 0);
    bus_wen : in std_logic;
    bus_cen : in std_logic;
    iopins : out std_logic_vector(63 downto 0)
  );
end;

architecture rtl of debugreg is
  signal iopins_r : std_logic_vector(63 downto 0);
  
begin
  
  process(clk)
  begin
    if(clk'event and clk='1') then
      if(rst_n = '0') then
        iopins_r <= (others => '0');
      elsif(bus_cen='0' and bus_wen='0') then
        if(bus_addr(2)='0') then
          iopins_r(31 downto 0) <= bus_datai;
        else
          iopins_r(63 downto 32) <= bus_datai;
        end if;
      end if;
      iopins <= iopins_r;
      if(bus_addr(2)='0') then
        bus_datao <= iopins_r(31 downto 0);
      else
        bus_datao <= iopins_r(63 downto 32);
      end if;
    end if;
  end process;
  
end;

  