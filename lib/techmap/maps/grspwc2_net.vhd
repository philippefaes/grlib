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
-- Entity: 	grspwc2
-- File:	grspwc2.vhd
-- Author:	Marko Isomaki - Gaisler Research
-- Description: Provides a link interface to a SpaceWire network
--              with an AHB host interface and RMAP support.
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library techmap;
use techmap.gencomp.all;

entity grspwc2_net is
  generic(
    rmap         : integer range 0 to 1  := 0;
    rmapcrc      : integer range 0 to 1  := 0;
    fifosize1    : integer range 4 to 32 := 32;
    fifosize2    : integer range 16 to 64 := 64;
    rxunaligned  : integer range 0 to 1 := 0;
    rmapbufs     : integer range 2 to 8 := 4;
    scantest     : integer range 0 to 1 := 0;
    ports        : integer range 1 to 2 := 1;
    dmachan      : integer range 1 to 4 := 1;
    tech         : integer;
    input_type   : integer range 0 to 4 := 0;
    output_type  : integer range 0 to 2 := 0;
    rxtx_sameclk : integer range 0 to 1 := 0
  );
  port(
    rst          : in  std_ulogic;
    clk          : in  std_ulogic;
    rxclk        : in  std_logic_vector(1 downto 0);
    txclk        : in  std_ulogic;
    txclkn       : in  std_ulogic;
    --ahb mst in
    hgrant       : in  std_ulogic;
    hready       : in  std_ulogic;
    hresp        : in  std_logic_vector(1 downto 0);
    hrdata       : in  std_logic_vector(31 downto 0);
    --ahb mst out
    hbusreq      : out  std_ulogic;
    hlock        : out  std_ulogic;
    htrans       : out  std_logic_vector(1 downto 0);
    haddr        : out  std_logic_vector(31 downto 0);
    hwrite       : out  std_ulogic;
    hsize        : out  std_logic_vector(2 downto 0);
    hburst       : out  std_logic_vector(2 downto 0);
    hprot        : out  std_logic_vector(3 downto 0);
    hwdata       : out  std_logic_vector(31 downto 0);
    --apb slv in
    psel	 : in   std_ulogic;
    penable	 : in   std_ulogic;
    paddr	 : in   std_logic_vector(31 downto 0);
    pwrite	 : in   std_ulogic;
    pwdata	 : in   std_logic_vector(31 downto 0);
    --apb slv out
    prdata	 : out  std_logic_vector(31 downto 0);
    --spw in
    d            : in   std_logic_vector(3 downto 0);
    dv           : in   std_logic_vector(3 downto 0);
    dconnect     : in   std_logic_vector(3 downto 0);
    --spw out
    do           : out  std_logic_vector(3 downto 0);
    so           : out  std_logic_vector(3 downto 0);
    --time iface
    tickin       : in   std_logic;
    tickinraw    : in   std_logic;
    timein       : in   std_logic_vector(7 downto 0);
    tickindone   : out  std_logic;
    tickout      : out  std_logic;
    tickoutraw   : out  std_logic;
    timeout      : out  std_logic_vector(7 downto 0);
    --irq
    irq          : out  std_logic;
    --misc
    clkdiv10     : in   std_logic_vector(7 downto 0);
    dcrstval     : in   std_logic_vector(9 downto 0);
    timerrstval  : in   std_logic_vector(11 downto 0);
    --rmapen
    rmapen       : in   std_ulogic;
    --rx ahb fifo
    rxrenable    : out  std_ulogic;
    rxraddress   : out  std_logic_vector(4 downto 0);
    rxwrite      : out  std_ulogic;
    rxwdata      : out  std_logic_vector(31 downto 0);
    rxwaddress   : out  std_logic_vector(4 downto 0);
    rxrdata      : in   std_logic_vector(31 downto 0);
    --tx ahb fifo
    txrenable    : out  std_ulogic;
    txraddress   : out  std_logic_vector(4 downto 0);
    txwrite      : out  std_ulogic;
    txwdata      : out  std_logic_vector(31 downto 0);
    txwaddress   : out  std_logic_vector(4 downto 0);
    txrdata      : in   std_logic_vector(31 downto 0);
    --nchar fifo
    ncrenable    : out  std_ulogic;
    ncraddress   : out  std_logic_vector(5 downto 0);
    ncwrite      : out  std_ulogic;
    ncwdata      : out  std_logic_vector(9 downto 0);
    ncwaddress   : out  std_logic_vector(5 downto 0);
    ncrdata      : in   std_logic_vector(9 downto 0);
    --rmap buf
    rmrenable    : out  std_ulogic;
    rmraddress   : out  std_logic_vector(7 downto 0);
    rmwrite      : out  std_ulogic;
    rmwdata      : out  std_logic_vector(7 downto 0);
    rmwaddress   : out  std_logic_vector(7 downto 0);
    rmrdata      : in   std_logic_vector(7 downto 0);
    linkdis      : out  std_ulogic;
    testclk      : in   std_ulogic;
    testrst      : in   std_logic;
    testen       : in   std_logic;
    rxdav        : out  std_logic;
    rxdataout    : out  std_logic_vector(8 downto 0);
    loopback     : out  std_logic
  );
end entity;

architecture rtl of grspwc2_net is
 
component grspwc2_unisim is
  generic(
    rmap         : integer range 0 to 1  := 0;
    rmapcrc      : integer range 0 to 1  := 0;
    fifosize1    : integer range 4 to 32 := 32;
    fifosize2    : integer range 16 to 64 := 64;
    rxunaligned  : integer range 0 to 1 := 0;
    rmapbufs     : integer range 2 to 8 := 4;
    scantest     : integer range 0 to 1 := 0;
    ports        : integer range 1 to 2 := 1;
    dmachan      : integer range 1 to 4 := 1;
    tech         : integer;
    input_type   : integer range 0 to 3 := 0;
    output_type  : integer range 0 to 2 := 0;
    rxtx_sameclk : integer range 0 to 1 := 0
  );
  port(
    rst          : in  std_ulogic;
    clk          : in  std_ulogic;
    rxclk        : in  std_logic_vector(1 downto 0);
    txclk        : in  std_ulogic;
    txclkn       : in  std_ulogic;
    --ahb mst in
    hgrant       : in  std_ulogic;
    hready       : in  std_ulogic;   
    hresp        : in  std_logic_vector(1 downto 0);
    hrdata       : in  std_logic_vector(31 downto 0); 
    --ahb mst out
    hbusreq      : out  std_ulogic;        
    hlock        : out  std_ulogic;
    htrans       : out  std_logic_vector(1 downto 0);
    haddr        : out  std_logic_vector(31 downto 0);
    hwrite       : out  std_ulogic;
    hsize        : out  std_logic_vector(2 downto 0);
    hburst       : out  std_logic_vector(2 downto 0);
    hprot        : out  std_logic_vector(3 downto 0);
    hwdata       : out  std_logic_vector(31 downto 0);
    --apb slv in 
    psel	 : in   std_ulogic;
    penable	 : in   std_ulogic;
    paddr	 : in   std_logic_vector(31 downto 0);
    pwrite	 : in   std_ulogic;
    pwdata	 : in   std_logic_vector(31 downto 0);
    --apb slv out
    prdata	 : out  std_logic_vector(31 downto 0);
    --spw in
    d            : in   std_logic_vector(3 downto 0);
    dv           : in   std_logic_vector(3 downto 0);
    dconnect     : in   std_logic_vector(3 downto 0);
    --spw out
    do           : out  std_logic_vector(3 downto 0);
    so           : out  std_logic_vector(3 downto 0);
    --time iface
    tickin       : in   std_logic;
    tickinraw    : in   std_logic;
    timein       : in   std_logic_vector(7 downto 0);
    tickindone   : out  std_logic;
    tickout      : out  std_logic;
    tickoutraw   : out  std_logic;
    timeout      : out  std_logic_vector(7 downto 0);
    --irq
    irq          : out  std_logic;
    --misc     
    clkdiv10     : in   std_logic_vector(7 downto 0);
    --rmapen
    rmapen       : in   std_ulogic;
    --rx ahb fifo
    rxrenable    : out  std_ulogic;
    rxraddress   : out  std_logic_vector(4 downto 0);
    rxwrite      : out  std_ulogic;
    rxwdata      : out  std_logic_vector(31 downto 0);
    rxwaddress   : out  std_logic_vector(4 downto 0);
    rxrdata      : in   std_logic_vector(31 downto 0);    
    --tx ahb fifo
    txrenable    : out  std_ulogic;
    txraddress   : out  std_logic_vector(4 downto 0);
    txwrite      : out  std_ulogic;
    txwdata      : out  std_logic_vector(31 downto 0);
    txwaddress   : out  std_logic_vector(4 downto 0);
    txrdata      : in   std_logic_vector(31 downto 0);    
    --nchar fifo
    ncrenable    : out  std_ulogic;
    ncraddress   : out  std_logic_vector(5 downto 0);
    ncwrite      : out  std_ulogic;
    ncwdata      : out  std_logic_vector(9 downto 0);
    ncwaddress   : out  std_logic_vector(5 downto 0);
    ncrdata      : in   std_logic_vector(9 downto 0);
    --rmap buf
    rmrenable    : out  std_ulogic;
    rmraddress   : out  std_logic_vector(7 downto 0);
    rmwrite      : out  std_ulogic;
    rmwdata      : out  std_logic_vector(7 downto 0);
    rmwaddress   : out  std_logic_vector(7 downto 0);
    rmrdata      : in   std_logic_vector(7 downto 0);
    linkdis      : out  std_ulogic;
    testrst      : in   std_logic;
    testen       : in   std_logic;
    rxdav        : out  std_logic;
    rxdataout    : out  std_logic_vector(8 downto 0);
    loopback     : out  std_logic
  );
end component;

component grspwc2_axcelerator is
  generic(
    rmap         : integer range 0 to 1  := 0;
    rmapcrc      : integer range 0 to 1  := 0;
    fifosize1    : integer range 4 to 32 := 32;
    fifosize2    : integer range 16 to 64 := 64;
    rxunaligned  : integer range 0 to 1 := 0;
    rmapbufs     : integer range 2 to 8 := 4;
    scantest     : integer range 0 to 1 := 0;
    ports        : integer range 1 to 2 := 1;
    dmachan      : integer range 1 to 4 := 1;
    tech         : integer;
    input_type   : integer range 0 to 3 := 0;
    output_type  : integer range 0 to 2 := 0;
    rxtx_sameclk : integer range 0 to 1 := 0
  );
  port(
    rst          : in  std_ulogic;
    clk          : in  std_ulogic;
    rxclk        : in  std_logic_vector(1 downto 0);
    txclk        : in  std_ulogic;
    txclkn       : in  std_ulogic;
    --ahb mst in
    hgrant       : in  std_ulogic;
    hready       : in  std_ulogic;   
    hresp        : in  std_logic_vector(1 downto 0);
    hrdata       : in  std_logic_vector(31 downto 0); 
    --ahb mst out
    hbusreq      : out  std_ulogic;        
    hlock        : out  std_ulogic;
    htrans       : out  std_logic_vector(1 downto 0);
    haddr        : out  std_logic_vector(31 downto 0);
    hwrite       : out  std_ulogic;
    hsize        : out  std_logic_vector(2 downto 0);
    hburst       : out  std_logic_vector(2 downto 0);
    hprot        : out  std_logic_vector(3 downto 0);
    hwdata       : out  std_logic_vector(31 downto 0);
    --apb slv in 
    psel	 : in   std_ulogic;
    penable	 : in   std_ulogic;
    paddr	 : in   std_logic_vector(31 downto 0);
    pwrite	 : in   std_ulogic;
    pwdata	 : in   std_logic_vector(31 downto 0);
    --apb slv out
    prdata	 : out  std_logic_vector(31 downto 0);
    --spw in
    d            : in   std_logic_vector(3 downto 0);
    dv           : in   std_logic_vector(3 downto 0);
    dconnect     : in   std_logic_vector(3 downto 0);
    --spw out
    do           : out  std_logic_vector(3 downto 0);
    so           : out  std_logic_vector(3 downto 0);
    --time iface
    tickin       : in   std_logic;
    tickinraw    : in   std_logic;
    timein       : in   std_logic_vector(7 downto 0);
    tickindone   : out  std_logic;
    tickout      : out  std_logic;
    tickoutraw   : out  std_logic;
    timeout      : out  std_logic_vector(7 downto 0);
    --irq
    irq          : out  std_logic;
    --misc     
    clkdiv10     : in   std_logic_vector(7 downto 0);
    --rmapen
    rmapen       : in   std_ulogic;
    --rx ahb fifo
    rxrenable    : out  std_ulogic;
    rxraddress   : out  std_logic_vector(4 downto 0);
    rxwrite      : out  std_ulogic;
    rxwdata      : out  std_logic_vector(31 downto 0);
    rxwaddress   : out  std_logic_vector(4 downto 0);
    rxrdata      : in   std_logic_vector(31 downto 0);    
    --tx ahb fifo
    txrenable    : out  std_ulogic;
    txraddress   : out  std_logic_vector(4 downto 0);
    txwrite      : out  std_ulogic;
    txwdata      : out  std_logic_vector(31 downto 0);
    txwaddress   : out  std_logic_vector(4 downto 0);
    txrdata      : in   std_logic_vector(31 downto 0);    
    --nchar fifo
    ncrenable    : out  std_ulogic;
    ncraddress   : out  std_logic_vector(5 downto 0);
    ncwrite      : out  std_ulogic;
    ncwdata      : out  std_logic_vector(9 downto 0);
    ncwaddress   : out  std_logic_vector(5 downto 0);
    ncrdata      : in   std_logic_vector(9 downto 0);
    --rmap buf
    rmrenable    : out  std_ulogic;
    rmraddress   : out  std_logic_vector(7 downto 0);
    rmwrite      : out  std_ulogic;
    rmwdata      : out  std_logic_vector(7 downto 0);
    rmwaddress   : out  std_logic_vector(7 downto 0);
    rmrdata      : in   std_logic_vector(7 downto 0);
    linkdis      : out  std_ulogic;
    testrst      : in   std_logic;
    testen       : in   std_logic;
    rxdav        : out  std_logic;
    rxdataout    : out  std_logic_vector(8 downto 0);
    loopback     : out  std_logic
  );
end component;

component grspwc2_proasic3 is
  generic(
    rmap         : integer range 0 to 1  := 0;
    rmapcrc      : integer range 0 to 1  := 0;
    fifosize1    : integer range 4 to 32 := 32;
    fifosize2    : integer range 16 to 64 := 64;
    rxunaligned  : integer range 0 to 1 := 0;
    rmapbufs     : integer range 2 to 8 := 4;
    scantest     : integer range 0 to 1 := 0;
    ports        : integer range 1 to 2 := 1;
    dmachan      : integer range 1 to 4 := 1;
    tech         : integer;
    input_type   : integer range 0 to 3 := 0;
    output_type  : integer range 0 to 2 := 0;
    rxtx_sameclk : integer range 0 to 1 := 0
  );
  port(
    rst          : in  std_ulogic;
    clk          : in  std_ulogic;
    rxclk        : in  std_logic_vector(1 downto 0);
    txclk        : in  std_ulogic;
    txclkn       : in  std_ulogic;
    --ahb mst in
    hgrant       : in  std_ulogic;
    hready       : in  std_ulogic;   
    hresp        : in  std_logic_vector(1 downto 0);
    hrdata       : in  std_logic_vector(31 downto 0); 
    --ahb mst out
    hbusreq      : out  std_ulogic;        
    hlock        : out  std_ulogic;
    htrans       : out  std_logic_vector(1 downto 0);
    haddr        : out  std_logic_vector(31 downto 0);
    hwrite       : out  std_ulogic;
    hsize        : out  std_logic_vector(2 downto 0);
    hburst       : out  std_logic_vector(2 downto 0);
    hprot        : out  std_logic_vector(3 downto 0);
    hwdata       : out  std_logic_vector(31 downto 0);
    --apb slv in 
    psel	 : in   std_ulogic;
    penable	 : in   std_ulogic;
    paddr	 : in   std_logic_vector(31 downto 0);
    pwrite	 : in   std_ulogic;
    pwdata	 : in   std_logic_vector(31 downto 0);
    --apb slv out
    prdata	 : out  std_logic_vector(31 downto 0);
    --spw in
    d            : in   std_logic_vector(3 downto 0);
    dv           : in   std_logic_vector(3 downto 0);
    dconnect     : in   std_logic_vector(3 downto 0);
    --spw out
    do           : out  std_logic_vector(3 downto 0);
    so           : out  std_logic_vector(3 downto 0);
    --time iface
    tickin       : in   std_logic;
    tickinraw    : in   std_logic;
    timein       : in   std_logic_vector(7 downto 0);
    tickindone   : out  std_logic;
    tickout      : out  std_logic;
    tickoutraw   : out  std_logic;
    timeout      : out  std_logic_vector(7 downto 0);
    --irq
    irq          : out  std_logic;
    --misc     
    clkdiv10     : in   std_logic_vector(7 downto 0);
    --rmapen
    rmapen       : in   std_ulogic;
    --rx ahb fifo
    rxrenable    : out  std_ulogic;
    rxraddress   : out  std_logic_vector(4 downto 0);
    rxwrite      : out  std_ulogic;
    rxwdata      : out  std_logic_vector(31 downto 0);
    rxwaddress   : out  std_logic_vector(4 downto 0);
    rxrdata      : in   std_logic_vector(31 downto 0);    
    --tx ahb fifo
    txrenable    : out  std_ulogic;
    txraddress   : out  std_logic_vector(4 downto 0);
    txwrite      : out  std_ulogic;
    txwdata      : out  std_logic_vector(31 downto 0);
    txwaddress   : out  std_logic_vector(4 downto 0);
    txrdata      : in   std_logic_vector(31 downto 0);    
    --nchar fifo
    ncrenable    : out  std_ulogic;
    ncraddress   : out  std_logic_vector(5 downto 0);
    ncwrite      : out  std_ulogic;
    ncwdata      : out  std_logic_vector(9 downto 0);
    ncwaddress   : out  std_logic_vector(5 downto 0);
    ncrdata      : in   std_logic_vector(9 downto 0);
    --rmap buf
    rmrenable    : out  std_ulogic;
    rmraddress   : out  std_logic_vector(7 downto 0);
    rmwrite      : out  std_ulogic;
    rmwdata      : out  std_logic_vector(7 downto 0);
    rmwaddress   : out  std_logic_vector(7 downto 0);
    rmrdata      : in   std_logic_vector(7 downto 0);
    linkdis      : out  std_ulogic;
    testrst      : in   std_ulogic := '0';
    testen       : in   std_ulogic := '0';
    rxdav        : out  std_logic;
    rxdataout    : out  std_logic_vector(8 downto 0);
    loopback     : out  std_logic
  );
end component;

component grspwc2_proasic3e is
  generic(
    rmap         : integer range 0 to 1  := 0;
    rmapcrc      : integer range 0 to 1  := 0;
    fifosize1    : integer range 4 to 32 := 32;
    fifosize2    : integer range 16 to 64 := 64;
    rxunaligned  : integer range 0 to 1 := 0;
    rmapbufs     : integer range 2 to 8 := 4;
    scantest     : integer range 0 to 1 := 0;
    ports        : integer range 1 to 2 := 1;
    dmachan      : integer range 1 to 4 := 1;
    tech         : integer;
    input_type   : integer range 0 to 3 := 0;
    output_type  : integer range 0 to 2 := 0;
    rxtx_sameclk : integer range 0 to 1 := 0
  );
  port(
    rst          : in  std_ulogic;
    clk          : in  std_ulogic;
    rxclk        : in  std_logic_vector(1 downto 0);
    txclk        : in  std_ulogic;
    txclkn       : in  std_ulogic;
    --ahb mst in
    hgrant       : in  std_ulogic;
    hready       : in  std_ulogic;   
    hresp        : in  std_logic_vector(1 downto 0);
    hrdata       : in  std_logic_vector(31 downto 0); 
    --ahb mst out
    hbusreq      : out  std_ulogic;        
    hlock        : out  std_ulogic;
    htrans       : out  std_logic_vector(1 downto 0);
    haddr        : out  std_logic_vector(31 downto 0);
    hwrite       : out  std_ulogic;
    hsize        : out  std_logic_vector(2 downto 0);
    hburst       : out  std_logic_vector(2 downto 0);
    hprot        : out  std_logic_vector(3 downto 0);
    hwdata       : out  std_logic_vector(31 downto 0);
    --apb slv in 
    psel	 : in   std_ulogic;
    penable	 : in   std_ulogic;
    paddr	 : in   std_logic_vector(31 downto 0);
    pwrite	 : in   std_ulogic;
    pwdata	 : in   std_logic_vector(31 downto 0);
    --apb slv out
    prdata	 : out  std_logic_vector(31 downto 0);
    --spw in
    d            : in   std_logic_vector(3 downto 0);
    dv           : in   std_logic_vector(3 downto 0);
    dconnect     : in   std_logic_vector(3 downto 0);
    --spw out
    do           : out  std_logic_vector(3 downto 0);
    so           : out  std_logic_vector(3 downto 0);
    --time iface
    tickin       : in   std_logic;
    tickinraw    : in   std_logic;
    timein       : in   std_logic_vector(7 downto 0);
    tickindone   : out  std_logic;
    tickout      : out  std_logic;
    tickoutraw   : out  std_logic;
    timeout      : out  std_logic_vector(7 downto 0);
    --irq
    irq          : out  std_logic;
    --misc     
    clkdiv10     : in   std_logic_vector(7 downto 0);
    --rmapen
    rmapen       : in   std_ulogic;
    --rx ahb fifo
    rxrenable    : out  std_ulogic;
    rxraddress   : out  std_logic_vector(4 downto 0);
    rxwrite      : out  std_ulogic;
    rxwdata      : out  std_logic_vector(31 downto 0);
    rxwaddress   : out  std_logic_vector(4 downto 0);
    rxrdata      : in   std_logic_vector(31 downto 0);    
    --tx ahb fifo
    txrenable    : out  std_ulogic;
    txraddress   : out  std_logic_vector(4 downto 0);
    txwrite      : out  std_ulogic;
    txwdata      : out  std_logic_vector(31 downto 0);
    txwaddress   : out  std_logic_vector(4 downto 0);
    txrdata      : in   std_logic_vector(31 downto 0);    
    --nchar fifo
    ncrenable    : out  std_ulogic;
    ncraddress   : out  std_logic_vector(5 downto 0);
    ncwrite      : out  std_ulogic;
    ncwdata      : out  std_logic_vector(9 downto 0);
    ncwaddress   : out  std_logic_vector(5 downto 0);
    ncrdata      : in   std_logic_vector(9 downto 0);
    --rmap buf
    rmrenable    : out  std_ulogic;
    rmraddress   : out  std_logic_vector(7 downto 0);
    rmwrite      : out  std_ulogic;
    rmwdata      : out  std_logic_vector(7 downto 0);
    rmwaddress   : out  std_logic_vector(7 downto 0);
    rmrdata      : in   std_logic_vector(7 downto 0);
    linkdis      : out  std_ulogic;
    testrst      : in   std_ulogic := '0';
    testen       : in   std_ulogic := '0';
    rxdav        : out  std_logic;
    rxdataout    : out  std_logic_vector(8 downto 0);
    loopback     : out  std_logic
  );
end component;

component grspwc2_proasic3l is
  generic(
    rmap         : integer range 0 to 1  := 0;
    rmapcrc      : integer range 0 to 1  := 0;
    fifosize1    : integer range 4 to 32 := 32;
    fifosize2    : integer range 16 to 64 := 64;
    rxunaligned  : integer range 0 to 1 := 0;
    rmapbufs     : integer range 2 to 8 := 4;
    scantest     : integer range 0 to 1 := 0;
    ports        : integer range 1 to 2 := 1;
    dmachan      : integer range 1 to 4 := 1;
    tech         : integer;
    input_type   : integer range 0 to 3 := 0;
    output_type  : integer range 0 to 2 := 0;
    rxtx_sameclk : integer range 0 to 1 := 0
  );
  port(
    rst          : in  std_ulogic;
    clk          : in  std_ulogic;
    rxclk        : in  std_logic_vector(1 downto 0);
    txclk        : in  std_ulogic;
    txclkn       : in  std_ulogic;
    --ahb mst in
    hgrant       : in  std_ulogic;
    hready       : in  std_ulogic;   
    hresp        : in  std_logic_vector(1 downto 0);
    hrdata       : in  std_logic_vector(31 downto 0); 
    --ahb mst out
    hbusreq      : out  std_ulogic;        
    hlock        : out  std_ulogic;
    htrans       : out  std_logic_vector(1 downto 0);
    haddr        : out  std_logic_vector(31 downto 0);
    hwrite       : out  std_ulogic;
    hsize        : out  std_logic_vector(2 downto 0);
    hburst       : out  std_logic_vector(2 downto 0);
    hprot        : out  std_logic_vector(3 downto 0);
    hwdata       : out  std_logic_vector(31 downto 0);
    --apb slv in 
    psel	 : in   std_ulogic;
    penable	 : in   std_ulogic;
    paddr	 : in   std_logic_vector(31 downto 0);
    pwrite	 : in   std_ulogic;
    pwdata	 : in   std_logic_vector(31 downto 0);
    --apb slv out
    prdata	 : out  std_logic_vector(31 downto 0);
    --spw in
    d            : in   std_logic_vector(3 downto 0);
    dv           : in   std_logic_vector(3 downto 0);
    dconnect     : in   std_logic_vector(3 downto 0);
    --spw out
    do           : out  std_logic_vector(3 downto 0);
    so           : out  std_logic_vector(3 downto 0);
    --time iface
    tickin       : in   std_logic;
    tickinraw    : in   std_logic;
    timein       : in   std_logic_vector(7 downto 0);
    tickindone   : out  std_logic;
    tickout      : out  std_logic;
    tickoutraw   : out  std_logic;
    timeout      : out  std_logic_vector(7 downto 0);
    --irq
    irq          : out  std_logic;
    --misc     
    clkdiv10     : in   std_logic_vector(7 downto 0);
    --rmapen
    rmapen       : in   std_ulogic;
    --rx ahb fifo
    rxrenable    : out  std_ulogic;
    rxraddress   : out  std_logic_vector(4 downto 0);
    rxwrite      : out  std_ulogic;
    rxwdata      : out  std_logic_vector(31 downto 0);
    rxwaddress   : out  std_logic_vector(4 downto 0);
    rxrdata      : in   std_logic_vector(31 downto 0);    
    --tx ahb fifo
    txrenable    : out  std_ulogic;
    txraddress   : out  std_logic_vector(4 downto 0);
    txwrite      : out  std_ulogic;
    txwdata      : out  std_logic_vector(31 downto 0);
    txwaddress   : out  std_logic_vector(4 downto 0);
    txrdata      : in   std_logic_vector(31 downto 0);    
    --nchar fifo
    ncrenable    : out  std_ulogic;
    ncraddress   : out  std_logic_vector(5 downto 0);
    ncwrite      : out  std_ulogic;
    ncwdata      : out  std_logic_vector(9 downto 0);
    ncwaddress   : out  std_logic_vector(5 downto 0);
    ncrdata      : in   std_logic_vector(9 downto 0);
    --rmap buf
    rmrenable    : out  std_ulogic;
    rmraddress   : out  std_logic_vector(7 downto 0);
    rmwrite      : out  std_ulogic;
    rmwdata      : out  std_logic_vector(7 downto 0);
    rmwaddress   : out  std_logic_vector(7 downto 0);
    rmrdata      : in   std_logic_vector(7 downto 0);
    linkdis      : out  std_ulogic;
    testrst      : in   std_ulogic := '0';
    testen       : in   std_ulogic := '0';
    rxdav        : out  std_logic;
    rxdataout    : out  std_logic_vector(8 downto 0);
    loopback     : out  std_logic
  );
end component;

begin

  xil : if (is_unisim(tech) = 1) generate
    grspwc20 : grspwc2_unisim
    generic map (rmap, rmapcrc, fifosize1, fifosize2,
		 rxunaligned, rmapbufs, scantest, ports, dmachan,
		tech, input_type, output_type, rxtx_sameclk)
    port map(
      rst          => rst,
      clk          => clk,
      rxclk        => rxclk,
      txclk        => txclk,
      txclkn       => txclkn,
      --ahb mst in
      hgrant       => hgrant,
      hready       => hready,
      hresp        => hresp,
      hrdata       => hrdata,
      --ahb mst out
      hbusreq      => hbusreq,
      hlock        => hlock,
      htrans       => htrans,
      haddr        => haddr,
      hwrite       => hwrite,
      hsize        => hsize,
      hburst       => hburst,
      hprot        => hprot,
      hwdata       => hwdata,
      --apb slv in
      psel	   => psel,
      penable	   => penable,
      paddr	   => paddr,
      pwrite	   => pwrite,
      pwdata	   => pwdata,
      --apb slv out
      prdata       => prdata,
      --spw in
      d            => d,
      dv           => dv,
      dconnect  => dconnect,
      --spw out
      do           => do,
      so           => so,
      --time iface
      tickin       => tickin,
      tickinraw    => tickinraw,
      timein       => timein,
      tickindone   => tickindone,
      tickout      => tickout,
      tickoutraw   => tickoutraw,
      timeout      => timeout,
      --irq
      irq          => irq,
      --misc
      clkdiv10     => clkdiv10,
      --rmapen
      rmapen       => rmapen,
      --rx ahb fifo
      rxrenable    => rxrenable,
      rxraddress   => rxraddress,
      rxwrite      => rxwrite,
      rxwdata      => rxwdata,
      rxwaddress   => rxwaddress,
      rxrdata      => rxrdata,
      --tx ahb fifo
      txrenable    => txrenable,
      txraddress   => txraddress,
      txwrite      => txwrite,
      txwdata      => txwdata,
      txwaddress   => txwaddress,
      txrdata      => txrdata,
      --nchar fifo
      ncrenable    => ncrenable,
      ncraddress   => ncraddress,
      ncwrite      => ncwrite,
      ncwdata      => ncwdata,
      ncwaddress   => ncwaddress,
      ncrdata      => ncrdata,
      --rmap buf
      rmrenable    => rmrenable,
      rmraddress   => rmraddress,
      rmwrite      => rmwrite,
      rmwdata      => rmwdata,
      rmwaddress   => rmwaddress,
      rmrdata      => rmrdata,
      linkdis      => linkdis,
      testrst      => testrst,
      testen       => testen,
      rxdav        => rxdav,
      rxdataout    => rxdataout,
      loopback     => loopback
      );
  end generate;

  ax : if (tech = axcel) or (tech = axdsp) generate
    grspwc20 : grspwc2_axcelerator
    generic map (rmap, rmapcrc, fifosize1, fifosize2,
		 rxunaligned, rmapbufs, scantest, ports, dmachan,
		tech, input_type, output_type, rxtx_sameclk)
    port map(
      rst          => rst,
      clk          => clk,
      rxclk        => rxclk,
      txclk        => txclk,
      txclkn       => txclkn,
      --ahb mst in
      hgrant       => hgrant,
      hready       => hready,
      hresp        => hresp,
      hrdata       => hrdata,
      --ahb mst out
      hbusreq      => hbusreq,
      hlock        => hlock,
      htrans       => htrans,
      haddr        => haddr,
      hwrite       => hwrite,
      hsize        => hsize,
      hburst       => hburst,
      hprot        => hprot,
      hwdata       => hwdata,
      --apb slv in
      psel	   => psel,
      penable	   => penable,
      paddr	   => paddr,
      pwrite	   => pwrite,
      pwdata	   => pwdata,
      --apb slv out
      prdata       => prdata,
      --spw in
      d            => d,
      dv           => dv,
      dconnect  => dconnect,
      --spw out
      do           => do,
      so           => so,
      --time iface
      tickin       => tickin,
      tickinraw    => tickinraw,
      timein       => timein,
      tickindone   => tickindone,
      tickout      => tickout,
      tickoutraw   => tickoutraw,
      timeout      => timeout,
      --irq
      irq          => irq,
      --misc
      clkdiv10     => clkdiv10,
      --rmapen
      rmapen       => rmapen,
      --rx ahb fifo
      rxrenable    => rxrenable,
      rxraddress   => rxraddress,
      rxwrite      => rxwrite,
      rxwdata      => rxwdata,
      rxwaddress   => rxwaddress,
      rxrdata      => rxrdata,
      --tx ahb fifo
      txrenable    => txrenable,
      txraddress   => txraddress,
      txwrite      => txwrite,
      txwdata      => txwdata,
      txwaddress   => txwaddress,
      txrdata      => txrdata,
      --nchar fifo
      ncrenable    => ncrenable,
      ncraddress   => ncraddress,
      ncwrite      => ncwrite,
      ncwdata      => ncwdata,
      ncwaddress   => ncwaddress,
      ncrdata      => ncrdata,
      --rmap buf
      rmrenable    => rmrenable,
      rmraddress   => rmraddress,
      rmwrite      => rmwrite,
      rmwdata      => rmwdata,
      rmwaddress   => rmwaddress,
      rmrdata      => rmrdata,
      linkdis      => linkdis,
      testrst      => testrst,
      testen       => testen,
      rxdav        => rxdav,
      rxdataout    => rxdataout,
      loopback     => loopback
      );
  end generate;

  a3p : if (tech = apa3) generate
    grspwc20 : grspwc2_proasic3
    generic map (rmap, rmapcrc, fifosize1, fifosize2,
		 rxunaligned, rmapbufs, scantest, ports, dmachan,
		tech, input_type, output_type, rxtx_sameclk)
    port map(
      rst          => rst,
      clk          => clk,
      rxclk        => rxclk,
      txclk        => txclk,
      txclkn       => txclkn,
      --ahb mst in
      hgrant       => hgrant,
      hready       => hready,
      hresp        => hresp,
      hrdata       => hrdata,
      --ahb mst out
      hbusreq      => hbusreq,
      hlock        => hlock,
      htrans       => htrans,
      haddr        => haddr,
      hwrite       => hwrite,
      hsize        => hsize,
      hburst       => hburst,
      hprot        => hprot,
      hwdata       => hwdata,
      --apb slv in
      psel	   => psel,
      penable	   => penable,
      paddr	   => paddr,
      pwrite	   => pwrite,
      pwdata	   => pwdata,
      --apb slv out
      prdata       => prdata,
      --spw in
      d            => d,
      dv           => dv,
      dconnect  => dconnect,
      --spw out
      do           => do,
      so           => so,
      --time iface
      tickin       => tickin,
      tickinraw    => tickinraw,
      timein       => timein,
      tickindone   => tickindone,
      tickout      => tickout,
      tickoutraw   => tickoutraw,
      timeout      => timeout,
      --irq
      irq          => irq,
      --misc
      clkdiv10     => clkdiv10,
      --rmapen
      rmapen       => rmapen,
      --rx ahb fifo
      rxrenable    => rxrenable,
      rxraddress   => rxraddress,
      rxwrite      => rxwrite,
      rxwdata      => rxwdata,
      rxwaddress   => rxwaddress,
      rxrdata      => rxrdata,
      --tx ahb fifo
      txrenable    => txrenable,
      txraddress   => txraddress,
      txwrite      => txwrite,
      txwdata      => txwdata,
      txwaddress   => txwaddress,
      txrdata      => txrdata,
      --nchar fifo
      ncrenable    => ncrenable,
      ncraddress   => ncraddress,
      ncwrite      => ncwrite,
      ncwdata      => ncwdata,
      ncwaddress   => ncwaddress,
      ncrdata      => ncrdata,
      --rmap buf
      rmrenable    => rmrenable,
      rmraddress   => rmraddress,
      rmwrite      => rmwrite,
      rmwdata      => rmwdata,
      rmwaddress   => rmwaddress,
      rmrdata      => rmrdata,
      linkdis      => linkdis,
      testrst      => testrst,
      testen       => testen,
      rxdav        => rxdav,
      rxdataout    => rxdataout,
      loopback     => loopback
      );
  end generate;

  a3e : if (tech = apa3e) generate
    grspwc20 : grspwc2_proasic3e
    generic map (rmap, rmapcrc, fifosize1, fifosize2,
		 rxunaligned, rmapbufs, scantest, ports, dmachan,
		tech, input_type, output_type, rxtx_sameclk)
    port map(
      rst          => rst,
      clk          => clk,
      rxclk        => rxclk,
      txclk        => txclk,
      txclkn       => txclkn,
      --ahb mst in
      hgrant       => hgrant,
      hready       => hready,
      hresp        => hresp,
      hrdata       => hrdata,
      --ahb mst out
      hbusreq      => hbusreq,
      hlock        => hlock,
      htrans       => htrans,
      haddr        => haddr,
      hwrite       => hwrite,
      hsize        => hsize,
      hburst       => hburst,
      hprot        => hprot,
      hwdata       => hwdata,
      --apb slv in
      psel	   => psel,
      penable	   => penable,
      paddr	   => paddr,
      pwrite	   => pwrite,
      pwdata	   => pwdata,
      --apb slv out
      prdata       => prdata,
      --spw in
      d            => d,
      dv           => dv,
      dconnect  => dconnect,
      --spw out
      do           => do,
      so           => so,
      --time iface
      tickin       => tickin,
      tickinraw    => tickinraw,
      timein       => timein,
      tickindone   => tickindone,
      tickout      => tickout,
      tickoutraw   => tickoutraw,
      timeout      => timeout,
      --irq
      irq          => irq,
      --misc
      clkdiv10     => clkdiv10,
      --rmapen
      rmapen       => rmapen,
      --rx ahb fifo
      rxrenable    => rxrenable,
      rxraddress   => rxraddress,
      rxwrite      => rxwrite,
      rxwdata      => rxwdata,
      rxwaddress   => rxwaddress,
      rxrdata      => rxrdata,
      --tx ahb fifo
      txrenable    => txrenable,
      txraddress   => txraddress,
      txwrite      => txwrite,
      txwdata      => txwdata,
      txwaddress   => txwaddress,
      txrdata      => txrdata,
      --nchar fifo
      ncrenable    => ncrenable,
      ncraddress   => ncraddress,
      ncwrite      => ncwrite,
      ncwdata      => ncwdata,
      ncwaddress   => ncwaddress,
      ncrdata      => ncrdata,
      --rmap buf
      rmrenable    => rmrenable,
      rmraddress   => rmraddress,
      rmwrite      => rmwrite,
      rmwdata      => rmwdata,
      rmwaddress   => rmwaddress,
      rmrdata      => rmrdata,
      linkdis      => linkdis,
      testrst      => testrst,
      testen       => testen,
      rxdav        => rxdav,
      rxdataout    => rxdataout,
      loopback     => loopback
      );
  end generate;

  a3l : if (tech = apa3l) generate
    grspwc20 : grspwc2_proasic3l
    generic map (rmap, rmapcrc, fifosize1, fifosize2,
		 rxunaligned, rmapbufs, scantest, ports, dmachan,
		tech, input_type, output_type, rxtx_sameclk)
    port map(
      rst          => rst,
      clk          => clk,
      rxclk        => rxclk,
      txclk        => txclk,
      txclkn       => txclkn,
      --ahb mst in
      hgrant       => hgrant,
      hready       => hready,
      hresp        => hresp,
      hrdata       => hrdata,
      --ahb mst out
      hbusreq      => hbusreq,
      hlock        => hlock,
      htrans       => htrans,
      haddr        => haddr,
      hwrite       => hwrite,
      hsize        => hsize,
      hburst       => hburst,
      hprot        => hprot,
      hwdata       => hwdata,
      --apb slv in
      psel	   => psel,
      penable	   => penable,
      paddr	   => paddr,
      pwrite	   => pwrite,
      pwdata	   => pwdata,
      --apb slv out
      prdata       => prdata,
      --spw in
      d            => d,
      dv           => dv,
      dconnect  => dconnect,
      --spw out
      do           => do,
      so           => so,
      --time iface
      tickin       => tickin,
      tickinraw    => tickinraw,
      timein       => timein,
      tickindone   => tickindone,
      tickout      => tickout,
      tickoutraw   => tickoutraw,
      timeout      => timeout,
      --irq
      irq          => irq,
      --misc
      clkdiv10     => clkdiv10,
      --rmapen
      rmapen       => rmapen,
      --rx ahb fifo
      rxrenable    => rxrenable,
      rxraddress   => rxraddress,
      rxwrite      => rxwrite,
      rxwdata      => rxwdata,
      rxwaddress   => rxwaddress,
      rxrdata      => rxrdata,
      --tx ahb fifo
      txrenable    => txrenable,
      txraddress   => txraddress,
      txwrite      => txwrite,
      txwdata      => txwdata,
      txwaddress   => txwaddress,
      txrdata      => txrdata,
      --nchar fifo
      ncrenable    => ncrenable,
      ncraddress   => ncraddress,
      ncwrite      => ncwrite,
      ncwdata      => ncwdata,
      ncwaddress   => ncwaddress,
      ncrdata      => ncrdata,
      --rmap buf
      rmrenable    => rmrenable,
      rmraddress   => rmraddress,
      rmwrite      => rmwrite,
      rmwdata      => rmwdata,
      rmwaddress   => rmwaddress,
      rmrdata      => rmrdata,
      linkdis      => linkdis,
      testrst      => testrst,
      testen       => testen,
      rxdav        => rxdav,
      rxdataout    => rxdataout,
      loopback     => loopback
      );
  end generate;

-- pragma translate_off
  nonet : if not ((is_unisim(tech) = 1) or (tech = axcel) or 
	(tech = axdsp) or (tech = apa3) or (tech = apa3e) or (tech = apa3l)) generate
    err : process
    begin
      assert false report "ERROR : No GRSPWC2 netlist available for this process!"
      severity failure;
      wait;
    end process;
  end generate;

-- pragma translate_on

end architecture;
