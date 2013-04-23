------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2013, Aeroflex Gaisler
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
-- Entity: 	slavecheck
-- File:	slavecheck.vhd
-- Author:	Magnus Hjorth - Aeroflex Gaisler
-- Description:	Generic memory slave checker
------------------------------------------------------------------------------

-- pragma translate_off

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
library gaisler;
use gaisler.sim.all;

entity slavecheck is
  generic (
    hindex: integer := 0;
    hbar: integer := 0;
    ahbbits: integer := 32;
    fname: string;
    autoload: integer := 0
    );
  port (
    rst: in std_logic;
    clk: in std_logic;
    ahbsi: in ahb_slv_in_type;
    ahbso: in ahb_slv_out_type
    );
end;

architecture sim of slavecheck is

  constant a0: std_logic_vector(30-log2(ahbbits/32)-1 downto 0) := (others => '0');
  constant w0: std_logic_vector(ahbbits/8-1 downto 0) := (others => '0');
  constant d0: std_logic_vector(ahbbits-1 downto 0) := (others => '0');

  signal rbaddr: std_logic_vector(30-log2(ahbbits/32)-1 downto 0);
  signal rbdout: std_logic_vector(ahbbits-1 downto 0);
  signal rbwr: std_logic_vector(ahbbits/8-1 downto 0) := (others => '0');
  signal rbdin: std_logic_vector(ahbbits-1 downto 0);
  signal tog: std_logic := '0';

  signal bein: ramback_in_array(1 to 1) := (others => ramback_in_none);
  signal beout: ramback_out_array(1 to 1);
  
begin

  rb0: ramback
    generic map (abits => 30-log2(ahbbits/32),
                 dbits => ahbbits,
                 fname => fname, autoload => autoload,
                 nports => 1)
    port map (bein,beout);

  chkp: process
    variable hsel, cur_hsel: std_logic;
    variable htrans, cur_htrans: std_logic_vector(1 downto 0);
    variable haddr, cur_haddr: std_logic_vector(31 downto 0);
    variable hsize, cur_hsize: std_logic_vector(2 downto 0);
    variable hwrite, cur_hwrite: std_logic;
    variable hrdata,hwdata: std_logic_vector(ahbbits-1 downto 0);
    variable hresp: std_logic_vector(1 downto 0);
    variable amask,cmpmask: std_logic_vector(ahbbits/8-1 downto 0);
    variable i,s: integer;
  begin
    wait until clk='1';
    
    -- Sample AMBA signals - this must be done before any
    -- delta delays are added through the ram backend accesses
    hrdata := ahbso.hrdata;
    hwdata := ahbsi.hwdata;
    hresp := ahbso.hresp;
    hsel := ahbsi.hsel(hindex) and ahbsi.hmbsel(hbar);
    htrans := ahbsi.htrans;
    haddr := ahbsi.haddr;
    hsize := ahbsi.hsize;
    hwrite := ahbsi.hwrite;    
    
    if rst='0' then
      hsel := '0';
    elsif ahbsi.hready='1' then
      -- Deal with current tfr
      if cur_hsel='1' and cur_htrans /= "00" then
        bein(1).addr(30-log2(ahbbits/32)-1 downto 0) <= cur_haddr(31 downto log2(ahbbits/8));
        i := to_integer(unsigned(cur_haddr(log2(ahbbits/8)-1 downto 0)));
        s := 2 ** to_integer(unsigned(cur_hsize));
        amask := (others => '0');
        for x in i to i+s-1 loop
          amask(ahbbits/8-1-x):='1';
        end loop;
        if cur_hwrite='1' then
          bein(1).din(ahbbits-1 downto 0) <= hwdata;
          bein(1).wr(ahbbits/8-1 downto 0) <= amask;
          wait until beout(1).cmdack='1';
          bein(1).wr <= (others => '0');
          wait until beout(1).cmdack='0';
          if cur_haddr(31 downto 4)=x"000131a" then
            grlib.testlib.print("write to addr " & tost(cur_haddr) & " hsize " & tost(cur_hsize) & " data " & tost(hwdata));
          end if;
        else
          tog <= not tog;
          wait until tog'event;
          tog <= not tog;
          wait until tog'event;
          cmpmask := (others => '0');
          for q in ahbbits/8-1 downto 0 loop
            if hrdata(8*q+7 downto 8*q) /= beout(1).dout(8*q+7 downto 8*q) and
              beout(1).dout(8*q+7 downto 8*q) /= "UUUUUUUU" then
              cmpmask(q) := '1';
            end if;
          end loop;
          if (cmpmask and amask) /= (amask'range => '0') then
            print("Compare mismatch! amask: " & tost(amask) & " cmpmask: " & tost(cmpmask));
            grlib.testlib.print("read addr " & tost(cur_haddr) & " hsize " & tost(cur_hsize) & " slave " & tost(hrdata) &
                                " mem " & tost(beout(1).dout(ahbbits-1 downto 0)));
          end if;
        end if;
      end if;
      -- Get new tfr
      cur_hsel := hsel;
      cur_htrans := htrans;
      cur_haddr := haddr;
      cur_hsize := hsize;
      cur_hwrite := hwrite;
      -- grlib.testlib.print("New tfr: hsel: " & tost(cur_hsel) & " htrans:" & tost(cur_htrans) & " haddr:" & tost(cur_haddr) & " hsize:" & tost(cur_hsize) & " hwrite:" & tost(cur_hwrite));
    end if;
  end process;
  
end;

-- pragma translate_on
