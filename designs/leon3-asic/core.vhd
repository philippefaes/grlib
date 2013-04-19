-----------------------------------------------------------------------------
--  LEON3 Demonstration design
--  Copyright (C) 2004 Jiri Gaisler, Gaisler Research
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
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.stdlib.all;
library techmap;
use techmap.gencomp.all;
library gaisler;
use gaisler.misc.all;
use gaisler.jtag.all;
use work.config.all;

entity core is
  generic (
    fabtech   : integer := CFG_FABTECH;
    memtech   : integer := CFG_MEMTECH;
    padtech   : integer := CFG_PADTECH;
    clktech   : integer := CFG_CLKTECH;
    disas     : integer := CFG_DISAS;	-- Enable disassembly to console
    dbguart   : integer := CFG_DUART;	-- Print UART on console
    pclow     : integer := CFG_PCLOW;
    scantest  : integer := CFG_SCAN;
    bscanen   : integer := CFG_BOUNDSCAN_EN
  );
  port (
    resetn	: in  std_ulogic;
    clksel 	: in  std_logic_vector (1 downto 0);
    clk		: in  std_ulogic;
    errorn	: out std_ulogic;
    address 	: out std_logic_vector(27 downto 0);
    datain	: in std_logic_vector(31 downto 0);
    dataout	: out std_logic_vector(31 downto 0);
    dataen 	: out std_logic_vector(31 downto 0);
    cbin   	: in std_logic_vector(7 downto 0);
    cbout   	: out std_logic_vector(7 downto 0);
    cben   	: out std_logic_vector(7 downto 0);
    sdclk  	: out std_ulogic;
    sdcsn  	: out std_logic_vector (1 downto 0);    -- sdram chip select
    sdwen  	: out std_ulogic;                       -- sdram write enable
    sdrasn  	: out std_ulogic;                       -- sdram ras
    sdcasn  	: out std_ulogic;                       -- sdram cas
    sddqm   	: out std_logic_vector (3 downto 0);    -- sdram dqm
    dsutx  	: out std_ulogic; 			-- DSU tx data
    dsurx  	: in  std_ulogic;  			-- DSU rx data
    dsuen   	: in std_ulogic;
    dsubre  	: in std_ulogic;
    dsuact  	: out std_ulogic;
    txd1   	: out std_ulogic; 			-- UART1 tx data
    rxd1   	: in  std_ulogic;  			-- UART1 rx data
    txd2   	: out std_ulogic; 			-- UART2 tx data
    rxd2   	: in  std_ulogic;  			-- UART2 rx data
    ramsn  	: out std_logic_vector (4 downto 0);
    ramoen 	: out std_logic_vector (4 downto 0);
    rwen   	: out std_logic_vector (3 downto 0);
    oen    	: out std_ulogic;
    writen 	: out std_ulogic;
    read   	: out std_ulogic;
    iosn   	: out std_ulogic;
    romsn  	: out std_logic_vector (1 downto 0);
    brdyn  	: in  std_ulogic;
    bexcn  	: in  std_ulogic;
    wdogn  	: out std_ulogic;
    gpioin      : in std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0); 	-- I/O port
    gpioout     : out std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0); 	-- I/O port
    gpioen      : out std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0); 	-- I/O port
    prom32	: in  std_ulogic;
    promedac	: in  std_ulogic;

    spw_clksel 	: in  std_logic_vector (1 downto 0);
    spw_clk	: in  std_ulogic;
    spw_rxd     : in  std_logic_vector(0 to CFG_SPW_NUM-1);
    spw_rxs     : in  std_logic_vector(0 to CFG_SPW_NUM-1);
    spw_txd     : out std_logic_vector(0 to CFG_SPW_NUM-1);
    spw_txs     : out std_logic_vector(0 to CFG_SPW_NUM-1);
    spw_ten     : out std_logic_vector(0 to CFG_SPW_NUM-1);

    lclk2x      : in  std_ulogic;
    lclk4x      : in  std_ulogic;
    lclkdis     : out std_ulogic;
    lclklock    : in  std_ulogic;
    lock        : out std_ulogic;

    roen        : in  std_ulogic;
    roout       : out std_ulogic;

    testen 	: in  std_ulogic;
    gnd         : out std_ulogic;

    trst        : in std_ulogic;
    tck         : in std_ulogic;
    tms         : in std_ulogic;
    tdi         : in std_ulogic;
    tdo         : out std_ulogic
	);
end;

architecture rtl of core is

  constant OEPOL : integer := padoen_polarity(padtech);

  constant hzsup: integer := 0;
  
  signal lclk, lspw_clk, clklock : std_ulogic;
  signal llspw_clk, llclk : std_ulogic;
  signal scanen, testrst, testoen : std_ulogic;
  signal lgpioen : std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0);

  signal chain_tck, chain_tdi, chain_tdo, bsshft, bscapt, bsupdi, bsupdo, bsdrive, bshighz: std_ulogic;

  signal resetn_core, clk_core, errorn_core, sdclk_core, sdwen_core, sdrasn_core: std_ulogic;
  signal sdcasn_core, dsutx_core, dsurx_core, dsuen_core, dsubre_core, dsuact_core: std_ulogic;
  signal txd1_core, rxd1_core, txd2_core, rxd2_core, oen_core, writen_core, read_core: std_ulogic;
  signal iosn_core, brdyn_core, bexcn_core, wdogn_core, prom32_core, promedac_core: std_ulogic;
  signal spw_clk_core, lclk2x_core, lclk4x_core, lclkdis_core, lclklock_core, lock_core: std_ulogic;
  signal roen_core, roout_core: std_ulogic;

  signal clksel_core,sdcsn_core,romsn_core,spw_clksel_core: std_logic_vector(1 downto 0);
  signal sddqm_core,rwen_core: std_logic_vector(3 downto 0);
  signal ramsn_core, ramoen_core: std_logic_vector(4 downto 0);
  signal cbin_core,cbout_core,cben_core: std_logic_vector(7 downto 0);
  signal address_core: std_logic_vector(27 downto 0);
  signal datain_core,dataout_core,dataen_core: std_logic_vector(31 downto 0);
  signal gpioin_core,gpioout_core,gpioen_core: std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0);
  signal spw_rxd_core,spw_rxs_core,spw_txd_core,spw_txs_core,spw_ten_core: std_logic_vector(CFG_SPW_NUM-1 downto 0);
  
begin

  gnd <= '0';


  -- Scan test mux logic not connected boundary scan chain
  scanen <= dsubre when (testen = '1') else '0';
  testrst <= dsuen when (testen = '1') else '1'; 
  testoen <= dsurx;

  
  -- Clock muxing inside boundary scan chain  
  lclk <= clk_core     when clksel_core = "00" else
          spw_clk_core when clksel_core = "01" else
          lclk2x_core when clksel_core = "10" else lclk4x_core;
	
  lspw_clk <= clk_core when spw_clksel_core = "00" else
              spw_clk_core when spw_clksel_core = "01" else
              lclk2x_core  when spw_clksel_core = "10" else lclk4x_core;

  
  -- Clock override for scan test
  llclk <= clk when (testen = '1') else lclk;  
  llspw_clk <= clk when (testen = '1') else lspw_clk;

  lclkdis_core <= '1' when (testen = '1') or ((clksel_core(1) or spw_clksel_core(1)) = '0')
                  else '0';

  clklock <= '1' when (testen = '1') or ((clksel_core(1) or spw_clksel_core(1)) = '0')
    else lclklock_core;


  -- Clock outputs - through scan chain
  sdclk_core <= llclk;
  lock_core <= clklock;

  
  ringosc0 : ringosc generic map (fabtech) port map (roen_core, roout_core);

  gpioen_core <= lgpioen when (testen = '0') else (others => '0') when oepol = 1 
                 else (others => '1');

--  nandtree0 : nandtree generic map (fabtech, nandchain'length)
--	port map (nandchain, nandout, testen);
--
--  nandout <= nandtree(testen & brdyn & bexcn & roen & promedac & prom32 &
--	spw_clksel & clksel & spw_rxs & spw_rxd & resetn & rxd2 & rxd1 &
--	dsuen & dsubre & dsurx & datain & cbin & gpioin);

  bschain0: entity work.bschain
    generic map ( fabtech, bscanen, hzsup )
    port map (
      chain_tck, chain_tdi, chain_tdo, bsshft, bscapt, bsupdi, bsupdo, bsdrive, bshighz,

      resetn, clksel, clk, errorn, address, datain,
      dataout, dataen, cbin, cbout, cben,
      sdclk, sdcsn, sdwen, sdrasn, sdcasn, sddqm,
      dsutx, dsurx, dsuen, dsubre, dsuact,
      txd1, rxd1, txd2, rxd2, ramsn, ramoen,
      rwen, oen, writen, read, iosn, romsn, brdyn, bexcn,
      wdogn, gpioin, gpioout, gpioen, prom32, promedac,
      spw_clksel, spw_clk, spw_rxd, spw_rxs, spw_txd, spw_txs, spw_ten,
      lclk2x, lclk4x, lclkdis, lclklock, lock, roen, roout,
      
      resetn_core, clksel_core, clk_core, errorn_core, address_core, datain_core,
      dataout_core, dataen_core, cbin_core, cbout_core, cben_core,
      sdclk_core, sdcsn_core, sdwen_core, sdrasn_core, sdcasn_core, sddqm_core,
      dsutx_core, dsurx_core, dsuen_core, dsubre_core, dsuact_core,
      txd1_core, rxd1_core, txd2_core, rxd2_core, ramsn_core, ramoen_core,
      rwen_core, oen_core, writen_core, read_core, iosn_core, romsn_core, brdyn_core, bexcn_core,
      wdogn_core, gpioin_core, gpioout_core, gpioen_core, prom32_core, promedac_core,
      spw_clksel_core, spw_clk_core, spw_rxd_core, spw_rxs_core, spw_txd_core, spw_txs_core, spw_ten_core,
      lclk2x_core, lclk4x_core, lclkdis_core, lclklock_core, lock_core, roen_core, roout_core);
      
      
                 
  leon3core0 : entity work.leon3core
    generic map ( fabtech, memtech, padtech, clktech, disas, dbguart, 
		pclow, scantest*(1 - is_fpga(fabtech)))
  port map (
    resetn_core, clksel_core, llclk, clklock, errorn_core, 
    address_core, datain_core, dataout_core, dataen_core, cbin_core, cbout_core, cben_core, 
    sdcsn_core, sdwen_core, sdrasn_core, sdcasn_core, sddqm_core,
    dsutx_core, dsurx_core, dsuen_core, dsubre_core, dsuact_core,
    txd1_core, rxd1_core, txd2_core, rxd2_core,
    ramsn_core, ramoen_core, rwen_core, oen_core, writen_core, read_core, iosn_core, romsn_core, brdyn_core, bexcn_core,
    wdogn_core, gpioin_core, gpioout_core, lgpioen, prom32_core, promedac_core, spw_clksel_core,
    llspw_clk, spw_rxd_core, spw_rxs_core, spw_txd_core, spw_txs_core, spw_ten_core,
    trst, tck, tms, tdi, tdo,
    scanen, testen, testrst, testoen,
    chain_tck, chain_tdi, chain_tdo, bsshft, bscapt, bsupdi, bsupdo, bsdrive, bshighz);

end;
