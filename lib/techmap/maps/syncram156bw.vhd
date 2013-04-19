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
-- File:    syncram128bw.vhd
-- Author:	Nils-Johan Wessman - Aeroflex Gaisler AB
-- Description:	128-bit data + 28-bit edac syncronous 1-port ram with 16-bit write strobes
--		and tech selection
--    
------------------------------------------------------------------------------

library ieee;
library techmap;
use ieee.std_logic_1164.all;
use techmap.gencomp.all;
  
entity syncram156bw is
  generic (tech : integer := 0; abits : integer := 6; testen : integer := 0);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (155 downto 0);
    dataout : out std_logic_vector (155 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000");
end;

architecture rtl of syncram156bw is

constant has_sram156bw : tech_ability_type := (
	virtex2 => 0, virtex4 => 0, virtex5 => 0, spartan3 => 0,
	spartan3e => 0, spartan6 => 0, virtex6 => 0, 
	altera => 0, cyclone3 => 0, stratix2 => 0, stratix3 => 0,
	tm65gpl => 0, custom1 => 1, ut90 => 1, others => 0);

--  component unisim_syncram128bw
--  generic ( abits : integer := 9);
--  port (
--    clk     : in  std_ulogic;
--    address : in  std_logic_vector (abits -1 downto 0);
--    datain  : in  std_logic_vector (127 downto 0);
--    dataout : out std_logic_vector (127 downto 0);
--    enable  : in  std_logic_vector (15 downto 0);
--    write   : in  std_logic_vector (15 downto 0)
--  );
--  end component;
--
--  component altera_syncram128bw
--  generic ( abits : integer := 9);
--  port (
--    clk     : in std_ulogic;
--    address : in std_logic_vector (abits -1 downto 0);
--    datain  : in std_logic_vector (127 downto 0);
--    dataout : out std_logic_vector (127 downto 0);
--    enable  : in  std_logic_vector (15 downto 0);
--    write   : in  std_logic_vector (15 downto 0)
--  );
--  end component;
--
  component cust1_syncram156bw
  generic ( abits : integer := 14; testen : integer := 0);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (155 downto 0);
    dataout : out std_logic_vector (155 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000"
  );
  end component;

  component ut90nhbd_syncram156bw
  generic (abits : integer := 14; testen : integer := 0);
  port (
    clk     : in  std_ulogic;
    address : in  std_logic_vector (abits -1 downto 0);
    datain  : in  std_logic_vector (155 downto 0);
    dataout : out std_logic_vector (155 downto 0);
    enable  : in  std_logic_vector (15 downto 0);
    write   : in  std_logic_vector (15 downto 0);
    testin  : in  std_logic_vector (3 downto 0) := "0000");
  end component;

begin

  s156 : if has_sram156bw(tech) = 1 generate
--    xc2v : if (is_unisim(tech) = 1) generate 
--      x0 : unisim_syncram128bw generic map (abits)
--         port map (clk, address, datain, dataout, enable, write);
--    end generate;
--    alt : if (tech = stratix2) or (tech = stratix3) or 
--             (tech = cyclone3) or (tech = altera) generate
--      x0 : altera_syncram128bw generic map (abits)
--         port map (clk, address, datain, dataout, enable, write);
--    end generate;
    cust1u : if tech = custom1 generate
      x0 : cust1_syncram156bw generic map (abits, testen)
         port map (clk, address, datain, dataout, enable, write, testin);
    end generate;
    ut90u : if tech = ut90 generate
      x0 : ut90nhbd_syncram156bw generic map (abits, testen)
         port map (clk, address, datain, dataout, enable, write, testin);
    end generate;
  end generate;

  nos156 : if has_sram156bw(tech) = 0 generate
    rx : for i in 0 to 15 generate
      x0 : syncram generic map (tech, abits, 8, testen)
        port map (clk, address, datain(i*8+7 downto i*8), 
          dataout(i*8+7 downto i*8), enable(i), write(i), testin);
      c0 : if i mod 4 = 0 generate 
        x0 : syncram generic map (tech, abits, 7, testen)
          port map (clk, address, datain(i/4*7+128+6 downto i/4*7+128), 
            dataout(i/4*7+128+6 downto i/4*7+128), enable(i), write(i), testin);
        end generate;
    end generate;
  end generate;

end;

