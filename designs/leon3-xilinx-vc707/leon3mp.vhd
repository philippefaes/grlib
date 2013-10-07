-----------------------------------------------------------------------------
--  LEON3 Xilinx VC707 Demonstration design
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
library grlib, techmap;
use grlib.amba.all;
use grlib.stdlib.all;
use techmap.gencomp.all;
use techmap.allclkgen.all;
library gaisler;
use gaisler.memctrl.all;
use gaisler.leon3.all;
use gaisler.uart.all;
use gaisler.misc.all;
use gaisler.i2c.all;
use gaisler.spi.all;
use gaisler.net.all;
use gaisler.jtag.all;
use gaisler.grusb.all;
use gaisler.can.all;
-- pragma translate_off
use gaisler.sim.all;
library unisim;
use unisim.all;
-- pragma translate_on


library esa;
use esa.memoryctrl.all;

use work.config.all;

entity leon3mp is
  generic (
    fabtech             : integer := CFG_FABTECH;
    memtech             : integer := CFG_MEMTECH;
    padtech             : integer := CFG_PADTECH;
    clktech             : integer := CFG_CLKTECH;
    disas               : integer := CFG_DISAS;   -- Enable disassembly to console
    dbguart             : integer := CFG_DUART;   -- Print UART on console
    pclow               : integer := CFG_PCLOW;
    testahb             : boolean := false;
    SIM_BYPASS_INIT_CAL : string := "OFF";
    SIMULATION          : string := "FALSE";
    USE_MIG_INTERFACE_MODEL : boolean := false;
    autonegotiation     : integer := 1
  );
  port (
    reset           : in    std_ulogic;
    clk200p         : in    std_ulogic;  -- 200 MHz clock
    clk200n         : in    std_ulogic;  -- 200 MHz clock
    address         : out   std_logic_vector(25 downto 0);
    data            : inout std_logic_vector(15 downto 0);
    oen             : out   std_ulogic;
    writen          : out   std_ulogic;
    romsn           : out   std_logic;
    adv             : out   std_logic;
    ddr3_dq         : inout std_logic_vector(63 downto 0);
    ddr3_dqs_p      : inout std_logic_vector(7 downto 0);
    ddr3_dqs_n      : inout std_logic_vector(7 downto 0);
    ddr3_addr       : out   std_logic_vector(13 downto 0);
    ddr3_ba         : out   std_logic_vector(2 downto 0);
    ddr3_ras_n      : out   std_logic;
    ddr3_cas_n      : out   std_logic;
    ddr3_we_n       : out   std_logic;
    ddr3_reset_n    : out   std_logic;
    ddr3_ck_p       : out   std_logic_vector(0 downto 0);
    ddr3_ck_n       : out   std_logic_vector(0 downto 0);
    ddr3_cke        : out   std_logic_vector(0 downto 0);
    ddr3_cs_n       : out   std_logic_vector(0 downto 0);
    ddr3_dm         : out   std_logic_vector(7 downto 0);
    ddr3_odt        : out   std_logic_vector(0 downto 0);
    dsurx           : in    std_ulogic;
    dsutx           : out   std_ulogic;
    dsuctsn         : in    std_ulogic;
    dsurtsn         : out   std_ulogic;
    button          : in    std_logic_vector(3 downto 0);
    switch          : inout std_logic_vector(4 downto 0); 
    led             : out   std_logic_vector(6 downto 0);
    iic_scl         : inout std_ulogic;
    iic_sda         : inout std_ulogic;
    usb_refclk_opt  : in    std_logic;
    usb_clkout      : in    std_logic;
    usb_d           : inout std_logic_vector(7 downto 0);
    usb_nxt         : in    std_logic;
    usb_stp         : out   std_logic;
    usb_dir         : in    std_logic;
    usb_resetn      : out   std_ulogic;
    gtrefclk_p      : in    std_logic;
    gtrefclk_n      : in    std_logic;
    txp             : out   std_logic;
    txn             : out   std_logic;
    rxp             : in    std_logic;
    rxn             : in    std_logic;
    emdio           : inout std_logic;
    emdc            : out   std_ulogic;
    eint            : in    std_ulogic;
    erst            : out   std_ulogic;
    can_txd         : out   std_logic_vector(0 to CFG_CAN_NUM-1);
    can_rxd         : in    std_logic_vector(0 to CFG_CAN_NUM-1);
    spi_data_out    : in    std_logic;
    spi_data_in     : out   std_ulogic;
    spi_data_cs_b   : out   std_ulogic;
    spi_clk         : out   std_ulogic
   );
end;


architecture rtl of leon3mp is

component sgmii_vc707
  generic(
    pindex          : integer := 0;
    paddr           : integer := 0;
    pmask           : integer := 16#fff#;
    autonegotiation : integer := 1
  );
  port(
    sgmiii    :  in  eth_sgmii_in_type; 
    sgmiio    :  out eth_sgmii_out_type;
    gmiii     : out   eth_in_type;
    gmiio     : in    eth_out_type;
    reset     : in    std_logic;                     -- Asynchronous reset for entire core.
    apb_clk   : in    std_logic;
    apb_rstn  : in    std_logic;
    apbi      : in    apb_slv_in_type;
    apbo      : out   apb_slv_out_type
  );
end component;

component ahb2mig_series7
  generic(
    hindex     : integer := 0;
    haddr      : integer := 0;
    hmask      : integer := 16#f00#;
    pindex     : integer := 0;
    paddr      : integer := 0;
    pmask      : integer := 16#fff#;
    SIM_BYPASS_INIT_CAL : string := "OFF";
    SIMULATION : string  := "FALSE";
    USE_MIG_INTERFACE_MODEL : boolean := false
  );
  port(
    ddr3_dq           : inout std_logic_vector(63 downto 0);
    ddr3_dqs_p        : inout std_logic_vector(7 downto 0);
    ddr3_dqs_n        : inout std_logic_vector(7 downto 0);
    ddr3_addr         : out   std_logic_vector(13 downto 0);
    ddr3_ba           : out   std_logic_vector(2 downto 0);
    ddr3_ras_n        : out   std_logic;
    ddr3_cas_n        : out   std_logic;
    ddr3_we_n         : out   std_logic;
    ddr3_reset_n      : out   std_logic;
    ddr3_ck_p         : out   std_logic_vector(0 downto 0);
    ddr3_ck_n         : out   std_logic_vector(0 downto 0);
    ddr3_cke          : out   std_logic_vector(0 downto 0);
    ddr3_cs_n         : out   std_logic_vector(0 downto 0);
    ddr3_dm           : out   std_logic_vector(7 downto 0);
    ddr3_odt          : out   std_logic_vector(0 downto 0);
    ahbso             : out   ahb_slv_out_type;
    ahbsi             : in    ahb_slv_in_type;
    apbi              : in    apb_slv_in_type;
    apbo              : out   apb_slv_out_type;
    calib_done        : out   std_logic;
    rst_n_syn         : in    std_logic;
    rst_n_async       : in    std_logic;
    clk_amba          : in    std_logic;
    sys_clk_p         : in    std_logic;
    sys_clk_n         : in    std_logic;
    clk_ref_i         : in    std_logic;
    ui_clk            : out   std_logic;
    ui_clk_sync_rst   : out   std_logic
   );
end component ;

component ddr_dummy 
  port (
    ddr_dq           : inout std_logic_vector(63 downto 0);
    ddr_dqs          : inout std_logic_vector(7 downto 0);
    ddr_dqs_n        : inout std_logic_vector(7 downto 0);
    ddr_addr         : out   std_logic_vector(13 downto 0);
    ddr_ba           : out   std_logic_vector(2 downto 0);
    ddr_ras_n        : out   std_logic;
    ddr_cas_n        : out   std_logic;
    ddr_we_n         : out   std_logic;
    ddr_reset_n      : out   std_logic;
    ddr_ck_p         : out   std_logic_vector(0 downto 0);
    ddr_ck_n         : out   std_logic_vector(0 downto 0);
    ddr_cke          : out   std_logic_vector(0 downto 0);
    ddr_cs_n         : out   std_logic_vector(0 downto 0);
    ddr_dm           : out   std_logic_vector(7 downto 0);
    ddr_odt          : out   std_logic_vector(0 downto 0)
   ); 
end component ;

--constant maxahbm : integer := CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+CFG_GRUSBHC+CFG_GRUSBDC+CFG_GRUSB_DCL;
constant maxahbm : integer := 16;
--constant maxahbs : integer := 1+CFG_DSU+CFG_MCTRL_LEON2+CFG_AHBROMEN+CFG_AHBRAMEN+2+CFG_GRUSBDC;
constant maxahbs : integer := 16;
constant maxapbs : integer := CFG_IRQ3_ENABLE+CFG_GPT_ENABLE+CFG_GRGPIO_ENABLE+CFG_AHBSTAT+CFG_AHBSTAT+CFG_GRUSBHC+CFG_GRUSBDC;

signal vcc, gnd   : std_logic_vector(31 downto 0);
signal memi  : memory_in_type;
signal memo  : memory_out_type;
signal wpo   : wprot_out_type;
signal sdi   : sdctrl_in_type;
signal sdo   : sdram_out_type;
signal sdo2, sdo3 : sdctrl_out_type;

signal apbi  : apb_slv_in_type;
signal apbo  : apb_slv_out_vector := (others => apb_none);
signal ahbsi : ahb_slv_in_type;
signal ahbso : ahb_slv_out_vector := (others => ahbs_none);
signal ahbmi : ahb_mst_in_type;
signal vahbmi : ahb_mst_in_type;
signal ahbmo : ahb_mst_out_vector := (others => ahbm_none);
signal vahbmo : ahb_mst_out_type;

signal ui_clk : std_ulogic;
signal clkm, rstn, rstraw, sdclkl : std_ulogic;
signal clk_200 : std_ulogic;
signal clk25, clk40, clk65 : std_ulogic;

signal cgi, cgi2, cgiu   : clkgen_in_type;
signal cgo, cgo2, cgou   : clkgen_out_type;
signal u1i, u2i, dui : uart_in_type;
signal u1o, u2o, duo : uart_out_type;

signal irqi : irq_in_vector(0 to CFG_NCPU-1);
signal irqo : irq_out_vector(0 to CFG_NCPU-1);

signal dbgi : l3_debug_in_vector(0 to CFG_NCPU-1);
signal dbgo : l3_debug_out_vector(0 to CFG_NCPU-1);

signal dsui : dsu_in_type;
signal dsuo : dsu_out_type;

signal gmiii : eth_in_type;
signal gmiio : eth_out_type;

signal sgmiii :  eth_sgmii_in_type; 
signal sgmiio :  eth_sgmii_out_type;

signal sgmiirst : std_logic;

signal ethernet_phy_int : std_logic;

signal rxd1 : std_logic;
signal txd1 : std_logic;

signal ethi : eth_in_type;
signal etho : eth_out_type;
signal egtx_clk :std_ulogic;
signal negtx_clk :std_ulogic;

signal gpti : gptimer_in_type;
signal gpto : gptimer_out_type;

signal gpioi : gpio_in_type;
signal gpioo : gpio_out_type;

signal clklock, elock, uclk ,ulock : std_ulogic;

signal lock, calib_done, clkml, lclk, rst, ndsuact : std_ulogic;
signal tck, tckn, tms, tdi, tdo : std_ulogic;

signal lcd_datal : std_logic_vector(11 downto 0);
signal lcd_hsyncl, lcd_vsyncl, lcd_del, lcd_reset_bl : std_ulogic;

signal i2ci, dvi_i2ci : i2c_in_type;
signal i2co, dvi_i2co : i2c_out_type;

signal spii : spi_in_type;
signal spio : spi_out_type;
signal slvsel : std_logic_vector(CFG_SPICTRL_SLVS-1 downto 0);

constant BOARD_FREQ : integer := 200000;   -- input frequency in KHz
constant CPU_FREQ : integer := BOARD_FREQ * CFG_CLKMUL / CFG_CLKDIV;  -- cpu frequency in KHz

signal stati : ahbstat_in_type;

signal fpi : grfpu_in_vector_type;
signal fpo : grfpu_out_vector_type;

signal dsurx_int   : std_logic; 
signal dsutx_int   : std_logic; 
signal dsuctsn_int : std_logic;
signal dsurtsn_int : std_logic;

signal dsu_sel : std_logic;

signal usbi : grusb_in_vector(0 downto 0);
signal usbo : grusb_out_vector(0 downto 0);

signal can_lrx, can_ltx   : std_logic_vector(0 to 7);

signal clkref           : std_logic;

attribute keep : boolean;
attribute syn_keep : string;
attribute keep of clkm : signal is true;
attribute keep of uclk : signal is true;

begin

----------------------------------------------------------------------
---  Reset and Clock generation  -------------------------------------
----------------------------------------------------------------------

  vcc <= (others => '1'); gnd <= (others => '0');
  cgi.pllctrl <= "00"; cgi.pllrst <= rstraw;

   clk_gen : if (CFG_MIG_SERIES7 = 0) generate
     clk_pad_ds : clkpad_ds generic map (tech => padtech, level => sstl, voltage => x15v) port map (clk200p, clk200n, lclk);
     clkgen0 : clkgen        -- clock generator
       generic map (clktech, CFG_CLKMUL, CFG_CLKDIV, CFG_MCTRL_SDEN,
      CFG_CLK_NOFB, 0, 0, 0, BOARD_FREQ)
       port map (lclk, lclk, clkm, open, open, open, open, cgi, cgo, open, open, open);
   end generate;

  reset_pad : inpad generic map (tech => padtech, level => cmos, voltage => x18v) port map (reset, rst);
  rst0 : rstgen         -- reset generator
  generic map (acthigh => 1)
  port map (rst, clkm, lock, rstn, rstraw);
  lock <= calib_done when CFG_MIG_SERIES7 = 1 else cgo.clklock;

----------------------------------------------------------------------
---  AHB CONTROLLER --------------------------------------------------
----------------------------------------------------------------------

  ahb0 : ahbctrl       -- AHB arbiter/multiplexer
  generic map (defmast => CFG_DEFMST, split => CFG_SPLIT,
   rrobin => CFG_RROBIN, ioaddr => CFG_AHBIO, fpnpen => CFG_FPNPEN,
     nahbm => maxahbm, nahbs => maxahbs)
  port map (rstn, clkm, ahbmi, ahbmo, ahbsi, ahbso);

----------------------------------------------------------------------
---  LEON3 processor and DSU -----------------------------------------
----------------------------------------------------------------------

  nosh : if CFG_GRFPUSH = 0 generate
    cpu : for i in 0 to CFG_NCPU-1 generate
      l3ft : if CFG_LEON3FT_EN /= 0 generate
        leon3ft0 : leon3ft    -- LEON3 processor
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
      0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
    CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
    CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
          CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
          CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, CFG_NCPU-1,
    CFG_IUFT_EN, CFG_FPUFT_EN, CFG_CACHE_FT_EN, CFG_RF_ERRINJ,
    CFG_CACHE_ERRINJ, CFG_DFIXED, CFG_LEON3_NETLIST, CFG_SCAN, CFG_MMU_PAGE)
        port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso,
        irqi(i), irqo(i), dbgi(i), dbgo(i), clkm);
      end generate;

      l3s : if CFG_LEON3FT_EN = 0 generate
        u0 : leon3s     -- LEON3 processor
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
    0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
    CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
    CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
          CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
          CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, CFG_NCPU-1,
    CFG_DFIXED, CFG_SCAN, CFG_MMU_PAGE, CFG_BP)
        port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso,
        irqi(i), irqo(i), dbgi(i), dbgo(i));
      end generate;
    end generate;
  end generate;

  sh : if CFG_GRFPUSH = 1 generate
    cpu : for i in 0 to CFG_NCPU-1 generate
      l3ft : if CFG_LEON3FT_EN /= 0 generate
        leon3ft0 : leon3ftsh    -- LEON3 processor
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
      0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
    CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
    CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
          CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
          CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, CFG_NCPU-1,
    CFG_IUFT_EN, CFG_FPUFT_EN, CFG_CACHE_FT_EN, CFG_RF_ERRINJ,
    CFG_CACHE_ERRINJ, CFG_DFIXED, CFG_LEON3_NETLIST, CFG_SCAN, CFG_MMU_PAGE)
        port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso,
        irqi(i), irqo(i), dbgi(i), dbgo(i), clkm,  fpi(i), fpo(i));

      end generate;
      l3s : if CFG_LEON3FT_EN = 0 generate
        u0 : leon3sh    -- LEON3 processor
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
    0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
    CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
    CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
          CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
          CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, CFG_NCPU-1,
    CFG_DFIXED, CFG_SCAN, CFG_MMU_PAGE)
        port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso,
        irqi(i), irqo(i), dbgi(i), dbgo(i), fpi(i), fpo(i));
      end generate;
    end generate;

    grfpush0 : grfpushwx generic map ((CFG_FPU-1), CFG_NCPU, fabtech)
    port map (clkm, rstn, fpi, fpo);

  end generate;

  led1_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v) port map (led(1), dbgo(0).error);

  dsugen : if CFG_DSU = 1 generate
      dsu0 : dsu3         -- LEON3 Debug Support Unit
      generic map (hindex => 2, haddr => 16#900#, hmask => 16#F00#,
         ncpu => CFG_NCPU, tbits => 30, tech => memtech, irq => 0, kbytes => CFG_ATBSZ)
      port map (rstn, clkm, ahbmi, ahbsi, ahbso(2), dbgo, dbgi, dsui, dsuo);
      dsui.enable <= '1';
      dsui_break_pad   : inpad  generic map (level => cmos, voltage => x18v, tech => padtech) port map (button(3), dsui.break);
      dsuact_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v) port map (led(0), ndsuact);
      ndsuact <= not dsuo.active;
  end generate;

  nodsu : if CFG_DSU = 0 generate
    dsuo.tstop <= '0'; dsuo.active <= '0'; ahbso(2) <= ahbs_none;
  end generate;

  -- Debug UART
  dcomgen : if CFG_AHB_UART = 1 generate
    dcom0 : ahbuart
      generic map (hindex => CFG_NCPU, pindex => 7, paddr => 7)
      port map (rstn, clkm, dui, duo, apbi, apbo(7), ahbmi, ahbmo(CFG_NCPU));
    dui.extclk <= '0';
  end generate;

  nouah : if CFG_AHB_UART = 0 generate 
     apbo(7) <= apb_none; 
     duo.txd <= '0';
     duo.rtsn <= '0';
     dui.extclk <= '0';
  end generate;


  sw4_pad : iopad generic map (tech => padtech, level => cmos, voltage => x18v)
      port map (switch(4), '0', '1', dsu_sel);

  dsutx_int   <= duo.txd     when dsu_sel = '1' else u1o.txd;
  dui.rxd     <= dsurx_int   when dsu_sel = '1' else '1';
  u1i.rxd     <= dsurx_int   when dsu_sel = '0' else '1';
  dsurtsn_int <= duo.rtsn    when dsu_sel = '1' else u1o.rtsn;  
  dui.ctsn    <= dsuctsn_int when dsu_sel = '1' else '1';
  u1i.ctsn    <= dsuctsn_int when dsu_sel = '0' else '1';
  
  dsurx_pad   : inpad  generic map (level => cmos, voltage => x18v, tech => padtech) port map (dsurx, dsurx_int);
  dsutx_pad   : outpad generic map (level => cmos, voltage => x18v, tech => padtech) port map (dsutx, dsutx_int);
  dsuctsn_pad : inpad  generic map (level => cmos, voltage => x18v, tech => padtech) port map (dsuctsn, dsuctsn_int);
  dsurtsn_pad : outpad generic map (level => cmos, voltage => x18v, tech => padtech) port map (dsurtsn, dsurtsn_int);


  ahbjtaggen0 :if CFG_AHB_JTAG = 1 generate
    ahbjtag0 : ahbjtag generic map(tech => fabtech, hindex => CFG_NCPU+1)
      port map(rstn, clkm, tck, tms, tdi, tdo, ahbmi, ahbmo(CFG_NCPU+1),
               open, open, open, open, open, open, open, gnd(0));
  end generate;

  nojtag : if CFG_AHB_JTAG = 0 generate apbo(CFG_NCPU+1) <= apb_none; end generate;

----------------------------------------------------------------------
---  Memory controllers ----------------------------------------------
----------------------------------------------------------------------

  memi.writen <= '1'; memi.wrn <= "1111"; memi.bwidth <= "01";
  memi.brdyn <= '0'; memi.bexcn <= '1';

  mctrl_gen : if CFG_MCTRL_LEON2 /= 0 generate
    mctrl0 : mctrl generic map (hindex => 0, pindex => 0,
     paddr => 0, srbanks => 2, ram8 => CFG_MCTRL_RAM8BIT,
     ram16 => CFG_MCTRL_RAM16BIT, sden => CFG_MCTRL_SDEN,
     invclk => CFG_CLK_NOFB, sepbus => CFG_MCTRL_SEPBUS,
     pageburst => CFG_MCTRL_PAGE, rammask => 0, iomask => 0)
    port map (rstn, clkm, memi, memo, ahbsi, ahbso(0), apbi, apbo(0), wpo, sdo);

    addr_pad : outpadv generic map (width => 26, tech => padtech, level => cmos, voltage => x18v)
     port map (address(25 downto 0), memo.address(26 downto 1));
    roms_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (romsn, memo.romsn(0));
    oen_pad  : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (oen, memo.oen);
    adv_pad  : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (adv, '0');
    wri_pad  : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (writen, memo.writen);
    data_pad : iopadvv generic map (tech => padtech, width => 16, level => cmos, voltage => x18v)
        port map (data(15 downto 0), memo.data(31 downto 16),
     memo.vbdrive(31 downto 16), memi.data(31 downto 16));
  end generate;
  nomctrl : if CFG_MCTRL_LEON2 = 0 generate
    roms_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (romsn, vcc(0)); --ahbso(0) <= ahbso_none;
  end generate;

----------------------------------------------------------------------
---  DDR3 memory controller ------------------------------------------
----------------------------------------------------------------------

  mig_gen : if (CFG_MIG_SERIES7 = 1) generate
      ddrc : ahb2mig_series7 generic map(
    hindex => 4, haddr => 16#400#, hmask => 16#C00#,
    pindex => 4, paddr => 4,
    SIM_BYPASS_INIT_CAL => SIM_BYPASS_INIT_CAL,
    SIMULATION => SIMULATION, USE_MIG_INTERFACE_MODEL => USE_MIG_INTERFACE_MODEL)
      port map(
      ddr3_dq         => ddr3_dq,
      ddr3_dqs_p      => ddr3_dqs_p,
      ddr3_dqs_n      => ddr3_dqs_n,
      ddr3_addr       => ddr3_addr,
      ddr3_ba         => ddr3_ba,
      ddr3_ras_n      => ddr3_ras_n,
      ddr3_cas_n      => ddr3_cas_n,
      ddr3_we_n       => ddr3_we_n,
      ddr3_reset_n    => ddr3_reset_n,
      ddr3_ck_p       => ddr3_ck_p,
      ddr3_ck_n       => ddr3_ck_n,
      ddr3_cke        => ddr3_cke,
      ddr3_cs_n       => ddr3_cs_n,
      ddr3_dm         => ddr3_dm,
      ddr3_odt        => ddr3_odt,
      ahbsi           => ahbsi,
      ahbso           => ahbso(4),
      apbi            => apbi,
      apbo            => apbo(4),
      calib_done      => calib_done,
      rst_n_syn       => rstn,
      rst_n_async     => rstraw,
      clk_amba        => clkm,
      sys_clk_p       => clk200p,
      sys_clk_n       => clk200n,
      clk_ref_i       => clkref,
      ui_clk          => clkm,
      ui_clk_sync_rst => open
     );

     clkgenmigref0 : clkgen
       generic map (clktech, 16, 8, 0,CFG_CLK_NOFB, 0, 0, 0, 100000)
       port map (clkm, clkm, clkref, open, open, open, open, cgi, cgo, open, open, open);

  end generate;

  no_mig_gen : if (CFG_MIG_SERIES7 = 0) generate  
  
    ahbram0 : ahbram 
       generic map (hindex => 4, haddr => 16#400#, tech => CFG_MEMTECH, kbytes => 128)
       port map ( rstn, clkm, ahbsi, ahbso(4));

    ddrdummy0 : ddr_dummy
      port map (
       ddr_dq      => ddr3_dq,
       ddr_dqs     => ddr3_dqs_p,
       ddr_dqs_n   => ddr3_dqs_n,
       ddr_addr    => ddr3_addr,
       ddr_ba      => ddr3_ba,
       ddr_ras_n   => ddr3_ras_n,
       ddr_cas_n   => ddr3_cas_n,
       ddr_we_n    => ddr3_we_n,
       ddr_reset_n => ddr3_reset_n,
       ddr_ck_p    => ddr3_ck_p,
       ddr_ck_n    => ddr3_ck_n,
       ddr_cke     => ddr3_cke,
       ddr_cs_n    => ddr3_cs_n,
       ddr_dm      => ddr3_dm,
       ddr_odt     => ddr3_odt
     ); 
    
     calib_done <= '1';
    
  end generate;

  led2_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (led(2), calib_done);
  led3_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
     port map (led(3), lock);
  led4_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
      port map (led(4), ahbso(4).hready);

-----------------------------------------------------------------------
---  ETHERNET ---------------------------------------------------------
-----------------------------------------------------------------------

    eth0 : if CFG_GRETH = 1 generate -- Gaisler ethernet MAC
      e1 : grethm 
       generic map(
        hindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG, 
        pindex => 14, paddr => 14, pirq => 12, memtech => memtech,
        mdcscaler => CPU_FREQ/1000, rmii => 0, enable_mdio => 1, fifosize => CFG_ETH_FIFO,
        nsync => 2, edcl => CFG_DSU_ETH, edclbufsz => CFG_ETH_BUF, phyrstadr => 7,
        macaddrh => CFG_ETH_ENM, macaddrl => CFG_ETH_ENL, enable_mdint => 1,
        ipaddrh => CFG_ETH_IPM, ipaddrl => CFG_ETH_IPL,
        giga => CFG_GRETH1G)
       port map( rst => rstn, clk => clkm, ahbmi => ahbmi,
        ahbmo => ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG), 
        apbi => apbi, apbo => apbo(14), ethi => gmiii, etho => gmiio); 

       sgmiirst <= not rstn;

       sgmii0 : sgmii_vc707
         generic map(
           pindex => 11,
           paddr  => 11,
           pmask  => 16#fff#,
           autonegotiation => autonegotiation
         )
         port map(
           sgmiii   => sgmiii,
           sgmiio   => sgmiio,
           gmiii    => gmiii,
           gmiio    => gmiio,
           reset    => sgmiirst,
           apb_clk  => clkm,
           apb_rstn => rstn,
           apbi     => apbi,
           apbo     => apbo(11)
         );

      emdio_pad : iopad generic map (tech => padtech, level => cmos, voltage => x18v) 
        port map (emdio, sgmiio.mdio_o, sgmiio.mdio_oe, sgmiii.mdio_i);

      emdc_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v) 
        port map (emdc, sgmiio.mdc);

      eint_pad : inpad generic map (tech => padtech, level => cmos, voltage => x18v) 
        port map (eint, sgmiii.mdint);

      erst_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v) 
        port map (erst, sgmiio.reset);

      sgmiii.clkp <= gtrefclk_p;
      sgmiii.clkn <= gtrefclk_n;
      txp         <= sgmiio.txp;
      txn         <= sgmiio.txn;
      sgmiii.rxp  <= rxp;
      sgmiii.rxn  <= rxn;

    end generate;

    noeth0 : if CFG_GRETH = 0 generate
      -- TODO: 
    end generate;

-----------------------------------------------------------------------
---  CAN --------------------------------------------------------------
-----------------------------------------------------------------------

   can0 : if CFG_CAN = 1 generate 
     can0 : can_mc 
      generic map (slvndx => 6, ioaddr => CFG_CANIO,
                   iomask => 16#FF0#, irq => CFG_CANIRQ, memtech => memtech,
                   ncores => CFG_CAN_NUM, sepirq => CFG_CANSEPIRQ)
      port map (rstn, clkm, ahbsi, ahbso(6), can_lrx, can_ltx );

     can_pads : for i in 0 to CFG_CAN_NUM-1 generate
         can_tx_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
            port map (can_txd(i), can_ltx(i));
         can_rx_pad : inpad generic map (tech => padtech, level => cmos, voltage => x18v)
            port map (can_rxd(i), can_lrx(i));
     end generate;
   end generate;

   ncan : if CFG_CAN = 0 generate ahbso(6) <= ahbs_none; end generate;

-------------------------------------------------------------------------------
-- USB ------------------------------------------------------------------------
-------------------------------------------------------------------------------

  -- Note that more than one USB component can not be instantiated at the same
  -- time (board has only one USB transceiver), therefore they share AHB
  -- master/slave indexes
  -----------------------------------------------------------------------------
  -- Shared pads
  -----------------------------------------------------------------------------
  usbpads: if (CFG_GRUSBHC + CFG_GRUSBDC + CFG_GRUSB_DCL) /= 0 generate
    -- Incoming 60 MHz clock from transceiver, arch 3 = through BUFGDLL or
    -- arch 2 = through BUFG or similiar.
    --usb_clkout_pad : clkpad
      --generic map (tech => padtech, arch => 3)
      --port map (usb_clkout, uclk, cgo.clklock, ulock);
     usb_clkout_pad : clkpad generic map (tech => padtech, arch => 2) port map (usb_clkout,uclk);

    usb_d_pad: iopadv
      generic map(tech => padtech, width => 8)
      port map (usb_d, usbo(0).dataout(7 downto 0), usbo(0).oen,
                usbi(0).datain(7 downto 0));
    usb_nxt_pad : inpad generic map (tech => padtech)
      port map (usb_nxt, usbi(0).nxt);
    usb_dir_pad : inpad generic map (tech => padtech)
      port map (usb_dir, usbi(0).dir);
    usb_resetn_pad : outpad generic map (tech => padtech)
      port map (usb_resetn, usbo(0).reset);
    usb_stp_pad : outpad generic map (tech => padtech)
      port map (usb_stp, usbo(0).stp);
  end generate usbpads;
  nousb: if (CFG_GRUSBHC + CFG_GRUSBDC + CFG_GRUSB_DCL) = 0 generate
    --ulock <= '1';
    usb_resetn_pad : outpad generic map (tech => padtech, slew => 1)
      port map (usb_resetn, '0');
    usb_stp_pad : outpad generic map (tech => padtech, slew => 1)
      port map (usb_stp, '0');
  end generate nousb;
  
  -----------------------------------------------------------------------------
  -- USB 2.0 Host Controller
  -----------------------------------------------------------------------------
  usbhc0: if CFG_GRUSBHC = 1 generate
    usbhc0 : grusbhc
      generic map (
        ehchindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH,
        ehcpindex => 13, ehcpaddr => 13, ehcpirq => 13, ehcpmask => 16#fff#,
        uhchindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+1,
        uhchsindex => 8, uhchaddr => 16#A00#, uhchmask => 16#fff#, uhchirq => 9, tech => fabtech,
        memtech => memtech, ehcgen => CFG_GRUSBHC_EHC, uhcgen => CFG_GRUSBHC_UHC,
        endian_conv => CFG_GRUSBHC_ENDIAN, be_regs => CFG_GRUSBHC_BEREGS,
        be_desc => CFG_GRUSBHC_BEDESC, uhcblo => CFG_GRUSBHC_BLO,
        bwrd => CFG_GRUSBHC_BWRD, vbusconf => CFG_GRUSBHC_VBUSCONF)
      port map (
        clkm,uclk,rstn,apbi,apbo(13),ahbmi,ahbsi,
        ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH),
        ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+1
              downto
              CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+1),
        ahbso(8 downto 8),
        usbo,usbi);    
  end generate usbhc0;

  -----------------------------------------------------------------------------
  -- USB 2.0 Device Controller
  -----------------------------------------------------------------------------
  usbdc0: if CFG_GRUSBDC = 1 generate
    usbdc0: grusbdc
      generic map(
        hsindex => 8, hirq => 6, haddr => 16#004#, hmask => 16#FFC#,        
        hmindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH,
        aiface => CFG_GRUSBDC_AIFACE, uiface => 1,
        nepi => CFG_GRUSBDC_NEPI, nepo => CFG_GRUSBDC_NEPO,
        i0 => CFG_GRUSBDC_I0, i1 => CFG_GRUSBDC_I1,
        i2 => CFG_GRUSBDC_I2, i3 => CFG_GRUSBDC_I3,
        i4 => CFG_GRUSBDC_I4, i5 => CFG_GRUSBDC_I5,
        i6 => CFG_GRUSBDC_I6, i7 => CFG_GRUSBDC_I7,
        i8 => CFG_GRUSBDC_I8, i9 => CFG_GRUSBDC_I9,
        i10 => CFG_GRUSBDC_I10, i11 => CFG_GRUSBDC_I11,
        i12 => CFG_GRUSBDC_I12, i13 => CFG_GRUSBDC_I13,
        i14 => CFG_GRUSBDC_I14, i15 => CFG_GRUSBDC_I15,
        o0 => CFG_GRUSBDC_O0, o1 => CFG_GRUSBDC_O1,
        o2 => CFG_GRUSBDC_O2, o3 => CFG_GRUSBDC_O3,
        o4 => CFG_GRUSBDC_O4, o5 => CFG_GRUSBDC_O5,
        o6 => CFG_GRUSBDC_O6, o7 => CFG_GRUSBDC_O7,
        o8 => CFG_GRUSBDC_O8, o9 => CFG_GRUSBDC_O9,
        o10 => CFG_GRUSBDC_O10, o11 => CFG_GRUSBDC_O11,
        o12 => CFG_GRUSBDC_O12, o13 => CFG_GRUSBDC_O13,
        o14 => CFG_GRUSBDC_O14, o15 => CFG_GRUSBDC_O15,
        memtech => memtech, keepclk => 1)
      port map(
        uclk  => uclk,
        usbi  => usbi(0),
        usbo  => usbo(0),
        hclk  => clkm,
        hrst  => rstn,
        ahbmi => ahbmi,
        ahbmo => ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH),
        ahbsi => ahbsi,
        ahbso => ahbso(8)
        );
  end generate usbdc0;

  -----------------------------------------------------------------------------
  -- USB DCL 
  -----------------------------------------------------------------------------
  usb_dcl0: if CFG_GRUSB_DCL = 1 generate
    usb_dcl0: grusb_dcl
      generic map (
        hindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH,
        memtech => memtech, keepclk => 1, uiface => 1)
      port map (
        uclk, usbi(0), usbo(0), clkm, rstn, ahbmi,
        ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH));
  end generate usb_dcl0;

----------------------------------------------------------------------
---  I2C Controller--------------------------------------------
----------------------------------------------------------------------

  i2cm: if CFG_I2C_ENABLE = 1 generate  -- I2C master
    i2c0 : i2cmst
      generic map (pindex => 9, paddr => 9, pmask => 16#FFF#,
                   pirq => 11, filter => 9)
      port map (rstn, clkm, apbi, apbo(9), i2ci, i2co);
    -- Does not use a bi-directional line for the I2C clock
    i2ci.scl <= i2co.scloen;            -- No clock stretch possible
    -- When SCL output enable is activated the line should go low
    i2c_scl_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v)
      port map (iic_scl, i2co.scloen);
    i2c_sda_pad : iopad generic map (tech => padtech, level => cmos, voltage => x18v)
      port map (iic_sda, i2co.sda, i2co.sdaoen, i2ci.sda);
  end generate i2cm;


----------------------------------------------------------------------
---  APB Bridge and various periherals -------------------------------
----------------------------------------------------------------------

  apb0 : apbctrl            -- AHB/APB bridge
  generic map (hindex => 1, haddr => CFG_APBADDR, nslaves => 16)
  port map (rstn, clkm, ahbsi, ahbso(1), apbi, apbo );

  irqctrl : if CFG_IRQ3_ENABLE /= 0 generate
    irqctrl0 : irqmp         -- interrupt controller
    generic map (pindex => 2, paddr => 2, ncpu => CFG_NCPU)
    port map (rstn, clkm, apbi, apbo(2), irqo, irqi);
  end generate;
  irq3 : if CFG_IRQ3_ENABLE = 0 generate
    x : for i in 0 to CFG_NCPU-1 generate
      irqi(i).irl <= "0000";
    end generate;
    apbo(2) <= apb_none;
  end generate;

  gpt : if CFG_GPT_ENABLE /= 0 generate
    timer0 : gptimer          -- timer unit
    generic map (pindex => 3, paddr => 3, pirq => CFG_GPT_IRQ, 
   sepirq => CFG_GPT_SEPIRQ, sbits => CFG_GPT_SW, ntimers => CFG_GPT_NTIM, 
   nbits => CFG_GPT_TW, wdog => CFG_GPT_WDOGEN*CFG_GPT_WDOG)
    port map (rstn, clkm, apbi, apbo(3), gpti, gpto);
    gpti.dhalt <= dsuo.tstop; gpti.extclk <= '0';
  end generate;

  nogpt : if CFG_GPT_ENABLE = 0 generate apbo(3) <= apb_none; end generate;

  gpio0 : if CFG_GRGPIO_ENABLE /= 0 generate     -- GPIO unit
    grgpio0: grgpio
    generic map(pindex => 10, paddr => 10, imask => CFG_GRGPIO_IMASK, nbits => 7)
    port map(rst => rstn, clk => clkm, apbi => apbi, apbo => apbo(10),
    gpioi => gpioi, gpioo => gpioo);
    pio_pads : for i in 0 to 3 generate
        pio_pad : iopad generic map (tech => padtech, level => cmos, voltage => x18v)
            port map (switch(i), gpioo.dout(i), gpioo.oen(i), gpioi.din(i));
    end generate;
    pio_pads2 : for i in 4 to 6 generate
        pio_pad : inpad generic map (tech => padtech, level => cmos, voltage => x18v)
            port map (button(i-4), gpioi.din(i));
    end generate;
  end generate;

  ua1 : if CFG_UART1_ENABLE /= 0 generate
    uart1 : apbuart                     -- UART 1
      generic map (pindex   => 1, paddr => 1, pirq => 2, console => dbguart,
         fifosize => CFG_UART1_FIFO)
      port map (rstn, clkm, apbi, apbo(1), u1i, u1o);
      u1i.extclk <= '0';   
    serrx_pad : outpad generic map (level => cmos, voltage => x18v, tech => padtech)
       port map (led(5), rxd1);
    sertx_pad : outpad generic map (level => cmos, voltage => x18v, tech => padtech)
       port map (led(6), txd1);
  end generate;
  noua0 : if CFG_UART1_ENABLE = 0 generate apbo(1) <= apb_none; end generate;

  spic: if CFG_SPICTRL_ENABLE = 1 generate  -- SPI controller
    spi1 : spictrl
      generic map (pindex => 12, paddr  => 12, pmask  => 16#fff#, pirq => 12,
                   fdepth => CFG_SPICTRL_FIFO, slvselen => CFG_SPICTRL_SLVREG,
                   slvselsz => CFG_SPICTRL_SLVS, odmode => 0, netlist => 0,
                   syncram => CFG_SPICTRL_SYNCRAM, ft => CFG_SPICTRL_FT)
      port map (rstn, clkm, apbi, apbo(12), spii, spio, slvsel);
    spii.spisel <= '1';                 -- Master only
    miso_pad : inpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_data_out, spii.miso);
    mosi_pad : outpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_data_in, spio.mosi);
    sck_pad  : outpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_clk, spio.sck);
    slvsel_pad : outpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_data_cs_b, slvsel(0));
  end generate spic;

  nospi: if CFG_SPICTRL_ENABLE = 0 generate
    miso_pad : inpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_data_out, spii.miso);
    mosi_pad : outpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_data_in, vcc(0));
    sck_pad  : outpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_clk, gnd(0));
    slvsel_pad : outpad generic map (level => cmos, voltage => x18v,tech => padtech)
      port map (spi_data_cs_b, vcc(0));
  end generate;

  ahbs : if CFG_AHBSTAT = 1 generate   -- AHB status register
    ahbstat0 : ahbstat generic map (pindex => 15, paddr => 15, pirq => 7,
   nftslv => CFG_AHBSTATN)
      port map (rstn, clkm, ahbmi, ahbsi, stati, apbi, apbo(15));
  end generate;

-----------------------------------------------------------------------
---  AHB ROM ----------------------------------------------------------
-----------------------------------------------------------------------

  bpromgen : if CFG_AHBROMEN /= 0 generate
    brom : entity work.ahbrom
      generic map (hindex => 7, haddr => CFG_AHBRODDR, pipe => CFG_AHBROPIP)
      port map ( rstn, clkm, ahbsi, ahbso(7));
  end generate;

-----------------------------------------------------------------------
---  AHB RAM ----------------------------------------------------------
-----------------------------------------------------------------------

  ocram : if CFG_AHBRAMEN = 1 generate
    ahbram0 : ahbram generic map (hindex => 5, haddr => CFG_AHBRADDR,
   tech => CFG_MEMTECH, kbytes => CFG_AHBRSZ)
    port map ( rstn, clkm, ahbsi, ahbso(5));
  end generate;

-----------------------------------------------------------------------
---  Test report module  ----------------------------------------------
-----------------------------------------------------------------------

  -- pragma translate_off
  test0_gen : if (testahb = true) generate
     test0 : ahbrep generic map (hindex => 3, haddr => 16#200#)
      port map (rstn, clkm, ahbsi, ahbso(3));
  end generate;
  -- pragma translate_on

  test1_gen : if (testahb = false) generate
    ahbram0 : ahbram generic map (hindex => 3, haddr => 16#200#,
   tech => CFG_MEMTECH, kbytes => CFG_AHBRSZ)
    port map ( rstn, clkm, ahbsi, ahbso(3));
  end generate;

 -----------------------------------------------------------------------
 ---  Drive unused bus elements  ---------------------------------------
 -----------------------------------------------------------------------

  nam1 : for i in (CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+CFG_GRUSBDC+CFG_GRUSBHC*2+CFG_GRUSB_DCL) to NAHBMST-1 generate
    ahbmo(i) <= ahbm_none;
  end generate;

 -----------------------------------------------------------------------
 ---  Boot message  ----------------------------------------------------
 -----------------------------------------------------------------------

 -- pragma translate_off
   x : report_design
   generic map (
    msg1 => "LEON3 Xilinx VC707 Demonstration design",
    fabtech => tech_table(fabtech), memtech => tech_table(memtech),
    mdel => 1
   );
 -- pragma translate_on
 end;

