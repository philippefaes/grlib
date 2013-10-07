-----------------------------------------------------------------------------
--  LEON3 Demonstration design
--  Copyright (C) 2008 Jiri Gaisler, Jan Andersson, Aeroflex Gaisler
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
use techmap.gencomp.all;
use techmap.allclkgen.all;
library gaisler;
use gaisler.memctrl.all;
use gaisler.leon3.all;
use gaisler.uart.all;
use gaisler.misc.all;
use gaisler.spi.all;
use gaisler.i2c.all;
use gaisler.net.all;
use gaisler.jtag.all;
use gaisler.pci.all;
use gaisler.ddrpkg.all;

library esa;
use esa.memoryctrl.all;
use esa.pcicomp.all;
use work.config.all;

-- pragma translate_off
library unisim;
use unisim.BUFG;
-- pragma translate_on

entity leon3mp is
  generic (
    fabtech   : integer := CFG_FABTECH;
    memtech   : integer := CFG_MEMTECH;
    padtech   : integer := CFG_PADTECH;
    ncpu      : integer := CFG_NCPU;
    disas     : integer := CFG_DISAS;	-- Enable disassembly to console
    dbguart   : integer := CFG_DUART;	-- Print UART on console
    pclow     : integer := CFG_PCLOW
  );
  port (
    fpga_cpu_reset_b : in  std_ulogic;
    user_clksys      : in  std_ulogic; 	-- 100 MHz main clock
    sysace_fpga_clk  : in  std_ulogic;  -- 33 MHz

    -- Flash
    flash_we_b       : out std_ulogic;
    flash_wait       : in  std_ulogic;
    flash_reset_b    : out std_ulogic;
    flash_oe_b       : out std_ulogic;
    flash_d          : inout std_logic_vector(15 downto 0);
    flash_clk        : out std_ulogic;
    flash_ce_b       : out std_ulogic;
    flash_adv_b      : out std_logic;
    flash_a          : out std_logic_vector(21 downto 0);    
--pragma translate_off
    -- For debug output module 
    sram_bw          : out std_ulogic;
    sim_d            : inout std_logic_vector(31 downto 16);
    iosn             : out std_ulogic;
--pragma translate_on

    -- DDR2 slot 1
    dimm1_ddr2_we_b  : out std_ulogic;
    dimm1_ddr2_s_b   : out std_logic_vector(1 downto 0);
    dimm1_ddr2_ras_b : out std_ulogic;
    dimm1_ddr2_pll_clkin_p : out std_ulogic;
    dimm1_ddr2_pll_clkin_n : out std_ulogic;
    dimm1_ddr2_odt   : out std_logic_vector(1 downto 0);
    dimm1_ddr2_dqs_p : inout std_logic_vector(8 downto 0);
    dimm1_ddr2_dqs_n : inout std_logic_vector(8 downto 0);
    dimm1_ddr2_dqm   : out std_logic_vector(8 downto 0);
    dimm1_ddr2_dq    : inout std_logic_vector(71 downto 0);
    dimm1_ddr2_cke   : out std_logic_vector(1 downto 0);
--    dimm1_ddr2_cb    : inout std_logic_vector(7 downto 0);
    dimm1_ddr2_cas_b : out std_ulogic;
    dimm1_ddr2_ba    : out std_logic_vector(2 downto 0);
    dimm1_ddr2_a     : out std_logic_vector(13 downto 0);

    -- DDR2 slot 0
    dimm0_ddr2_we_b  : out std_ulogic;
    dimm0_ddr2_s_b   : out std_logic_vector(1 downto 0);
    dimm0_ddr2_ras_b : out std_ulogic;
    dimm0_ddr2_pll_clkin_p : out std_ulogic;
    dimm0_ddr2_pll_clkin_n : out std_ulogic;
    dimm0_ddr2_odt   : out std_logic_vector(1 downto 0);
    dimm0_ddr2_dqs_p : inout std_logic_vector(8 downto 0);
    dimm0_ddr2_dqs_n : inout std_logic_vector(8 downto 0);
    dimm0_ddr2_dqm   : out std_logic_vector(8 downto 0);
    dimm0_ddr2_dq    : inout std_logic_vector(71 downto 0);
    dimm0_ddr2_cke   : out std_logic_vector(1 downto 0);
--    dimm0_ddr2_cb    : inout std_logic_vector(7 downto 0);
    dimm0_ddr2_cas_b : out std_ulogic;
    dimm0_ddr2_ba    : out std_logic_vector(2 downto 0);
    dimm0_ddr2_a     : out std_logic_vector(13 downto 0);
    dimm0_ddr2_reset_n : out std_ulogic;

    -- Ethernet PHY
    phy0_txer        : out std_ulogic;
    phy0_txd         : out std_logic_vector(3 downto 0);
    phy0_txctl_txen  : out std_ulogic;
    phy0_txclk       : in  std_ulogic;
    phy0_rxer        : in  std_ulogic;
    phy0_rxd         : in  std_logic_vector(3 downto 0);
    phy0_rxctl_rxdv  : in  std_ulogic;
    phy0_rxclk       : in  std_ulogic;
    phy0_reset       : out std_ulogic;
    phy0_mdio        : inout std_logic;
    phy0_mdc         : out std_ulogic;
--    phy0_int         : in  std_ulogic;

    -- System ACE MPU
    sysace_mpa       : out std_logic_vector(6 downto 0);
    sysace_mpce      : out std_ulogic;
    sysace_mpirq     : in  std_ulogic;
    sysace_mpoe      : out std_ulogic;
    sysace_mpwe      : out std_ulogic;
    sysace_mpd       : inout std_logic_vector(15 downto 0);

    -- GPIO/Green LEDs
    dbg_led          : inout std_logic_vector(3 downto 0);

    -- Red/Green LEDs
    opb_bus_error    : out std_ulogic;
    plb_bus_error    : out std_ulogic;

    -- LCD
--     fpga_lcd_rw      : out std_ulogic;
--     fpga_lcd_rs      : out std_ulogic;
--     fpga_lcd_e       : out std_ulogic;
--     fpga_lcd_db      : out std_logic_vector(7 downto 0);

    -- DVI
    dvi_xclk_p       : out std_ulogic;
    dvi_xclk_n       : out std_ulogic;
    dvi_v            : out std_ulogic;
    dvi_reset_b      : out std_ulogic;
    dvi_h            : out std_ulogic;
    dvi_gpio1        : inout std_logic;
    dvi_de           : out std_ulogic;
    dvi_d            : out std_logic_vector(11 downto 0);

    -- PCI
    pci_p_trdy_b     : inout std_logic;
    pci_p_stop_b     : inout std_logic;
    pci_p_serr_b     : inout std_logic;
    pci_p_rst_b      : inout std_logic;
    pci_p_req_b      : in  std_logic_vector(0 to 4);
    pci_p_perr_b     : inout std_logic;
    pci_p_par        : inout std_logic;
    pci_p_lock_b     : inout std_logic;
    pci_p_irdy_b     : inout std_logic;
    pci_p_intd_b     : in std_logic;
    pci_p_intc_b     : in std_logic;
    pci_p_intb_b     : in std_logic;
    pci_p_inta_b     : in std_logic;
    pci_p_gnt_b      : out std_logic_vector(0 to 4);
    pci_p_frame_b    : inout std_logic;
    pci_p_devsel_b   : inout std_logic;
    pci_p_clk5_r     : out std_ulogic;
    pci_p_clk5       : in  std_ulogic;
    pci_p_clk4_r     : out std_ulogic;
    pci_p_clk3_r     : out std_ulogic;
    pci_p_clk1_r     : out std_ulogic;
    pci_p_clk0_r     : out std_ulogic;
    pci_p_cbe_b      : inout std_logic_vector(3 downto 0);
    pci_p_ad         : inout std_logic_vector(31 downto 0);
--    pci_fpga_idsel   : in  std_ulogic;

    sbr_pwg_rsm_rstj : inout std_logic;
    sbr_nmi_r        : in  std_ulogic;
    sbr_intr_r       : in  std_ulogic;
    sbr_ide_rst_b    : inout std_logic;
    
    -- IIC/SMBus and sideband signals
    iic_sda_dvi      : inout std_logic;
    iic_scl_dvi      : inout std_logic;
    fpga_sda         : inout std_logic;
    fpga_scl         : inout std_logic;
    iic_therm_b      : in  std_ulogic;
    iic_reset_b      : out std_ulogic;
    iic_irq_b        : in  std_ulogic;
    iic_alert_b      : in  std_ulogic;

    -- SPI
    spi_data_out     : in  std_logic;
    spi_data_in      : out std_ulogic;
    spi_data_cs_b    : out std_ulogic;
    spi_clk          : out std_ulogic;
    
    -- UARTs
    uart1_txd        : out std_ulogic;
    uart1_rxd        : in  std_ulogic;
    uart1_rts_b      : out std_ulogic;
    uart1_cts_b      : in  std_ulogic;
    uart0_txd        : out std_ulogic;
    uart0_rxd        : in  std_ulogic;
    uart0_rts_b      : out std_ulogic
--    uart0_cts_b      : in  std_ulogic

    -- System monitor
--    test_mon_vrefp   : in std_ulogic;
--    test_mon_vp0_p   : in std_ulogic;
--    test_mon_vn0_n   : in std_ulogic
--    test_mon_avdd    : in std_ulogic    
    );
end;

architecture rtl of leon3mp is

component svga2ch7301c
  generic (
    tech    : integer := 0;
    idf     : integer := 0;
    dynamic : integer := 0
    );
  port (
    clk         : in  std_ulogic;
    rstn        : in  std_ulogic;
    clksel      : in  std_logic_vector(1 downto 0);
    vgao        : in  apbvga_out_type;
    vgaclk_fb   : in  std_ulogic;
    clk25_fb    : in  std_ulogic;
    clk40_fb    : in  std_ulogic;
    clk65_fb    : in  std_ulogic;
    vgaclk      : out std_ulogic;
    clk25       : out std_ulogic;
    clk40       : out std_ulogic;
    clk65       : out std_ulogic;
    dclk_p      : out std_ulogic;
    dclk_n      : out std_ulogic;
    locked      : out std_ulogic;
    data        : out std_logic_vector(11 downto 0);
    hsync       : out std_ulogic;
    vsync       : out std_ulogic;
    de          : out std_ulogic
    );
end component;

component BUFG port (O : out std_logic; I : in std_logic); end component;

constant blength : integer := 12;
constant fifodepth : integer := 8;
constant maxahbm : integer := NCPU+CFG_AHB_UART+CFG_AHB_JTAG+
                              CFG_SVGA_ENABLE+CFG_PCI;
               
-- Set this constant to 1 to include an APB bridge with the Logan logic
-- analyzer attached to the PCI signals
constant CFG_LOGAN : integer := 0;
               
signal ddr0_clk_fb, ddr1_clk_fb  : std_logic;
signal vcc, gnd   : std_logic_vector(31 downto 0);
signal memi  : memory_in_type;
signal memo  : memory_out_type;
signal wpo   : wprot_out_type;

signal apbi, apbi1  : apb_slv_in_type;
signal apbo, apbo1  : apb_slv_out_vector := (others => apb_none);
signal ahbsi : ahb_slv_in_type;
signal ahbso : ahb_slv_out_vector := (others => ahbs_none);
signal ahbmi : ahb_mst_in_type;
signal ahbmo : ahb_mst_out_vector := (others => ahbm_none);

signal clkm, clkm2x, rstn, rstraw, flashclkl : std_ulogic;
signal clkddr, clk_200 : std_ulogic;
signal clk25, clk40, clk65 : std_ulogic;

signal cgi, cgi2, cgi3 : clkgen_in_type;
signal cgo, cgo2, cgo3 : clkgen_out_type;

signal u1i, dui : uart_in_type;
signal u1o, duo : uart_out_type;

signal irqi : irq_in_vector(0 to NCPU-1);
signal irqo : irq_out_vector(0 to NCPU-1);

signal dbgi : l3_debug_in_vector(0 to NCPU-1);
signal dbgo : l3_debug_out_vector(0 to NCPU-1);

signal dsui : dsu_in_type;
signal dsuo : dsu_out_type; 

signal opb_bus_errorl, plb_bus_errorl : std_ulogic;

signal ethi, ethi1, ethi2 : eth_in_type;
signal etho, etho1, etho2 : eth_out_type;

signal gpti : gptimer_in_type;

signal gpioi : gpio_in_type;
signal gpioo : gpio_out_type;

signal clklock, lock0, lock1, lclk, clkml0, clkml1 : std_ulogic;
signal tck, tckn, tms, tdi, tdo : std_ulogic;
signal rst : std_ulogic;

signal egtx_clk_fb : std_ulogic;
signal egtx_clk, legtx_clk, l2egtx_clk : std_ulogic;

signal vgao  : apbvga_out_type;
signal lcd_datal : std_logic_vector(11 downto 0);
signal lcd_hsyncl, lcd_vsyncl, lcd_del, lcd_reset_bl : std_ulogic;
signal clk_sel : std_logic_vector(1 downto 0);
signal vgalock : std_ulogic;
signal clkvga, clkvga_p, clkvga_n : std_ulogic;

signal i2ci, dvi_i2ci : i2c_in_type;
signal i2co, dvi_i2co : i2c_out_type;

signal spii : spi_in_type;
signal spio : spi_out_type;
signal slvsel : std_logic_vector(CFG_SPICTRL_SLVS-1 downto 0);

constant BOARD_FREQ_200 : integer := 200000;   -- input frequency in KHz
constant BOARD_FREQ : integer := 100000;   -- input frequency in KHz
constant CPU_FREQ : integer := BOARD_FREQ * CFG_CLKMUL / CFG_CLKDIV;  -- cpu frequency in KHz
constant I2C_FILTER : integer := (CPU_FREQ*5+50000)/100000+1;

-- DDR clock is 200 MHz clock unless CFG_DDR2SP_NOSYNC is set. If that config
-- option is set the DDR clock is 2x CPU clock.
constant DDR_FREQ : integer :=
  BOARD_FREQ_200 - (BOARD_FREQ_200 - 2*CPU_FREQ)*CFG_DDR2SP_NOSYNC;

constant IOAEN : integer := CFG_DDR2SP;

signal stati : ahbstat_in_type;

signal ddr0_clkv 	: std_logic_vector(2 downto 0);
signal ddr0_clkbv	: std_logic_vector(2 downto 0);
signal ddr1_clkv 	: std_logic_vector(2 downto 0);
signal ddr1_clkbv	: std_logic_vector(2 downto 0);

signal clkace : std_ulogic;
signal acei   : gracectrl_in_type;
signal aceo   : gracectrl_out_type;

signal sysmoni : grsysmon_in_type;
signal sysmono : grsysmon_out_type;

signal pciclk, pci_clk, pci_clk_fb : std_ulogic;
signal pci_arb_gnt : std_logic_vector(0 to 7);
signal pci_arb_req : std_logic_vector(0 to 7);
signal pci_arb_reql : std_logic_vector(0 to 4);
signal pci_reql : std_ulogic;
signal pci_host, pci_66 : std_ulogic;
signal pci_intv : std_logic_vector(3 downto 0);
signal pcii : pci_in_type;
signal pcio : pci_out_type;
signal clkma, clkmb, clkmc : std_ulogic;

signal clk0_tb, rst0_tb, rst0_tbn : std_ulogic;
signal phy_init_done : std_ulogic;
-- Logan signals
signal signals : std_logic_vector(63*CFG_LOGAN downto 0);       

attribute syn_keep : boolean;
attribute syn_preserve : boolean;
attribute syn_keep of clkml0 : signal is true;
attribute syn_preserve of clkml0 : signal is true;
attribute syn_keep of clkml1 : signal is true;
attribute syn_preserve of clkml1 : signal is true;
attribute syn_keep of clkm : signal is true;
attribute syn_preserve of clkm : signal is true;
attribute syn_keep of egtx_clk : signal is true;
attribute syn_preserve of egtx_clk : signal is true;
attribute syn_keep of clkvga : signal is true;
attribute syn_preserve of clkvga : signal is true;
attribute syn_keep of clk25 : signal is true;
attribute syn_preserve of clk25 : signal is true;
attribute syn_keep of clk40 : signal is true;
attribute syn_preserve of clk40 : signal is true;
attribute syn_keep of clk65 : signal is true;
attribute syn_preserve of clk65 : signal is true;
attribute syn_keep of phy_init_done : signal is true;
attribute syn_preserve of phy_init_done : signal is true;

attribute keep : boolean;
attribute keep of lock0 : signal is true;
attribute keep of lock1 : signal is true;
attribute keep of clkml0 : signal is true;
attribute keep of clkml1 : signal is true;
attribute keep of clkm : signal is true;
attribute keep of egtx_clk : signal is true;
attribute keep of clkvga : signal is true;
attribute keep of clk25 : signal is true;
attribute keep of clk40 : signal is true;
attribute keep of clk65 : signal is true;

attribute syn_noprune : boolean;
attribute syn_noprune of sysace_fpga_clk_pad : label is true;
               
begin

  vcc <= (others => '1'); gnd <= (others => '0');
  rst0_tbn <= not rst0_tb; 
----------------------------------------------------------------------
---  Reset and Clock generation  -------------------------------------
----------------------------------------------------------------------
  
  flashclk_pad : outpad generic map (tech => padtech, slew => 1, strength => 24) 
    port map (flash_clk, flashclkl);

  sysace_fpga_clk_pad : clkpad generic map (tech => padtech, level => cmos, voltage => x25v) 
    port map (sysace_fpga_clk, clkace);

  pci_p_clk5_pad : clkpad generic map (tech => padtech, level => cmos, voltage => x25v)
    port map (pci_p_clk5, pci_clk_fb);
  pci_p_clk5_r_pad : outpad generic map (tech => padtech, level => pci33)
    port map (pci_p_clk5_r, pci_clk);
  pci_p_clk4_r_pad : outpad generic map (tech => padtech, level => pci33)
    port map (pci_p_clk4_r, pci_clk);
  pci_p_clk3_r_pad : outpad generic map (tech => padtech, level => pci33)
    port map (pci_p_clk3_r, pci_clk);
  pci_p_clk1_r_pad : outpad generic map (tech => padtech, level => pci33)
    port map (pci_p_clk1_r, pci_clk);
  pci_p_clk0_r_pad : outpad generic map (tech => padtech, level => pci33)
    port map (pci_p_clk0_r, pci_clk);
  
  clkgen0 : clkgen  		-- system clock generator
    generic map (CFG_FABTECH, CFG_CLKMUL, CFG_CLKDIV, 1, 1,
                 1, CFG_PCIDLL, CFG_PCISYSCLK, BOARD_FREQ, 1)
    port map (lclk, pci_clk_fb, clkmc, open, clkm2x, flashclkl, pciclk, cgi, cgo,
              open, open, clk_200);
  cgi.pllctrl <= "00"; cgi.pllrst <= rstraw; cgi.pllref <= '0';

--   clkgen1 : clkgen  		-- Ethernet 1G PHY clock generator
--     generic map (CFG_FABTECH, 5, 4, 0, 0, 0, 0, 0, BOARD_FREQ, 0)
--     port map (lclk, gnd(0), egtx_clk, open, open, open, open, cgi2, cgo2);
--   cgi2.pllctrl <= "00"; cgi2.pllrst <= rstraw; --cgi2.pllref <= egtx_clk_fb;
--   egtx_clk_pad : outpad generic map (tech => padtech)
--       port map (phy_gtx_clk, egtx_clk);

  clkgen2 : clkgen  		-- PCI clock generator
    generic map (CFG_FABTECH, 2, 6, 0, 0, 0, 0, 0, BOARD_FREQ, 0)
    port map (lclk, gnd(0), pci_clk, open, open, open, open, cgi3, cgo3);
  cgi3.pllctrl <= "00"; cgi3.pllrst <= rstraw;  cgi3.pllref <= '0';

  iic_reset_b_pad : outpad generic map (tech => padtech)
    port map (iic_reset_b, rstn);
  
  resetn_pad : inpad generic map (tech => padtech, level => cmos, voltage => x25v)
    port map (fpga_cpu_reset_b, rst); 
  rst0 : rstgen			-- reset generator
  port map (rst, clkm, clklock, rstn, rstraw);
  clklock <= lock0 and lock1 and cgo.clklock and cgo3.clklock;

  clk_pad : clkpad generic map (tech => padtech, arch => 2, level => cmos, voltage => x25v) 
    port map (user_clksys, lclk);
  
  
----------------------------------------------------------------------
---  AHB CONTROLLER --------------------------------------------------
----------------------------------------------------------------------

  ahb0 : ahbctrl 		-- AHB arbiter/multiplexer
  generic map (defmast => CFG_DEFMST, split => CFG_SPLIT, 
	rrobin => CFG_RROBIN, ioaddr => CFG_AHBIO, devid => XILINX_ML510,
	ioen => IOAEN, nahbm => maxahbm, nahbs => 11 + CFG_LOGAN)
  port map (rstn, clkm, ahbmi, ahbmo, ahbsi, ahbso);

----------------------------------------------------------------------
---  LEON3 processor and DSU -----------------------------------------
----------------------------------------------------------------------

  l3 : if CFG_LEON3 = 1 generate
    cpu : for i in 0 to NCPU-1 generate
      u0 : leon3s			-- LEON3 processor      
      generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8, 
	0, CFG_MAC, pclow, CFG_NOTAG, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE, 
	CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
	CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
        CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE,
        CFG_TLB_REP, CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, NCPU-1,
        CFG_DFIXED, CFG_SCAN, CFG_MMU_PAGE, CFG_BP)
      port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso, 
    		irqi(i), irqo(i), dbgi(i), dbgo(i));
    end generate;

    opb_bus_errorl <= not dbgo(0).error;
    
    dsugen : if CFG_DSU = 1 generate
      dsu0 : dsu3			-- LEON3 Debug Support Unit
      generic map (hindex => 2, haddr => 16#D00#, hmask => 16#F00#, 
         ncpu => NCPU, tbits => 30, tech => memtech, irq => 0, kbytes => CFG_ATBSZ)
      port map (rstn, clkm, ahbmi, ahbsi, ahbso(2), dbgo, dbgi, dsui, dsuo);
      dsui.enable <= '1';
      dsui.break <= not gpioo.val(0); -- Position on on GPIO DIP switch
      plb_bus_errorl <= dsuo.active;
    end generate;
  end generate;

  nodsu : if CFG_DSU = 0 generate 
    dsuo.tstop <= '0'; dsuo.active <= '0'; plb_bus_errorl <= '0';
  end generate;

  opb_bus_error_pad : outpad generic map (tech => padtech)
      port map (opb_bus_error, opb_bus_errorl);
  plb_bus_error_pad : outpad generic map (tech => padtech)
        port map (plb_bus_error, plb_bus_errorl);
  
  dcomgen : if CFG_AHB_UART = 1 generate
    dcom0: ahbuart		-- Debug UART
      generic map (hindex => NCPU, pindex => 7, paddr => 7)
      port map (rstn, clkm, dui, duo, apbi, apbo(7), ahbmi, ahbmo(NCPU));
  end generate;

  nodcom : if CFG_AHB_UART = 0 generate
    duo.txd <= '0'; duo.rtsn <= '1';
  end generate;
  
  dsurx_pad : inpad generic map (tech => padtech, level => cmos, voltage => x33v)
    port map (uart0_rxd, dui.rxd); 
  dsutx_pad : outpad generic map (tech => padtech, level => cmos, voltage => x33v)
    port map (uart0_txd, duo.txd);
--  dsucts_pad : inpad generic map (tech => padtech, level => cmos, voltage => x33v)
--    port map (uart0_cts_b, dui.ctsn);
  dsurts_pad : outpad generic map (tech => padtech, level => cmos, voltage => x33v)
    port map (uart0_rts_b, duo.rtsn);

  ahbjtaggen0 :if CFG_AHB_JTAG = 1 generate
    ahbjtag0 : ahbjtag generic map(tech => fabtech, hindex => NCPU+CFG_AHB_UART)
      port map(rstn, clkm, tck, tms, tdi, tdo, ahbmi, ahbmo(NCPU+CFG_AHB_UART),
               open, open, open, open, open, open, open, gnd(0));
  end generate;
  
----------------------------------------------------------------------
---  Memory controllers ----------------------------------------------
----------------------------------------------------------------------

  memi.writen <= '1'; memi.wrn <= "1111"; memi.bwidth <= "01";
  memi.brdyn <= '1'; memi.bexcn <= '1';

  mctrl0 : if CFG_MCTRL_LEON2 = 1 generate
    mctrl0 : mctrl generic map (hindex => 3, pindex => 0,
        ramaddr => 0, rammask => 0, paddr => 0, srbanks => 0,
        ram8 => CFG_MCTRL_RAM8BIT,  ram16 => CFG_MCTRL_RAM16BIT,
        sden => CFG_MCTRL_SDEN, invclk => CFG_MCTRL_INVCLK,
        sepbus => CFG_MCTRL_SEPBUS)
    port map (rstn, clkm, memi, memo, ahbsi, ahbso(3), apbi, apbo(0), wpo);
  end generate;

  nomctrl: if CFG_MCTRL_LEON2 = 0 generate
    memo.address <= (others => '0'); memo.romsn <= (others => '1');
    memo.oen <= '1'; memo.wrn <= (others => '1');
    memo.vbdrive <= (others => '1'); memo.writen <= '1'; 
  end generate;
  
  flash_reset_b_pad  : outpad generic map (tech => padtech) 
    port map (flash_reset_b, rstn);
--   flash_wait_pad : inpad generic map (tech => padtech)
--     port map (flash_wait, );
  flash_adv_b_pad : outpad generic map (tech => padtech) 
	port map (flash_adv_b, gnd(0)); 
  flash_a_pads : outpadv generic map (width => 22, tech => padtech) 
	port map (flash_a, memo.address(22 downto 1)); 
  flash_ce_b_pad : outpad generic map (tech => padtech) 
	port map (flash_ce_b, memo.romsn(0)); 
  flash_oe_b_pad  : outpad generic map (tech => padtech) 
	port map (flash_oe_b, memo.oen);
--pragma translate_off
  rwen_pad : outpad generic map (tech => padtech) 
	port map (sram_bw, memo.wrn(3)); 
  sim_d_pads : iopadvv generic map (tech => padtech, width => 16)
    port map (sim_d, memo.data(15 downto 0), 
		memo.vbdrive(15 downto 0), memi.data(15 downto 0));
  iosn_pad  : outpad generic map (tech => padtech) 
	port map (iosn, memo.iosn);
--pragma translate_on
  flash_we_b_pad  : outpad generic map (tech => padtech) 
	port map (flash_we_b, memo.writen);
  flash_d_pads : iopadvv generic map (tech => padtech, width => 16)
      port map (flash_d, memo.data(31 downto 16), 
		memo.vbdrive(31 downto 16), memi.data(31 downto 16));
      
  dbg_led0_pad : outpad generic map (tech => padtech, level => cmos, voltage => x33v)
    port map (dbg_led(3), phy_init_done);

  clkm <= clkma; clkma <= clkmb; clkmb <= clkmc;

  ddrsp0 : if (CFG_DDR2SP /= 0) generate

    phy_init_done <= '1';
    -- DDR clock selection
    -- If the synchronization registers are removed in the DDR controller, we
    -- assume that the user wants to run at 2x the system clock. Otherwise the
    -- DDR clock is generated from the 200 MHz clock.
    ddrclkselarb: if CFG_DDR2SP_NOSYNC = 0 generate
      BUFGDDR : BUFG port map (I => clk_200, O => clkddr);
    end generate;
    ddrclksel2x: if CFG_DDR2SP_NOSYNC /= 0 generate
      clkddr <= clkm2x;
    end generate;
    dimm0_ddr2_reset_n_pad : outpad generic map (tech => padtech, level => cmos, voltage => x33v)
      port map (dimm0_ddr2_reset_n, rst);
    -- Slot 0
    ddrc0 : ddr2spa generic map ( fabtech => fabtech, memtech => memtech, 
      hindex => 0, haddr => 16#400#, hmask => 16#e00#, ioaddr => 1, 
      pwron => CFG_DDR2SP_INIT, MHz => DDR_FREQ/1000, TRFC => CFG_DDR2SP_TRFC, 
      clkmul => CFG_DDR2SP_FREQ/10 - (CFG_DDR2SP_FREQ/10-1)*CFG_DDR2SP_NOSYNC,
      clkdiv => 20 - (19)*CFG_DDR2SP_NOSYNC, ahbfreq => CPU_FREQ/1000,
      col => CFG_DDR2SP_COL, Mbyte => CFG_DDR2SP_SIZE, ddrbits => CFG_DDR2SP_DATAWIDTH,
      ddelayb0 => CFG_DDR2SP_DELAY0, ddelayb1 => CFG_DDR2SP_DELAY1, 
      ddelayb2 => CFG_DDR2SP_DELAY2, ddelayb3 => CFG_DDR2SP_DELAY3, 
      ddelayb4 => CFG_DDR2SP_DELAY4, ddelayb5 => CFG_DDR2SP_DELAY5,
      ddelayb6 => CFG_DDR2SP_DELAY6, ddelayb7 => CFG_DDR2SP_DELAY7,
      readdly => 1, rskew => 0, oepol => 0,
      dqsgating => 0, rstdel  => 200, eightbanks => 1,
      numidelctrl => 2 + CFG_DDR2SP_DATAWIDTH/64, norefclk => 0, odten => 3,
      nosync => CFG_DDR2SP_NOSYNC)
    port map (rst, rstn, clkddr, clkm, clk_200, lock0, clkml0, clkml0, ahbsi, ahbso(0),
              ddr0_clkv, ddr0_clkbv, ddr0_clk_fb, ddr0_clk_fb,
              dimm0_ddr2_cke,  dimm0_ddr2_s_b, dimm0_ddr2_we_b, dimm0_ddr2_ras_b, 
              dimm0_ddr2_cas_b, dimm0_ddr2_dqm(7 downto 4*(32/CFG_DDR2SP_DATAWIDTH)),
              dimm0_ddr2_dqs_p(7 downto 4*(32/CFG_DDR2SP_DATAWIDTH)),
              dimm0_ddr2_dqs_n(7 downto 4*(32/CFG_DDR2SP_DATAWIDTH)), dimm0_ddr2_a,
              dimm0_ddr2_ba(2 downto 0), dimm0_ddr2_dq(63 downto 32*(32/CFG_DDR2SP_DATAWIDTH)),
              dimm0_ddr2_odt);
    dimm0_ddr2_pll_clkin_p <= ddr0_clkv(0);
    dimm0_ddr2_pll_clkin_n <= ddr0_clkbv(0);
    -- Ground unused bank address and memory mask
--    dimm0_ddr2_ba_notused_pad : outpad generic map (tech => padtech, level => SSTL18_I)
--      port map (dimm0_ddr2_ba(2), gnd(0));
    dimm0_ddr2_dqm_notused8_pad : outpad generic map (tech => padtech, level => SSTL18_I)
      port map (dimm0_ddr2_dqm(8), gnd(0));
    -- Tri-state unused data strobe
    dimm0_dqsp_notused8_pad : iopad generic map (tech => padtech, level => SSTL18_II)
      port map (dimm0_ddr2_dqs_p(8), gnd(0), vcc(0), open);
    dimm0_dqsn_notused8_pad : iopad generic map (tech => padtech, level => SSTL18_II)
      port map (dimm0_ddr2_dqs_n(8), gnd(0), vcc(0), open);
    -- Tristate unused check bits
    dimm0_cb_notused_pad : iopadv generic map (tech => padtech, width => 8, level => SSTL18_II)
      port map (dimm0_ddr2_dq(71 downto 64), gnd(7 downto 0), vcc(0), open);
    -- Handle signals not used with 32-bit interface
    ddr032bit: if CFG_DDR2SP_DATAWIDTH /= 64 generate
      dimm0_ddr2_dqm_notused30_pads : outpadv generic map (tech => padtech, width => 4, level => SSTL18_I)
        port map (dimm0_ddr2_dqm(3 downto 0), gnd(3 downto 0));
      dimm0_dqsp_notused30_pads : iopadv generic map (tech => padtech, width => 4, level => SSTL18_II)
        port map (dimm0_ddr2_dqs_p(3 downto 0), gnd(3 downto 0), vcc(0), open);
      dimm0_dqsn_notused30_pads : iopadv generic map (tech => padtech, width => 4, level => SSTL18_II)
        port map (dimm0_ddr2_dqs_n(3 downto 0), gnd(3 downto 0), vcc(0), open);
      dimm0_dq_notused_pads : iopadv generic map (tech => padtech, width => 32, level => SSTL18_II)
        port map (dimm0_ddr2_dq(31 downto 0), gnd, vcc(0), open);
    end generate;
    
    -- Slot 1
    ddrc1 : ddr2spa generic map ( fabtech => fabtech, memtech => memtech, 
      hindex => 1, haddr => 16#600#, hmask => 16#E00#, ioaddr => 2, 
      pwron => CFG_DDR2SP_INIT, MHz => DDR_FREQ/1000, TRFC => CFG_DDR2SP_TRFC, 
      clkmul => CFG_DDR2SP_FREQ/10 - (CFG_DDR2SP_FREQ/10-1)*CFG_DDR2SP_NOSYNC,
      clkdiv => 20 - (19)*CFG_DDR2SP_NOSYNC, ahbfreq => CPU_FREQ/1000,
      col => CFG_DDR2SP_COL, Mbyte => CFG_DDR2SP_SIZE, ddrbits => CFG_DDR2SP_DATAWIDTH,
      ddelayb0 => CFG_DDR2SP_DELAY0, ddelayb1 => CFG_DDR2SP_DELAY1, 
      ddelayb2 => CFG_DDR2SP_DELAY2, ddelayb3 => CFG_DDR2SP_DELAY3, 
      ddelayb4 => CFG_DDR2SP_DELAY4, ddelayb5 => CFG_DDR2SP_DELAY5,
      ddelayb6 => CFG_DDR2SP_DELAY6, ddelayb7 => CFG_DDR2SP_DELAY7,
      readdly => 1, rskew => 0, oepol => 0,
      dqsgating => 0, rstdel  => 200, eightbanks => 1,
      numidelctrl => 2 + CFG_DDR2SP_DATAWIDTH/64, norefclk => 0, odten => 3,
      nosync => CFG_DDR2SP_NOSYNC)
    port map (rst, rstn, clkddr, clkm, clk_200, lock1, clkml1, clkml1, ahbsi, ahbso(1),
              ddr1_clkv, ddr1_clkbv, ddr1_clk_fb, ddr1_clk_fb,
              dimm1_ddr2_cke,  dimm1_ddr2_s_b, dimm1_ddr2_we_b, dimm1_ddr2_ras_b, 
              dimm1_ddr2_cas_b, dimm1_ddr2_dqm(7 downto 4*(32/CFG_DDR2SP_DATAWIDTH)),
              dimm1_ddr2_dqs_p(7 downto 4*(32/CFG_DDR2SP_DATAWIDTH)),
              dimm1_ddr2_dqs_n(7 downto 4*(32/CFG_DDR2SP_DATAWIDTH)), dimm1_ddr2_a,
              dimm1_ddr2_ba(2 downto 0), dimm1_ddr2_dq(63 downto 32*(32/ CFG_DDR2SP_DATAWIDTH)),
              dimm1_ddr2_odt);
    dimm1_ddr2_pll_clkin_p <= ddr1_clkv(0);
    dimm1_ddr2_pll_clkin_n <= ddr1_clkbv(0);
    -- Ground unused bank address and memory mask
--    dimm1_ddr2_ba_notused_pad : outpad generic map (tech => padtech, level => SSTL18_I)
--      port map (dimm1_ddr2_ba(2), gnd(0));
    dimm1_ddr2_dqm_notused8_pad : outpad generic map (tech => padtech, level => SSTL18_I)
      port map (dimm1_ddr2_dqm(8), gnd(0));
    -- Tri-state unused data strobe
    dimm1_dqsp_notused8_pad : iopad generic map (tech => padtech, level => SSTL18_II)
      port map (dimm1_ddr2_dqs_p(8), gnd(0), vcc(0), open);
    dimm1_dqsn_notused8_pad : iopad generic map (tech => padtech, level => SSTL18_II)
      port map (dimm1_ddr2_dqs_n(8), gnd(0), vcc(0), open);
    -- Tristate unused check bits
    dimm1_cb_notused_pad : iopadv generic map (tech => padtech, width => 8, level => SSTL18_II)
      port map (dimm1_ddr2_dq(71 downto 64), gnd(7 downto 0), vcc(0), open);
    -- Handle signals not used with 32-bit interface
    ddr132bit: if CFG_DDR2SP_DATAWIDTH /= 64 generate
      dimm1_ddr2_dqm_notused30_pads : outpadv generic map (tech => padtech, width => 4, level => SSTL18_I)
        port map (dimm1_ddr2_dqm(3 downto 0), gnd(3 downto 0));
      dimm1_dqsp_notused30_pads : iopadv generic map (tech => padtech, width => 4, level => SSTL18_II)
        port map (dimm1_ddr2_dqs_p(3 downto 0), gnd(3 downto 0), vcc(0), open);
      dimm1_dqsn_notused30_pads : iopadv generic map (tech => padtech, width => 4, level => SSTL18_II)
        port map (dimm1_ddr2_dqs_n(3 downto 0), gnd(3 downto 0), vcc(0), open);
      dimm1_dq_notused_pads : iopadv generic map (tech => padtech, width => 32, level => SSTL18_II)
        port map (dimm1_ddr2_dq(31 downto 0), gnd, vcc(0), open);
    end generate;
  end generate;

--  noddr :  if (CFG_DDR2SP = 0) generate lock0 <= '1'; lock1 <= '1'; end generate;
  
----------------------------------------------------------------------
---  System ACE I/F Controller ---------------------------------------
----------------------------------------------------------------------
  
  grace: if CFG_GRACECTRL = 1 generate
    grace0 : gracectrl generic map (hindex => 5, hirq => 5,
        haddr => 16#000#, hmask => 16#fff#, split => CFG_SPLIT)
      port map (rstn, clkm, clkace, ahbsi, ahbso(5), acei, aceo);
  end generate;

  nograce: if CFG_GRACECTRL = 0 generate
    aceo <= gracectrl_none;
  end generate nograce;
  
  sysace_mpa_pads : outpadv generic map (width => 7, tech => padtech) 
    port map (sysace_mpa, aceo.addr); 
  sysace_mpce_pad : outpad generic map (tech => padtech)
    port map (sysace_mpce, aceo.cen); 
  sysace_mpd_pads : iopadv generic map (tech => padtech, width => 16)
    port map (sysace_mpd, aceo.do, aceo.doen, acei.di); 
  sysace_mpoe_pad : outpad generic map (tech => padtech)
    port map (sysace_mpoe, aceo.oen);
  sysace_mpwe_pad : outpad generic map (tech => padtech)
    port map (sysace_mpwe, aceo.wen); 
  sysace_mpirq_pad : inpad generic map (tech => padtech)
    port map (sysace_mpirq, acei.irq); 
  
----------------------------------------------------------------------
---  AHB ROM ---------------------------------------------------------
----------------------------------------------------------------------

  bpromgen : if CFG_AHBROMEN /= 0 generate
    brom : entity work.ahbrom
      generic map (hindex => 10, haddr => CFG_AHBRODDR, pipe => CFG_AHBROPIP)
      port map (rstn, clkm, ahbsi, ahbso(10));
  end generate;

----------------------------------------------------------------------
---  APB Bridge and various periherals -------------------------------
----------------------------------------------------------------------

  apb0 : apbctrl				-- AHB/APB bridge
    generic map (hindex => 4, haddr => CFG_APBADDR, nslaves => 16)
    port map (rstn, clkm, ahbsi, ahbso(4), apbi, apbo);

  ua1 : if CFG_UART1_ENABLE /= 0 generate
    uart1 : apbuart			-- UART 1
      generic map (pindex => 1, paddr => 1,  pirq => 2, console => dbguart,
                   fifosize => CFG_UART1_FIFO)
      port map (rstn, clkm, apbi, apbo(1), u1i, u1o);
    u1i.extclk <= '0';
  end generate;

  noua1: if CFG_UART1_ENABLE = 0 generate u1o.txd <= '0'; u1o.rtsn <= '1'; end generate;

  ua1rx_pad : inpad generic map (tech => padtech) port map (uart1_rxd, u1i.rxd); 
  ua1tx_pad : outpad generic map (tech => padtech) port map (uart1_txd, u1o.txd);
  ua1cts_pad : inpad generic map (tech => padtech) port map (uart1_cts_b, u1i.ctsn);
  ua1rts_pad : outpad generic map (tech => padtech) port map (uart1_rts_b, u1o.rtsn);
  
  irqctrl : if CFG_IRQ3_ENABLE /= 0 generate
    irqctrl0 : irqmp			-- interrupt controller
    generic map (pindex => 2, paddr => 2, ncpu => NCPU)
    port map (rstn, clkm, apbi, apbo(2), irqo, irqi);
  end generate;
  irq3 : if CFG_IRQ3_ENABLE = 0 generate
    x : for i in 0 to NCPU-1 generate
      irqi(i).irl <= "0000";
    end generate;
    apbo(2) <= apb_none;
  end generate;

  gpt : if CFG_GPT_ENABLE /= 0 generate
    timer0 : gptimer 			-- timer unit
      generic map (pindex => 3, paddr => 3, pirq => CFG_GPT_IRQ, 
	sepirq => CFG_GPT_SEPIRQ, sbits => CFG_GPT_SW, ntimers => CFG_GPT_NTIM, 
	nbits => CFG_GPT_TW)
      port map (rstn, clkm, apbi, apbo(3), gpti, open);
    gpti.dhalt <= dsuo.tstop; gpti.extclk <= '0';
  end generate;

  nogpt : if CFG_GPT_ENABLE = 0 generate apbo(3) <= apb_none; end generate;

  svga : if CFG_SVGA_ENABLE /= 0 generate
    svga0 : svgactrl generic map(memtech => memtech, pindex => 14, paddr => 14,
        hindex => CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG, 
	clk0 => 40000, clk1 => 40000, clk2 => 25000, clk3 => 15385, burstlen => 6)
       port map(rstn, clkm, clkvga, apbi, apbo(14), vgao, ahbmi, 
		ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_AHB_JTAG), clk_sel);
    
    dvi0 : svga2ch7301c generic map (tech => fabtech, idf => 2)
      port map (lclk, rstraw, clk_sel, vgao, clkvga, clk25, clk40, clk65,
                clkvga, clk25, clk40, clk65, clkvga_p, clkvga_n, 
                vgalock, lcd_datal, lcd_hsyncl, lcd_vsyncl, lcd_del);
    
    i2cdvi : i2cmst
      generic map (pindex => 6, paddr => 6, pmask => 16#FFF#,
                   pirq => 6, filter => I2C_FILTER)
      port map (rstn, clkm, apbi, apbo(6), dvi_i2ci, dvi_i2co);
  end generate;

  novga : if CFG_SVGA_ENABLE = 0 generate 
     apbo(14) <= apb_none; apbo(6) <= apb_none;
     lcd_datal <= (others => '0'); clkvga_p <= '0'; clkvga_n <= '0';
     lcd_hsyncl <= '0'; lcd_vsyncl <= '0'; lcd_del <= '0';
     dvi_i2co.scloen <= '1'; dvi_i2co.sdaoen <= '1';
  end generate;

  dvi_d_pad : outpadv generic map (width => 12, tech => padtech)
    port map (dvi_d, lcd_datal);
  dvi_xclk_p_pad : outpad generic map (tech => padtech)
    port map (dvi_xclk_p, clkvga_p);
  dvi_xclk_n_pad : outpad generic map (tech => padtech)
    port map (dvi_xclk_n, clkvga_n);
  dvi_h_pad : outpad generic map (tech => padtech)
    port map (dvi_h, lcd_hsyncl);
  dvi_v_pad : outpad generic map (tech => padtech)
    port map (dvi_v, lcd_vsyncl);
  dvi_de_pad : outpad generic map (tech => padtech)
    port map (dvi_de, lcd_del);
  dvi_reset_b_pad : outpad generic map (tech => padtech)
    port map (dvi_reset_b, rstn);
  iic_scl_dvi_pad : iopad generic map (tech => padtech)
    port map (iic_scl_dvi, dvi_i2co.scl, dvi_i2co.scloen, dvi_i2ci.scl);
  iic_sda_dvi_pad : iopad generic map (tech => padtech)
    port map (iic_sda_dvi, dvi_i2co.sda, dvi_i2co.sdaoen, dvi_i2ci.sda);

  gpio0 : if CFG_GRGPIO_ENABLE /= 0 generate     -- GPIO unit
    grgpio0: grgpio
    generic map(pindex => 8, paddr => 8, imask => CFG_GRGPIO_IMASK, nbits => CFG_GRGPIO_WIDTH)
      port map(rst => rstn, clk => clkm, apbi => apbi, apbo => apbo(8),
               gpioi => gpioi, gpioo => gpioo);
  end generate;

  nogpio0: if CFG_GRGPIO_ENABLE = 0 generate
    gpioo.oen <= (others => '1'); gpioo.val <= (others => '0');
    gpioo.dout <= (others => '1');
  end generate;
  
  dbg_led_pads : iopadvv generic map (tech => padtech, width => 3,  level => cmos, voltage => x33v)
    port map (dbg_led(2 downto 0), gpioo.dout(2 downto 0), gpioo.oen(2 downto 0), 
		gpioi.din(2 downto 0));
  dvi_gpio_pad : iopad generic map (tech => padtech)
    port map (dvi_gpio1, gpioo.dout(4), gpioo.oen(4), gpioi.din(4));
  iic_therm_b_pad : inpad generic map (tech => padtech)
    port map (iic_therm_b, gpioi.din(9));
  iic_irq_b_pad : inpad generic map (tech => padtech)
    port map (iic_irq_b, gpioi.din(10));
  iic_alert_b_pad : inpad generic map (tech => padtech)
    port map (iic_alert_b, gpioi.din(11));
  sbr_pwg_rsm_rstj_pad : iopad generic map (tech => padtech, level => cmos, voltage => x25v)
    port map (sbr_pwg_rsm_rstj, gpioo.dout(7), gpioo.oen(7), gpioi.din(7));
  sbr_nmi_r_pad : inpad generic map (tech => padtech)
    port map (sbr_nmi_r, gpioi.din(6));
  sbr_intr_r_pad : inpad generic map (tech => padtech, level => cmos, voltage => x25v)
    port map (sbr_intr_r, gpioi.din(5));
  sbr_ide_rst_b_pad : iopad generic map (tech => padtech)
    port map (sbr_ide_rst_b, gpioo.dout(8), gpioo.oen(8), gpioi.din(8));

  i2cm: if CFG_I2C_ENABLE = 1 generate  -- I2C master
    i2c0 : i2cmst
      generic map (pindex => 9, paddr => 9, pmask => 16#FFF#,
                   pirq => 3, filter => I2C_FILTER)
      port map (rstn, clkm, apbi, apbo(9), i2ci, i2co);
  end generate;

  noi2cm: if CFG_I2C_ENABLE = 0 generate
    i2co.scloen <= '1'; i2co.sdaoen <= '1';
    i2co.scl <= '0'; i2co.sda <= '0';
  end generate;
  
  i2c_scl_pad : iopad generic map (tech => padtech)
    port map (fpga_scl, i2co.scl, i2co.scloen, i2ci.scl);
  i2c_sda_pad : iopad generic map (tech => padtech)
    port map (fpga_sda, i2co.sda, i2co.sdaoen, i2ci.sda);
  
  spic: if CFG_SPICTRL_ENABLE = 1 generate  -- SPI controller
    spi1 : spictrl
      generic map (pindex => 10, paddr  => 10, pmask  => 16#fff#, pirq => 12,
                   fdepth => CFG_SPICTRL_FIFO, slvselen => CFG_SPICTRL_SLVREG,
                   slvselsz => CFG_SPICTRL_SLVS, odmode => 0, netlist => 0,
                   syncram => CFG_SPICTRL_SYNCRAM, ft => CFG_SPICTRL_FT)
      port map (rstn, clkm, apbi, apbo(10), spii, spio, slvsel);
    spii.spisel <= '1';                 -- Master only
    miso_pad : inpad generic map (tech => padtech)
      port map (spi_data_out, spii.miso);
    mosi_pad : outpad generic map (tech => padtech)
      port map (spi_data_in, spio.mosi);
    sck_pad  : outpad generic map (tech => padtech)
      port map (spi_clk, spio.sck);
    slvsel_pad : outpad generic map (tech => padtech)
      port map (spi_data_cs_b, slvsel(0));
  end generate spic;

  nospi: if CFG_SPICTRL_ENABLE = 0 generate
    miso_pad : inpad generic map (tech => padtech)
      port map (spi_data_out, spii.miso);
    mosi_pad : outpad generic map (tech => padtech)
      port map (spi_data_in, vcc(0));
    sck_pad  : outpad generic map (tech => padtech)
      port map (spi_clk, gnd(0));
    slvsel_pad : outpad generic map (tech => padtech)
      port map (spi_data_cs_b, vcc(0));
  end generate;
  
  ahbs : if CFG_AHBSTAT = 1 generate	-- AHB status register
    ahbstat0 : ahbstat generic map (pindex => 15, paddr => 15, pirq => 7,
                                    nftslv => CFG_AHBSTATN)
      port map (rstn, clkm, ahbmi, ahbsi, stati, apbi, apbo(15));
  end generate;

-----------------------------------------------------------------------
---  ETHERNET ---------------------------------------------------------
-----------------------------------------------------------------------

    eth1 : if CFG_GRETH = 1 generate -- Gaisler ethernet MAC
      e1 : grethm generic map(hindex => NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE, 
	pindex => 11, paddr => 11, pirq => 4, memtech => memtech,
        mdcscaler => CPU_FREQ/1000, enable_mdio => 1, fifosize => CFG_ETH_FIFO,
        nsync => 1, edcl => CFG_DSU_ETH, edclbufsz => CFG_ETH_BUF,
        macaddrh => CFG_ETH_ENM, macaddrl => CFG_ETH_ENL, phyrstadr => 7,
	ipaddrh => CFG_ETH_IPM, ipaddrl => CFG_ETH_IPL, giga => CFG_GRETH1G)
      port map( rst => rstn, clk => clkm, ahbmi => ahbmi,
        ahbmo => ahbmo(NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE), 
	apbi => apbi, apbo => apbo(11), ethi => ethi, etho => etho); 

      emdio_pad : iopad generic map (tech => padtech) 
        port map (phy0_mdio, etho.mdio_o, etho.mdio_oe, ethi.mdio_i);
      etxc_pad : clkpad generic map (tech => padtech, arch => 2, level => cmos, voltage => x25v) 
	port map (phy0_txclk, ethi.tx_clk);
      erxc_pad : clkpad generic map (tech => padtech, arch => 2, level => cmos, voltage => x25v) 
	port map (phy0_rxclk, ethi.rx_clk);
      erxd_pad : inpadv generic map (tech => padtech, width => 4) 
	port map (phy0_rxd, ethi.rxd(3 downto 0));
      erxdv_pad : inpad generic map (tech => padtech) 
	port map (phy0_rxctl_rxdv, ethi.rx_dv);
      erxer_pad : inpad generic map (tech => padtech) 
	port map (phy0_rxer, ethi.rx_er);

      -- Collision detect and carrier sense are not connected on the
      -- board.
      ethi.rx_col <= '0';
      ethi.rx_crs <= ethi.rx_dv;
      
      etxd_pad : outpadv generic map (tech => padtech, width => 4) 
	port map (phy0_txd, etho.txd(3 downto 0));
      etxen_pad : outpad generic map (tech => padtech) 
	port map (phy0_txctl_txen, etho.tx_en);
      etxer_pad : outpad generic map (tech => padtech) 
	port map (phy0_txer, etho.tx_er);
      emdc_pad : outpad generic map (tech => padtech) 
	port map (phy0_mdc, etho.mdc);
      erst_pad : outpad generic map (tech => padtech) 
	port map (phy0_reset, rstn);
--      ethi.gtx_clk <= egtx_clk;
    end generate;

-----------------------------------------------------------------------
---  PCI   ------------------------------------------------------------
----------------------------------------------------------------------

  pp : if CFG_PCI /= 0 generate
    pci_mtf0 : if CFG_PCI = 2 generate	-- master/target with fifo
      pci0 : pci_mtf generic map (memtech => memtech,
          hmstndx => NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE+CFG_GRETH, 
	  fifodepth => log2(CFG_PCIDEPTH), device_id => CFG_PCIDID, vendor_id => CFG_PCIVID,
	  hslvndx => 7, pindex => 4, paddr => 4, haddr => 16#800#, hmask => 16#c00#,
	  ioaddr => 16#400#, irq => 5, irqmask => 16#F#, nsync => 2, hostrst => 1)
      port map (rstn, clkm, pciclk, pcii, pcio, apbi, apbo(4),
	ahbmi, ahbmo(NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE+CFG_GRETH), ahbsi, ahbso(7));
    end generate;

    pci_mtf1 : if CFG_PCI = 3 generate	-- master/target with fifo and DMA
      dma : pcidma generic map (memtech => memtech,
          dmstndx => NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE+CFG_GRETH+1, 
	  dapbndx => 5, dapbaddr => 5, blength => blength,
          mstndx => NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE+CFG_GRETH,
	  fifodepth => log2(fifodepth), device_id => CFG_PCIDID, vendor_id => CFG_PCIVID,
	  slvndx => 7, apbndx => 4, apbaddr => 4, haddr => 16#800#, hmask => 16#c00#,
          ioaddr => 16#400#, irq => 5, irqmask => 16#F#, nsync => 2, hostrst => 1)
      	port map (rstn, clkm, pciclk, pcii, pcio, apbo(5),
                  ahbmo(NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE+CFG_GRETH+1), 
                  apbi, apbo(4), ahbmi, ahbmo(NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_SVGA_ENABLE+CFG_GRETH),
                  ahbsi, ahbso(7));
    end generate;

    pci_trc0 : if CFG_PCITBUFEN /= 0 generate	-- PCI trace buffer
      pt0 : pcitrace generic map (depth => (6 + log2(CFG_PCITBUF/256)), 
	memtech => memtech, pindex  => 12, paddr => 16#100#, pmask => 16#f00#)
        port map (rstn, clkm, pciclk, pcii, apbi, apbo(12));
    end generate;

    pcia0 : if CFG_PCI_ARB = 1 generate	-- PCI arbiter
      pciarb0 : pciarb generic map (pindex => 13, paddr => 13, nb_agents => CFG_PCI_ARB_NGNT,
                                    apb_en => CFG_PCI_ARBAPB)
        port map (clk => pciclk, rst_n => pcii.rst, req_n => pci_arb_req, frame_n => pcii.frame,
                  gnt_n => pci_arb_gnt, pclk => clkm, prst_n => rstn, apbi => apbi, apbo => apbo(13));
      -- Internal connection of req(2)
      pci_arb_req(0 to 4) <= pci_arb_reql(0 to 1) & pci_reql & pci_arb_reql(3 to 4);
      pci_arb_req(5 to 7) <= (others => '1');
    end generate;
  end generate;

  nopcia0: if CFG_PCI = 0 or CFG_PCI_ARB = 0 generate
    pci_arb_gnt <= (others => '1');
  end generate;

  nopci_mtf: if CFG_PCI /= 2 and CFG_PCI /= 3 generate
    pcio <= pci_out_none;
  end generate;
  
  pgnt_pad : outpadv generic map (tech => padtech, width => 5, level => pci33) 
    port map (pci_p_gnt_b, pci_arb_gnt(0 to 4));
  preq_pad : inpadv generic map (tech => padtech, width => 5, level => pci33) 
    port map (pci_p_req_b, pci_arb_reql);

  pcipads0 : pcipads          -- PCI pads
    generic map (padtech => padtech, host => 2, int => 14, no66 => 1, onchipreqgnt => 1,
                 drivereset => 1, constidsel => 1)
    port map (pci_rst => pci_p_rst_b, pci_gnt => pci_arb_gnt(2), pci_idsel => '0', --pci_fpga_idsel,
              pci_lock => pci_p_lock_b, pci_ad => pci_p_ad, pci_cbe => pci_p_cbe_b,
              pci_frame => pci_p_frame_b, pci_irdy => pci_p_irdy_b, pci_trdy => pci_p_trdy_b,
              pci_devsel => pci_p_devsel_b, pci_stop => pci_p_stop_b, pci_perr => pci_p_perr_b,
              pci_par => pci_p_par, pci_req => pci_reql, pci_serr =>  pci_p_serr_b,
              pci_host => pci_host, pci_66 => pci_66, pcii => pcii, pcio => pcio, pci_int => pci_intv);
  pci_intv <= pci_p_intd_b & pci_p_intc_b & pci_p_intb_b & pci_p_inta_b;
  pci_host <= '0';   -- Always host
  pci_66 <= '0';
    
-----------------------------------------------------------------------
---  SYSTEM MONITOR ---------------------------------------------------
-----------------------------------------------------------------------

  grsmon: if CFG_GRSYSMON = 1 generate
    sysm0 : grsysmon generic map (tech => fabtech, hindex => 8,
         hirq => 1, caddr => 16#003#, cmask => 16#fff#,
         saddr => 16#004#, smask => 16#ffe#, split => CFG_SPLIT,
         extconvst => 0, wrdalign => 1, INIT_40 => X"0000",
         INIT_41 => X"0000", INIT_42 => X"0800", INIT_43 => X"0000",
         INIT_44 => X"0000", INIT_45 => X"0000", INIT_46 => X"0000",
         INIT_47 => X"0000", INIT_48 => X"0000", INIT_49 => X"0000",
         INIT_4A => X"0000", INIT_4B => X"0000", INIT_4C => X"0000",
         INIT_4D => X"0000", INIT_4E => X"0000", INIT_4F => X"0000",
         INIT_50 => X"0000", INIT_51 => X"0000", INIT_52 => X"0000",
         INIT_53 => X"0000", INIT_54 => X"0000", INIT_55 => X"0000",
         INIT_56 => X"0000", INIT_57 => X"0000",
         SIM_MONITOR_FILE => "sysmon.txt")
      port map (rstn, clkm, ahbsi, ahbso(8), sysmoni, sysmono);
    sysmoni.convst <= '0';
    sysmoni.convstclk <= '0';
    sysmoni.vauxn <= (others => '0');
    sysmoni.vauxp <= (others => '0');
--    sysmoni.vn <= test_mon_vn0_n;
--    sysmoni.vp <= test_mon_vp0_p;
  end generate grsmon;
  
-----------------------------------------------------------------------
---  AHB RAM ----------------------------------------------------------
-----------------------------------------------------------------------

  ocram : if CFG_AHBRAMEN = 1 generate 
    ahbram0 : ahbram generic map (hindex => 9, haddr => CFG_AHBRADDR, 
	tech => CFG_MEMTECH, kbytes => CFG_AHBRSZ, pipe => CFG_AHBRPIPE)
    port map ( rstn, clkm, ahbsi, ahbso(9));
  end generate;

-----------------------------------------------------------------------
---  APB bridge with LOGAN --------------------------------------------
-----------------------------------------------------------------------

--   log: if CFG_LOGAN = 1 generate        -- Logan is enabled by constant
--                                         -- declared above
--     apb0 : apbctrl				-- AHB/APB bridge
--       generic map (hindex => 11, haddr => 16#F00#, nslaves => 1)
--       port map (rstn, clkm, ahbsi, ahbso(11), apbi1, apbo1);

--     logan0 : logan                      -- Logic analyzer
--       generic map (dbits => 64, depth => 4096, trigl => 2, usereg => 1,
--                    usequal => 0, pindex => 0, paddr => 0, pmask => 16#F00#,
--                    memtech => memtech)
--       port map (rstn, clkm, pciclk, apbi1, apbo1(0), signals);

--     signals(0) <= pcii.rst;
--     signals(1) <= pcii.gnt;
--     signals(2) <= pcii.idsel;
--     signals(34 downto 3) <= pcii.ad;
--     signals(38 downto 35) <= pcii.cbe;
--     signals(39) <= pcii.frame;
--     signals(40) <= pcii.irdy;
--     signals(41) <= pcii.trdy;
--     signals(42) <= pcii.devsel;
--     signals(43) <= pcii.stop;
--     signals(44) <= pcii.lock;
--     signals(45) <= pcii.perr;
--     signals(46) <= pcii.serr;
--     signals(47) <= pcii.par;
--     signals(48) <= pcii.host;
--     signals(49) <= pcii.pci66;
--     signals(53 downto 50) <= pcii.int;
--     signals(58 downto 54) <= pci_arb_gnt(0 to 4);
--     signals(63 downto 59) <= pci_arb_req(0 to 4);
--   end generate log;

  nolog: if CFG_LOGAN /= 1 generate
    signals <= (others => '0');
  end generate nolog;
  
-----------------------------------------------------------------------
---  AHB DEBUG --------------------------------------------------------
-----------------------------------------------------------------------

--  dma0 : ahbdma
--    generic map (hindex => CFG_NCPU+CFG_AHB_UART+CFG_GRETH+CFG_AHB_JTAG,
--	pindex => 13, paddr => 13, dbuf => 6)
--    port map (rstn, clkm, apbi, apbo(13), ahbmi, 
--	ahbmo(CFG_NCPU+CFG_AHB_UART+CFG_GRETH+CFG_AHB_JTAG));

--  at0 : ahbtrace
--  generic map ( hindex  => 7, ioaddr => 16#200#, iomask => 16#E00#,
--    tech    => memtech, irq     => 0, kbytes  => 8) 
--  port map ( rstn, clkm, ahbmi, ahbsi, ahbso(7));

-----------------------------------------------------------------------
---  Drive unused bus elements  ---------------------------------------
-----------------------------------------------------------------------

--  nam1 : for i in (NCPU+CFG_AHB_UART+CFG_ETH+CFG_AHB_ETH+CFG_AHB_JTAG) to NAHBMST-1 generate
--    ahbmo(i) <= ahbm_none;
--  end generate;
--  nap0 : for i in 11 to NAPBSLV-1 generate apbo(i) <= apb_none; end generate;
--  nah0 : for i in 8 to NAHBSLV-1 generate ahbso(i) <= ahbs_none; end generate;

-----------------------------------------------------------------------
---  Boot message  ----------------------------------------------------
-----------------------------------------------------------------------

-- pragma translate_off
  x : report_design
  generic map (
   msg1 => system_table(XILINX_ML510),
   fabtech => tech_table(fabtech), memtech => tech_table(memtech),
   mdel => 1
  );
-- pragma translate_on
end;

