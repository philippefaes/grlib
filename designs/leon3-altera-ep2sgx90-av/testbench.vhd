------------------------------------------------------------------------------
--  LEON3 Demonstration design test bench
--  Copyright (C) 2004 Jiri Gaisler, Aeroflex Gaisler
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
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library gaisler;
use gaisler.libdcom.all;
use gaisler.sim.all;
library techmap;
use techmap.gencomp.all;
library micron;
use micron.components.all;
library cypress;
use cypress.components.all;
library hynix;
use hynix.components.all;

use work.debug.all;

use work.config.all;	-- configuration

entity testbench is
  generic (
    fabtech   : integer := CFG_FABTECH;
    memtech   : integer := CFG_MEMTECH;
    padtech   : integer := CFG_PADTECH;
    clktech   : integer := CFG_CLKTECH;
    ncpu      : integer := CFG_NCPU;
    disas     : integer := CFG_DISAS;	-- Enable disassembly to console
    dbguart   : integer := CFG_DUART;	-- Print UART on console
    pclow     : integer := CFG_PCLOW;

    clkperiod : integer := 10;		-- system clock period
    romwidth  : integer := 8;		-- rom data width (8/32)
    romdepth  : integer := 21;		-- rom address depth
    sramwidth  : integer := 32;		-- ram data width (8/16/32)
    sramdepth  : integer := 20;		-- ram address depth
    srambanks  : integer := 4		-- number of ram banks
  );
end; 

architecture behav of testbench is

constant promfile  : string := "prom.srec";  -- rom contents
constant sramfile  : string := "ram.srec";  -- ram contents
constant sdramfile : string := "ram.srec"; -- sdram contents

signal clk : std_logic := '0';


signal clkout, pllref : std_ulogic;
signal Rst    : std_logic := '0';			-- Reset
constant ct : integer := clkperiod/2;

signal dsuen, dsutx, dsurx, dsuact : std_ulogic;
signal dsurst   : std_ulogic;
signal test     : std_ulogic;
signal error    : std_logic;
signal gpio	: std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0);
signal GND      : std_ulogic := '0';
signal VCC      : std_ulogic := '1';
signal NC       : std_ulogic := 'Z';
signal clk2     : std_ulogic := '1';
signal debugout : std_logic_vector(31 downto 0);
    

-- External Adress/data bus, flash+ssram
signal fs_addr      : std_logic_vector(24 downto 0);
signal fs_data      : std_logic_vector(31 downto 0);
signal io_cen       : std_logic;
signal flash_cen    : std_ulogic;
signal flash_oen    : std_ulogic;
signal flash_wen    : std_ulogic;

signal ssram_cen    : std_logic;
signal ssram_wen    : std_logic;
signal ssram_bw     : std_logic_vector (0 to 3);
signal ssram_oen    : std_ulogic;
signal ssram_clk    : std_ulogic;
signal ssram_adscn  : std_ulogic;
signal ssram_adspn : std_ulogic;
signal ssram_advn  : std_ulogic;
signal datazz       : std_logic_vector(3 downto 0);

signal flash_addr : std_logic_vector(romdepth downto 0);
-- muxed data bus
signal prd : std_logic_vector(31 downto 0);
signal ssd : std_logic_vector(31 downto 0);

  -- ddr memory  
signal ddr_clk  	: std_logic_vector(2 downto 0);
signal ddr_clkb  	: std_logic_vector(2 downto 0);
signal ddr_cke  	: std_logic_vector(1 downto 0);
signal ddr_csb  	: std_logic_vector(1 downto 0);
signal ddr_odt  	: std_logic_vector(1 downto 0);
signal ddr_web  	: std_ulogic;                       -- ddr write enable
signal ddr_rasb  	: std_ulogic;                       -- ddr ras
signal ddr_casb  	: std_ulogic;                       -- ddr cas
signal ddr_dm   	: std_logic_vector (7 downto 0);    -- ddr dm
signal ddr_dqs  	: std_logic_vector (7 downto 0);    -- ddr dqs
signal ddr_dqsn  	: std_logic_vector (7 downto 0);    -- ddr dqs
signal ddr_rdqs  	: std_logic_vector (7 downto 0);    -- ddr dqs
signal ddr_ad      : std_logic_vector (13 downto 0);   -- ddr address
signal ddr_ba      : std_logic_vector (1 downto 0);    -- ddr bank address
signal ddr_dq, ddr_dq2 : std_logic_vector (63 downto 0); -- ddr data

signal phy_gtx_clk  : std_logic;
signal phy_mii_data : std_logic;		-- ethernet PHY interface
signal phy_tx_clk   : std_ulogic;
signal phy_rx_clk   : std_ulogic;
signal phy_rx_data  : std_logic_vector(7 downto 0);   
signal phy_dv  	    : std_ulogic; 
signal phy_rx_er    : std_ulogic; 
signal phy_col 	    : std_ulogic;
signal phy_crs 	    : std_ulogic;
signal phy_tx_data  : std_logic_vector(7 downto 0);   
signal phy_tx_en    : std_ulogic; 
signal phy_tx_er    : std_ulogic; 
signal phy_mii_clk  : std_ulogic;

signal ft245_data  : std_logic_vector (7 downto 0);
signal ft245_rdn   : std_logic;
signal ft245_wr    : std_logic;
signal ft245_rxfn  : std_logic;
signal ft245_txen  : std_logic;
signal ft245_pwrenn : std_logic;

signal plllock    : std_ulogic;       
signal txd1, rxd1 : std_ulogic;       
--signal txd2, rxd2 : std_ulogic;       



constant lresp : boolean := false;

signal sa      	: std_logic_vector(14 downto 0);
signal sd   	: std_logic_vector(31 downto 0);


  component sram32 is
    generic (
      index : integer := 0;		-- Byte lane (0 - 3)
      abits: Positive := 10;		-- Default 10 address bits (1Kx32)
      echk : integer := 0;		-- Generate EDAC checksum
      tacc : integer := 10;		-- access time (ns)
      fname : string := "ram.dat");	-- File to read from
    port (  
      a : in std_logic_vector(abits-1 downto 0);
      d : inout std_logic_vector(31 downto 0);
      lb : in std_logic;
      ub : in std_logic;
      ce : in std_logic;
      we : in std_ulogic;
      oe : in std_ulogic);
  end component;     

begin

-- clock and reset
-- 100 MHz
  clk <= not clk after 5 ns;
  
  
--  ddr_clkin <= not clk after ct * 1 ns;
  rst <= dsurst;
  rxd1 <= '1';

--  ddr_dqs <= (others => 'L');
  d3 : entity work.leon3mp generic map (fabtech, memtech, padtech,  
	ncpu, disas, dbguart, pclow )
    port map (
      resetn => rst, 
      clk => clk,
      errorn => error, 
      fs_addr => fs_addr, 
      fs_data => fs_data, 
      io_cen => io_cen,
      flash_cen => flash_cen, 
      flash_oen => flash_oen, 
      flash_wen => flash_wen, 
      
      ssram_cen => ssram_cen, 
      ssram_wen => ssram_wen, 
      ssram_bw => ssram_bw, 
      ssram_oen => ssram_oen, 
      ssram_clk => ssram_clk, 
      ssram_adscn => ssram_adscn, 
      ssram_adspn => ssram_adspn, 
      ssram_advn => ssram_advn, 
      
      ddr_clk => ddr_clk,
      ddr_clkb => ddr_clkb,
      ddr_cke => ddr_cke,
      ddr_csb => ddr_csb,
      ddr_odt => ddr_odt,
      ddr_web => ddr_web,                       -- ddr write enable
      ddr_rasb => ddr_rasb,                       -- ddr ras

      ddr_casb => ddr_casb,                       -- ddr cas
      ddr_dm => ddr_dm,    -- ddr dm
      ddr_dqs => ddr_dqs,    -- ddr dqs
      ddr_ad => ddr_ad,   -- ddr address
      ddr_ba => ddr_ba,    -- ddr bank address
      ddr_dq => ddr_dq, -- ddr data

      phy_gtx_clk => phy_gtx_clk,
      phy_mii_data => phy_mii_data,
      phy_tx_clk =>  phy_tx_clk,
      phy_rx_clk => phy_rx_clk,
      phy_rx_data => phy_rx_data,
      phy_dv  	 =>  phy_dv,
      phy_rx_er	 => phy_rx_er,
      phy_col 	 =>  phy_col,
      phy_crs 	 => phy_crs,
      phy_tx_data => phy_tx_data,
      phy_tx_en => phy_tx_en,
      phy_tx_er => phy_tx_er,
      phy_mii_clk => phy_mii_clk,
	
      dsuact => dsuact, 
      rxd1 => rxd1, 
      txd1 => txd1, 
      gpio => gpio,

      ft245_data => ft245_data,
      ft245_rdn => ft245_rdn,
      ft245_wr => ft245_wr, 
      ft245_rxfn => ft245_rxfn, 
      ft245_txen => ft245_txen,
      ft245_pwrenn => ft245_pwrenn
    );




  datazz <= "HHHH";

  ssram0 : cy7c1380d generic map (fname => sramfile)
   port map(
      ioDq(35 downto 32) => datazz, ioDq(31 downto 0) => fs_data,
      iAddr => fs_addr(19 downto 1), iMode =>  gnd, 
      inGW => vcc, inBWE => ssram_wen, inADV => ssram_advn,
      inADSP => ssram_adspn, inADSC => ssram_adscn,
      iClk => ssram_clk, 
      inBwa => ssram_bw(3), inBwb => ssram_bw(2), 
      inBwc => ssram_bw(1), inBwd => ssram_bw(0),
      inOE => ssram_oen, inCE1 => ssram_cen, 
      iCE2 => vcc, inCE3 => gnd, iZz => gnd);

  -- 16 bit prom
  flash_addr <= '0'&fs_addr(romdepth-1 downto 0);
  prom0 : sram16 generic map (index => 4, abits => romdepth, fname => promfile)
	port map (a => flash_addr(romdepth-1 downto 0), d => fs_data(31 downto 16), lb => '0', ub => '0',
		  ce => flash_cen, we => flash_wen, oe => flash_oen);
--  prd(23 downto 0) <= (others => '0');
  
  -- data mux
--  fs_data <= ssd when ssram_oen='0' and ssram_cen='0' else
--             prd when flash_oen='0' and flash_cen='0' else
--             (others => 'Z');
--  data <= buskeep(data), (others => 'H') after 250 ns;

  test0 :  grtestmod
    port map ( rst, clk, error, fs_addr(20 downto 1), fs_data,
    	       io_cen, flash_oen, flash_wen, open);

  error <= 'H';			  -- ERROR pull-up


  ddr2delay : delay_wire 
    generic map(data_width => ddr_dq'length, delay_atob => 0.0, delay_btoa => 2.5)
    port map(a => ddr_dq, b => ddr_dq2);


  --DDR2
  ddr2mem : for i in 0 to 3 generate
    u1 : HY5PS121621F
      generic map (TimingCheckFlag => false, PUSCheckFlag => false,
                   index => 3-i, fname => sdramfile)
      port map (DQ => ddr_dq2(i*16+15 downto i*16), LDQS  => ddr_dqs(i*2),
                LDQSB => ddr_dqsn(i*2), UDQS => ddr_dqs(i*2+1),
                UDQSB => ddr_dqsn(i*2+1), LDM => ddr_dm(i*2),
                WEB => ddr_web, CASB => ddr_casb, RASB  => ddr_rasb, CSB => ddr_csb(0),
                BA => ddr_ba, ADDR => ddr_ad(12 downto 0), CKE => ddr_cke(0),
                CLK => ddr_clk(0), CLKB => ddr_clkb(0), UDM => ddr_dm(i*2+1));

--    PORT MAP(
--      ck => ddr_clk(0), ck_n => ddr_clkb(0), cke => ddr_cke(0), cs_n => ddr_csb(0),
--      ras_n => ddr_rasb, cas_n => ddr_casb, we_n => ddr_web, 
--      dm_rdqs => ddr_dm(i*2+1 downto i*2), ba => ddr_ba,
--      addr => ddr_ad(12 downto 0), dq => ddr_dq(i*16+15 downto i*16),
--      dqs => ddr_dqs(i*2+1 downto i*2), dqs_n => ddr_dqsn(i*2+1 downto i*2),
--      rdqs_n => ddr_rdqs(i*2+1 downto i*2), odt => ddr_odt(0));
  end generate;

--  ddr_dq <= buskeep(ddr_dq), (others => 'H') after 250 ns;
  ddr_dqsn <= (others => 'U');
  
   iuerr : process
   begin
     wait for 2500 ns;
     if to_x01(error) = '1' then wait on error; end if;
     assert (to_x01(error) = '1') 
       report "*** IU in error mode, simulation halted ***"
         severity failure ;
   end process;

  sd <= buskeep(sd), (others => 'H') after 250 ns;



  dsucom : process
    procedure dsucfg(signal dsurx : in std_ulogic; signal dsutx : out std_ulogic) is
    variable w32 : std_logic_vector(31 downto 0);
    variable c8  : std_logic_vector(7 downto 0);
    constant txp : time := 160 * 1 ns;
    begin
    dsutx <= '1';
    dsurst <= '0';
    wait for 500 ns;
    dsurst <= '1';
    wait;
    wait for 5000 ns;
    txc(dsutx, 16#55#, txp);		-- sync uart

--    txc(dsutx, 16#c0#, txp);
--    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#00#, txp);
--    txa(dsutx, 16#00#, 16#00#, 16#02#, 16#ae#, txp);
--    txc(dsutx, 16#c0#, txp);
--    txa(dsutx, 16#91#, 16#00#, 16#00#, 16#00#, txp);
--    txa(dsutx, 16#00#, 16#00#, 16#06#, 16#ae#, txp);
--    txc(dsutx, 16#c0#, txp);
--    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#24#, txp);
--    txa(dsutx, 16#00#, 16#00#, 16#06#, 16#03#, txp);
--    txc(dsutx, 16#c0#, txp);
--    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#20#, txp);
--    txa(dsutx, 16#00#, 16#00#, 16#06#, 16#fc#, txp);

    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#00#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#2f#, txp);
    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#91#, 16#00#, 16#00#, 16#00#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#6f#, txp);
    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#11#, 16#00#, 16#00#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#00#, txp);
    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#40#, 16#00#, 16#04#, txp);
    txa(dsutx, 16#00#, 16#02#, 16#20#, 16#01#, txp);
    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#20#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#02#, txp);

    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#20#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#0f#, txp);

    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#40#, 16#00#, 16#43#, 16#10#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#0f#, txp);

    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#91#, 16#40#, 16#00#, 16#24#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#24#, txp);
    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#91#, 16#70#, 16#00#, 16#00#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#03#, txp);





    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#20#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#ff#, 16#ff#, txp);

    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#40#, 16#00#, 16#48#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#00#, 16#12#, txp);

    txc(dsutx, 16#c0#, txp);
    txa(dsutx, 16#90#, 16#40#, 16#00#, 16#60#, txp);
    txa(dsutx, 16#00#, 16#00#, 16#12#, 16#10#, txp);

    txc(dsutx, 16#80#, txp);
    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#00#, txp);
    rxi(dsurx, w32, txp, lresp);

    txc(dsutx, 16#a0#, txp);
    txa(dsutx, 16#40#, 16#00#, 16#00#, 16#00#, txp);
    rxi(dsurx, w32, txp, lresp);

    end;

  begin

    dsucfg(dsutx, dsurx);

    wait;
  end process;
end ;

