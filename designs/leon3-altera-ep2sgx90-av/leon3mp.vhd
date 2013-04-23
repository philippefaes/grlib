-----------------------------------------------------------------------------
--  LEON3 Demonstration design
--  Copyright (C) 2004 Jiri Gaisler, Gaisler Research
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


library ieee;
use ieee.std_logic_1164.all;
library grlib, techmap;
use grlib.amba.all;
use grlib.stdlib.all;
use techmap.gencomp.all;
library gaisler;
use gaisler.memctrl.all;
use gaisler.ddrpkg.all;
use gaisler.leon3.all;
use gaisler.uart.all;
use gaisler.misc.all;
use gaisler.net.all;
use gaisler.jtag.all;
library esa;
use esa.memoryctrl.all;
use work.ft245.all;
use work.config.all;

entity leon3mp is
  generic (
    fabtech : integer := CFG_FABTECH;
    memtech : integer := CFG_MEMTECH;
    padtech : integer := CFG_PADTECH;
    ncpu    : integer := CFG_NCPU;
    disas   : integer := CFG_DISAS;     -- Enable disassembly to console
    dbguart : integer := CFG_DUART;     -- Print UART on console
    pclow   : integer := CFG_PCLOW
    );
  port (

    -- RESET, CLK, ERROR
    resetn  : in  std_ulogic;
    clk     : in  std_ulogic;
    errorn  : out   std_ulogic;

    -- combined flash/SSRAM/IO bus (fs_...)
    fs_addr : out std_logic_vector(24 downto 0);
    fs_data : inout std_logic_vector(31 downto 0);
    
    -- IO chip enable
    io_cen :  out std_logic;
    io_wen :  out std_logic;
    
    -- separate flash signals (flash_...)
    flash_cen : out std_ulogic;
    flash_oen : out std_logic;
    flash_wen : out std_logic;
    
    -- separate SSRAM signals (ssram_...)
    ssram_cen  	: out std_logic;
    ssram_wen 	: out std_logic;
    ssram_bw   	: out std_logic_vector (3 downto 0);
    ssram_oen   : out std_ulogic;
    ssram_clk  	: out std_ulogic;
    ssram_adscn : out std_ulogic;
    ssram_adspn : out std_ulogic;
    ssram_advn  : out std_ulogic;
    
    -- DDR2
    ddr_clk  	: out std_logic_vector(2 downto 0);
    ddr_clkb  	: out std_logic_vector(2 downto 0);
    ddr_cke  	: out std_logic_vector(1 downto 0);
    ddr_csb  	: out std_logic_vector(1 downto 0);
    ddr_odt  	: out std_logic_vector(1 downto 0);
    ddr_web  	: out std_ulogic;                       -- ddr write enable
    ddr_rasb  	: out std_ulogic;                       -- ddr ras

    ddr_casb  	: out std_ulogic;                       -- ddr cas
    ddr_dm   	: out std_logic_vector (7 downto 0);    -- ddr dm
    ddr_dqs  	: inout std_logic_vector (7 downto 0);  -- ddr dqs
    ddr_ad      : out std_logic_vector (13 downto 0);   -- ddr address
    ddr_ba      : out std_logic_vector (1 downto 0);    -- ddr bank address
    ddr_dq  	: inout std_logic_vector (63 downto 0); -- ddr data

    -- ETHERNET PHY
    phy_gtx_clk : out std_logic;
    phy_mii_data: inout std_logic;		-- ethernet PHY interface
    phy_tx_clk 	: in std_ulogic;
    phy_rx_clk 	: in std_ulogic;
    phy_rx_data	: in std_logic_vector(7 downto 0);   
    phy_dv  	: in std_ulogic; 
    phy_rx_er	: in std_ulogic; 
    phy_col 	: in std_ulogic;
    phy_crs 	: in std_ulogic;
    phy_tx_data : out std_logic_vector(7 downto 0);   
    phy_tx_en 	: out std_ulogic; 
    phy_tx_er 	: out std_ulogic; 
    phy_mii_clk	: out std_ulogic;

    -- debug support unit
    dsuact      : out std_ulogic;

    -- console/debug UART
    rxd1        : in  std_logic;
    txd1        : out std_logic;

    -- FT245 UART
    ft245_data  : inout std_logic_vector (7 downto 0);
    ft245_rdn   : out std_logic;
    ft245_wr    : out std_logic;
    ft245_rxfn  : in std_logic;
    ft245_txen  : in std_logic;
    ft245_pwrenn : in std_logic;
        
    -- GPIO
    gpio	: inout std_logic_vector(CFG_GRGPIO_WIDTH-1 downto 0)
  );
end;

architecture rtl of leon3mp is
  
  constant maxahbm : integer := NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH;

  signal vcc, gnd    : std_logic_vector(7 downto 0);
  signal memi, smemi : memory_in_type;
  signal memo, smemo : memory_out_type;
  signal wpo         : wprot_out_type;
  
  signal ddrclkfb, ssrclkfb, ddr_clkl, ddr_clk90l, ddr_clknl, ddr_clk270l : std_ulogic;
  signal ddr_clkv 	: std_logic_vector(2 downto 0);
  signal ddr_clkbv	: std_logic_vector(2 downto 0);
  signal ddr_ckev  	: std_logic_vector(1 downto 0);
  signal ddr_csbv  	: std_logic_vector(1 downto 0);
  signal ddr_adl    : std_logic_vector (13 downto 0);
  signal clklock, lock, clkml, rst, ndsuact : std_ulogic;
  signal tck, tckn, tms, tdi, tdo : std_ulogic;
  signal ddrclk, ddrrst : std_ulogic;

--  attribute syn_keep : boolean;
--  attribute syn_preserve : boolean;
--  attribute syn_keep of clkml : signal is true;
--  attribute syn_preserve of clkml : signal is true;

  signal extd    : std_logic_vector(31 downto 0);

  signal apbi  : apb_slv_in_type;
  signal apbo  : apb_slv_out_vector := (others => apb_none);
  signal ahbsi : ahb_slv_in_type;
  signal ahbso : ahb_slv_out_vector := (others => ahbs_none);
  signal ahbmi : ahb_mst_in_type;
  signal ahbmo : ahb_mst_out_vector;

  signal clkm, rstn, ssram_clkl : std_ulogic;
  signal cgi                : clkgen_in_type;
  signal cgo                : clkgen_out_type;
  signal u1i, dui           : uart_in_type;
  signal u1o, duo           : uart_out_type;

  signal irqi : irq_in_vector(0 to NCPU-1);
  signal irqo : irq_out_vector(0 to NCPU-1);

  signal dbgi : l3_debug_in_vector(0 to NCPU-1);
  signal dbgo : l3_debug_out_vector(0 to NCPU-1);

  signal dsui : dsu_in_type;
  signal dsuo : dsu_out_type;

  signal ethi : eth_in_type;
  signal etho : eth_out_type;

  signal gpti : gptimer_in_type;
  signal gpioi : gpio_in_type;
  signal gpioo : gpio_out_type;

  signal ft245i : ft245_in_type;
  signal ft245o : ft245_out_type;
  signal ft245_vbdrive : std_logic_vector(7 downto 0);
  
  constant IOAEN : integer := 1;
  constant BOARD_FREQ : integer := 100000;   -- input frequency in KHz
  constant CPU_FREQ : integer := BOARD_FREQ * CFG_CLKMUL / CFG_CLKDIV;  -- cpu frequency in KHz
  
begin

----------------------------------------------------------------------
---  Reset and Clock generation  -------------------------------------
----------------------------------------------------------------------

  vcc <= (others => '1'); gnd <= (others => '0');
  cgi.pllctrl <= "00"; cgi.pllrst <= not resetn; cgi.pllref <= '0';

  clklock <=  cgo.clklock and lock;

  clkgen0 : clkgen  -- clock generator for main clock
    generic map (tech => CFG_CLKTECH, clk_mul => CFG_CLKMUL, clk_div => CFG_CLKDIV,
                 sdramen => CFG_MCTRL_SDEN, pcien => 0, pcidll => 0,
                 freq => BOARD_FREQ, clk2xen => 0, clksel => 0, clk_odiv => 0)
    port map (clkin => clk, pciclkin => gnd(0), clk => clkm, clkn => ssram_clkl,
              clk2x => open, sdclk => open, pciclk => open,
              cgi => cgi, cgo => cgo);

--  ssram_clkl <= not clkm;
  ssrclk_pad : outpad generic map (tech => padtech, slew => 1, strength => 24) 
    port map (ssram_clk, ssram_clkl);
  
  rst0 : rstgen                         -- reset generator
    port map (resetn, clkm, clklock, rstn);

---------------------------------------------------------------------- 
---  AHB CONTROLLER --------------------------------------------------
----------------------------------------------------------------------

  ahb0 : ahbctrl 		-- AHB arbiter/multiplexer
  generic map (defmast => CFG_DEFMST, split => CFG_SPLIT, 
	rrobin => CFG_RROBIN, ioaddr => CFG_AHBIO,
	ioen => IOAEN, nahbm => maxahbm, nahbs => 8)
  port map (rstn, clkm, ahbmi, ahbmo, ahbsi, ahbso);

----------------------------------------------------------------------
---  LEON3 processor and DSU -----------------------------------------
----------------------------------------------------------------------

  l3 : if CFG_LEON3 = 1 generate
    cpu : for i in 0 to NCPU-1 generate
      u0 : leon3s                         -- LEON3 processor
        generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8,
                   0, CFG_MAC, pclow, 0, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE,
                   CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
                   CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
                   CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP,
                   CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, NCPU-1)
        port map (clkm, rstn, ahbmi, ahbmo(i), ahbsi, ahbso,
                irqi(i), irqo(i), dbgi(i), dbgo(i));
    end generate;
    errorn_pad : odpad generic map (tech => padtech) port map (errorn, dbgo(0).error);

    dsugen : if CFG_DSU = 1 generate
      dsu0 : dsu3                         -- LEON3 Debug Support Unit
        generic map (hindex => 2, haddr => 16#900#, hmask => 16#F00#,
                   ncpu   => NCPU, tbits => 30, tech => memtech, irq => 0, kbytes => CFG_ATBSZ)
        port map (rstn, clkm, ahbmi, ahbsi, ahbso(2), dbgo, dbgi, dsui, dsuo);
    
      dsui.enable <= '1';
      dsui.break  <= '0';

      dsuact_pad : outpad generic map (tech => padtech) port map (dsuact, dsuo.active);
    end generate;
  end generate;
  nodsu : if CFG_DSU = 0 generate 
    ahbso(2) <= ahbs_none; dsuo.tstop <= '0'; dsuo.active <= '0';
  end generate;

  dcomgen : if CFG_AHB_UART = 1 generate
    dcom0 : ahbuart                     -- Debug UART
      generic map (hindex => NCPU, pindex => 4, paddr => 7)
      port map (rstn, clkm, dui, duo, apbi, apbo(4), ahbmi, ahbmo(NCPU));
    dsurx_pad : inpad generic map (tech  => padtech) port map (rxd1, dui.rxd);
    dsutx_pad : outpad generic map (tech => padtech) port map (txd1, duo.txd);
  end generate;
  nouah : if CFG_AHB_UART = 0 generate apbo(7) <= apb_none; end generate;

  ahbjtaggen0 :if CFG_AHB_JTAG = 1 generate
    ahbjtag0 : ahbjtag generic map(tech => fabtech, hindex => NCPU+CFG_AHB_UART)
      port map(rstn, clkm, tck, tms, tdi, tdo, ahbmi, ahbmo(NCPU+CFG_AHB_UART),
               open, open, open, open, open, open, open, gnd(0));
  end generate;

----------------------------------------------------------------------
---  Memory controllers ----------------------------------------------
----------------------------------------------------------------------

  mctrl0 : if CFG_MCTRL_LEON2 = 1 generate
    mctrl0 : mctrl generic map (hindex => 0, pindex => 0,
           romaddr => 16#000#, rommask => 16#E00#,
           ioaddr => 16#200#, iomask => 16#E00#,
           ramaddr => 16#C00#, rammask => 16#F00#,
           paddr => 0, pmask => 16#FFF#,
           srbanks => 1, wprot => 0,
           ram8 => CFG_MCTRL_RAM8BIT, ram16 => CFG_MCTRL_RAM16BIT,
           sden => CFG_MCTRL_SDEN,
           invclk => CFG_MCTRL_INVCLK, sepbus => CFG_MCTRL_SEPBUS)
    port map (rstn, clkm, memi, memo, ahbsi, ahbso(0), apbi, apbo(0), wpo, open);
  end generate;

  memi.brdyn  <= '1'; memi.bexcn <= '1';
  memi.writen <= '1'; memi.wrn <= "1111"; memi.bwidth <= "01";

  mg0 : if CFG_MCTRL_LEON2 = 0 generate	-- no prom/sram pads
    apbo(0) <= apb_none; ahbso(0) <= ahbs_none;
    rom_sel_pad : outpad generic map (tech => padtech)
      port map (flash_cen, vcc(0));
    ssram_sel_pad : outpad generic map (tech => padtech)
      port map (ssram_cen, vcc(0));
    io_sel_pad : outpad generic map (tech => padtech)
      port map (io_cen, vcc(0));
  end generate;

  mgpads : if CFG_MCTRL_LEON2 = 1 generate
  -- flash/ssram data/address pads
    fsaddr_pad : outpadv generic map (width => 25, tech => padtech)
      port map (fs_addr, memo.address(25 downto 1));
    fsdata_pad : iopadvv generic map (width => 32, tech => padtech)
      port map (fs_data, memo.data, memo.vbdrive, memi.data);
    
  -- flash only pads
    rom_sel_pad : outpad generic map (tech => padtech)
      port map (flash_cen, memo.romsn(0));
    rom_oen_pad : outpad generic map (tech => padtech)
      port map (flash_oen, memo.oen);
    rom_wri_pad : outpad generic map (tech => padtech)
      port map (flash_wen, memo.writen);

  -- ssram only pads
    ssram_adv_n_pad : outpad generic map (tech => padtech) 
      port map (ssram_advn, vcc(0)); 
    ssram_adsp_n_pad : outpad generic map (tech => padtech) 
      port map (ssram_adspn, vcc(0)); 
    ssram_adscn_pad : outpad generic map (tech => padtech) 
      port map (ssram_adscn, gnd(0)); 
    ssram_sel_pad : outpad generic map ( tech => padtech)
      port map (ssram_cen, memo.ramsn(0));
    ssram_oen_pad  : outpad generic map (tech => padtech) 
      port map (ssram_oen, memo.ramoen(0));
    ssram_wen_pad : outpad generic map (tech => padtech) 
      port map (ssram_wen, memo.wrn(0));
    ssram_bw_pad : outpadv generic map (width => 4, tech => padtech)
      port map (ssram_bw, memo.mben);

  -- io data
    io_sel_pad : outpad generic map (tech => padtech)
      port map (io_cen, memo.iosn);
    io_wri_pad : outpad generic map (tech => padtech)
      port map (io_wen, memo.writen);
  end generate;

  ddrsp0 : if (CFG_DDR2SP /= 0) generate 
    ddrc0 : ddr2spa generic map ( fabtech => fabtech, memtech => memtech, 
      hindex => 3, haddr => 16#400#, hmask => 16#C00#, ioaddr => 1, 
      pwron => CFG_DDR2SP_INIT, MHz => BOARD_FREQ/1000, 
      clkmul => CFG_DDR2SP_FREQ/10, clkdiv => BOARD_FREQ/10000,
      ahbfreq => CPU_FREQ/1000, col => CFG_DDR2SP_COL,
      Mbyte => CFG_DDR2SP_SIZE, ddrbits => 64, readdly => 1,
      ddelayb0 => CFG_DDR2SP_DELAY0, ddelayb1 => CFG_DDR2SP_DELAY1, 
      ddelayb2 => CFG_DDR2SP_DELAY2, ddelayb3 => CFG_DDR2SP_DELAY3, 
      ddelayb4 => CFG_DDR2SP_DELAY4, ddelayb5 => CFG_DDR2SP_DELAY5,
      ddelayb6 => CFG_DDR2SP_DELAY6, ddelayb7 => CFG_DDR2SP_DELAY7,
      numidelctrl => 3, norefclk => 1, odten => 1, dqsse => 1)
    port map ( rst_ddr => resetn, rst_ahb => rstn, clk_ddr => clk, clk_ahb => clkm, clkref200 => gnd(0),
               lock => lock, clkddro => clkml, clkddri => clkml, ahbsi => ahbsi, ahbso => ahbso(3),
               ddr_clk => ddr_clkv, ddr_clkb => ddr_clkbv, ddr_clk_fb => gnd(0), ddr_cke => ddr_ckev,
               ddr_csb => ddr_csbv, ddr_web => ddr_web, ddr_rasb => ddr_rasb, ddr_casb => ddr_casb, 
               ddr_dm => ddr_dm, ddr_dqs => ddr_dqs, ddr_dqsn => open, ddr_ad => ddr_ad, ddr_ba => ddr_ba,
               ddr_dq => ddr_dq, ddr_odt => ddr_odt);
    ddr_clk <= ddr_clkv(2 downto 0); ddr_clkb <= ddr_clkbv(2 downto 0);
    ddr_cke <= ddr_ckev(1 downto 0); ddr_csb <= ddr_csbv(1 downto 0);
  end generate;

  noddr : if (CFG_DDR2SP = 0) generate 
    ddr_cke <= (others => '0'); ddr_csb <= (others => '1'); lock <= '1';
  end generate;


-----------------------------------------------------------------------
---  ETHERNET ---------------------------------------------------------
-----------------------------------------------------------------------

    eth1 : if CFG_GRETH = 1 generate -- Gaisler ethernet MAC
      e1 : grethm generic map(hindex => NCPU+CFG_AHB_UART+CFG_AHB_JTAG, 
	pindex => 11, paddr => 11, pirq => 12, memtech => memtech,
        mdcscaler => CPU_FREQ/1000, enable_mdio => 1, fifosize => CFG_ETH_FIFO,
        nsync => 1, edcl => CFG_DSU_ETH, edclbufsz => CFG_ETH_BUF,
        macaddrh => CFG_ETH_ENM, macaddrl => CFG_ETH_ENL, phyrstadr => 18,
	ipaddrh => CFG_ETH_IPM, ipaddrl => CFG_ETH_IPL, giga => CFG_GRETH1G)
      port map( rst => rstn, clk => clkm, ahbmi => ahbmi,
        ahbmo => ahbmo(NCPU+CFG_AHB_UART+CFG_AHB_JTAG), 
	apbi => apbi, apbo => apbo(11), ethi => ethi, etho => etho); 

      emdio_pad : iopad generic map (tech => padtech) 
      port map (phy_mii_data, etho.mdio_o, etho.mdio_oe, ethi.mdio_i);
      etxc_pad : inpad generic map (tech => padtech) 
	port map (phy_tx_clk, ethi.tx_clk);
      erxc_pad : inpad generic map (tech => padtech) 
	port map (phy_rx_clk, ethi.rx_clk);
      erxd_pad : inpadv generic map (tech => padtech, width => 8) 
	port map (phy_rx_data, ethi.rxd(7 downto 0));
      erxdv_pad : inpad generic map (tech => padtech) 
	port map (phy_dv, ethi.rx_dv);
      erxer_pad : inpad generic map (tech => padtech) 
	port map (phy_rx_er, ethi.rx_er);
      erxco_pad : inpad generic map (tech => padtech) 
	port map (phy_col, ethi.rx_col);
      erxcr_pad : inpad generic map (tech => padtech) 
	port map (phy_crs, ethi.rx_crs);

      etxd_pad : outpadv generic map (tech => padtech, width => 8) 
	port map (phy_tx_data, etho.txd(7 downto 0));
      etxen_pad : outpad generic map (tech => padtech) 
	port map ( phy_tx_en, etho.tx_en);
      etxer_pad : outpad generic map (tech => padtech) 
	port map (phy_tx_er, etho.tx_er);
      emdc_pad : outpad generic map (tech => padtech) 
	port map (phy_mii_clk, etho.mdc);

    end generate;


----------------------------------------------------------------------
---  APB Bridge and various peripherals -------------------------------
----------------------------------------------------------------------

  apb0 : apbctrl                        -- AHB/APB bridge
    generic map (hindex => 1, haddr => CFG_APBADDR)
    port map (rstn, clkm, ahbsi, ahbso(1), apbi, apbo);

  ua1 : if CFG_UART1_ENABLE = 1 generate
    uart1 : ft245uart                     -- UART 1
      generic map (pindex => 1, paddr => 1, pirq => 2, console => dbguart)
      port map (rstn, clkm, apbi, apbo(1), ft245i, ft245o);

    ft245_vbdrive <= (others => ft245o.oen);
    ft245_data_pad : iopadvv generic map (width => 8, tech => padtech)
      port map (ft245_data, ft245o.wrdata, ft245_vbdrive, ft245i.rddata);
    ft245_rdn_pad : outpad generic map (tech => padtech)
      port map (ft245_rdn, ft245o.rdn);
    ft245_wr_pad : outpad generic map (tech => padtech)
      port map (ft245_wr, ft245o.wr);
    ft245_rxfn_pad : inpad generic map (tech  => padtech)
      port map (ft245_rxfn, ft245i.rxfn);
    ft245_txen_pad : inpad generic map (tech  => padtech)
      port map (ft245_txen, ft245i.txen);
    ft245_pwrenn_pad : inpad generic map (tech  => padtech)
      port map (ft245_pwrenn, ft245i.pwrenn);
    
  end generate;
  noua0 : if CFG_UART1_ENABLE = 0 generate apbo(1) <= apb_none; end generate;

  irqctrl : if CFG_IRQ3_ENABLE /= 0 generate
    irqctrl0 : irqmp                    -- interrupt controller
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
    timer0 : gptimer                    -- timer unit
      generic map (pindex => 3, paddr => 3, pirq => CFG_GPT_IRQ,
        sepirq => CFG_GPT_SEPIRQ, sbits => CFG_GPT_SW, ntimers => CFG_GPT_NTIM,
        nbits  => CFG_GPT_TW)
      port map (rstn, clkm, apbi, apbo(3), gpti, open);
    gpti.dhalt <= dsuo.tstop; gpti.extclk <= '0';
  end generate;
  notim : if CFG_GPT_ENABLE = 0 generate apbo(3) <= apb_none; end generate;
  
  gpio0 : if CFG_GRGPIO_ENABLE /= 0 generate     -- GPIO unit
    grgpio0: grgpio
    generic map(pindex => 5, paddr => 5, imask => CFG_GRGPIO_IMASK, nbits => CFG_GRGPIO_WIDTH)
    port map(rst => rstn, clk => clkm, apbi => apbi, apbo => apbo(5),
    gpioi => gpioi, gpioo => gpioo);
    pio_pads : for i in 0 to CFG_GRGPIO_WIDTH-1 generate
        pio_pad : iopad generic map (tech => padtech)
            port map (gpio(i), gpioo.dout(i), gpioo.oen(i), gpioi.din(i));
    end generate;
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
    ahbram0 : ahbram generic map (hindex => 7, haddr => CFG_AHBRADDR,
                                  tech   => CFG_MEMTECH, kbytes => CFG_AHBRSZ)
      port map (rstn, clkm, ahbsi, ahbso(7));
  end generate;
  nram : if CFG_AHBRAMEN = 0 generate ahbso(7) <= ahbs_none; end generate;

-----------------------------------------------------------------------
---  Drive unused bus elements  ---------------------------------------
-----------------------------------------------------------------------

  nam1 : for i in (NCPU+CFG_AHB_UART+CFG_AHB_JTAG+CFG_GRETH) to NAHBMST-1 generate
    ahbmo(i) <= ahbm_none;
  end generate;
--  nap0 : for i in 6 to NAPBSLV-1 generate apbo(i) <= apb_none; end generate;
--  nah0 : for i in 7 to NAHBSLV-1 generate ahbso(i) <= ahbs_none; end generate;

-----------------------------------------------------------------------
---  Boot message  ----------------------------------------------------
-----------------------------------------------------------------------

-- pragma translate_off
  x : report_version 
  generic map (
   msg1 => "LEON3 Altera EP2SGX90 SSRAM/DDR Demonstration design",
   msg2 => "GRLIB Version " & tost(LIBVHDL_VERSION/1000) & "." & tost((LIBVHDL_VERSION mod 1000)/100)
      & "." & tost(LIBVHDL_VERSION mod 100) & ", build " & tost(LIBVHDL_BUILD),
   msg3 => "Target technology: " & tech_table(fabtech) & ",  memory library: " & tech_table(memtech),
   mdel => 1
  );
-- pragma translate_on

end;
