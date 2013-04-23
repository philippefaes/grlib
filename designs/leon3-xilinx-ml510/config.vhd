



-----------------------------------------------------------------------------
-- LEON3 Demonstration design test bench configuration
-- Copyright (C) 2009 Aeroflex Gaisler
------------------------------------------------------------------------------


library techmap;
use techmap.gencomp.all;

package config is
-- Technology and synthesis options
  constant CFG_FABTECH : integer := virtex5;
  constant CFG_MEMTECH : integer := virtex5;
  constant CFG_PADTECH : integer := virtex5;
  constant CFG_NOASYNC : integer := 0;
  constant CFG_SCAN : integer := 0;
-- Clock generator
  constant CFG_CLKTECH : integer := virtex5;
  constant CFG_CLKMUL : integer := (8);
  constant CFG_CLKDIV : integer := (10);
  constant CFG_OCLKDIV : integer := 1;
  constant CFG_OCLKBDIV : integer := 0;
  constant CFG_OCLKCDIV : integer := 0;
  constant CFG_PCIDLL : integer := 0;
  constant CFG_PCISYSCLK: integer := 0;
  constant CFG_CLK_NOFB : integer := 1;
-- LEON3 processor core
  constant CFG_LEON3 : integer := 1;
  constant CFG_NCPU : integer := (2);
  constant CFG_NWIN : integer := (8);
  constant CFG_V8 : integer := 16#32# + 4*0;
  constant CFG_MAC : integer := 0;
  constant CFG_BP : integer := 1;
  constant CFG_SVT : integer := 1;
  constant CFG_RSTADDR : integer := 16#00000#;
  constant CFG_LDDEL : integer := (1);
  constant CFG_NOTAG : integer := 0;
  constant CFG_NWP : integer := (2);
  constant CFG_PWD : integer := 1*2;
  constant CFG_FPU : integer := 0 + 16*0 + 32*0;
  constant CFG_GRFPUSH : integer := 0;
  constant CFG_ICEN : integer := 1;
  constant CFG_ISETS : integer := 4;
  constant CFG_ISETSZ : integer := 8;
  constant CFG_ILINE : integer := 8;
  constant CFG_IREPL : integer := 0;
  constant CFG_ILOCK : integer := 0;
  constant CFG_ILRAMEN : integer := 0;
  constant CFG_ILRAMADDR: integer := 16#8E#;
  constant CFG_ILRAMSZ : integer := 1;
  constant CFG_DCEN : integer := 1;
  constant CFG_DSETS : integer := 4;
  constant CFG_DSETSZ : integer := 4;
  constant CFG_DLINE : integer := 4;
  constant CFG_DREPL : integer := 0;
  constant CFG_DLOCK : integer := 0;
  constant CFG_DSNOOP : integer := 1 + 1 + 4*1;
  constant CFG_DFIXED : integer := 16#0#;
  constant CFG_DLRAMEN : integer := 0;
  constant CFG_DLRAMADDR: integer := 16#8F#;
  constant CFG_DLRAMSZ : integer := 1;
  constant CFG_MMUEN : integer := 1;
  constant CFG_ITLBNUM : integer := 8;
  constant CFG_DTLBNUM : integer := 8;
  constant CFG_TLB_TYPE : integer := 0 + 1*2;
  constant CFG_TLB_REP : integer := 0;
  constant CFG_MMU_PAGE : integer := 0;
  constant CFG_DSU : integer := 1;
  constant CFG_ITBSZ : integer := 2;
  constant CFG_ATBSZ : integer := 2;
  constant CFG_LEON3FT_EN : integer := 0;
  constant CFG_IUFT_EN : integer := 0;
  constant CFG_FPUFT_EN : integer := 0;
  constant CFG_RF_ERRINJ : integer := 0;
  constant CFG_CACHE_FT_EN : integer := 0;
  constant CFG_CACHE_ERRINJ : integer := 0;
  constant CFG_LEON3_NETLIST: integer := 0;
  constant CFG_DISAS : integer := 0 + 0;
  constant CFG_PCLOW : integer := 2;
-- AMBA settings
  constant CFG_DEFMST : integer := (0);
  constant CFG_RROBIN : integer := 1;
  constant CFG_SPLIT : integer := 1;
  constant CFG_FPNPEN : integer := 0;
  constant CFG_AHBIO : integer := 16#FFF#;
  constant CFG_APBADDR : integer := 16#C00#;
  constant CFG_AHB_MON : integer := 1;
  constant CFG_AHB_MONERR : integer := 1;
  constant CFG_AHB_MONWAR : integer := 1;
  constant CFG_AHB_DTRACE : integer := 0;
-- DSU UART
  constant CFG_AHB_UART : integer := 1;
-- JTAG based DSU interface
  constant CFG_AHB_JTAG : integer := 1;
-- Ethernet DSU
  constant CFG_DSU_ETH : integer := 1 + 0 + 0;
  constant CFG_ETH_BUF : integer := 2;
  constant CFG_ETH_IPM : integer := 16#C0A8#;
  constant CFG_ETH_IPL : integer := 16#0034#;
  constant CFG_ETH_ENM : integer := 16#020000#;
  constant CFG_ETH_ENL : integer := 16#000035#;
-- LEON2 memory controller
  constant CFG_MCTRL_LEON2 : integer := 1;
  constant CFG_MCTRL_RAM8BIT : integer := 0;
  constant CFG_MCTRL_RAM16BIT : integer := 1;
  constant CFG_MCTRL_5CS : integer := 0;
  constant CFG_MCTRL_SDEN : integer := 0;
  constant CFG_MCTRL_SEPBUS : integer := 0;
  constant CFG_MCTRL_INVCLK : integer := 0;
  constant CFG_MCTRL_SD64 : integer := 0;
  constant CFG_MCTRL_PAGE : integer := 0 + 0;
-- DDR controller
  constant CFG_DDR2SP : integer := 1;
  constant CFG_DDR2SP_INIT : integer := 1;
  constant CFG_DDR2SP_FREQ : integer := 100;
  constant CFG_DDR2SP_TRFC : integer := (130);
  constant CFG_DDR2SP_DATAWIDTH : integer := (64);
  constant CFG_DDR2SP_FTEN : integer := 0;
  constant CFG_DDR2SP_FTWIDTH : integer := 0;
  constant CFG_DDR2SP_COL : integer := (10);
  constant CFG_DDR2SP_SIZE : integer := (512);
  constant CFG_DDR2SP_DELAY0 : integer := (8);
  constant CFG_DDR2SP_DELAY1 : integer := (8);
  constant CFG_DDR2SP_DELAY2 : integer := (8);
  constant CFG_DDR2SP_DELAY3 : integer := (8);
  constant CFG_DDR2SP_DELAY4 : integer := (8);
  constant CFG_DDR2SP_DELAY5 : integer := (8);
  constant CFG_DDR2SP_DELAY6 : integer := (8);
  constant CFG_DDR2SP_DELAY7 : integer := (8);
  constant CFG_DDR2SP_NOSYNC : integer := 1;
-- AHB status register
  constant CFG_AHBSTAT : integer := 1;
  constant CFG_AHBSTATN : integer := (1);
-- AHB ROM
  constant CFG_AHBROMEN : integer := 0;
  constant CFG_AHBROPIP : integer := 0;
  constant CFG_AHBRODDR : integer := 16#000#;
  constant CFG_ROMADDR : integer := 16#000#;
  constant CFG_ROMMASK : integer := 16#E00# + 16#000#;
-- AHB RAM
  constant CFG_AHBRAMEN : integer := 0;
  constant CFG_AHBRSZ : integer := 1;
  constant CFG_AHBRADDR : integer := 16#A00#;
-- Gaisler Ethernet core
  constant CFG_GRETH : integer := 1;
  constant CFG_GRETH1G : integer := 0;
  constant CFG_ETH_FIFO : integer := 64;

-- UART 1
  constant CFG_UART1_ENABLE : integer := 1;
  constant CFG_UART1_FIFO : integer := 4;

-- LEON3 interrupt controller
  constant CFG_IRQ3_ENABLE : integer := 1;
  constant CFG_IRQ3_NSEC : integer := 0;

-- Modular timer
  constant CFG_GPT_ENABLE : integer := 1;
  constant CFG_GPT_NTIM : integer := (2);
  constant CFG_GPT_SW : integer := (8);
  constant CFG_GPT_TW : integer := (32);
  constant CFG_GPT_IRQ : integer := (8);
  constant CFG_GPT_SEPIRQ : integer := 1;
  constant CFG_GPT_WDOGEN : integer := 0;
  constant CFG_GPT_WDOG : integer := 16#0#;

-- GPIO port
  constant CFG_GRGPIO_ENABLE : integer := 1;
  constant CFG_GRGPIO_IMASK : integer := 16#0060#;
  constant CFG_GRGPIO_WIDTH : integer := (12);

-- I2C master
  constant CFG_I2C_ENABLE : integer := 1;

-- SPI controller
  constant CFG_SPICTRL_ENABLE : integer := 1;
  constant CFG_SPICTRL_NUM : integer := (1);
  constant CFG_SPICTRL_SLVS : integer := (1);
  constant CFG_SPICTRL_FIFO : integer := (2);
  constant CFG_SPICTRL_SLVREG : integer := 1;
  constant CFG_SPICTRL_ODMODE : integer := 0;
  constant CFG_SPICTRL_AM : integer := 0;
  constant CFG_SPICTRL_ASEL : integer := 0;
  constant CFG_SPICTRL_TWEN : integer := 0;
  constant CFG_SPICTRL_MAXWLEN : integer := (0);
  constant CFG_SPICTRL_SYNCRAM : integer := 0;
  constant CFG_SPICTRL_FT : integer := 0;

-- PCI interface
  constant CFG_PCI : integer := 3;
  constant CFG_PCIVID : integer := 16#1AC8#;
  constant CFG_PCIDID : integer := 16#0054#;
  constant CFG_PCIDEPTH : integer := 128;
  constant CFG_PCI_MTF : integer := 1;

-- PCI arbiter
  constant CFG_PCI_ARB : integer := 1;
  constant CFG_PCI_ARBAPB : integer := 1;
  constant CFG_PCI_ARB_NGNT : integer := (8);

-- PCI trace buffer
  constant CFG_PCITBUFEN: integer := 1;
  constant CFG_PCITBUF : integer := 4096;

-- SVGA controller
  constant CFG_SVGA_ENABLE : integer := 1;

-- AMBA System ACE Interface Controller
  constant CFG_GRACECTRL : integer := 1;

-- AMBA Wrapper for Xilinx System Monitor
  constant CFG_GRSYSMON : integer := 0;

-- GRLIB debugging
  constant CFG_DUART : integer := 0;
end;
