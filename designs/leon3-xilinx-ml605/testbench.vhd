-----------------------------------------------------------------------------
--  LEON3 Demonstration design test bench
--  Copyright (C) 2004 Jiri Gaisler, Gaisler Research
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
use micron.all;
use work.debug.all;

use work.config.all;
use work.ml605.all;

entity testbench is
  generic (
    fabtech   : integer := CFG_FABTECH;
    memtech   : integer := CFG_MEMTECH;
    padtech   : integer := CFG_PADTECH;
    disas     : integer := CFG_DISAS;   -- Enable disassembly to console
    dbguart   : integer := CFG_DUART;   -- Print UART on console
    pclow     : integer := CFG_PCLOW;
    clkperiod : integer := 37
    );
end;

architecture behav of testbench is

-- DDR3 Simulation parameters
constant SIM_BYPASS_INIT_CAL : string := "FAST";
          -- # = "OFF" -  Complete memory init &
          --               calibration sequence
          -- # = "SKIP" - Not supported
          -- # = "FAST" - Complete memory init & use
          --              abbreviated calib sequence


  constant promfile  : string  := "prom.srec";        -- rom contents
  constant sdramfile : string  := "sdram.srec";       -- sdram contents

  constant lresp    : boolean := false;
  constant ct       : integer := clkperiod/2;

  signal clk        : std_logic := '0';
  signal clk200p    : std_logic := '1';
  signal clk200n    : std_logic := '0';
  signal rst        : std_logic := '0';
  signal rstn1      : std_logic;
  signal rstn2      : std_logic;
  signal error      : std_logic;

  -- PROM flash
  signal address    : std_logic_vector(24 downto 0);
  signal data       : std_logic_vector(15 downto 0);
  signal romsn      : std_logic;
  signal oen        : std_ulogic;
  signal writen     : std_ulogic;
  signal iosn       : std_ulogic;

  -- DDR3 memory

  signal ddr3_dq       : std_logic_vector(DQ_WIDTH-1 downto 0);
  signal ddr3_dm       : std_logic_vector(DM_WIDTH-1 downto 0);
  signal ddr3_addr     : std_logic_vector(ROW_WIDTH-1 downto 0);
  signal ddr3_ba       : std_logic_vector(BANK_WIDTH-1 downto 0);
  signal ddr3_ras_n    : std_logic;
  signal ddr3_cas_n    : std_logic;
  signal ddr3_we_n     : std_logic;
  signal ddr3_reset_n  : std_logic;
  signal ddr3_cs_n     : std_logic_vector((CS_WIDTH*nCS_PER_RANK)-1 downto 0);
  signal ddr3_odt      : std_logic_vector((CS_WIDTH*nCS_PER_RANK)-1 downto 0);
  signal ddr3_cke      : std_logic_vector(CKE_WIDTH-1 downto 0);
  signal ddr3_dqs_p    : std_logic_vector(DQS_WIDTH-1 downto 0);
  signal ddr3_dqs_n    : std_logic_vector(DQS_WIDTH-1 downto 0);
  signal ddr3_tdqs_n   : std_logic_vector(DQS_WIDTH-1 downto 0);
  signal ddr3_ck_p     : std_logic_vector(CK_WIDTH-1 downto 0);
  signal ddr3_ck_n     : std_logic_vector(CK_WIDTH-1 downto 0);

  
  -- Debug support unit
  signal dsubre     : std_ulogic;

  -- AHB Uart
  signal dsurx      : std_ulogic;
  signal dsutx      : std_ulogic;

  -- APB Uart
  signal urxd       : std_ulogic;
  signal utxd       : std_ulogic;

  -- Ethernet signals
  signal etx_clk    : std_ulogic;
  signal erx_clk    : std_ulogic;
  signal erxdt      : std_logic_vector(7 downto 0);
  signal erx_dv     : std_ulogic;
  signal erx_er     : std_ulogic;
  signal erx_col    : std_ulogic;
  signal erx_crs    : std_ulogic;
  signal etxdt      : std_logic_vector(7 downto 0);
  signal etx_en     : std_ulogic;
  signal etx_er     : std_ulogic;
  signal emdc       : std_ulogic;
  signal emdio      : std_logic;
  signal emdint     : std_logic;
  signal egtx_clk   : std_logic;
  signal gmiiclk_p  : std_logic := '1';
  signal gmiiclk_n  : std_logic := '0';

  -- Output signals for LEDs
  signal led       : std_logic_vector(6 downto 0);

signal iic_scl_main, iic_sda_main : std_logic;
signal iic_scl_dvi, iic_sda_dvi : std_logic;
signal tft_lcd_data    : std_logic_vector(11 downto 0);
signal tft_lcd_clk_p   : std_logic;
signal tft_lcd_clk_n   : std_logic;
signal tft_lcd_hsync   : std_logic;
signal tft_lcd_vsync   : std_logic;
signal tft_lcd_de      : std_logic;
signal tft_lcd_reset_b : std_logic;
signal sysace_mpa      : std_logic_vector(6 downto 0);
signal sysace_mpce     : std_ulogic;
signal sysace_mpirq    : std_ulogic;
signal sysace_mpoe     : std_ulogic;
signal sysace_mpwe     : std_ulogic;
signal sysace_d        : std_logic_vector(7 downto 0);
signal clk_33          : std_ulogic := '0';

  signal brdyn     : std_ulogic;

component ddr3_model is
  port (
     	rst_n	: in    std_logic;
     	ck	: in    std_logic;
     	ck_n	: in    std_logic;
     	cke	: in    std_logic;
     	cs_n	: in    std_logic;
     	ras_n	: in    std_logic;
     	cas_n	: in    std_logic;
     	we_n	: in    std_logic;
     	dm_tdqs : inout std_logic_vector(1 downto 0);
     	ba	: in    std_logic_vector(2 downto 0);
     	addr	: in    std_logic_vector(12 downto 0);
     	dq	: inout std_logic_vector(15 downto 0);
     	dqs	: inout std_logic_vector(1 downto 0);
     	dqs_n	: inout std_logic_vector(1 downto 0);
     	tdqs_n  : out   std_logic_vector(1 downto 0);
     	odt	: in    std_logic
   );
end component ddr3_model;


begin
  -- clock and reset
  clk        <= not clk after ct * 1 ns;
  clk200p    <= not clk200p after 2.5 ns;
  clk200n    <= not clk200n after 2.5 ns;
  gmiiclk_p    <= not gmiiclk_p after 4 ns;
  gmiiclk_n    <= not gmiiclk_n after 4 ns;
  clk_33       <= not clk_33 after 15 ns;
  rst        <= '1', '0' after 200 us;
  rstn1      <= not rst;
  dsubre     <= '0';
  urxd       <= 'H';
  
  d3 : entity work.leon3mp
    generic map (fabtech, memtech, padtech, disas, dbguart, pclow,
                 SIM_BYPASS_INIT_CAL)
    port map (
      reset     => rst,
      errorn    => error,
      clk_ref_p    => clk200p,
      clk_ref_n    => clk200n,

      -- PROM
      address   => address(24 downto 1),
      data      => data(15 downto 0),
      romsn     => romsn,
      oen       => oen,
      writen    => writen,

      -- DDR3
      ddr3_dq       => ddr3_dq,
      ddr3_dm       => ddr3_dm,
      ddr3_addr     => ddr3_addr,
      ddr3_ba       => ddr3_ba,
      ddr3_ras_n    => ddr3_ras_n,
      ddr3_cas_n    => ddr3_cas_n,
      ddr3_we_n     => ddr3_we_n,
      ddr3_reset_n  => ddr3_reset_n,
      ddr3_cs_n     => ddr3_cs_n,
      ddr3_odt      => ddr3_odt,
      ddr3_cke      => ddr3_cke,
      ddr3_dqs_p    => ddr3_dqs_p,
      ddr3_dqs_n    => ddr3_dqs_n,
      ddr3_ck_p     => ddr3_ck_p,
      ddr3_ck_n     => ddr3_ck_n,
      
      -- Debug Unit
      dsubre    => dsubre,

      -- AHB Uart
      dsutx     => dsutx,
      dsurx     => dsurx,

      -- PHY
      gmiiclk_p  => gmiiclk_p,
      gmiiclk_n  => gmiiclk_n,
      egtx_clk  => egtx_clk,
      etx_clk   => etx_clk,
      erx_clk   => erx_clk,
      erxd      => erxdt(7 downto 0),
      erx_dv    => erx_dv,
      erx_er    => erx_er,
      erx_col   => erx_col,
      erx_crs   => erx_crs,
      emdint    => emdint,
      etxd      => etxdt(7 downto 0),
      etx_en    => etx_en,
      etx_er    => etx_er,
      emdc      => emdc,
      emdio     => emdio,

      -- Output signals for LEDs
        iic_scl_main => iic_scl_main, 
	iic_sda_main => iic_sda_main,
        dvi_iic_scl => iic_scl_dvi, 
	dvi_iic_sda => iic_sda_dvi,
        tft_lcd_data => tft_lcd_data, 
	tft_lcd_clk_p => tft_lcd_clk_p, 
	tft_lcd_clk_n => tft_lcd_clk_n, 
	tft_lcd_hsync => tft_lcd_hsync,
        tft_lcd_vsync => tft_lcd_vsync, 
	tft_lcd_de => tft_lcd_de, 
	tft_lcd_reset_b => tft_lcd_reset_b,
        clk_33 => clk_33, 
        sysace_mpa => sysace_mpa, 
	sysace_mpce => sysace_mpce, 
	sysace_mpirq => sysace_mpirq, 
	sysace_mpoe => sysace_mpoe,
        sysace_mpwe => sysace_mpwe, 
	sysace_d => sysace_d,
        led => led
      );

  gen_mem: for i in 0 to 3 generate
    u1: ddr3_model port map
      (
    	rst_n	=> ddr3_reset_n,
    	ck	=> ddr3_ck_p(0),
    	ck_n	=> ddr3_ck_n(0),
    	cke	=> ddr3_cke(0),
    	cs_n	=> ddr3_cs_n(0),
    	ras_n	=> ddr3_ras_n,
    	cas_n	=> ddr3_cas_n,
    	we_n	=> ddr3_we_n,
    	dm_tdqs => ddr3_dm((2*(i+1)-1) downto (i*2)),
    	ba	=> ddr3_ba,
    	addr	=> ddr3_addr,
    	dq	=> ddr3_dq((16*i+15) downto (16*i)),
    	dqs	=> ddr3_dqs_p((2*(i+1)-1) downto (i*2)),
    	dqs_n	=> ddr3_dqs_n((2*(i+1)-1) downto (i*2)),
    	tdqs_n  => ddr3_tdqs_n((2*(i+1)-1) downto (i*2)),
    	odt	=> ddr3_odt(0));
  end generate gen_mem;

--  prom0 : sram
--    generic map (index => 6, abits => 24, fname => promfile)
--    port map (address(23 downto 0), data(31 downto 24), romsn, writen, oen);

  address(0) <= '0';
  prom0 : for i in 0 to 1 generate
      sr0 : sram generic map (index => i+4, abits => 24, fname => promfile)
        port map (address(24 downto 1), data(15-i*8 downto 8-i*8), romsn,
                  writen, oen);
  end generate;

  phy0 : if (CFG_GRETH = 1) generate
    emdio <= 'H';
    p0: phy
      generic map (address => 7)
      port map(rstn1, emdio, etx_clk, erx_clk, erxdt, erx_dv, erx_er,
               erx_col, erx_crs, etxdt, etx_en, etx_er, emdc, egtx_clk);
  end generate;

--  spimem0: if CFG_SPIMCTRL = 1 generate
--    s0 : spi_flash generic map (ftype => 4, debug => 0, fname => promfile,
--                                readcmd => CFG_SPIMCTRL_READCMD,
--                                dummybyte => CFG_SPIMCTRL_DUMMYBYTE,
--                                dualoutput => 0)  -- Dual output is not supported in this design
--      port map (spi_clk, spi_mosi, data(24), spi_sel_n);
--  end generate spimem0;

  error <= 'H';                         -- ERROR pull-up

  iuerr : process
  begin
     wait for 210 us; -- This is for proper DDR3 behaviour durign init phase not needed durin simulation
     wait on led(3);  -- DDR3 Memory Init ready
     wait for 5000 ns;
    assert (to_X01(error) = '1')
      report "*** IU in error mode, simulation halted ***"
      severity failure;
  end process;

  data <= buskeep(data) after 5 ns;

  dsucom : process
    procedure dsucfg(signal dsurx : in std_ulogic; signal dsutx : out std_ulogic) is
      variable w32 : std_logic_vector(31 downto 0);
      variable c8  : std_logic_vector(7 downto 0);
      constant txp : time := 160 * 1 ns;
    begin
      dsutx  <= '1';
      wait;
      wait for 5000 ns;
      txc(dsutx, 16#55#, txp);          -- sync uart
      txc(dsutx, 16#a0#, txp);
      txa(dsutx, 16#40#, 16#00#, 16#00#, 16#00#, txp);
      rxi(dsurx, w32, txp, lresp);

-- txc(dsutx, 16#c0#, txp);
-- txa(dsutx, 16#90#, 16#00#, 16#00#, 16#00#, txp);
-- txa(dsutx, 16#00#, 16#00#, 16#00#, 16#ef#, txp);
--
-- txc(dsutx, 16#c0#, txp);
-- txa(dsutx, 16#90#, 16#00#, 16#00#, 16#20#, txp);
-- txa(dsutx, 16#00#, 16#00#, 16#ff#, 16#ff#, txp);
--
-- txc(dsutx, 16#c0#, txp);
-- txa(dsutx, 16#90#, 16#40#, 16#00#, 16#48#, txp);
-- txa(dsutx, 16#00#, 16#00#, 16#00#, 16#12#, txp);
--
-- txc(dsutx, 16#c0#, txp);
-- txa(dsutx, 16#90#, 16#40#, 16#00#, 16#60#, txp);
-- txa(dsutx, 16#00#, 16#00#, 16#12#, 16#10#, txp);
--
-- txc(dsutx, 16#80#, txp);
-- txa(dsutx, 16#90#, 16#00#, 16#00#, 16#00#, txp);
-- rxi(dsurx, w32, txp, lresp);
    end;
  begin
    dsucfg(dsutx, dsurx);
    wait;
  end process;
end;


