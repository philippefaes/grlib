

-----------------------------------------------------------------------------
-- LEON3 Demonstration design test bench configuration
-- Copyright (C) 2009 Aeroflex Gaisler
------------------------------------------------------------------------------


library techmap;
use techmap.gencomp.all;

package config is
-- Technology and synthesis options
  constant CFG_FABTECH : integer := inferred;
  constant CFG_MEMTECH : integer := inferred;
  constant CFG_PADTECH : integer := inferred;
  constant CFG_NOASYNC : integer := 0;
  constant CFG_SCAN : integer := 0;
-- Clock generator
  constant CFG_CLKTECH : integer := inferred;
  constant CFG_CLKMUL : integer := 2;
  constant CFG_CLKDIV : integer := 2;
  constant CFG_OCLKDIV : integer := 1;
  constant CFG_OCLKBDIV : integer := 0;
  constant CFG_OCLKCDIV : integer := 0;
  constant CFG_PCIDLL : integer := 0;
  constant CFG_PCISYSCLK: integer := 0;
  constant CFG_CLK_NOFB : integer := 0;
-- LEON3 processor core
  constant CFG_LEON3 : integer := 1;
  constant CFG_NCPU : integer := (1);
  constant CFG_NWIN : integer := (8);
  constant CFG_V8 : integer := 0 + 4*0;
  constant CFG_MAC : integer := 0;
  constant CFG_BP : integer := 0;
  constant CFG_SVT : integer := 0;
  constant CFG_RSTADDR : integer := 16#00000#;
  constant CFG_LDDEL : integer := (1);
  constant CFG_NOTAG : integer := 0;
  constant CFG_NWP : integer := (0);
  constant CFG_PWD : integer := 0*2;
  constant CFG_FPU : integer := 0 + 16*0;
  constant CFG_GRFPUSH : integer := 0;
  constant CFG_ICEN : integer := 0;
  constant CFG_ISETS : integer := 1;
  constant CFG_ISETSZ : integer := 1;
  constant CFG_ILINE : integer := 8;
  constant CFG_IREPL : integer := 0;
  constant CFG_ILOCK : integer := 0;
  constant CFG_ILRAMEN : integer := 0;
  constant CFG_ILRAMADDR: integer := 16#8E#;
  constant CFG_ILRAMSZ : integer := 1;
  constant CFG_DCEN : integer := 0;
  constant CFG_DSETS : integer := 1;
  constant CFG_DSETSZ : integer := 1;
  constant CFG_DLINE : integer := 8;
  constant CFG_DREPL : integer := 0;
  constant CFG_DLOCK : integer := 0;
  constant CFG_DSNOOP : integer := 0 + 0 + 4*0;
  constant CFG_DFIXED : integer := 16#0#;
  constant CFG_DLRAMEN : integer := 0;
  constant CFG_DLRAMADDR: integer := 16#8F#;
  constant CFG_DLRAMSZ : integer := 1;
  constant CFG_MMUEN : integer := 0;
  constant CFG_ITLBNUM : integer := 2;
  constant CFG_DTLBNUM : integer := 2;
  constant CFG_TLB_TYPE : integer := 1 + 0*2;
  constant CFG_TLB_REP : integer := 1;
  constant CFG_MMU_PAGE : integer := 0;
  constant CFG_DSU : integer := 0;
  constant CFG_ITBSZ : integer := 0;
  constant CFG_ATBSZ : integer := 0;
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
  constant CFG_RROBIN : integer := 0;
  constant CFG_SPLIT : integer := 0;
  constant CFG_AHBIO : integer := 16#FFF#;
  constant CFG_APBADDR : integer := 16#800#;
  constant CFG_AHB_MON : integer := 0;
  constant CFG_AHB_MONERR : integer := 0;
  constant CFG_AHB_MONWAR : integer := 0;
  constant CFG_AHB_DTRACE : integer := 0;
-- DSU UART
  constant CFG_AHB_UART : integer := 0;
-- JTAG based DSU interface
  constant CFG_AHB_JTAG : integer := 0;
-- Pass through port settings
  constant CFG_AHBM_PT : integer := 0; -- Number of Master pass through ports
  constant CFG_AHBS_PT : integer := 1; -- Number of Slave pass through ports
  constant CFG_AHBM0_BAR0 : integer := 16#000#; -- BAR0 address
  constant CFG_AHBM0_MASK0 : integer := 16#000#; -- BAR0 mask
  constant CFG_AHBM0_BARTYPE0 : integer := 0; -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF0 : integer := 0; -- BAR0 Prefetchable
  constant CFG_AHBM0_CA0 : integer := 0; -- BAR0 Cacheable
  constant CFG_AHBM0_BAR1 : integer := 16#000#; -- BAR1 address
  constant CFG_AHBM0_MASK1 : integer := 16#000#; -- BAR1 mask
  constant CFG_AHBM0_BARTYPE1 : integer := 0; -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF1 : integer := 0; -- BAR1 Prefetchable
  constant CFG_AHBM0_CA1 : integer := 0; -- BAR1 Cacheable
  constant CFG_AHBM0_BAR2 : integer := 16#000#; -- BAR2 address
  constant CFG_AHBM0_MASK2 : integer := 16#000#; -- BAR2 mask
  constant CFG_AHBM0_BARTYPE2 : integer := 0; -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF2 : integer := 0; -- BAR2 Prefetchable
  constant CFG_AHBM0_CA2 : integer := 0; -- BAR2 Cacheable
  constant CFG_AHBM0_BAR3 : integer := 16#000#; -- BAR3 address
  constant CFG_AHBM0_MASK3 : integer := 16#000#; -- BAR3 mask
  constant CFG_AHBM0_BARTYPE3 : integer := 0; -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF3 : integer := 0; -- BAR3 Prefetchable
  constant CFG_AHBM0_CA3 : integer := 0; -- BAR3 Cacheable
  constant CFG_AHBM1_BAR0 : integer := 16#000#; -- BAR0 address
  constant CFG_AHBM1_MASK0 : integer := 16#000#; -- BAR0 mask
  constant CFG_AHBM1_BARTYPE0 : integer := 0; -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF0 : integer := 0; -- BAR0 Prefetchable
  constant CFG_AHBM1_CA0 : integer := 0; -- BAR0 Cacheable
  constant CFG_AHBM1_BAR1 : integer := 16#000#; -- BAR1 address
  constant CFG_AHBM1_MASK1 : integer := 16#000#; -- BAR1 mask
  constant CFG_AHBM1_BARTYPE1 : integer := 0; -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF1 : integer := 0; -- BAR1 Prefetchable
  constant CFG_AHBM1_CA1 : integer := 0; -- BAR1 Cacheable

  constant CFG_AHBM1_BAR2 : integer := 16#000#; -- BAR2 address
  constant CFG_AHBM1_MASK2 : integer := 16#000#; -- BAR2 mask
  constant CFG_AHBM1_BARTYPE2 : integer := 0; -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF2 : integer := 0; -- BAR2 Prefetchable
  constant CFG_AHBM1_CA2 : integer := 0; -- BAR2 Cacheable

  constant CFG_AHBM1_BAR3 : integer := 16#000#; -- BAR3 address
  constant CFG_AHBM1_MASK3 : integer := 16#000#; -- BAR3 mask
  constant CFG_AHBM1_BARTYPE3 : integer := 0; -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF3 : integer := 0; -- BAR3 Prefetchable
  constant CFG_AHBM1_CA3 : integer := 0; -- BAR3 Cacheable

  constant CFG_AHBS0_BAR0 : integer := 16#A00#; -- BAR0 address
  constant CFG_AHBS0_MASK0 : integer := 16#00F#; -- BAR0 mask
  constant CFG_AHBS0_BARTYPE0 : integer := 0; -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF0 : integer := 0; -- BAR0 Prefetchable
  constant CFG_AHBS0_CA0 : integer := 0; -- BAR0 Cacheable

  constant CFG_AHBS0_BAR1 : integer := 16#000#; -- BAR1 address
  constant CFG_AHBS0_MASK1 : integer := 16#000#; -- BAR1 mask
  constant CFG_AHBS0_BARTYPE1 : integer := 0; -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF1 : integer := 0; -- BAR1 Prefetchable
  constant CFG_AHBS0_CA1 : integer := 0; -- BAR1 Cacheable

  constant CFG_AHBS0_BAR2 : integer := 16#000#; -- BAR2 address
  constant CFG_AHBS0_MASK2 : integer := 16#000#; -- BAR2 mask
  constant CFG_AHBS0_BARTYPE2 : integer := 0; -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF2 : integer := 0; -- BAR2 Prefetchable
  constant CFG_AHBS0_CA2 : integer := 0; -- BAR2 Cacheable

  constant CFG_AHBS0_BAR3 : integer := 16#000#; -- BAR3 address
  constant CFG_AHBS0_MASK3 : integer := 16#000#; -- BAR3 mask
  constant CFG_AHBS0_BARTYPE3 : integer := 0; -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF3 : integer := 0; -- BAR3 Prefetchable
  constant CFG_AHBS0_CA3 : integer := 0; -- BAR3 Cacheable

  constant CFG_AHBS1_BAR0 : integer := 16#000#; -- BAR0 address
  constant CFG_AHBS1_MASK0 : integer := 16#000#; -- BAR0 mask
  constant CFG_AHBS1_BARTYPE0 : integer := 0; -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF0 : integer := 0; -- BAR0 Prefetchable
  constant CFG_AHBS1_CA0 : integer := 0; -- BAR0 Cacheable

  constant CFG_AHBS1_BAR1 : integer := 16#000#; -- BAR1 address
  constant CFG_AHBS1_MASK1 : integer := 16#000#; -- BAR1 mask
  constant CFG_AHBS1_BARTYPE1 : integer := 0; -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF1 : integer := 0; -- BAR1 Prefetchable
  constant CFG_AHBS1_CA1 : integer := 0; -- BAR1 Cacheable

  constant CFG_AHBS1_BAR2 : integer := 16#000#; -- BAR2 address
  constant CFG_AHBS1_MASK2 : integer := 16#000#; -- BAR2 mask
  constant CFG_AHBS1_BARTYPE2 : integer := 0; -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF2 : integer := 0; -- BAR2 Prefetchable
  constant CFG_AHBS1_CA2 : integer := 0; -- BAR2 Cacheable

  constant CFG_AHBS1_BAR3 : integer := 16#000#; -- BAR3 address
  constant CFG_AHBS1_MASK3 : integer := 16#000#; -- BAR3 mask
  constant CFG_AHBS1_BARTYPE3 : integer := 0; -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF3 : integer := 0; -- BAR3 Prefetchable
  constant CFG_AHBS1_CA3 : integer := 0; -- BAR3 Cacheable

  constant CFG_AHBS2_BAR0 : integer := 16#000#; -- BAR0 address
  constant CFG_AHBS2_MASK0 : integer := 16#000#; -- BAR0 mask
  constant CFG_AHBS2_BARTYPE0 : integer := 0; -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF0 : integer := 0; -- BAR0 Prefetchable
  constant CFG_AHBS2_CA0 : integer := 0; -- BAR0 Cacheable

  constant CFG_AHBS2_BAR1 : integer := 16#000#; -- BAR1 address
  constant CFG_AHBS2_MASK1 : integer := 16#000#; -- BAR1 mask
  constant CFG_AHBS2_BARTYPE1 : integer := 0; -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF1 : integer := 0; -- BAR1 Prefetchable
  constant CFG_AHBS2_CA1 : integer := 0; -- BAR1 Cacheable

  constant CFG_AHBS2_BAR2 : integer := 16#000#; -- BAR2 address
  constant CFG_AHBS2_MASK2 : integer := 16#000#; -- BAR2 mask
  constant CFG_AHBS2_BARTYPE2 : integer := 0; -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF2 : integer := 0; -- BAR2 Prefetchable
  constant CFG_AHBS2_CA2 : integer := 0; -- BAR2 Cacheable

  constant CFG_AHBS2_BAR3 : integer := 16#000#; -- BAR3 address
  constant CFG_AHBS2_MASK3 : integer := 16#000#; -- BAR3 mask
  constant CFG_AHBS2_BARTYPE3 : integer := 0; -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF3 : integer := 0; -- BAR3 Prefetchable
  constant CFG_AHBS2_CA3 : integer := 0; -- BAR3 Cacheable

  constant CFG_AHBS3_BAR0 : integer := 16#000#; -- BAR0 address
  constant CFG_AHBS3_MASK0 : integer := 16#000#; -- BAR0 mask
  constant CFG_AHBS3_BARTYPE0 : integer := 0; -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF0 : integer := 0; -- BAR0 Prefetchable
  constant CFG_AHBS3_CA0 : integer := 0; -- BAR0 Cacheable

  constant CFG_AHBS3_BAR1 : integer := 16#000#; -- BAR1 address
  constant CFG_AHBS3_MASK1 : integer := 16#000#; -- BAR1 mask
  constant CFG_AHBS3_BARTYPE1 : integer := 0; -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF1 : integer := 0; -- BAR1 Prefetchable
  constant CFG_AHBS3_CA1 : integer := 0; -- BAR1 Cacheable

  constant CFG_AHBS3_BAR2 : integer := 16#000#; -- BAR2 address
  constant CFG_AHBS3_MASK2 : integer := 16#000#; -- BAR2 mask
  constant CFG_AHBS3_BARTYPE2 : integer := 0; -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF2 : integer := 0; -- BAR2 Prefetchable
  constant CFG_AHBS3_CA2 : integer := 0; -- BAR2 Cacheable

  constant CFG_AHBS3_BAR3 : integer := 16#000#; -- BAR3 address
  constant CFG_AHBS3_MASK3 : integer := 16#000#; -- BAR3 mask
  constant CFG_AHBS3_BARTYPE3 : integer := 0; -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF3 : integer := 0; -- BAR3 Prefetchable
  constant CFG_AHBS3_CA3 : integer := 0; -- BAR3 Cacheable
-- AHB ROM
  constant CFG_AHBROMEN : integer := 1;
  constant CFG_AHBROPIP : integer := 0;
  constant CFG_AHBRODDR : integer := 16#000#;
  constant CFG_ROMADDR : integer := 16#100#;
  constant CFG_ROMMASK : integer := 16#E00# + 16#100#;

-- UART 1
  constant CFG_UART1_ENABLE : integer := 1;
  constant CFG_UART1_FIFO : integer := 1;

-- LEON3 interrupt controller
  constant CFG_IRQ3_ENABLE : integer := 0;
  constant CFG_IRQ3_NSEC : integer := 0;

-- Modular timer
  constant CFG_GPT_ENABLE : integer := 0;
  constant CFG_GPT_NTIM : integer := 1;
  constant CFG_GPT_SW : integer := 8;
  constant CFG_GPT_TW : integer := 8;
  constant CFG_GPT_IRQ : integer := 8;
  constant CFG_GPT_SEPIRQ : integer := 0;
  constant CFG_GPT_WDOGEN : integer := 0;
  constant CFG_GPT_WDOG : integer := 16#0#;

-- GPIO port
  constant CFG_GRGPIO_ENABLE : integer := 1;
  constant CFG_GRGPIO_IMASK : integer := 16#0000#;
  constant CFG_GRGPIO_WIDTH : integer := (32);

-- GRLIB debugging
  constant CFG_DUART : integer := 0;
end;
