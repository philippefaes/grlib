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
-- Entity: 	syncram128bw
-- File:	syncram128bw.vhd
-- Author:	Jiri Gaisler - Gaisler Research
-- Description:	128-bit syncronous 1-port ram with 8-bit write strobes
--		and tech selection
------------------------------------------------------------------------------

library ieee;
library techmap;
use ieee.std_logic_1164.all;
use techmap.gencomp.all;
library grlib;
use grlib.config.all;
use grlib.stdlib.all;

entity syncram128bw is
  generic (tech : integer := 0; abits : integer := 6; testen : integer := 0);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000");
end;

architecture rtl of syncram128bw is

constant has_sram128bw : tech_ability_type := (
	virtex2 => 1, virtex4 => 1, virtex5 => 1, spartan3 => 1,
	spartan3e => 1, spartan6 => 1, virtex6 => 1, 
	altera => 1, cyclone3 => 1, stratix2 => 1, stratix3 => 1,
	ut90 => 1, others => 0);

  component unisim_syncram128bw
  generic ( abits : integer := 9);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0)
  );
  end component;

  component altera_syncram128bw
  generic ( abits : integer := 9);
  port (
    clk     : in std_ulogic;
    address : in std_logic_vector (abits -1 downto 0);
    datain  : in std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0)
  );
  end component;

  component tm65gpl_syncram128bw
  generic ( abits : integer := 9);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000"
  );
  end component;

  component ut90nhbd_syncram128bw
  generic ( abits : integer := 9);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (127 downto 0);
    dataout : out std_logic_vector (127 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000"
  );
  end component;

begin

  s64 : if has_sram128bw(tech) = 1 generate
    xc2v : if (is_unisim(tech) = 1) generate 
      x0 : unisim_syncram128bw generic map (abits)
         port map (clk, address, datain, dataout, enable, write);
    end generate;
    alt : if (tech = stratix2) or (tech = stratix3) or 
	(tech = cyclone3) or (tech = altera) generate
      x0 : altera_syncram128bw generic map (abits)
         port map (clk, address, datain, dataout, enable, write);
    end generate;
    tm65: if tech = tm65gpl generate
      x0 : tm65gpl_syncram128bw generic map (abits)
         port map (clk, address, datain, dataout, enable, write, testin);
    end generate;
    ut09: if tech = ut90 generate
      x0 : ut90nhbd_syncram128bw generic map (abits)
         port map (clk, address, datain, dataout, enable, write, testin);
    end generate;
-- pragma translate_off
    dmsg : if grlib_debug_level >= 2 generate
      x : process
      begin
        assert false report "syncram128bw: " & tost(2**abits) & "x128" &
         " (" & tech_table(tech) & ")"
        severity note;
        wait;
      end process;
    end generate;
-- pragma translate_on
  end generate;

  nos64 : if has_sram128bw(tech) = 0 generate
    rx : for i in 0 to 15 generate
      x0 : syncram generic map (tech, abits, 8, testen)
         port map (clk, address, datain(i*8+7 downto i*8), 
	    dataout(i*8+7 downto i*8), enable(i), write(i), testin);
    end generate;
  end generate;

end;

