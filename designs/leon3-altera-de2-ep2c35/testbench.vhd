------------------------------------------------------------------------------
--  LEON3 Demonstration design test bench
--  Copyright (C) 2004 Jiri Gaisler, Gaisler Research
------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2010, Aeroflex Gaisler
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
use work.debug.all;
library techmap;
use techmap.gencomp.all;
library micron; --removed original SDRAM memory
use micron.components.all;
library grlib;
use grlib.stdlib.all;

use work.config.all;	-- configuration


entity testbench is
  generic (
    fabtech   : integer := CFG_FABTECH;
    memtech   : integer := CFG_MEMTECH;
    padtech   : integer := CFG_PADTECH;
    clktech   : integer := CFG_CLKTECH;
    disas     : integer := CFG_DISAS;	-- Enable disassembly to console
    dbguart   : integer := CFG_DUART;	-- Print UART on console
    pclow     : integer := CFG_PCLOW;

    clkperiod : integer := 20;		-- system clock period
    romdepth  : integer := 22		-- rom address depth (flash 4 MB)
 --   sramwidth  : integer := 32;		-- ram data width (8/16/32)
 --   sramdepth  : integer := 20;		-- ram address depth
 --   srambanks  : integer := 2		-- number of ram banks
  );
end; 

architecture behav of testbench is

constant promfile  : string := "prom.srec";  -- rom contents
constant sramfile  : string := "sram.srec";  -- ram contents
constant sdramfile : string := "sdram.srec"; -- sdram contents

signal clk : std_logic := '0';
signal Rst    : std_logic := '0';			-- Reset
constant ct : integer := clkperiod/2;

signal address  : std_logic_vector(21 downto 0);
signal data     : std_logic_vector(31 downto 24);

--signal ramsn    : std_logic_vector(4 downto 0);
--signal ramoen   : std_logic_vector(4 downto 0);
--signal rwen     : std_logic_vector(3 downto 0);
--signal rwenx    : std_logic_vector(3 downto 0);
signal romsn    : std_logic;
--signal iosn     : std_logic; --grtestmod (finns ingen annanstans)
signal oen      : std_logic;
--signal read     : std_logic;
signal writen   : std_logic;
--signal brdyn    : std_logic; --grtestmod (finns ingen annanstans)
--signal bexcn    : std_logic;
signal dsuen, dsutx, dsurx, dsubre, dsuact : std_logic;
signal dsurst   : std_logic;
--signal test     : std_logic;
signal error    : std_logic;
signal gpio_0	: std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0);
signal gpio_1	: std_logic_vector(CFG_GRGPIO2_WIDTH-1 downto 0);
--signal GND      : std_logic := '0';
--signal VCC      : std_logic := '1';
--signal NC       : std_logic := 'Z';
--signal clk2     : std_logic := '1';
    
signal sdcke    : std_logic;
signal sdcsn    : std_logic;
signal sdwen    : std_logic;                       -- write en
signal sdrasn   : std_logic;                       -- row addr stb
signal sdcasn   : std_logic;                       -- col addr stb
--signal sddqm    : std_logic_vector ( 3 downto 0);  -- data i/o mask (32 bit)
signal dram_ldqm : std_logic;
signal dram_udqm : std_logic;
signal sdclk    : std_logic;       
--signal plllock    : std_logic;       
--signal txd1, rxd1 : std_logic;
signal sw : std_logic_vector(0 to 2);      

--signal etx_clk, erx_clk, erx_dv, erx_er, erx_col : std_logic := '0';
--signal eth_gtxclk, erx_crs, etx_en, etx_er : std_logic :='0';
--signal eth_macclk  : std_logic := '0';
--signal erxd, etxd  : std_logic_vector(7 downto 0) := (others => '0');  
--signal emdc, emdio : std_logic; --dummy signal for the mdc,mdio in the phy which is not used
--signal emdintn     : std_logic := '1';

--signal emddis 	: std_logic;    
--signal epwrdwn 	: std_logic;
--signal ereset 	: std_logic;
--signal esleep 	: std_logic;
--signal epause 	: std_logic;

signal ps2_clk       : std_logic;
signal ps2_dat       : std_logic;
signal vga_clk       : std_ulogic;
signal vga_blank     : std_ulogic;
signal vga_sync      : std_ulogic;
signal vga_hs        : std_ulogic;
signal vga_vs        : std_ulogic;
signal vga_r         : std_logic_vector(9 downto 0);
signal vga_g         : std_logic_vector(9 downto 0);
signal vga_b         : std_logic_vector(9 downto 0); 


constant lresp : boolean := false;


signal sa      	: std_logic_vector(13 downto 0);
signal sd   	: std_logic_vector(15 downto 0);

--signals for 32 bit
--signal sa     : std_logic_vector(14 downto 0);
--signal sd   	: std_logic_vector(31 downto 0);

--signal can_txd	: std_logic_vector(0 to CFG_CAN_NUM-1);
--signal can_rxd	: std_logic_vector(0 to CFG_CAN_NUM-1);
--signal can_stb	: std_logic_vector(0 to CFG_CAN_NUM-1);

begin

  clk <= not clk after ct * 1 ns; --50 MHz clk 
  rst <= dsurst; --reset
  dsuen <= '1'; --onödig egenligen
  dsubre <= '1'; -- inverted on the board
  sw(0) <= '1';
--  rxd1 <= '1';                              --används inte någonstans
--  can_rxd <= (others => 'H'); bexcn <= '1'; --ta bort? vi har inte can och bexcn används inte någonstans.
  --gpio_0(2 downto 0) <= "LHL"; --varför? bara inputs till GPIO.
  gpio_0(CFG_GRGPIO_WIDTH-1 downto 0) <= (others => 'H');
  --gpio_1(2 downto 0) <= "LHL"; --varför? bara inputs till GPIO.
  gpio_1(CFG_GRGPIO2_WIDTH-1 downto 0) <= (others => 'H');
--  eth_macclk <= not eth_macclk after 4 ns;  --används inte eftersom vi inte har ethernet
  
--dsutx, dsurx (debug support tx,rx)
--dsubre, dsuact: key1, led1
  d3 : entity work.leon3mp
        generic map ( fabtech, memtech, padtech, clktech, disas, dbguart, pclow )
        port map (rst, clk, error, address(21 downto 0), data, 
	sa(11 downto 0), sa(12), sa(13), sd, sdclk, sdcke, sdcsn, sdwen, 
	sdrasn, sdcasn, dram_ldqm, dram_udqm, dsutx, dsurx, dsubre, dsuact,
	oen, writen, open, romsn, open, open, open, open, open, open, gpio_0, gpio_1,
        ps2_clk, ps2_dat, vga_clk, vga_blank, vga_sync, vga_hs, vga_vs, vga_r,
        vga_g, vga_b, sw);
  sd1 : if (CFG_SDCTRL = 1) generate
    u1: entity work.mt48lc16m16a2 generic map (addr_bits => 12, col_bits => 8, index => 1024, fname => sdramfile)
	PORT MAP(
            Dq => sd(15 downto 0), Addr => sa(11 downto 0),
            Ba => sa(13 downto 12), Clk => sdclk, Cke => sdcke,
            Cs_n => sdcsn, Ras_n => sdrasn, Cas_n => sdcasn, We_n => sdwen,
            Dqm(0) => dram_ldqm, Dqm(1) => dram_udqm );
  end generate;

  prom0 : sram generic map (index => 6, abits => romdepth, fname => promfile) --detta är flashen
	port map (address(romdepth-1 downto 0), data(31 downto 24), romsn,
		  writen, oen);

--  sram0 : for i in 0 to (sramwidth/8)-1 generate
--      sr0 : sram generic map (index => i, abits => sramdepth, fname => sramfile)
--	port map (address(sramdepth+1 downto 2), data(31-i*8 downto 24-i*8), ramsn(0),
--		  rwen(0), ramoen(0));
--  end generate;

 
--  phy0 : if (CFG_GRETH = 1) generate --ta bort pga vi inte har ethernet?
--    emdio <= 'H'; 
--    p0: phy
--      generic map(address => 16)
--      port map(rst, emdio, etx_clk, erx_clk, erxd, erx_dv,
--        erx_er, erx_col, erx_crs, etxd, etx_en, etx_er, emdc, eth_macclk);
--  end generate;
--error aktiv låg från DSU eller P. 0 eller 1 overridar weak signals.
  error <= 'H';			  -- ERROR pull-up (H and L is weak 1 or 0)

   iuerr : process --väntar på errors och skriver ut den. Ahb rep skriver ut grejjer emellan.
   begin --to_x01 converts H and L to 1 and 0, respectively!!
     wait for 2500 ns;
     if to_x01(error) = '1' then wait on error; end if; --w8 4 change
     assert (to_x01(error) = '1') 
       report "*** IU in error mode, simulation halted ***"
         severity failure ;
   end process;

--  test0 :  grtestmod --(AHB rep i leon3mb har liknande funkton. Därför används den inte här)
--    port map ( rst, clk, error, address(21 downto 2), data,
--    	       iosn, oen, writen, brdyn);

--  data <= buskeep(data), (others => 'H') after 250 ns;
  data <= buskeep(data) after 5 ns; --delayar effekt av tillelning
--  sd <= buskeep(sd), (others => 'H') after 250 ns;
  sd <= buskeep(sd) after 5 ns;

  dsucom : process
    procedure dsucfg(signal dsurx : in std_logic; signal dsutx : out std_logic) is
    variable w32 : std_logic_vector(31 downto 0);
    variable c8  : std_logic_vector(7 downto 0);
    constant txp : time := 160 * 1 ns;
    begin
    dsutx <= '1';
    dsurst <= '0'; --reset low
    wait for 500 ns;
    dsurst <= '1'; --reset high
    wait; --evig w8
    wait for 5000 ns;
    txc(dsutx, 16#55#, txp);		-- sync uart (troligen samma funktion som prom.s men via debug.
--dvs boot för processor.

--    txc(dsutx, 16#c0#, txp); --control byte
--    txa(dsutx, 16#90#, 16#00#, 16#00#, 16#00#, txp); --adress
--    txa(dsutx, 16#00#, 16#00#, 16#02#, 16#ae#, txp); --write data
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

