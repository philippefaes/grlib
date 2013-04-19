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
-------------------------------------------------------------------------------
-- Entity:      grusbdcsim
-- File:        grusbdcsim.vhd
-- Author:      Jonas Ekergarn - Aeroflex Gaisler
-- Description: Simulation module to use with GRUSBDC when running GRLIB
-- system test. This is _not_ a general simulation model of a USB host! It can
-- only be used when running GRLIB system test(grlib/software/leon3/grusbdc.c).
-- Also, it only works when GRUSBDC uses an ULPI interface.
-------------------------------------------------------------------------------

-- pragma translate_off

library ieee, grlib, gaisler;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use grlib.stdlib.all;
use gaisler.usbsim.all;

-------------------------------------------------------------------------------
-- NOTES:
-- * functm generic: Should be set to one if tests are to be run in
-- functional test mode. In functional test mode the device doesn't
-- need to receive a USB reset before sending data and also real USB timing
-- isn't used. The point of this is to speed up simulation, which might be
-- necessary if running ASIC tests.
-------------------------------------------------------------------------------

entity grusbdcsim is
  generic (
    functm  : integer range 0 to 1 := 0;
    keepclk : integer range 0 to 1 := 0);
  port (
    rst : in    std_ulogic;
    clk : out   std_ulogic;
    d   : inout std_logic_vector(7 downto 0);
    nxt : out   std_ulogic;
    stp : in    std_ulogic;
    dir : out   std_ulogic);
end grusbdcsim;

architecture behav of grusbdcsim is
  
  signal usbi : grusb_in_type;
  signal usbo : grusb_out_type;
  signal uctrl : uctrl_type;
  signal clk_int, clko_int : std_ulogic := '0';
  signal usb_rand : std_logic_vector(7 downto 0) := (others=>'0');
  signal usb_hs : std_ulogic := '1';
  
begin
    
  nxt <= usbi.nxt;
  dir <= usbi.dir;
  d   <= usbi.datain(7 downto 0) when usbi.dir = '1' else
         (others => 'Z');
  
  usbo.stp                 <= stp;
  usbo.dataout(7 downto 0) <= to_x01(d);
  usbo.termselect          <= uctrl.termselect;
  usbo.xcvrselect          <= uctrl.xcvrselect;
  usbo.opmode              <= uctrl.opmode;
  usbo.suspendm            <= uctrl.suspendm;

  clk_int  <= not clk_int after 8.333 ns;
  clk      <= clk_int and usbo.suspendm;
  clko_int <= clk_int and usbo.suspendm;  

  usbdc_test : process
    variable data    : octet_vector(0 to 3072);
    variable TP      : boolean := true;
    variable gotnak  : boolean;
    variable timeout : boolean := true;
    variable fn      : std_logic_vector(10 downto 0) := (others=>'0');
  begin
    -- Start up ---------------------------------------------------------------
    uctrl <= ('1',"01","00",'1');
    usbi.dir <= '1';
    usbi.nxt <= '0';
    while rst = '0' loop
      wait until rst = '1';
    end loop;
    ulpi_reset(clko_int, usbi, usbo, uctrl, false, keepclk = 1);
    
    if keepclk = 0 then
      wait for 10 us;
      -- assert vbus so that device can wake up from suspend
      usbi.datain(1 downto 0) <= J_STATE;
      usbi.datain(3) <= '1';
      wait until rising_edge(usbo.stp);
      wait until falling_edge(clk_int);
      uctrl.suspendm <= '1';
      for i in 0 to 5 loop
        wait until rising_edge(clko_int);
      end loop;
      usbi.dir <= '0';
      wait until rising_edge(clko_int);
      usbi.datain(7 downto 0) <= (others=>'0');
      accept_regread(clko_int,usbi,usbo,'1');
    end if;
    
    accept_regwrite(clko_int,usbi,usbo,uctrl);
    if functm = 1 then
      accept_regwrite(clko_int,usbi,usbo,uctrl);
    end if;
    if functm = 0 then
      hs_handshake(clko_int,usbi,usbo,uctrl,usb_hs,1);
      wait for 5 us;
    end if;
    ---------------------------------------------------------------------------

    -- Get Device Descriptor --------------------------------------------------
    -- perform setup transaction
    if functm = 0 then
      tsof(clko_int, 3, fn, false, false, usb_rand, 1, 8, usbi, usb_hs);
      fn := fn+1;
    end if;
    while timeout loop      
      ttoken(clko_int, 3, SETUP, false, false, "0000000", EP0, 1, 8,
             usb_rand, usbi, usb_hs);
      data(0 to 7) := (X"80", X"06", X"00", X"01", X"00", X"00", X"20", X"00");
      tdata(clko_int, DATA0, false, false, data(0 to 7), 8, usb_rand, 1, 8,
            usbi, usb_hs);
      rhandshake(clko_int, TACK, false, false, usb_rand, 1, 8, usbi,
                 usbo, TP, gotnak, usb_hs, timeout);
    end loop;
    
    -- expected descriptor
    data(0 to 17) := (X"12", X"01", X"10", X"02", X"FF", X"00", X"FF", X"40",
                      X"81", X"17", X"A0", X"0A", X"00", X"00", X"00", X"00",
                      X"00", X"01"); 

    -- perform in transaction
    rdata(clko_int, DATA1, true, 18, data, 0, "0000000", usb_rand, 1, 8,
          usbi, usbo, TP, false, usb_hs, false, timeout);
    shandshake(clko_int, TACK, 1, 8, usb_rand, usbi, usb_hs);

    -- perform out transaction of status stage
    getstatus(TOUT, false, true, clko_int, usbo, usbi, 0, usb_rand,
              1, 8, "0000000", TP, usb_hs, timeout);
    ---------------------------------------------------------------------------
    if functm = 0 then
      wait for 120 us;
      while true loop
        tsof(clko_int, 3, fn, false, false, usb_rand, 1, 8, usbi, usb_hs);
        fn := fn+1;
        wait for 125 us;
      end loop;
    else
      wait;
    end if;
  end process;
  
end behav;

-- pragma translate_on
