------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003, Gaisler Research
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
-- Entity: 	uart
-- File:	ft245uart.vhd
-- Authors:	Jan Schirok - TU Dresden
-- Description:	UART via USB FTDI FT245BL FIFO interface
--              interface: APB
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;

package ft245 is
type ft245_in_type is record
  rddata     : std_logic_vector(7 downto 0);  -- data read from ft245
  rxfn       : std_logic;                     -- data avail (low active)
  txen       : std_logic;                     -- transmit possible (low active)
  pwrenn     : std_logic;                     -- dev is active (low active)
end record;

type ft245_out_type is record
  wrdata     : std_logic_vector(7 downto 0);  -- data to ft245
  oen        : std_logic;                     -- output enable pad (low active)
  rdn        : std_logic;                     -- read enable (low active)
  wr         : std_logic;                     -- write enable (high active)
end record;

component ft245uart 
  generic (
    pindex   : integer := 0;
    paddr    : integer := 0;
    pmask    : integer := 16#fff#;
    console  : integer := 0;
    pirq     : integer := 0;
    abits    : integer := 8);
  port (
    rst    : in  std_ulogic;
    clk    : in  std_ulogic;
    apbi   : in  apb_slv_in_type;
    apbo   : out apb_slv_out_type;
    ft245i : in  ft245_in_type;
    ft245o : out ft245_out_type);
end component;

end;


library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;
library gaisler;
use gaisler.uart.all;
--pragma translate_off
use std.textio.all;
--pragma translate_on

use work.ft245.all;

entity ft245uart is
  generic (
    pindex   : integer := 0;
    paddr    : integer := 0;
    pmask    : integer := 16#fff#;
    console  : integer := 0;
    pirq     : integer := 0;
    abits    : integer := 8);
  port (
    rst    : in  std_ulogic;
    clk    : in  std_ulogic;
    apbi   : in  apb_slv_in_type;
    apbo   : out apb_slv_out_type;
    ft245i : in  ft245_in_type;
    ft245o : out ft245_out_type);
end;



architecture rtl of ft245uart is

constant REVISION : integer := 1;

constant pconfig : apb_config_type := (
  0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_APBUART, 0, REVISION, pirq),
  1 => apb_iobar(paddr, pmask));

-- CYCLE DEFINITIONS FOR FT245 COMMUNICATION
  --number of counter bits for cycles
  constant CYC_WIDTH : integer := 6; 
  --minimum length of ft245o.rdn pulse
  constant RDPULSE  : std_logic_vector(CYC_WIDTH-1 downto 0) 
    := conv_std_logic_vector(2, CYC_WIDTH);
  --number of clk periods until rddata is valid
  constant RDTODATA : std_logic_vector(CYC_WIDTH-1 downto 0)
    := conv_std_logic_vector(6, CYC_WIDTH); 
  --minimum length of ft245o.wr pulse in clk periods
  constant WRPULSE  : std_logic_vector(CYC_WIDTH-1 downto 0)
    := conv_std_logic_vector(8, CYC_WIDTH);
  --timeout for rdwait/wrwait (cycles to wait for rxfn/txen => '1')
  constant TIMEOUT  : std_logic_vector(CYC_WIDTH-1 downto 0)
    := conv_std_logic_vector(63, CYC_WIDTH);
  --zero definition
  constant CYNULL   : std_logic_vector(CYC_WIDTH-1 downto 0)
    := (CYC_WIDTH-1 downto 0 => '0');


type rxtxfsmtype is (idle, rdact, rddata, rdwait, wrdata, wrwait);
 



type ft245regs is record
  rxen   	:  std_ulogic;	-- receiver enabled
  txen   	:  std_ulogic;	-- transmitter enabled
  rirqen 	:  std_ulogic;	-- receiver irq enable
  tirqen 	:  std_ulogic;	-- transmitter irq enable
  loopb   	:  std_ulogic;	-- loop back mode enable
  rsempty   	:  std_ulogic;	-- receiver shift register empty (internal)
  tsempty   	:  std_ulogic;	-- transmitter shift register empty
  break  	:  std_ulogic;	-- break detected (data==0x0, reset in SW)
  irq       	:  std_ulogic;	-- tx/rx interrupt (internal)
  ft245i        :  ft245_in_type;  -- input register
  ft245o        :  ft245_out_type; -- output register
  rxtxstate     :  rxtxfsmtype; -- recv/transmit fsm
--  rcnt          :  std_logic_vector(0 downto 0);
--  tcnt          :  std_logic_vector(0 downto 0);
  rhold         :  std_logic_vector(7 downto 0);
  thold         :  std_logic_vector(7 downto 0);
  cyclecnt      :  std_logic_vector(CYC_WIDTH-1 downto 0);
end record;

signal r, rin : ft245regs;

begin
  uartop : process(rst, r, apbi )
  variable rdata : std_logic_vector(31 downto 0);
--  variable scaler : std_logic_vector(11 downto 0);
--  variable rxclk, txclk : std_logic_vector(2 downto 0);
--  variable rxd, ctsn : std_ulogic;
  variable irq : std_logic_vector(NAHBIRQ-1 downto 0);
  variable paddr : std_logic_vector(7 downto 2);
  variable v : ft245regs;
  variable dready : std_ulogic;
  variable thempty : std_ulogic;
--pragma translate_off
  variable L1 : line;
  variable CH : character;
  variable FIRST : boolean := true;
  variable pt : time := 0 ns;
--pragma translate_on

  begin

    v := r; irq := (others => '0'); irq(pirq) := r.irq;
    v.irq := '0'; 
    rdata := (others => '0');
--    dready := '0'; thempty := '1'; 

--    dready := r.rcnt(0); --rfull := dready; tfull := r.tcnt(0);
--    thempty := not r.tcnt(0);
      --thempty := not tfull;

-- read/write registers

  if (apbi.psel(pindex) and apbi.penable and (not apbi.pwrite)) = '1' then
    case paddr(7 downto 2) is
    when "000000" =>
      rdata(7 downto 0) := r.rhold;
      v.rsempty := '1';
--      v.rcnt(0) := '0';
    when "000001" =>
      rdata(3 downto 0) := r.break & r.tsempty & r.tsempty & not(r.rsempty); --fifo==shiftreg
--pragma translate_off
      if CONSOLE = 1 then rdata(2 downto 1) := "11"; end if;
--pragma translate_on
    when "000010" =>
      --no fifo => rdata(31)='0'
      rdata(7) := r.loopb;
      rdata(3 downto 0) := r.tirqen & r.rirqen & r.txen & r.rxen;
    when "000011" =>
      -- no scaler
      null;
    when "000100" =>
      -- no debug
      null;    
    when others =>
      null;
    end case;
  end if;

  paddr := "000000"; paddr(abits-1 downto 2) := apbi.paddr(abits-1 downto 2);
  if (apbi.psel(pindex) and apbi.penable and apbi.pwrite) = '1' then
    case paddr(7 downto 2) is
    when "000000" =>
      v.thold   := apbi.pwdata(7 downto 0);
      v.tsempty := '0';
--pragma translate_off
	if CONSOLE = 1 then
	  if first then L1:= new string'(""); first := false; end if; --'
	  if apbi.penable'event then	--'
	    CH := character'val(conv_integer(apbi.pwdata(7 downto 0))); --'
	    if CH  = CR then
	      std.textio.writeline(OUTPUT, L1);
	    elsif CH /= LF then
	      std.textio.write(L1,CH);
	    end if;
	    pt := now;
	  end if;
	end if;
--pragma translate_on
    when "000001" =>
      v.break      := apbi.pwdata(3);
    when "000010" =>
      v.loopb      := apbi.pwdata(7);
      v.tirqen     := apbi.pwdata(3);
      v.rirqen     := apbi.pwdata(2);
      v.txen 	   := apbi.pwdata(1);
      v.rxen 	   := apbi.pwdata(0);
    when "000011" =>
    when "000100" =>
    when others =>
      null;
    end case;
  end if;

-- FSM
    case r.rxtxstate is
    when idle =>
        -- loopback mode, rx/tx active, recv buf empty, send buf full
    	if r.loopb = '1' and r.rxen = '1' and r.txen = '1' and 
    	      r.rsempty = '1' and r.tsempty = '0' then
    	  v.rxtxstate := idle; -- loop back in one cycle
    	  v.rhold := r.thold;  -- copy transmit byte in recv buf
    	  v.rsempty := '0';
    	  v.tsempty := '1';
        -- something to recv, recv enabled, recv hold reg empty
    	elsif r.ft245i.rxfn = '0' and r.rxen = '1' and r.rsempty = '1' then
    	  v.rxtxstate := rdact;
    	  v.cyclecnt := RDTODATA;
    	  v.ft245o.oen := '1'; -- pad oen deact
    	  v.ft245o.rdn := '0'; -- read enable
    	-- external send fifo not full, send enabled, send reg not empty
        elsif r.ft245i.txen = '0' and r.txen = '1' and r.tsempty = '0' then
    	  v.rxtxstate := wrdata;
    	  v.cyclecnt := WRPULSE;
    	  v.ft245o.wr := '1';
    	  v.ft245o.oen := '0'; -- pad oen act
    	  v.ft245o.wrdata := r.thold;
          v.tsempty := '1';
          if r.tirqen = '1' then
            v.irq := '1';
          end if;
    	end if;

    when rdact =>
      v.cyclecnt := r.cyclecnt - 1;
      if v.cyclecnt = CYNULL then
        v.rxtxstate := rddata;
        --rdn stays low
        v.cyclecnt := RDPULSE;
      end if;
    when rddata =>
      v.cyclecnt := r.cyclecnt - 1;
      if v.cyclecnt = CYNULL then
        v.rxtxstate := rdwait;
        v.rsempty := '0';
        if r.rirqen = '1' then
          v.irq := '1'; -- irq if enabled
        end if;
        v.rhold := r.ft245i.rddata;
        if r.ft245i.rddata = "00000000" then
          v.break := '1';
        end if;
        v.ft245o.rdn := '1'; -- deactivate        
        v.cyclecnt := TIMEOUT;
      end if;
    when rdwait =>
      v.cyclecnt := r.cyclecnt - 1;
      -- value read or timeout
      if v.ft245i.rxfn = '1' or v.cyclecnt = CYNULL then 
        v.rxtxstate := idle;
      end if;
      
    when wrdata =>
      v.cyclecnt := r.cyclecnt - 1;
      if v.cyclecnt = CYNULL then
        v.rxtxstate := wrwait;
        v.cyclecnt := TIMEOUT;
        v.ft245o.wr := '0';
      end if;      
    when wrwait =>
      v.cyclecnt := r.cyclecnt - 1;
      --either tx byte accepted or timeout
      if r.ft245i.txen = '1' or r.cyclecnt = CYNULL then
        v.rxtxstate := idle;
        v.ft245o.oen := '1'; -- output pad deact
        v.tsempty := '1';
      end if;
    end case;

    -- reset if no power enable at ft245
    if r.ft245i.pwrenn = '1' then
      v.rxtxstate := idle;
      v.ft245o.wrdata := (others => '0');
      v.ft245o.oen := '1';
      v.ft245o.rdn := '1';
      v.ft245o.wr := '0';
      v.rsempty := '1'; v.tsempty := '1';
      v.irq := '0';
    end if;    

-- reset operation

    if rst = '0' then
      v.rxen := '0'; v.txen := '0';
      v.rirqen := '0'; v.tirqen := '0';
      v.loopb := '0';
      v.rsempty := '1'; v.tsempty := '1';
      v.break := '0';
      v.irq := '0';
      
      v.ft245o.wrdata := (others => '0');
      v.ft245o.oen := '1';
      v.ft245o.rdn := '1';
      v.ft245o.wr := '0';
      
      v.rxtxstate := idle;
      v.rhold := (others => '0');
      v.thold := (others => '0');
      v.cyclecnt := (others => '0'); 
    end if;

-- update registers

    rin <= v;

-- drive outputs

    apbo.prdata <= rdata; apbo.pirq <= irq;
    apbo.pindex <= pindex;
  end process;

  apbo.pconfig <= pconfig;
  
  ft245o <= r.ft245o;

  regs : process(clk)
  begin 
    if rising_edge(clk) then 
      r <= rin; 
      r.ft245i <= ft245i;
    end if; 
  end process;

-- pragma translate_off
    bootmsg : report_version
    generic map ("apbuart" & tost(pindex) &
	": FT245 UART rev " & tost(REVISION) & ", no fifo " &
	", irq " & tost(pirq));
-- pragma translate_on

end;
