-----------------------------------------------------------------------------
--  LEON3 Zedboard Demonstration design
--  Copyright (C) 2012 Fredrik Ringhage, Aeroflex Gaisler
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
use grlib.devices.all;
use grlib.config_types.all;
use grlib.config.all;
use techmap.gencomp.all;
use techmap.allclkgen.all;
library gaisler;
use gaisler.leon3.all;
use gaisler.uart.all;
use gaisler.misc.all;
use gaisler.i2c.all;
use gaisler.net.all;
use gaisler.jtag.all;
-- pragma translate_off
use gaisler.sim.all;
library unisim;
use unisim.all;
-- pragma translate_on

use work.config.all;

entity leon3mp is
  generic (
    fabtech : integer := CFG_FABTECH;
    memtech : integer := CFG_MEMTECH;
    padtech : integer := CFG_PADTECH;
    clktech : integer := CFG_CLKTECH;
    disas   : integer := CFG_DISAS;   -- Enable disassembly to console
    dbguart : integer := CFG_DUART;   -- Print UART on console
    pclow   : integer := CFG_PCLOW;
    testahb : boolean := false
  );
  port (
    processing_system7_0_MIO          : inout std_logic_vector(53 downto 0);
    processing_system7_0_PS_SRSTB     : in std_logic;
    processing_system7_0_PS_CLK       : in std_logic;
    processing_system7_0_PS_PORB      : in std_logic;
    processing_system7_0_DDR_Clk      : inout std_logic;
    processing_system7_0_DDR_Clk_n    : inout std_logic;
    processing_system7_0_DDR_CKE      : inout std_logic;
    processing_system7_0_DDR_CS_n     : inout std_logic;
    processing_system7_0_DDR_RAS_n    : inout std_logic;
    processing_system7_0_DDR_CAS_n    : inout std_logic;
    processing_system7_0_DDR_WEB_pin  : out std_logic;
    processing_system7_0_DDR_BankAddr : inout std_logic_vector(2 downto 0);
    processing_system7_0_DDR_Addr     : inout std_logic_vector(14 downto 0);
    processing_system7_0_DDR_ODT      : inout std_logic;
    processing_system7_0_DDR_DRSTB    : inout std_logic;
    processing_system7_0_DDR_DQ       : inout std_logic_vector(31 downto 0);
    processing_system7_0_DDR_DM       : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS      : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS_n    : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_VRN      : inout std_logic;
    processing_system7_0_DDR_VRP      : inout std_logic;
    button  : in    std_logic_vector(3 downto 0);
    switch  : inout std_logic_vector(7 downto 0);
    led     : out   std_logic_vector(7 downto 0)
   );
end;

architecture rtl of leon3mp is

constant use_ps_block : boolean := true;

constant hconfig : ahb_config_type := (
   0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_MIG_SERIES7, 0, 0, 0),
   4 => ahb_membar(16#000#, '1', '1', 16#F80#),
   others => zero32);

constant maxahbm : integer := CFG_NCPU+CFG_AHB_JTAG;
constant maxahbs : integer := 1+CFG_DSU+CFG_AHBROMEN+CFG_AHBRAMEN+1+2;
constant maxapbs : integer := CFG_IRQ3_ENABLE+CFG_GPT_ENABLE+CFG_GRGPIO_ENABLE+CFG_AHBSTAT;

signal vcc, gnd   : std_logic;

signal apbi  : apb_slv_in_type;
signal apbo  : apb_slv_out_vector := (others => apb_none);
signal ahbsi : ahb_slv_in_type;
signal ahbso : ahb_slv_out_vector := (others => ahbs_none);
signal ahbmi : ahb_mst_in_type;
signal vahbmi : ahb_mst_in_type;
signal ahbmo : ahb_mst_out_vector := (others => ahbm_none);
signal vahbmo : ahb_mst_out_type;

signal clkm, rstn, rstraw, sdclkl : std_ulogic;

signal cgi, cgi2   : clkgen_in_type;
signal cgo, cgo2   : clkgen_out_type;
signal u1i, u2i, dui : uart_in_type;
signal u1o, u2o, duo : uart_out_type;

signal irqi : irq_in_vector(0 to CFG_NCPU-1);
signal irqo : irq_out_vector(0 to CFG_NCPU-1);

signal dbgi : l3_debug_in_vector(0 to CFG_NCPU-1);
signal dbgo : l3_debug_out_vector(0 to CFG_NCPU-1);

signal dsui : dsu_in_type;
signal dsuo : dsu_out_type;

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

signal clklock, elock, ulock : std_ulogic;

signal lock, calib_done, clkml, lclk, rst, ndsuact : std_ulogic;
signal tck, tckn, tms, tdi, tdo : std_ulogic;

signal lcd_datal : std_logic_vector(11 downto 0);
signal lcd_hsyncl, lcd_vsyncl, lcd_del, lcd_reset_bl : std_ulogic;

signal i2ci, dvi_i2ci : i2c_in_type;
signal i2co, dvi_i2co : i2c_out_type;

constant BOARD_FREQ : integer := 50000;   -- input frequency in KHz
constant CPU_FREQ : integer := BOARD_FREQ * CFG_CLKMUL / CFG_CLKDIV;  -- cpu frequency in KHz

signal stati : ahbstat_in_type;

component leon3_zedboard_stub
  port (
    processing_system7_0_MIO : inout std_logic_vector(53 downto 0);
    processing_system7_0_PS_SRSTB : in std_logic;
    processing_system7_0_PS_CLK : in std_logic;
    processing_system7_0_PS_PORB : in std_logic;
    processing_system7_0_DDR_Clk : inout std_logic;
    processing_system7_0_DDR_Clk_n : inout std_logic;
    processing_system7_0_DDR_CKE : inout std_logic;
    processing_system7_0_DDR_CS_n : inout std_logic;
    processing_system7_0_DDR_RAS_n : inout std_logic;
    processing_system7_0_DDR_CAS_n : inout std_logic;
    processing_system7_0_DDR_WEB_pin : out std_logic;
    processing_system7_0_DDR_BankAddr : inout std_logic_vector(2 downto 0);
    processing_system7_0_DDR_Addr : inout std_logic_vector(14 downto 0);
    processing_system7_0_DDR_ODT : inout std_logic;
    processing_system7_0_DDR_DRSTB : inout std_logic;
    processing_system7_0_DDR_DQ : inout std_logic_vector(31 downto 0);
    processing_system7_0_DDR_DM : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS_n : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_VRN : inout std_logic;
    processing_system7_0_DDR_VRP : inout std_logic;
    ahblite_axi_bridge_0_S_AHB_HSEL_pin : in std_logic;
    ahblite_axi_bridge_0_S_AHB_HADDR_pin : in std_logic_vector(31 downto 0);
    ahblite_axi_bridge_0_S_AHB_HPROT_pin : in std_logic_vector(3 downto 0);
    ahblite_axi_bridge_0_S_AHB_HTRANS_pin : in std_logic_vector(1 downto 0);
    ahblite_axi_bridge_0_S_AHB_HSIZE_pin : in std_logic_vector(2 downto 0);
    ahblite_axi_bridge_0_S_AHB_HWRITE_pin : in std_logic;
    ahblite_axi_bridge_0_S_AHB_HBURST_pin : in std_logic_vector(2 downto 0);
    ahblite_axi_bridge_0_S_AHB_HWDATA_pin : in std_logic_vector(31 downto 0);
    ahblite_axi_bridge_0_S_AHB_HREADY_OUT_pin : out std_logic;
    ahblite_axi_bridge_0_S_AHB_HREADY_IN_pin : in std_logic;
    ahblite_axi_bridge_0_S_AHB_HRDATA_pin : out std_logic_vector(31 downto 0);
    ahblite_axi_bridge_0_S_AHB_HRESP_pin : out std_logic;
    processing_system7_0_FCLK_CLK0_pin : out std_logic;
    processing_system7_0_FCLK_RESET0_N_pin : out std_logic;
    processing_system7_0_FCLK_CLKTRIG0_N_pin : in std_logic
  );
end component;

begin

----------------------------------------------------------------------
---  Reset and Clock generation  -------------------------------------
----------------------------------------------------------------------

  vcc <= '1'; gnd <= '0';

  lock <= calib_done ;
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
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU*(1-CFG_GRFPUSH), CFG_V8,
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
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU*(1-CFG_GRFPUSH), CFG_V8,
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

  led1_pad : outpad generic map (tech => padtech, level => cmos, voltage => x33v) port map (led(1), dbgo(0).error);

  dsugen : if CFG_DSU = 1 generate
      dsu0 : dsu3         -- LEON3 Debug Support Unit
      generic map (hindex => 2, haddr => 16#900#, hmask => 16#F00#,
         ncpu => CFG_NCPU, tbits => 30, tech => memtech, irq => 0, kbytes => CFG_ATBSZ)
      port map (rstn, clkm, ahbmi, ahbsi, ahbso(2), dbgo, dbgi, dsui, dsuo);
      dsui.enable <= '1';
      dsui_break_pad   : inpad  generic map (level => cmos, voltage => x18v, tech => padtech) port map (button(0), dsui.break);
      dsuact_pad : outpad generic map (tech => padtech, level => cmos, voltage => x18v) port map (led(0), ndsuact);
      ndsuact <= not dsuo.active;
  end generate;

  nodsu : if CFG_DSU = 0 generate
    dsuo.tstop <= '0'; dsuo.active <= '0'; ahbso(2) <= ahbs_none;
  end generate;

  ahbjtaggen0 :if CFG_AHB_JTAG = 1 generate
    ahbjtag0 : ahbjtag generic map(tech => fabtech, hindex => 1)
      port map(rstn, clkm, tck, tms, tdi, tdo, ahbmi, ahbmo(1),
               open, open, open, open, open, open, open, gnd);
  end generate;

  nojtag : if CFG_AHB_JTAG = 0 generate apbo(1) <= apb_none; end generate;

     leon3_zedboard_stub_i : leon3_zedboard_stub
        port map (
          processing_system7_0_MIO                  => processing_system7_0_MIO,
          processing_system7_0_PS_SRSTB             => processing_system7_0_PS_SRSTB,
          processing_system7_0_PS_CLK               => processing_system7_0_PS_CLK,
          processing_system7_0_PS_PORB              => processing_system7_0_PS_PORB,
          processing_system7_0_DDR_Clk              => processing_system7_0_DDR_Clk,
          processing_system7_0_DDR_Clk_n            => processing_system7_0_DDR_Clk_n,
          processing_system7_0_DDR_CKE              => processing_system7_0_DDR_CKE,
          processing_system7_0_DDR_CS_n             => processing_system7_0_DDR_CS_n,
          processing_system7_0_DDR_RAS_n            => processing_system7_0_DDR_RAS_n,
          processing_system7_0_DDR_CAS_n            => processing_system7_0_DDR_CAS_n,
          processing_system7_0_DDR_WEB_pin          => processing_system7_0_DDR_WEB_pin,
          processing_system7_0_DDR_BankAddr         => processing_system7_0_DDR_BankAddr,
          processing_system7_0_DDR_Addr             => processing_system7_0_DDR_Addr,
          processing_system7_0_DDR_ODT              => processing_system7_0_DDR_ODT,
          processing_system7_0_DDR_DRSTB            => processing_system7_0_DDR_DRSTB,
          processing_system7_0_DDR_DQ               => processing_system7_0_DDR_DQ,
          processing_system7_0_DDR_DM               => processing_system7_0_DDR_DM,
          processing_system7_0_DDR_DQS              => processing_system7_0_DDR_DQS,
          processing_system7_0_DDR_DQS_n            => processing_system7_0_DDR_DQS_n,
          processing_system7_0_DDR_VRN              => processing_system7_0_DDR_VRN,
          processing_system7_0_DDR_VRP              => processing_system7_0_DDR_VRP,
          ahblite_axi_bridge_0_S_AHB_HSEL_pin       => ahbsi.hsel(4),
          ahblite_axi_bridge_0_S_AHB_HADDR_pin      => ahbsi.haddr,
          ahblite_axi_bridge_0_S_AHB_HPROT_pin      => ahbsi.hprot,
          ahblite_axi_bridge_0_S_AHB_HTRANS_pin     => ahbsi.htrans,
          ahblite_axi_bridge_0_S_AHB_HSIZE_pin      => ahbsi.hsize,
          ahblite_axi_bridge_0_S_AHB_HWRITE_pin     => ahbsi.hwrite,
          ahblite_axi_bridge_0_S_AHB_HBURST_pin     => ahbsi.hburst,
          ahblite_axi_bridge_0_S_AHB_HWDATA_pin     => ahbsi.hwdata,
          ahblite_axi_bridge_0_S_AHB_HREADY_OUT_pin => ahbso(4).hready,
          ahblite_axi_bridge_0_S_AHB_HREADY_IN_pin  => ahbsi.hready,
          ahblite_axi_bridge_0_S_AHB_HRDATA_pin     => ahbso(4).hrdata,
          ahblite_axi_bridge_0_S_AHB_HRESP_pin      => ahbso(4).hresp(0),
          processing_system7_0_FCLK_CLK0_pin        => clkm,
          processing_system7_0_FCLK_RESET0_N_pin    => rstn,
          processing_system7_0_FCLK_CLKTRIG0_N_pin  => '0'
        );

        calib_done <= '1';
        ahbso(4).hresp(1) <= '0';
        ahbso(4).hconfig <= hconfig;
        ahbso(4).hirq    <= (others => '0');
        ahbso(4).hindex  <= 4;
        ahbso(4).hsplit  <= (others => '0');

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
   nbits => CFG_GPT_TW, wdog => 0)
    port map (rstn, clkm, apbi, apbo(3), gpti, gpto);
    gpti.dhalt <= dsuo.tstop; gpti.extclk <= '0';
  end generate;

  nogpt : if CFG_GPT_ENABLE = 0 generate apbo(3) <= apb_none; end generate;

  gpio0 : if CFG_GRGPIO_ENABLE /= 0 generate     -- GPIO unit
    grgpio0: grgpio
    generic map(pindex => 10, paddr => 10, imask => CFG_GRGPIO_IMASK, nbits => CFG_GRGPIO_WIDTH)
    port map(rst => rstn, clk => clkm, apbi => apbi, apbo => apbo(10),
    gpioi => gpioi, gpioo => gpioo);
    pio_pads : for i in 0 to 7 generate
        pio_pad : iopad generic map (tech => padtech, level => cmos, voltage => x18v)
            port map (switch(i), gpioo.dout(i), gpioo.oen(i), gpioi.din(i));
    end generate;
    pio_pads2 : for i in 8 to 10 generate
        pio_pad : inpad generic map (tech => padtech, level => cmos, voltage => x18v)
            port map (button(i-8+1), gpioi.din(i));
    end generate;
    pio_pads3 : for i in 11 to 14 generate
        pio_pad : outpad generic map (tech => padtech, level => cmos, voltage => x33v)
            port map (led(i-11+4), gpioo.dout(i));
    end generate;
  end generate;

  ua1 : if CFG_UART1_ENABLE /= 0 generate
    uart1 : apbuart                     -- UART 1
      generic map (pindex   => 1, paddr => 1, pirq => 2, console => dbguart, 
         fifosize => CFG_UART1_FIFO)
      port map (rstn, clkm, apbi, apbo(1), u1i, u1o);
    u1i.rxd    <= rxd1;
    u1i.ctsn   <= '0';
    u1i.extclk <= '0';
    txd1       <= u1o.txd;
    serrx_pad : outpad generic map (level => cmos, voltage => x33v, tech => padtech) 
       port map (led(2), rxd1);
    sertx_pad : outpad generic map (level => cmos, voltage => x33v, tech => padtech) 
       port map (led(3), txd1);
  end generate;
  noua0 : if CFG_UART1_ENABLE = 0 generate apbo(1) <= apb_none; end generate;

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
   tech => CFG_MEMTECH, kbytes => CFG_AHBRSZ, pipe => CFG_AHBRPIPE)
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

  nam1 : for i in (maxahbs+1) to NAHBMST-1 generate
    ahbmo(i) <= ahbm_none;
  end generate;
 
 -----------------------------------------------------------------------
 ---  Boot message  ----------------------------------------------------
 -----------------------------------------------------------------------

 -- pragma translate_off
   x : report_design
   generic map (
    msg1 => "LEON3 Xilinx Zedboard Demonstration design",
    fabtech => tech_table(fabtech), memtech => tech_table(memtech),
    mdel => 1
    );
 -- pragma translate_on
 end;

