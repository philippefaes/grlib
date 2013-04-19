------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2012, Aeroflex Gaisler
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
-----------------------------------------------------------------------------
-- Entity: 	syncram128
-- File:	syncram128.vhd
-- Author:	Jiri Gaisler - Gaisler Research
-- Description:	128-bit syncronous 1-port ram with 32-bit write strobes
--		and tech selection
------------------------------------------------------------------------------

library ieee;
library techmap;
use ieee.std_logic_1164.all;
use techmap.gencomp.all;
use techmap.allmem.all;
library grlib;
use grlib.config.all;
use grlib.stdlib.all;

entity syncram128 is
  generic (tech : integer := 0; abits : integer := 6; testen : integer := 0);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (3 downto 0);
    write   : in  std_logic_vector (3 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000");
end;

architecture rtl of syncram128 is
  component unisim_syncram128
  generic ( abits : integer := 9);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (3 downto 0);
    write   : in  std_logic_vector (3 downto 0)
  );
  end component;

constant has_sram128 : tech_ability_type := (
	virtex2 => 1, virtex4 => 1, virtex5 => 1, spartan3 => 1,
	spartan3e => 1, spartan6 => 1, virtex6 => 1, 
	tm65gpl => 0, easic45 => 1, others => 0);
begin

  s128 : if has_sram128(tech) = 1 generate
    uni : if (is_unisim(tech) = 1) generate 
      x0 : unisim_syncram128 generic map (abits)
         port map (clk, address, datain, dataout, enable, write);
    end generate;
    n2x : if (tech = easic45) generate
      x0 : n2x_syncram_we generic map (abits => abits, dbits => 128)
        port map(clk, address, datain, dataout, enable, write);
    end generate;
-- pragma translate_off
    dmsg : if grlib_debug_level >= 2 generate
      x : process
      begin
        assert false report "syncram128: " & tost(2**abits) & "x128" &
         " (" & tech_table(tech) & ")"
        severity note;
        wait;
      end process;
    end generate;
-- pragma translate_on
  end generate;

  nos128 : if has_sram128(tech) = 0 generate
    x0 : syncram64 generic map (tech, abits, testen)
         port map (clk, address, datain(127 downto 64), dataout(127 downto 64), 
	           enable(3 downto 2), write(3 downto 2), testin);
    x1 : syncram64 generic map (tech, abits, testen)
         port map (clk, address, datain(63 downto 0), dataout(63 downto 0), 
	           enable(1 downto 0), write(1 downto 0), testin);
  end generate;

end;

