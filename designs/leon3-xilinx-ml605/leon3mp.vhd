------------------------------------------------------------------------------
--  LEON3 Demonstration design
--  Copyright (C) 2006 Jiri Gaisler, Gaisler Research
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
use ieee.numeric_std.all;

library grlib;
use grlib.config.all;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;
library techmap;
use techmap.gencomp.all;
use techmap.allclkgen.all;
library gaisler;
use gaisler.memctrl.all;
use gaisler.leon3.all;
use gaisler.uart.all;
use gaisler.misc.all;
use gaisler.i2c.all;
use gaisler.net.all;
use gaisler.jtag.all;
library esa;
use esa.memoryctrl.all;
use work.config.all;
use work.ml605.all;
-- pragma translate_off
use gaisler.sim.all;
-- pragma translate_on

entity leon3mp is
  generic (
    fabtech  : integer := CFG_FABTECH;
    memtech  : integer := CFG_MEMTECH;
    padtech  : integer := CFG_PADTECH;
    disas    : integer := CFG_DISAS;     -- Enable disassembly to console
    dbguart  : integer := CFG_DUART;     -- Print UART on console
    pclow    : integer := CFG_PCLOW;
    SIM_BYPASS_INIT_CAL : string := "OFF"
    );
  port (
    reset     : in    std_ulogic;
    errorn    : out   std_ulogic;
    clk_ref_p     : in    std_logic;
    clk_ref_n     : in    std_logic;

    -- PROM interface
    address   : out   std_logic_vector(23 downto 0);
    data      : inout std_logic_vector(15 downto 0);
    romsn     : out   std_ulogic;
    oen       : out   std_ulogic;
    writen    : out   std_ulogic;
    alatch    : out   std_ulogic;

    -- DDR3 memory
    ddr3_dq       : inout std_logic_vector(DQ_WIDTH-1 downto 0);
    ddr3_dm       : out   std_logic_vector(DM_WIDTH-1 downto 0);
    ddr3_addr     : out   std_logic_vector(ROW_WIDTH-1 downto 0);
    ddr3_ba       : out   std_logic_vector(BANK_WIDTH-1 downto 0);
    ddr3_ras_n    : out   std_logic;
    ddr3_cas_n    : out   std_logic;
    ddr3_we_n     : out   std_logic;
    ddr3_reset_n  : out   std_logic;
    ddr3_cs_n     : out   std_logic_vector((CS_WIDTH*nCS_PER_RANK)-1 downto 0);
    ddr3_odt      : out   std_logic_vector((CS_WIDTH*nCS_PER_RANK)-1 downto 0);
    ddr3_cke      : out   std_logic_vector(CKE_WIDTH-1 downto 0);
    ddr3_dqs_p    : inout std_logic_vector(DQS_WIDTH-1 downto 0);
    ddr3_dqs_n    : inout std_logic_vector(DQS_WIDTH-1 downto 0);
    ddr3_ck_p     : out   std_logic_vector(CK_WIDTH-1 downto 0);
    ddr3_ck_n     : out   std_logic_vector(CK_WIDTH-1 downto 0);

    -- Debug support unit
    dsubre    : in    std_ulogic;       -- Debug Unit break (connect to button)

    -- AHB Uart
    dsurx     : in    std_ulogic;
    dsutx     : out   std_ulogic;

    -- Ethernet signals
    gmiiclk_p : in    std_ulogic;
    gmiiclk_n : in    std_ulogic;
    egtx_clk  : out   std_ulogic;
    etx_clk   : in    std_ulogic;
    erx_clk   : in    std_ulogic;
    erxd      : in    std_logic_vector(7 downto 0);
    erx_dv    : in    std_ulogic;
    erx_er    : in    std_ulogic;
    erx_col   : in    std_ulogic;
    erx_crs   : in    std_ulogic;
    emdint    : in std_ulogic;
    etxd      : out   std_logic_vector(7 downto 0);
    etx_en    : out   std_ulogic;
    etx_er    : out   std_ulogic;
    emdc      : out   std_ulogic;
    emdio     : inout std_logic;
    erstn     : out   std_ulogic;

    iic_scl_main    : inout std_ulogic;
    iic_sda_main    : inout std_ulogic;

    dvi_iic_scl     : inout std_logic;
    dvi_iic_sda     : inout std_logic;

    tft_lcd_data    : out std_logic_vector(11 downto 0);
    tft_lcd_clk_p   : out std_ulogic;
    tft_lcd_clk_n   : out std_ulogic;
    tft_lcd_hsync   : out std_ulogic;
    tft_lcd_vsync   : out std_ulogic;
    tft_lcd_de      : out std_ulogic;
    tft_lcd_reset_b : out std_ulogic;

    clk_33          : in  std_ulogic;	-- SYSACE clock
    sysace_mpa      : out std_logic_vector(6 downto 0);
    sysace_mpce     : out std_ulogic;
    sysace_mpirq    : in  std_ulogic;
    sysace_mpoe     : out std_ulogic;
    sysace_mpwe     : out std_ulogic;
    sysace_d        : inout std_logic_vector(7 downto 0);

    -- Output signals to LEDs
    led       : out   std_logic_vector(6 downto 0)
    );
end;

architecture rtl of leon3mp is

  signal vcc : std_logic;
  signal gnd : std_logic;

  signal memi : memory_in_type;
  signal memo : memory_out_type;
  signal wpo  : wprot_out_type;

  signal gpioi : gpio_in_type;
  signal gpioo : gpio_out_type;

  signal apbi  : apb_slv_in_type;
  signal apbo  : apb_slv_out_vector := (others => apb_none);
  signal ahbsi : ahb_slv_in_type;
  signal ahbso : ahb_slv_out_vector := (others => ahbs_none);
  signal ahbmi : ahb_mst_in_type;
  signal ahbmo : ahb_mst_out_vector := (others => ahbm_none);

  signal u1i, dui : uart_in_type;
  signal u1o, duo : uart_out_type;

  signal irqi : irq_in_vector(0 to CFG_NCPU-1);
  signal irqo : irq_out_vector(0 to CFG_NCPU-1);

  signal dbgi : l3_debug_in_vector(0 to CFG_NCPU-1);
  signal dbgo : l3_debug_out_vector(0 to CFG_NCPU-1);

  signal dsui : dsu_in_type;
  signal dsuo : dsu_out_type;

  signal fpi : grfpu_in_vector_type;
  signal fpo : grfpu_out_vector_type;

  signal ethi : eth_in_type;
  signal etho : eth_out_type;

  signal gpti : gptimer_in_type;

  signal lclk, clk_ddr, lclk200      : std_ulogic;
  signal clkm, rstn, clkml  : std_ulogic;
  signal tck, tms, tdi, tdo : std_ulogic;
  signal rstraw             : std_logic;
  signal lock               : std_logic;

  signal tb_rst        : std_logic;
  signal tb_clk        : std_logic;
  signal phy_init_done : std_logic;
  signal sys_rst        : std_logic;
  signal lerrorn        : std_logic;

  -- RS232 APB Uart
  signal rxd1 : std_logic;
  signal txd1 : std_logic;

-- VGA
  signal vgao  : apbvga_out_type;
  signal lcd_datal : std_logic_vector(11 downto 0);
  signal lcd_hsyncl, lcd_vsyncl, lcd_del, lcd_reset_bl : std_ulogic;
  signal clk_sel : std_logic_vector(1 downto 0);
  signal clk100 : std_ulogic;
  signal clkvga, clkvga_p, clkvga_n : std_ulogic;

-- IIC

  signal i2ci, dvi_i2ci : i2c_in_type;
  signal i2co, dvi_i2co : i2c_out_type;

-- SYSACE
  signal clkace : std_ulogic;
  signal acei   : gracectrl_in_type;
  signal aceo   : gracectrl_out_type;

  -- Used for connecting input/output signals to the DDR3 controller
  signal migi		: mig_app_in_type;
  signal migo		: mig_app_out_type;
  
  signal counter : unsigned(31 downto 0);
  signal led_int : std_logic;


  attribute keep                     : boolean;
  attribute syn_keep                 : boolean;
  attribute syn_preserve             : boolean;
  attribute syn_keep of lock         : signal is true;
  attribute syn_keep of clk_ddr        : signal is true;
  attribute syn_keep of clkm         : signal is true;
  attribute syn_preserve of clkm     : signal is true;
  attribute syn_preserve of clk_ddr     : signal is true;
  attribute keep of lock             : signal is true;
  attribute keep of clkm             : signal is true;
  attribute keep of clk_ddr             : signal is true;

  constant VCO_FREQ  : integer := 1200000;                               -- MMCM VCO frequency in KHz
  constant CPU_FREQ   : integer := VCO_FREQ / CFG_MIG_CLK4;  -- cpu frequency in KHz
  constant I2C_FILTER : integer := (CPU_FREQ*5+50000)/100000+1;

begin

----------------------------------------------------------------------
---  Reset and Clock generation  -------------------------------------
----------------------------------------------------------------------

  vcc <= '1';
  gnd <= '0';
  alatch <= '0';
  erstn <= rstn;

  -- Glitch free reset that can be used for the Eth Phy and flash memory

  rst0 : rstgen generic map (acthigh => 1)
    port map (reset, clkm, lock, rstn, rstraw);

----------------------------------------------------------------------
---  AHB CONTROLLER --------------------------------------------------
----------------------------------------------------------------------

  ahb0 : ahbctrl
    generic map (defmast => CFG_DEFMST, split => CFG_SPLIT,
                 rrobin  => CFG_RROBIN, ioaddr => CFG_AHBIO, ioen => 1,
                 nahbm => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+CFG_SVGA_ENABLE,
                 nahbs => 8)
    port map (rstn, clkm, ahbmi, ahbmo, ahbsi, ahbso);

----------------------------------------------------------------------
---  LEON3 processor and DSU -----------------------------------------
----------------------------------------------------------------------

  -- LEON3 processor
  nosh : if CFG_GRFPUSH = 0 generate
    cpu : for i in 0 to CFG_NCPU-1 generate
      l3ft : if CFG_LEON3FT_EN /= 0 generate
        leon3ft0 : leon3ft		-- LEON3 processor
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
        u0 : leon3s 		-- LEON3 processor
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
	  0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
	  CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
	  CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
          CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
          CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, CFG_NCPU-1,
	  CFG_DFIXED, CFG_SCAN, CFG_MMU_PAGE)
        port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso,
    		irqi(i), irqo(i), dbgi(i), dbgo(i));
      end generate;
    end generate;
  end generate;

  sh : if CFG_GRFPUSH = 1 generate
    cpu : for i in 0 to CFG_NCPU-1 generate
      l3ft : if CFG_LEON3FT_EN /= 0 generate
        leon3ft0 : leon3ftsh		-- LEON3 processor
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
        u0 : leon3sh 		-- LEON3 processor
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

  lerrorn <= dbgo(0).error and rstn;
  error_pad : odpad generic map (level => cmos, voltage => x25v, tech => padtech) port map (errorn, lerrorn);

  dsugen : if CFG_DSU = 1 generate
    -- LEON3 Debug Support Unit
    dsugen : if CFG_DSU = 1 generate
      dsu0 : dsu3
        generic map (hindex => 2, haddr => 16#900#, hmask => 16#F00#,
                     ncpu   => CFG_NCPU, tbits => 30, tech => memtech, irq => 0, kbytes => CFG_ATBSZ)
        port map (rstn, clkm, ahbmi, ahbsi, ahbso(2), dbgo, dbgi, dsui, dsuo);

      dsubre_pad : inpad generic map (level => cmos, voltage => x15v, tech  => padtech) port map (dsubre, dsui.break);

      dsui.enable <= '1';
      led(2) <= dsuo.active;
    end generate;
  end generate;
  nodsu : if CFG_DSU = 0 generate
    ahbso(2) <= ahbs_none; dsuo.tstop <= '0'; dsuo.active <= '0';
  end generate;

  -- Debug UART
  dcomgen : if CFG_AHB_UART = 1 generate
    dcom0 : ahbuart
      generic map (hindex => CFG_NCPU, pindex => 4, paddr => 7)
      port map (rstn, clkm, dui, duo, apbi, apbo(4), ahbmi, ahbmo(CFG_NCPU));
    dsurx_pad : inpad generic map (level => cmos, voltage => x25v, tech  => padtech) port map (dsurx, dui.rxd);
    dsutx_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech) port map (dsutx, duo.txd);
    led(0) <= not dui.rxd;
    led(1) <= not duo.txd;
  end generate;
  nouah : if CFG_AHB_UART = 0 generate apbo(4) <= apb_none; end generate;

  ahbjtaggen0 :if CFG_AHB_JTAG = 1 generate
    ahbjtag0 : ahbjtag generic map(tech => fabtech, hindex => CFG_NCPU+CFG_AHB_UART)
      port map(rstn, clkm, tck, tms, tdi, tdo, ahbmi, ahbmo(CFG_NCPU+CFG_AHB_UART),
               open, open, open, open, open, open, open, gnd);
  end generate;

----------------------------------------------------------------------
---  Memory controllers ----------------------------------------------
----------------------------------------------------------------------

  mg2 : if CFG_MCTRL_LEON2 = 1 generate        -- LEON2 memory controller
    sr1 : mctrl generic map (hindex => 5, pindex => 0, paddr => 0,
	ram8 => CFG_MCTRL_RAM8BIT, ram16 => CFG_MCTRL_RAM16BIT, iomask => 0, rammask => 0)
      port map (rstn, clkm, memi, memo, ahbsi, ahbso(5), apbi, apbo(0), wpo, open);
  end generate;

  memi.brdyn  <= '1';
  memi.bexcn  <= '1';
  memi.writen <= '1';
  memi.wrn    <= "1111";
  memi.bwidth <= "01";

  mg0 : if (CFG_MCTRL_LEON2 = 0) generate
    apbo(0) <= apb_none;
    ahbso(5) <= ahbs_none;
    roms_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (romsn, vcc);
    memo.bdrive(0) <= '1';
  end generate;

  mgpads : if (CFG_MCTRL_LEON2 /= 0) generate
    addr_pad : outpadv generic map (level => cmos, voltage => x25v, tech => padtech, width => 24)
      port map (address, memo.address(24 downto 1));
    roms_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (romsn, memo.romsn(0));
    oen_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (oen, memo.oen);
    wri_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (writen, memo.writen);
  end generate;

  bdr : iopadvv generic map (level => cmos, voltage => x25v, tech => padtech, width => 16)
    port map (data(15 downto 0), memo.data(31 downto 16),
              memo.vbdrive(31 downto 16), memi.data(31 downto 16));

----------------------------------------------------------------------
---  DDR3 memory controller ------------------------------------------
----------------------------------------------------------------------

--  mig_gen : if (CFG_MIG_DDR2 = 1) generate

    ahb2mig0 : ahb2mig_ml605
      generic map ( hindex => 0, haddr => 16#400#, hmask => 16#E00#,
    MHz => 400, Mbyte => 512, nosync => boolean'pos(CFG_MIG_CLK4=12)) --CFG_CLKDIV/12)
      port map (
    rst => rstn, clk_ahb => clkm, clk_ddr => clk_ddr,
    ahbsi => ahbsi, ahbso => ahbso(0), migi => migi, migo => migo);

    ddr3ctrl : entity work.mig_37
     generic map (SIM_BYPASS_INIT_CAL => SIM_BYPASS_INIT_CAL,CLKOUT_DIVIDE4 => CFG_MIG_CLK4)
     port map(
      clk_ref_p         =>   clk_ref_p,
      clk_ref_n         =>   clk_ref_n,
      ddr3_dq           =>   ddr3_dq,
      ddr3_addr         =>   ddr3_addr,
      ddr3_ba           =>   ddr3_ba,
      ddr3_ras_n        =>   ddr3_ras_n,
      ddr3_cas_n        =>   ddr3_cas_n,
      ddr3_we_n         =>   ddr3_we_n,
      ddr3_reset_n      =>   ddr3_reset_n,
      ddr3_cs_n         =>   ddr3_cs_n,
      ddr3_odt          =>   ddr3_odt,
      ddr3_cke          =>   ddr3_cke,
      ddr3_dm           =>   ddr3_dm,
      ddr3_dqs_p        =>   ddr3_dqs_p,
      ddr3_dqs_n        =>   ddr3_dqs_n,
      ddr3_ck_p         =>   ddr3_ck_p,
      ddr3_ck_n         =>   ddr3_ck_n,
      app_wdf_wren      =>   migi.app_wdf_wren,
      app_wdf_data      =>   migi.app_wdf_data,
      app_wdf_mask      =>   migi.app_wdf_mask,
      app_wdf_end       =>   migi.app_wdf_end,
      app_addr          =>   migi.app_addr,
      app_cmd           =>   migi.app_cmd,
      app_en            =>   migi.app_en,
      app_rdy           =>   migo.app_rdy,
      app_wdf_rdy       =>   migo.app_wdf_rdy,
      app_rd_data       =>   migo.app_rd_data,
      app_rd_data_valid =>   migo.app_rd_data_valid,
      tb_rst            =>   open,
      tb_clk            =>   clk_ddr,
      clk_ahb           =>   clkm,
      clk100            =>   clk100,
      phy_init_done     =>   phy_init_done,
      sys_rst           =>   rstraw
    );

    led(3) <= phy_init_done;
    led(4) <= ahbmi.hready;
    led(5) <= reset;
    led(6) <= led_int;
    sys_rst <= reset;
    lock <= phy_init_done; -- and cgo.clklock;
--   end generate;
--  noddr : if (CFG_DDR2SP+CFG_MIG_DDR2) = 0 generate lock <= cgo.clklock; end generate;

 regs : process(clkm,rstn)
  begin
    if (rstn = '0') then
       counter <= (others => '0');
       led_int <= '0';
    elsif rising_edge(clkm) then
       if (counter >= 75000000) then
          counter <= (others => '0');
          led_int <= not led_int;
       else
          counter <= counter + 1;
          led_int <= led_int;
       end if;
    end if;
  end process;
----------------------------------------------------------------------
---  System ACE I/F Controller ---------------------------------------
----------------------------------------------------------------------

  grace: if CFG_GRACECTRL = 1 generate
    grace0 : gracectrl generic map (hindex => 7, hirq => 10, mode => 2,
        haddr => 16#002#, hmask => 16#fff#, split => CFG_SPLIT)
      port map (rstn, clkm, clkace, ahbsi, ahbso(7), acei, aceo);
  end generate;
  nograce: if CFG_GRACECTRL /= 1 generate
    aceo <= gracectrl_none;
  end generate;

  clk_33_pad : clkpad generic map (level => cmos, voltage => x25v, tech => padtech)
        port map (clk_33, clkace);
  sysace_mpa_pads : outpadv generic map (level => cmos, voltage => x25v, width => 7, tech => padtech)
    port map (sysace_mpa, aceo.addr);
  sysace_mpce_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (sysace_mpce, aceo.cen);
  sysace_d_pads : iopadv generic map (level => cmos, voltage => x25v, tech => padtech, width => 8)
    port map (sysace_d(7 downto 0), aceo.do(7 downto 0), aceo.doen, acei.di(7 downto 0));
  acei.di(15 downto 8) <= (others => '0');
  sysace_mpoe_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (sysace_mpoe, aceo.oen);
  sysace_mpwe_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (sysace_mpwe, aceo.wen);
  sysace_mpirq_pad : inpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (sysace_mpirq, acei.irq);

----------------------------------------------------------------------
---  APB Bridge and various periherals -------------------------------
----------------------------------------------------------------------

  -- APB Bridge
  apb0 : apbctrl
    generic map (hindex => 1, haddr => CFG_APBADDR)
    port map (rstn, clkm, ahbsi, ahbso(1), apbi, apbo);

  -- Interrupt controller
  irqctrl : if CFG_IRQ3_ENABLE /= 0 generate
    irqctrl0 : irqmp
      generic map (pindex => 2, paddr => 2, ncpu => CFG_NCPU)
      port map (rstn, clkm, apbi, apbo(2), irqo, irqi);
  end generate;
  irq3 : if CFG_IRQ3_ENABLE = 0 generate
    x : for i in 0 to CFG_NCPU-1 generate
      irqi(i).irl <= "0000";
    end generate;
    apbo(2) <= apb_none;
  end generate;

  -- Time Unit
  gpt : if CFG_GPT_ENABLE /= 0 generate
    timer0 : gptimer
      generic map (pindex => 3, paddr => 3, pirq => CFG_GPT_IRQ,
                   sepirq => CFG_GPT_SEPIRQ, sbits => CFG_GPT_SW,
                   ntimers => CFG_GPT_NTIM, nbits  => CFG_GPT_TW)
      port map (rstn, clkm, apbi, apbo(3), gpti, open);
    gpti.dhalt  <= dsuo.tstop;
    gpti.extclk <= '0';
  end generate;
  notim : if CFG_GPT_ENABLE = 0 generate apbo(3) <= apb_none; end generate;

  -- GPIO Unit
  gpio0 : if CFG_GRGPIO_ENABLE /= 0 generate
    grgpio0: grgpio
      generic map(pindex => 11, paddr => 11, imask => CFG_GRGPIO_IMASK, nbits => 12)
      port map(rstn, clkm, apbi, apbo(11), gpioi, gpioo);
  end generate;

  ua1 : if CFG_UART1_ENABLE /= 0 generate
    uart1 : apbuart                     -- UART 1
      generic map (pindex   => 1, paddr => 1, pirq => 2, console => dbguart, fifosize => CFG_UART1_FIFO)
      port map (rstn, clkm, apbi, apbo(1), u1i, u1o);
    u1i.rxd    <= rxd1;
    u1i.ctsn   <= '0';
    u1i.extclk <= '0';
    txd1       <= u1o.txd;
    serrx_pad : inpad generic map (level => cmos, voltage => x25v, tech  => padtech) port map (dsurx, rxd1);
    sertx_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech) port map (dsutx, txd1);
    led(0) <= not rxd1;
    led(1) <= not txd1;
  end generate;
  noua0 : if CFG_UART1_ENABLE = 0 generate apbo(1) <= apb_none; end generate;


  i2cm: if CFG_I2C_ENABLE = 1 generate  -- I2C master
    i2c0 : i2cmst
    generic map (pindex => 12, paddr => 12, pmask => 16#FFF#,
                 pirq => 11, filter => I2C_FILTER)
    port map (rstn, clkm, apbi, apbo(12), i2ci, i2co);
    i2c_scl_pad : iopad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (iic_scl_main, i2co.scl, i2co.scloen, i2ci.scl);
    i2c_sda_pad : iopad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (iic_sda_main, i2co.sda, i2co.sdaoen, i2ci.sda);
  end generate i2cm;

-----------------------------------------------------------------------
---  VGA + IIC --------------------------------------------------------
-----------------------------------------------------------------------

  vga : if CFG_VGA_ENABLE /= 0 generate
    vga0 : apbvga generic map(memtech => memtech, pindex => 6, paddr => 6)
      port map(rstn, clkm, clkvga, apbi, apbo(6), vgao);
      clk_sel <= "00";
  end generate;

  svga : if CFG_SVGA_ENABLE /= 0 generate
    svga0 : svgactrl generic map(memtech => memtech, pindex => 6, paddr => 6,
        hindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG, clk0 => 40000,
	clk1 => 24000, clk2 => 20000, clk3 => 16000, burstlen => 4,
                                 ahbaccsz => CFG_AHBDW)
       port map(rstn, clkm, clkvga, apbi, apbo(6), vgao, ahbmi,
		ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG), clk_sel);
  end generate;

  vgadvi : if (CFG_VGA_ENABLE + CFG_SVGA_ENABLE) /= 0 generate
    dvi0 : entity work.svga2ch7301c generic map (tech => fabtech, idf => 2)
      port map (clk100, ethi.gtx_clk, lock, clk_sel, vgao, clkvga, clkvga_p, clkvga_n,
                lcd_datal, lcd_hsyncl, lcd_vsyncl, lcd_del);

    i2cdvi : i2cmst
      generic map (pindex => 9, paddr => 9, pmask => 16#FFF#,
                   pirq => 14, filter => I2C_FILTER)
      port map (rstn, clkm, apbi, apbo(9), dvi_i2ci, dvi_i2co);
  end generate;

  novga : if (CFG_VGA_ENABLE + CFG_SVGA_ENABLE) = 0 generate
     apbo(6) <= apb_none;
     lcd_datal <= (others => '0'); clkvga_p <= '0'; clkvga_n <= '0';
     lcd_hsyncl <= '0'; lcd_vsyncl <= '0'; lcd_del <= '0';
     dvi_i2co.scloen <= '1'; dvi_i2co.sdaoen <= '1';
  end generate;

  tft_lcd_data_pad : outpadv generic map (level => cmos, voltage => x25v, width => 12, tech => padtech)
        port map (tft_lcd_data, lcd_datal);
  tft_lcd_clkp_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (tft_lcd_clk_p, clkvga_p);
  tft_lcd_clkn_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (tft_lcd_clk_n, clkvga_n);
  tft_lcd_hsync_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (tft_lcd_hsync, lcd_hsyncl);
  tft_lcd_vsync_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (tft_lcd_vsync, lcd_vsyncl);
  tft_lcd_de_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (tft_lcd_de, lcd_del);
  tft_lcd_reset_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (tft_lcd_reset_b, rstn);
  dvi_i2c_scl_pad : iopad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (dvi_iic_scl, dvi_i2co.scl, dvi_i2co.scloen, dvi_i2ci.scl);
  dvi_i2c_sda_pad : iopad generic map (level => cmos, voltage => x25v, tech => padtech)
    port map (dvi_iic_sda, dvi_i2co.sda, dvi_i2co.sdaoen, dvi_i2ci.sda);

-----------------------------------------------------------------------
---  ETHERNET ---------------------------------------------------------
-----------------------------------------------------------------------

  eth0 : if CFG_GRETH = 1 generate -- Gaisler ethernet MAC
    e1 : grethm
      generic map(hindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE,
        pindex => 15, paddr => 15, pirq => 12, memtech => memtech,
        mdcscaler => CPU_FREQ/1000, enable_mdio => 1, fifosize => CFG_ETH_FIFO,
        nsync => 1, edcl => CFG_DSU_ETH, edclbufsz => CFG_ETH_BUF,
        macaddrh => CFG_ETH_ENM, macaddrl => CFG_ETH_ENL, phyrstadr => 7,
        ipaddrh => CFG_ETH_IPM, ipaddrl => CFG_ETH_IPL, giga => CFG_GRETH1G,
	enable_mdint => 1)
      port map(rst => rstn, clk => clkm, ahbmi => ahbmi,
               ahbmo => ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE),
               apbi => apbi, apbo => apbo(15), ethi => ethi, etho => etho);
  end generate;

--  greth1g: if CFG_GRETH1G = 1 generate
    gtxclk0 : entity work.gtxclk port map (
	clk_p => gmiiclk_p, clk_n => gmiiclk_n, clkint => ethi.gtx_clk,
	clkout => egtx_clk);
--  end generate;

  ethpads : if (CFG_GRETH = 1) generate -- eth pads
    emdio_pad : iopad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (emdio, etho.mdio_o, etho.mdio_oe, ethi.mdio_i);
    etxc_pad : clkpad generic map (level => cmos, voltage => x25v, tech => padtech, arch => 2)
      port map (etx_clk, ethi.tx_clk);
    erxc_pad : clkpad generic map (level => cmos, voltage => x25v, tech => padtech, arch => 2)
      port map (erx_clk, ethi.rx_clk);
    erxd_pad : inpadv generic map (level => cmos, voltage => x25v, tech => padtech, width => 8)
      port map (erxd, ethi.rxd(7 downto 0));
    erxdv_pad : inpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (erx_dv, ethi.rx_dv);
    erxer_pad : inpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (erx_er, ethi.rx_er);
    erxco_pad : inpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (erx_col, ethi.rx_col);
    erxcr_pad : inpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (erx_crs, ethi.rx_crs);
    emdint_pad : inpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (emdint, ethi.mdint);


    etxd_pad : outpadv generic map (level => cmos, voltage => x25v, tech => padtech, width => 8)
      port map (etxd, etho.txd(7 downto 0));
    etxen_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (etx_en, etho.tx_en);
    etxer_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (etx_er, etho.tx_er);
    emdc_pad : outpad generic map (level => cmos, voltage => x25v, tech => padtech)
      port map (emdc, etho.mdc);
  end generate;

-----------------------------------------------------------------------
---  AHB ROM ----------------------------------------------------------
-----------------------------------------------------------------------

  bpromgen : if CFG_AHBROMEN /= 0 generate
    brom : entity work.ahbrom
      generic map (hindex => 6, haddr => CFG_AHBRODDR, pipe => CFG_AHBROPIP)
      port map ( rstn, clkm, ahbsi, ahbso(6));
  end generate;
  nobpromgen : if CFG_AHBROMEN = 0 generate
     ahbso(6) <= ahbs_none;
  end generate;

-----------------------------------------------------------------------
---  AHB RAM ----------------------------------------------------------
-----------------------------------------------------------------------

  ahbramgen : if CFG_AHBRAMEN = 1 generate
    ahbram0 : ahbram
      generic map (hindex => 3, haddr => CFG_AHBRADDR, tech => CFG_MEMTECH, kbytes => CFG_AHBRSZ)
      port map (rstn, clkm, ahbsi, ahbso(3));
  end generate;
  nram : if CFG_AHBRAMEN = 0 generate ahbso(3) <= ahbs_none; end generate;

-----------------------------------------------------------------------
---  Test report module  ----------------------------------------------
-----------------------------------------------------------------------

-- pragma translate_off

  test0 : ahbrep generic map (hindex => 4, haddr => 16#200#)
	port map (rstn, clkm, ahbsi, ahbso(4));

-- pragma translate_on

-----------------------------------------------------------------------
---  Drive unused bus elements  ---------------------------------------
-----------------------------------------------------------------------

  nam1 : for i in (CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH+1) to NAHBMST-1 generate
    ahbmo(i) <= ahbm_none;
  end generate;

-----------------------------------------------------------------------
---  Boot message  ----------------------------------------------------
-----------------------------------------------------------------------

-- pragma translate_off
  x : report_version
    generic map (
      msg1 => "LEON3 Demonstration design for Xilinx Virtex6 ML605 board",
      msg2 => "GRLIB Version " & tost(LIBVHDL_VERSION/1000) & "." & tost((LIBVHDL_VERSION mod 1000)/100)
        & "." & tost(LIBVHDL_VERSION mod 100) & ", build " & tost(LIBVHDL_BUILD),
      msg3 => "Target technology: " & tech_table(fabtech) & ",  memory library: " & tech_table(memtech),
      mdel => 1
      );
-- pragma translate_on

end rtl;
