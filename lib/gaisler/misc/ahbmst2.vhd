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
-- Entity:      ahbmst2
-- File:        ahbmst2.vhd
-- Author:      Magnus Hjorth - Aeroflex Gaisler
-- Description: Generic AHB master interface with support for back-to-back
--              bursts, and wrapping bursts with reconstruction in case of
--              split/retry.
------------------------------------------------------------------------------
-- Uses a wide input with both the current and next transfers for
-- back-to-back transfer. The user is responsible for flipping over the
-- next transfer to the current transfer when the current one is done.
--
-- In order to support back-to-back and wrapping bursts, two extra
-- input elements are required, burst_cont (set low for the first
-- transfer in the burst) and burst_wrap (set high for the transfer
-- where wrapping occurs in the burst). The user must make sure the
-- addresses are incremented/wrapped correctly.
--
-- Busy cycles can be inserted into bursts by asserting the busy
-- signal. This is only permitted when the current and next transfer
-- are part of the same burst (next_request.burst_cont='1'). When
-- inserting busy cycles, the next transfer should not be flipped
-- until the flip output signal goes high. (when not using busy
-- cycles, the "flip" and "done" outputs are always equal).
--
-- The generic dmastyle can be set to different levels of support:
--   dmastyle=1 single-access only
--   dmastyle=2 back-to-back accesses but no bursts
--   dmastyle=3 full featured (default)
--
-- Regardless of dmastyle setting the same input interface can be
-- used, i.e. you can still "pretend" to perform bursts etc. but they
-- will be emulated using simpler transfers.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;
library gaisler;
use gaisler.misc.all;

entity ahbmst2 is
  generic (
    hindex: integer := 0;
    venid: integer;
    devid: integer;
    version: integer;
    dmastyle: integer range 1 to 3;
    syncrst: integer range 0 to 1 := 1
    );      
  port (
    clk: in std_logic;
    rst: in std_logic;

    ahbi: in ahb_mst_in_type;
    ahbo: out ahb_mst_out_type;

    m2i: in ahbmst2_in_type;
    m2o: out ahbmst2_out_type
    );
end;

architecture rtl of ahbmst2 is

  constant cfg : ahb_config_type := (
    0 => ahb_device_reg ( venid, devid, 0, version, 0),
    others => zero32);
  
  type ahbmst2_regs is record
    addr_owner: std_logic;
    data_owner: std_logic;
    brokenburst: std_logic;
    flipdelay: std_logic;
  end record;

  constant r_rst: ahbmst2_regs := ('0','0','0','0');
  
  signal r,nr: ahbmst2_regs;

  -- signal dbg_badresp: std_logic;
    
begin

  comb: process(r,rst,ahbi,m2i)
    variable v: ahbmst2_regs;
    variable vahbo: ahb_mst_out_type;
    variable vm2o: ahbmst2_out_type;
    variable hb: std_logic_vector(2 downto 0);
    variable hgrant: std_logic;
    variable vbadresp: std_logic;
  begin
    vbadresp := '0';
    v := r;
    vahbo := (hbusreq => m2i.keepreq,
              htrans => HTRANS_IDLE,
              hlock => m2i.hlock,
              haddr => m2i.request.addr,
              hwrite => m2i.request.wr,
              hsize => m2i.request.hsize,
              hburst => m2i.request.hburst,
              hprot => m2i.request.hprot,
              hwdata => m2i.wrdata,
              hirq => (others => '0'),
              hconfig => cfg,
              hindex => hindex);
    vm2o := (done => '0', flip => '0', fail => '0', rddata => ahbi.hrdata);
    hgrant := ahbi.hgrant(hindex);
    
    if ahbi.hready='1' then
      v.addr_owner := hgrant;

      v.data_owner := '0';
      if r.addr_owner='1' and ((m2i.request.req='1' and r.data_owner='0') or (m2i.next_request.req='1' and dmastyle>1)) then
        v.data_owner := '1';
      end if;
      -- Special case when emulating busy cycles in single-access mode
      if dmastyle=1 and r.addr_owner='1' and r.data_owner='1' and m2i.busy='1' then
        v.data_owner := '1';
      elsif dmastyle=1 and r.addr_owner='1' and r.flipdelay='1' and m2i.busy='0' then
        v.data_owner := '0';
      end if;
    end if;

    -- Drive address and control
    hb := m2i.request.hburst;
    if dmastyle < 3 then hb:=HBURST_SINGLE; end if;
    
    if r.addr_owner='1' then
      
      if r.data_owner='0' and r.flipdelay='0' then

        -- Bus owner, first request in address phase
        if dmastyle>2 and m2i.request.burst_cont='1' then
          v.brokenburst := '1';
          hb := HBURST_INCR;
        end if;
        
        if m2i.request.req='1' then
          vahbo.htrans := HTRANS_NONSEQ;
          if m2i.next_request.req='1' then
            vahbo.hbusreq:='1';
          end if;        
        end if;      

      elsif dmastyle > 1 then

        vahbo.hprot := m2i.next_request.hprot;
        vahbo.haddr := m2i.next_request.addr;
        vahbo.hwrite := m2i.next_request.wr;
        vahbo.hsize := m2i.next_request.hsize;
        
        if m2i.request.req='1' and m2i.next_request.req='1' then

          vahbo.hlock := m2i.hlock;
          
          -- Bus owner, first request in data phase, next req in address phase
          
          hb := m2i.next_request.hburst;
          if dmastyle < 3 then hb:=HBURST_SINGLE; end if;
          
          vahbo.hbusreq := '1';
          
          if m2i.next_request.burst_cont='1' and r.brokenburst='1' then          
            hb := HBURST_INCR;
            if m2i.next_request.burst_wrap='1' then
              vahbo.htrans := HTRANS_NONSEQ;
            else
              vahbo.htrans := HTRANS_SEQ;
            end if;
            
          elsif m2i.next_request.burst_cont='1' and dmastyle > 2 then
            vahbo.htrans := HTRANS_SEQ;
            
          else          
            vahbo.htrans := HTRANS_NONSEQ;
            
          end if;
          
          if m2i.busy='1' then
-- pragma translate_off
            assert m2i.next_request.burst_cont='1' report "ahbmst2: m2i.busy asserted outside of burst" severity error;
-- pragma translate_on
            vahbo.htrans := HTRANS_BUSY;
            -- Special case:
            -- We are reconstructing a wrapping burst, and the user wants to
            -- insert a busy cycle at the point where the new burst is started          
            if (m2i.next_request.burst_wrap='1' and r.brokenburst='1') then
              vahbo.htrans := HTRANS_IDLE;
            end if;
            -- Always insert IDLE when bursts are not supported
            if dmastyle < 3 then
              vahbo.htrans := HTRANS_IDLE;
            end if;
            
          end if;

        end if;
        
      end if; -- data_owner

    else

      -- Not owner of address bus, put idle data
      vahbo.htrans := HTRANS_IDLE;
      vahbo.hbusreq := '0';
      if m2i.request.req='1' then vahbo.hbusreq:='1'; end if;
      
    end if; --addr_owner
    
    -- Drive output
    
    if r.data_owner='1' then

      if ahbi.hresp = HRESP_OKAY and ahbi.hready='1' then

        if m2i.next_request.req='0' or m2i.next_request.burst_cont='0' then
          v.brokenburst := '0';
        end if;
                
        if r.flipdelay='0' and m2i.busy='0' then
          vm2o.done := '1';
          vm2o.flip := '1';
        elsif r.flipdelay='0' and m2i.busy='1' then
          vm2o.done := '1';
          v.flipdelay := '1';
        end if;        
        
      elsif ahbi.hresp=HRESP_RETRY or ahbi.hresp=HRESP_SPLIT then
        -- assert ahbi.hready='0' report "AHB retry/split response without hready low" severity failure;
        vbadresp := '1';
        v.addr_owner := '0';
        v.data_owner := '0';
        
      elsif ahbi.hresp=HRESP_ERROR then
        --assert ahbi.hready='0' report "AHB error response without hready low" severity failure;
        vbadresp := '1';
        v.addr_owner := '0';
        v.data_owner := '0';
        vm2o.done := '1';
        vm2o.fail := '1';
        vm2o.flip := '1';
        
      end if;
      
    end if;
    
    if m2i.busy='0' and r.flipdelay='1' then
      vm2o.flip:='1';
      v.flipdelay:='0';
    end if;
        
    vahbo.hburst := hb;
    
    if rst='0' then
      if syncrst=1 then
        v := r_rst;
      end if;
      vahbo.hbusreq := '0';
      vahbo.htrans := HTRANS_IDLE;
    end if;

    nr <= v;
    ahbo <= vahbo;
    m2o <= vm2o;
  end process;
  
  regs: process(clk,rst)
  begin
    if rising_edge(clk) then r <= nr; end if;
    if rst='0' and syncrst=0 then r <= r_rst; end if;
  end process;
  
end;
