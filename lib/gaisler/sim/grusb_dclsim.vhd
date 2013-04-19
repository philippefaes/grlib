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
-- Entity:      grusb_dclsim
-- File:        grusb_dclsim.vhd
-- Author:      Jonas Ekergarn - Aeroflex Gaisler
-- Description: Simulation module to use with GRUSB_DCL when running GRLIB
-- system test. This is _not_ a general simulation model of a USB host. Only
-- works with ULPI interface as well.
-------------------------------------------------------------------------------

-- pragma translate_off

library ieee, grlib, gaisler;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use grlib.stdlib.all;
use gaisler.sim.all;
use gaisler.usbsim.all;

-------------------------------------------------------------------------------
-- NOTES:
-- * functm generic: Should be set to one if tests are to be run in
-- functional test mode. In functional test mode the device doesn't
-- need to receive a USB reset before sending data and also real USB timing
-- isn't used. The point of this is to speed up simulation, which might be
-- necessary if running ASIC tests. Note that the generic should only be set if
-- the functesten generic as well as the functesten input signal for GRUSB_DCL
-- are set.
-- * keepclk generic need to be the same as for the GRUSB_DCL core.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Example of how to use the core:
-------------------------------------------------------------------------------

-- Libraries needed
-------------------
-- library ieee, grlib, gaisler;
-- use ieee.std_logic_1164.all;
-- use grlib.stdlib.all;
-- use gaisler.sim.all;

-- Test signals needed
----------------------
-- signal ddelay : std_ulogic := '0';
-- signal dstart : std_ulogic := '0';
-- signal drw    : std_ulogic;
-- signal daddr  : std_logic_vector(31 downto 0);
-- signal dlen   : std_logic_vector(14 downto 0);
-- signal ddi    : grusb_dcl_debug_data;
-- signal ddone  : std_ulogic;
-- signal ddo    : grusb_dcl_debug_data;

-- Instantiation
----------------
-- u0: grusb_dclsim
--   port map (usb_rst, usb_clk, usb_data, usb_nxt, usb_stp, usb_dir,
--             ddelay, dstart, drw, daddr, dlen, ddi, ddone, ddo);

-- Example of test process
--------------------------
-- usb_dcl_proc : process
-- begin

-- Wait until initialisation of GRUSB_DCL is done
--   wait until rising_edge(ddone);
  
-- Write 128 bytes to memory (dlen input sets number of words)
--   daddr <= X"40000000";
--   dlen  <= conv_std_logic_vector(32,15);
--   for i in 0 to 127 loop
--     ddi(i) <= conv_std_logic_vector(i,8);
--   end loop;
--   grusb_dcl_write(usb_clkout, drw, dstart, ddone);
  
-- Read back written data (address and length not changed)
--   grusb_dcl_read(usb_clkout, drw, dstart, ddone);

--   wait;
-- end process;

-------------------------------------------------------------------------------
    
entity grusb_dclsim is
  generic (
    functm  : integer range 0 to 1 := 0;
    keepclk : integer range 0 to 1 := 0);
  port (
    rst    : in    std_ulogic;
    clk    : out   std_ulogic;
    d      : inout std_logic_vector(7 downto 0);
    nxt    : out   std_ulogic;
    stp    : in    std_ulogic;
    dir    : out   std_ulogic;
    delay  : in    std_ulogic := '0';
    dstart : in    std_ulogic;
    drw    : in    std_ulogic;
    daddr  : in    std_logic_vector(31 downto 0);
    dlen   : in    std_logic_vector(14 downto 0);
    ddi    : in    grusb_dcl_debug_data;
    ddone  : out   std_ulogic;
    ddo    : out   grusb_dcl_debug_data;
    start  : in    std_ulogic := '1');
end grusb_dclsim;

architecture behav of grusb_dclsim is
  
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

  usbdcl_test : process
    variable data    : octet_vector(0 to 3072);
    variable data2   : octet_vector(0 to 3072);
    variable TP      : boolean := true;
    variable gotnak  : boolean;
    variable gotnyet : boolean;
    variable timeout : boolean := true;
    variable fn      : std_logic_vector(10 downto 0) := (others=>'0');
    variable time1   : time;
    variable time2   : time;
    variable timesup : boolean;
    variable dlenv   : integer;
    variable togglei : std_ulogic;
    variable toggleo : std_ulogic;
  begin
        
    -- Start up ---------------------------------------------------------------
    ddone <= '0';
    uctrl <= ('1',"01","00",'1');
    usbi.dir <= '1';
    usbi.nxt <= '0';
    if start /= '1' then
      wait until start = '1';
    end if;
    while rst = '0' loop
      wait until rst = '1';
    end loop;
    ulpi_reset(clko_int, usbi, usbo, uctrl, false, keepclk = 1);
    
    if keepclk = 0 and (usbo.xcvrselect /= "00" or
                        usbo.termselect /= '0' or
                        usbo.opmode /= "00") then
      wait for 10 us;
      -- assert vbus so that device can wake up from suspend
      usbi.datain(1 downto 0) <= J_STATE;
      usbi.datain(3) <= '1';
      if usbo.stp /= '1' then
        wait until rising_edge(usbo.stp);
      end if;
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

    if keepclk = 1 or usbo.xcvrselect /= "00" or usbo.termselect /= '0' or
      usbo.opmode /= "00" then
      accept_regwrite(clko_int,usbi,usbo,uctrl);
    end if;
    if functm = 0 then
      hs_handshake(clko_int,usbi,usbo,uctrl,usb_hs,1);
      wait for 5 us;
    elsif keepclk = 1 then
      if usbo.xcvrselect /= "00" or usbo.termselect /= '0' or
        usbo.opmode /= "00" then
        accept_regwrite(clko_int,usbi,usbo,uctrl);
      end if;
    end if;
        
    ---------------------------------------------------------------------------
    -- Configure GRUSB_DCL
    ---------------------------------------------------------------------------
    -- SET_ADDRESS ------------------------------------------------------------
    -- send setup and data
    if functm = 0 then
      tsof(clko_int, 3, fn, false, false, usb_rand, 1, 8, usbi, usb_hs);
      fn := fn+1;
      time1 := now;
    end if;
    while timeout loop
      ttoken(clko_int, 3, SETUP, false, false, "0000000", EP0, 1, 8,
             usb_rand, usbi, usb_hs);
      data(0 to 7) := (X"00", X"05", X"01", X"00", X"00", X"00", X"00", X"00");
      tdata(clko_int, DATA0, false, false, data(0 to 7), 8, usb_rand, 1, 8,
            usbi, usb_hs);
      rhandshake(clko_int, TACK, false, false, usb_rand, 1, 8, usbi,
                 usbo, TP, gotnak, usb_hs, timeout);
      
    end loop;
    --zero length packet for status stage
    getstatus(TIN, false, true, clko_int, usbo, usbi, 0, usb_rand,
              1, 8, "0000000", TP, usb_hs, timeout);

    -- GET_DESCRIPTOR (device) ------------------------------------------------
    -- perform setup transaction
    ttoken(clko_int, 3, SETUP, false, false, "0000001", EP0, 1, 8,
           usb_rand, usbi, usb_hs);
    data(0 to 7) := (X"80", X"06", X"00", X"01", X"00", X"00", X"12", X"00");
    tdata(clko_int, DATA0, false, false, data(0 to 7), 8, usb_rand, 1, 8,
          usbi, usb_hs);
    rhandshake(clko_int, TACK, false, false, usb_rand, 1, 8, usbi,
               usbo, TP, gotnak, usb_hs, timeout);
    -- expected descriptor
    data(0 to 17) := (X"12", X"01", X"10", X"02", X"FF", X"00", X"FF", X"40",
                      X"81", X"17", X"A0", X"0A", X"00", X"00", X"00", X"00",
                      X"00", X"01"); 
    -- perform in transaction
    rdata(clko_int, DATA1, true, 18, data, 0, "0000001", usb_rand, 1, 8,
          usbi, usbo, TP, false, usb_hs, false, timeout);
    shandshake(clko_int, TACK, 1, 8, usb_rand, usbi, usb_hs);
    -- perform out transaction of status stage
    getstatus(TOUT, false, true, clko_int, usbo, usbi, 0, usb_rand,
              1, 8, "0000001", TP, usb_hs, timeout);

    -- SET_CONFIGURATION ------------------------------------------------------
    -- perform setup transaction
    ttoken(clko_int, 3, SETUP, false, false, "0000001", EP0, 1, 8,
           usb_rand, usbi, usb_hs);
    data(0 to 7) := (X"00", X"09", X"01", X"00", X"00", X"00", X"00", X"00");
    tdata(clko_int, DATA0, false, false, data(0 to 7), 8, usb_rand, 1, 8,
          usbi, usb_hs);
    rhandshake(clko_int, TACK, false, false, usb_rand, 1, 8, usbi,
               usbo, TP, gotnak, usb_hs, timeout);
    --zero length packet for status stage
    getstatus(TIN, false, true, clko_int, usbo, usbi, 0, usb_rand,
              1, 8, "0000001", TP, usb_hs, timeout);


    while delay /= '0' loop
      if functm = 0 then
        time2 := now;
        wait until delay = '0' for (125 us - (time2 - time1));
        if delay = '1' then
          tsof(clko_int, 3, fn, false, false, usb_rand, 1, 8, usbi, usb_hs);
          fn := fn+1;
          time1 := now;
        end if;
      else
        wait until delay = '0';
      end if;      
    end loop;
    
    wait until rising_edge(clko_int);
    ddone <= '1';
    wait until rising_edge(clko_int);
    ddone <= '0';

    ---------------------------------------------------------------------------
    -- Debug protocol transfers
    ---------------------------------------------------------------------------
    toggleo := '0';
    togglei := '0';
    if functm = 0 then
      time2 := now;
      wait for (125 us - (time2 - time1));
      while true loop
        tsof(clko_int, 3, fn, false, false, usb_rand, 1, 8, usbi, usb_hs);
        fn := fn+1;
        time1 := now;
        timesup := false;
        while (not timesup) loop
          time2 := now;
          if dstart = '0' then
            wait until rising_edge(dstart) for (120 us - (time2 - time1));
          end if;
          -- check that enough time is left in frame
          time2 := now;
          if dstart = '1' then
            dlenv := conv_integer(dlen)*4;
            -- address word
            data(3) := daddr(7 downto 0);
            data(2) := daddr(15 downto 8);
            data(1) := daddr(23 downto 16);
            data(0) := daddr(31 downto 24);
            -- control word
            data(7) := dlen(5 downto 0) & "00";
            data(6) := dlen(13 downto 6);
            data(5) := "0000000" & dlen(14);
            if drw = '0' then
              data(4) := X"00";
            else
              data(4) := X"80";
            end if;
            if gotnyet then
              gotnak := true; time2 := now;
              while (gotnak and (125 us - (time2 - time1)) > 5 us) loop
                ttoken(clko_int, 3, PING, false, false, "0000001", EP1, 1, 8,
                       usb_rand, usbi, usb_hs);
                rhandshake(clko_int, TACK, false, true, usb_rand, 1, 8, usbi,
                           usbo, TP, gotnak, gotnyet, usb_hs, timeout);
                time2 := now;
              end loop;
            end if;
            if not gotnak then
              if drw = '0' then
                -- debug read (OUT + IN transactions)
                ttoken(clko_int, 3, TOUT, false, false, "0000001", EP1, 1, 8,
                       usb_rand, usbi, usb_hs);
                if toggleo = '0' then
                  tdata(clko_int, DATA0, false, false, data(0 to 7), 8, usb_rand, 1, 8,
                        usbi, usb_hs);
                else
                  tdata(clko_int, DATA1, false, false, data(0 to 7), 8, usb_rand, 1, 8,
                        usbi, usb_hs);
                end if;
                rhandshake(clko_int, TACK, true, false, usb_rand, 1, 8, usbi,
                           usbo, TP, gotnak, gotnyet, usb_hs, timeout);
                toggleo := not toggleo;
                
                if togglei = '0' then
                  rdata(clko_int, DATA0, true, dlenv, data2, 1, "0000001", usb_rand, 1, 8,
                        usbi, usbo, TP, false, usb_hs, false, timeout, data, false);
                else
                  rdata(clko_int, DATA1, true, dlenv, data2, 1, "0000001", usb_rand, 1, 8,
                        usbi, usbo, TP, false, usb_hs, false, timeout, data, false);
                end if;
                shandshake(clko_int, TACK, 1, 8, usb_rand, usbi, usb_hs);
                togglei := not togglei;
                for i in 0 to dlenv-1 loop
                  ddo(i) <= data(i);
                end loop;  -- i
              else
                -- debug write (OUT transaction)
                for i in 0 to dlenv-1 loop
                  data(i+8) := ddi(i);
                end loop;  -- i
                ttoken(clko_int, 3, TOUT, false, false, "0000001", EP1, 1, 8,
                       usb_rand, usbi, usb_hs);
                if toggleo = '0' then
                  tdata(clko_int, DATA0, false, false, data(0 to dlenv+7), dlenv+8, usb_rand, 1, 8,
                        usbi, usb_hs);
                else
                  tdata(clko_int, DATA1, false, false, data(0 to dlenv+7), dlenv+8, usb_rand, 1, 8,
                        usbi, usb_hs);
                end if;
                rhandshake(clko_int, TACK, true, false, usb_rand, 1, 8, usbi,
                           usbo, TP, gotnak, gotnyet, usb_hs, timeout);
                toggleo := not toggleo;
              end if;            
              wait until rising_edge(clk_int);
              ddone <= '1';
              wait until rising_edge(clk_int);
              ddone <= '0';
            else
              timesup := true;
            end if;
          else
            timesup := true;
          end if;
        end loop;
        time2 := now;
        wait for (125 us - (time2 - time1));
      end loop;
    else
      while true loop
        if dstart = '0' then
          wait until rising_edge(dstart);
        end if;
        dlenv := conv_integer(dlen)*4;
        -- address word
        data(3) := daddr(7 downto 0);
        data(2) := daddr(15 downto 8);
        data(1) := daddr(23 downto 16);
        data(0) := daddr(31 downto 24);
        -- control word
        data(7) := dlen(5 downto 0) & "00";
        data(6) := dlen(13 downto 6);
        data(5) := "0000000" & dlen(14);
        if drw = '0' then
          data(4) := X"00";
        else
          data(4) := X"80";
        end if;
        if gotnyet then
          gotnak := true;
          while gotnak loop
            ttoken(clko_int, 3, PING, false, false, "0000001", EP1, 1, 8,
                   usb_rand, usbi, usb_hs);
            rhandshake(clko_int, TACK, false, true, usb_rand, 1, 8, usbi,
                       usbo, TP, gotnak, gotnyet, usb_hs, timeout);
          end loop;
        end if;
        if drw = '0' then
          -- debug read (OUT + IN transactions)
          ttoken(clko_int, 3, TOUT, false, false, "0000001", EP1, 1, 8,
                 usb_rand, usbi, usb_hs);
          if toggleo = '0' then
            tdata(clko_int, DATA0, false, false, data(0 to 7), 8, usb_rand, 1, 8,
                  usbi, usb_hs);
          else
            tdata(clko_int, DATA1, false, false, data(0 to 7), 8, usb_rand, 1, 8,
                  usbi, usb_hs);
          end if;
          rhandshake(clko_int, TACK, true, false, usb_rand, 1, 8, usbi,
                     usbo, TP, gotnak, gotnyet, usb_hs, timeout);
          toggleo := not toggleo;

          if togglei = '0' then
            rdata(clko_int, DATA0, true, dlenv, data2, 1, "0000001", usb_rand, 1, 8,
                  usbi, usbo, TP, false, usb_hs, false, timeout, data, false);
          else
            rdata(clko_int, DATA1, true, dlenv, data2, 1, "0000001", usb_rand, 1, 8,
                  usbi, usbo, TP, false, usb_hs, false, timeout, data, false);
          end if;
          shandshake(clko_int, TACK, 1, 8, usb_rand, usbi, usb_hs);
          togglei := not togglei;
          for i in 0 to dlenv-1 loop
            ddo(i) <= data(i);
          end loop;  -- i
        else
          -- debug write (OUT transaction)
          for i in 0 to dlenv-1 loop
            data(i+8) := ddi(i);
          end loop;  -- i
          ttoken(clko_int, 3, TOUT, false, false, "0000001", EP1, 1, 8,
                 usb_rand, usbi, usb_hs);
          if toggleo = '0' then
            tdata(clko_int, DATA0, false, false, data(0 to dlenv+7), dlenv+8, usb_rand, 1, 8,
                  usbi, usb_hs);
          else
            tdata(clko_int, DATA1, false, false, data(0 to dlenv+7), dlenv+8, usb_rand, 1, 8,
                  usbi, usb_hs);
          end if;
          rhandshake(clko_int, TACK, true, false, usb_rand, 1, 8, usbi,
                     usbo, TP, gotnak, gotnyet, usb_hs, timeout);
          toggleo := not toggleo;
        end if;
        wait until rising_edge(clk_int);
        ddone <= '1';
        wait until rising_edge(clk_int);
        ddone <= '0';
      end loop;
    end if;
  end process;
  
end behav;

-- pragma translate_on
