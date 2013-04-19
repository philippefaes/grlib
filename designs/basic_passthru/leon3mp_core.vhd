------------------------------------------------------------------------------
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
-- Default address Mapping for the core:
-- Leon3:  Master address 
library ieee;
use ieee.std_logic_1164.all;

library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;

library gaisler;
use gaisler.leon3.all;
use gaisler.misc.all;
use gaisler.uart.all;
use gaisler.jtag.all;

library praesum;
use praesum.ahbpassthru_vhdl.all;

use work.config.all;

entity leon3mp_core is
  generic (
    fabtech   : integer := CFG_FABTECH;
    memtech   : integer := CFG_MEMTECH;
    padtech   : integer := CFG_PADTECH;
    clktech   : integer := CFG_CLKTECH;
    disas     : integer := CFG_DISAS;	-- Enable disassembly to console
    pclow     : integer := CFG_PCLOW;
    CFG_AHBDW : integer := 64;
    CFG_AHB_ACDM : integer := 1;

    ahbm_pt   : integer := CFG_AHBM_PT;  -- Number of master passthru ports
    ahbs_pt   : integer := CFG_AHBS_PT;  -- Number of slave  passthru ports
    m0_haddr0 : integer    := CFG_AHBM0_BAR0;
    m0_hmask0 : integer    := CFG_AHBM0_MASK0;
    m0_htype0 : integer    := CFG_AHBM0_BARTYPE0;
    m0_pf0    : integer    := CFG_AHBM0_PF0;
    m0_ca0    : integer    := CFG_AHBM0_CA0;
    m0_haddr1 : integer    := CFG_AHBM0_BAR1;
    m0_hmask1 : integer    := CFG_AHBM0_MASK1;
    m0_htype1 : integer    := CFG_AHBM0_BARTYPE1;
    m0_pf1    : integer    := CFG_AHBM0_PF1;
    m0_ca1    : integer    := CFG_AHBM0_CA1;
    m0_haddr2 : integer    := CFG_AHBM0_BAR2;
    m0_hmask2 : integer    := CFG_AHBM0_MASK2;
    m0_htype2 : integer    := CFG_AHBM0_BARTYPE2;
    m0_pf2    : integer    := CFG_AHBM0_PF2;
    m0_ca2    : integer    := CFG_AHBM0_CA2;
    m0_haddr3 : integer    := CFG_AHBM0_BAR3;
    m0_hmask3 : integer    := CFG_AHBM0_MASK3;
    m0_htype3 : integer    := CFG_AHBM0_BARTYPE3;
    m0_pf3    : integer    := CFG_AHBM0_PF3;
    m0_ca3    : integer    := CFG_AHBM0_CA3;
    m1_haddr0 : integer    := CFG_AHBM1_BAR0;
    m1_hmask0 : integer    := CFG_AHBM1_MASK0;
    m1_htype0 : integer    := CFG_AHBM1_BARTYPE0;
    m1_pf0    : integer    := CFG_AHBM1_PF0;
    m1_ca0    : integer    := CFG_AHBM1_CA0;
    m1_haddr1 : integer    := CFG_AHBM1_BAR1;
    m1_hmask1 : integer    := CFG_AHBM1_MASK1;
    m1_htype1 : integer    := CFG_AHBM1_BARTYPE1;
    m1_pf1    : integer    := CFG_AHBM1_PF1;
    m1_ca1    : integer    := CFG_AHBM1_CA1;
    m1_haddr2 : integer    := CFG_AHBM1_BAR2;
    m1_hmask2 : integer    := CFG_AHBM1_MASK2;
    m1_htype2 : integer    := CFG_AHBM1_BARTYPE2;
    m1_pf2    : integer    := CFG_AHBM1_PF2;
    m1_ca2    : integer    := CFG_AHBM1_CA2;
    m1_haddr3 : integer    := CFG_AHBM1_BAR3;
    m1_hmask3 : integer    := CFG_AHBM1_MASK3;
    m1_htype3 : integer    := CFG_AHBM1_BARTYPE3;
    m1_pf3    : integer    := CFG_AHBM1_PF3;
    m1_ca3    : integer    := CFG_AHBM1_CA3;
    s0_haddr0 : integer    := CFG_AHBS0_BAR0;
    s0_hmask0 : integer    := CFG_AHBS0_MASK0;
    s0_htype0 : integer    := CFG_AHBS0_BARTYPE0;
    s0_pf0    : integer    := CFG_AHBS0_PF0;
    s0_ca0    : integer    := CFG_AHBS0_CA0;
    s0_haddr1 : integer    := CFG_AHBS0_BAR1;
    s0_hmask1 : integer    := CFG_AHBS0_MASK1;
    s0_htype1 : integer    := CFG_AHBS0_BARTYPE1;
    s0_pf1    : integer    := CFG_AHBS0_PF1;
    s0_ca1    : integer    := CFG_AHBS0_CA1;
    s0_haddr2 : integer    := CFG_AHBS0_BAR2;
    s0_hmask2 : integer    := CFG_AHBS0_MASK2;
    s0_htype2 : integer    := CFG_AHBS0_BARTYPE2;
    s0_pf2    : integer    := CFG_AHBS0_PF2;
    s0_ca2    : integer    := CFG_AHBS0_CA2;
    s0_haddr3 : integer    := CFG_AHBS0_BAR3;
    s0_hmask3 : integer    := CFG_AHBS0_MASK3;
    s0_htype3 : integer    := CFG_AHBS0_BARTYPE3;
    s0_pf3    : integer    := CFG_AHBS0_PF3;
    s0_ca3    : integer    := CFG_AHBS0_CA3;
    s1_haddr0 : integer    := CFG_AHBS1_BAR0;
    s1_hmask0 : integer    := CFG_AHBS1_MASK0;
    s1_htype0 : integer    := CFG_AHBS1_BARTYPE0;
    s1_pf0    : integer    := CFG_AHBS1_PF0;
    s1_ca0    : integer    := CFG_AHBS1_CA0;
    s1_haddr1 : integer    := CFG_AHBS1_BAR1;
    s1_hmask1 : integer    := CFG_AHBS1_MASK1;
    s1_htype1 : integer    := CFG_AHBS1_BARTYPE1;
    s1_pf1    : integer    := CFG_AHBS1_PF1;
    s1_ca1    : integer    := CFG_AHBS1_CA1;
    s1_haddr2 : integer    := CFG_AHBS1_BAR2;
    s1_hmask2 : integer    := CFG_AHBS1_MASK2;
    s1_htype2 : integer    := CFG_AHBS1_BARTYPE2;
    s1_pf2    : integer    := CFG_AHBS1_PF2;
    s1_ca2    : integer    := CFG_AHBS1_CA2;
    s1_haddr3 : integer    := CFG_AHBS1_BAR3;
    s1_hmask3 : integer    := CFG_AHBS1_MASK3;
    s1_htype3 : integer    := CFG_AHBS1_BARTYPE3;
    s1_pf3    : integer    := CFG_AHBS1_PF3;
    s1_ca3    : integer    := CFG_AHBS1_CA3;
    s2_haddr0 : integer    := CFG_AHBS2_BAR0;
    s2_hmask0 : integer    := CFG_AHBS2_MASK0;
    s2_htype0 : integer    := CFG_AHBS2_BARTYPE0;
    s2_pf0    : integer    := CFG_AHBS2_PF0;
    s2_ca0    : integer    := CFG_AHBS2_CA0;
    s2_haddr1 : integer    := CFG_AHBS2_BAR1;
    s2_hmask1 : integer    := CFG_AHBS2_MASK1;
    s2_htype1 : integer    := CFG_AHBS2_BARTYPE1;
    s2_pf1    : integer    := CFG_AHBS2_PF1;
    s2_ca1    : integer    := CFG_AHBS2_CA1;
    s2_haddr2 : integer    := CFG_AHBS2_BAR2;
    s2_hmask2 : integer    := CFG_AHBS2_MASK2;
    s2_htype2 : integer    := CFG_AHBS2_BARTYPE2;
    s2_pf2    : integer    := CFG_AHBS2_PF2;
    s2_ca2    : integer    := CFG_AHBS2_CA2;
    s2_haddr3 : integer    := CFG_AHBS2_BAR3;
    s2_hmask3 : integer    := CFG_AHBS2_MASK3;
    s2_htype3 : integer    := CFG_AHBS2_BARTYPE3;
    s2_pf3    : integer    := CFG_AHBS2_PF3;
    s2_ca3    : integer    := CFG_AHBS2_CA3;
    s3_haddr0 : integer    := CFG_AHBS3_BAR0;
    s3_hmask0 : integer    := CFG_AHBS3_MASK0;
    s3_htype0 : integer    := CFG_AHBS3_BARTYPE0;
    s3_pf0    : integer    := CFG_AHBS3_PF0;
    s3_ca0    : integer    := CFG_AHBS3_CA0;
    s3_haddr1 : integer    := CFG_AHBS3_BAR1;
    s3_hmask1 : integer    := CFG_AHBS3_MASK1;
    s3_htype1 : integer    := CFG_AHBS3_BARTYPE1;
    s3_pf1    : integer    := CFG_AHBS3_PF1;
    s3_ca1    : integer    := CFG_AHBS3_CA1;
    s3_haddr2 : integer    := CFG_AHBS3_BAR2;
    s3_hmask2 : integer    := CFG_AHBS3_MASK2;
    s3_htype2 : integer    := CFG_AHBS3_BARTYPE2;
    s3_pf2    : integer    := CFG_AHBS3_PF2;
    s3_ca2    : integer    := CFG_AHBS3_CA2;
    s3_haddr3 : integer    := CFG_AHBS3_BAR3;
    s3_hmask3 : integer    := CFG_AHBS3_MASK3;
    s3_htype3 : integer    := CFG_AHBS3_BARTYPE3;
    s3_pf3    : integer    := CFG_AHBS3_PF3;
    s3_ca3    : integer    := CFG_AHBS3_CA3
  );
  port (
    rstn        : in  std_ulogic;
    clk         : in  std_ulogic;
    dsutx       : out std_ulogic;                           -- DSU tx data
    dsurx       : in  std_ulogic;                           -- DSU rx data
    txd1        : out std_ulogic;                           -- UART1 tx data
    rxd1        : in  std_ulogic;                           -- UART1 rx data
    dsubreak    : in  std_ulogic;                           -- Break signal to DSU
    dsuactive   : out std_ulogic;                           -- DSU Active indicator
    gpio_in     : in  std_logic_vector(31 downto 0); 	    -- GPIO In
    gpio_out    : out std_logic_vector(31 downto 0);        -- GPIO Out
    gpio_oen    : out std_logic_vector(31 downto 0);        -- GPIO output enable

    -- Master #0 pass through
    m0_hgrant  : out std_logic;                             --bus grant
    m0_hready  : out std_logic;                             --transfer done
    m0_hresp   : out std_logic_vector(1 downto 0);          --response type
    m0_hrdata  : out std_logic_vector(AHBDW-1 downto 0);    --read data bus
    m0_hcache  : out std_logic;                             --cacheable
    m0_hirq    : out std_logic;                             --interrupt
    m0_hbusreq : in std_logic;                              --bus request
    m0_hlock   : in std_logic;                              --lock request
    m0_htrans  : in std_logic_vector(1 downto 0);           --transfer type
    m0_haddr   : in std_logic_vector(31 downto 0);          --address bus
    m0_hwrite  : in std_logic;                              --read/write
    m0_hsize   : in std_logic_vector(2 downto 0);           --transfer size
    m0_hburst  : in std_logic_vector(2 downto 0);           --burst type
    m0_hprot   : in std_logic_vector(3 downto 0);           --protection control
    m0_hwdata  : in std_logic_vector(AHBDW-1 downto 0);     --write data bus
    m0_hirq_o  : in std_logic;                              --interrupt

    -- Master #1 pass through
    m1_hgrant  : out std_logic;                             --bus grant
    m1_hready  : out std_logic;                             --transfer done
    m1_hresp   : out std_logic_vector(1 downto 0);          --response type
    m1_hrdata  : out std_logic_vector(AHBDW-1 downto 0);    --read data bus
    m1_hcache  : out std_logic;                             --cacheable
    m1_hirq    : out std_logic;                             --interrupt
    m1_hbusreq : in std_logic;                              --bus request
    m1_hlock   : in std_logic;                              --lock request
    m1_htrans  : in std_logic_vector(1 downto 0);           --transfer type
    m1_haddr   : in std_logic_vector(31 downto 0);          --address bus
    m1_hwrite  : in std_logic;                              --read/write
    m1_hsize   : in std_logic_vector(2 downto 0);           --transfer size
    m1_hburst  : in std_logic_vector(2 downto 0);           --burst type
    m1_hprot   : in std_logic_vector(3 downto 0);           --protection control
    m1_hwdata  : in std_logic_vector(AHBDW-1 downto 0);     --write data bus
    m1_hirq_o  : in std_logic;                              --interrupt

    -- Slave #0 pass through
    s0_hsel    : out std_logic;                             --slave select
    s0_haddr   : out std_logic_vector(31 downto 0);         --slave address (byte addressing)
    s0_hwrite  : out std_logic;                             --read/write
    s0_htrans  : out std_logic_vector(1 downto 0);          --transfer type
    s0_hsize   : out std_logic_vector(2 downto 0);          --transfer size
    s0_hburst  : out std_logic_vector(2 downto 0);          --burst type
    s0_hwdata  : out std_logic_vector(AHBDW-1 downto 0);    --write data
    s0_hprot   : out std_logic_vector(3 downto 0);          --protection control
    s0_hready  : out std_logic;                             --transfer done
    s0_hmaster : out std_logic_vector(3 downto 0);          --current master
    s0_hmastlock : out std_logic;                           --locked access
    s0_hmbsel  : out std_logic_vector(0 to NAHBAMR-1);      --memory bank select
    s0_hcache  : out std_logic;                             --cacheable
    s0_hirq    : out std_logic;                             --interrupt
    s0_hready_o : in std_logic;                             --transfer done
    s0_hresp   : in std_logic_vector(1 downto 0);           --response type
    s0_hrdata  : in std_logic_vector(AHBDW-1 downto 0);     --read data
    s0_hsplit  : in std_logic_vector(15 downto 0);          --split completion
    s0_hcache_o : in std_logic;                             --cacheable
    s0_hirq_o  : in std_logic;                              --interrupt

    -- Slave #1 pass through
    s1_hsel    : out std_logic;                             --slave select
    s1_haddr   : out std_logic_vector(31 downto 0);         --slave address (byte addressing)
    s1_hwrite  : out std_logic;                             --read/write
    s1_htrans  : out std_logic_vector(1 downto 0);          --transfer type
    s1_hsize   : out std_logic_vector(2 downto 0);          --transfer size
    s1_hburst  : out std_logic_vector(2 downto 0);          --burst type
    s1_hwdata  : out std_logic_vector(AHBDW-1 downto 0);    --write data
    s1_hprot   : out std_logic_vector(3 downto 0);          --protection control
    s1_hready  : out std_logic;                             --transfer done
    s1_hmaster : out std_logic_vector(3 downto 0);          --current master
    s1_hmastlock : out std_logic;                           --locked access
    s1_hmbsel  : out std_logic_vector(0 to NAHBAMR-1);      --memory bank select
    s1_hcache  : out std_logic;                             --cacheable
    s1_hirq    : out std_logic;                             --interrupt
    s1_hready_o : in std_logic;                             --transfer done
    s1_hresp   : in std_logic_vector(1 downto 0);           --response type
    s1_hrdata  : in std_logic_vector(AHBDW-1 downto 0);     --read data
    s1_hsplit  : in std_logic_vector(15 downto 0);          --split completion
    s1_hcache_o : in std_logic;                             --cacheable
    s1_hirq_o  : in std_logic;                              --interrupt

    -- Slave #2 pass through
    s2_hsel    : out std_logic;                             --slave select
    s2_haddr   : out std_logic_vector(31 downto 0);         --slave address (byte addressing)
    s2_hwrite  : out std_logic;                             --read/write
    s2_htrans  : out std_logic_vector(1 downto 0);          --transfer type
    s2_hsize   : out std_logic_vector(2 downto 0);          --transfer size
    s2_hburst  : out std_logic_vector(2 downto 0);          --burst type
    s2_hwdata  : out std_logic_vector(AHBDW-1 downto 0);    --write data
    s2_hprot   : out std_logic_vector(3 downto 0);          --protection control
    s2_hready  : out std_logic;                             --transfer done
    s2_hmaster : out std_logic_vector(3 downto 0);          --current master
    s2_hmastlock : out std_logic;                           --locked access
    s2_hmbsel  : out std_logic_vector(0 to NAHBAMR-1);      --memory bank select
    s2_hcache  : out std_logic;                             --cacheable
    s2_hirq    : out std_logic;                             --interrupt
    s2_hready_o : in std_logic;                             --transfer done
    s2_hresp   : in std_logic_vector(1 downto 0);           --response type
    s2_hrdata  : in std_logic_vector(AHBDW-1 downto 0);     --read data
    s2_hsplit  : in std_logic_vector(15 downto 0);          --split completion
    s2_hcache_o : in std_logic;                             --cacheable
    s2_hirq_o  : in std_logic;                              --interrupt

    -- Slave #3 pass through
    s3_hsel    : out std_logic;                             --slave select
    s3_haddr   : out std_logic_vector(31 downto 0);         --slave address (byte addressing)
    s3_hwrite  : out std_logic;                             --read/write
    s3_htrans  : out std_logic_vector(1 downto 0);          --transfer type
    s3_hsize   : out std_logic_vector(2 downto 0);          --transfer size
    s3_hburst  : out std_logic_vector(2 downto 0);          --burst type
    s3_hwdata  : out std_logic_vector(AHBDW-1 downto 0);    --write data
    s3_hprot   : out std_logic_vector(3 downto 0);          --protection control
    s3_hready  : out std_logic;                             --transfer done
    s3_hmaster : out std_logic_vector(3 downto 0);          --current master
    s3_hmastlock : out std_logic;                           --locked access
    s3_hmbsel  : out std_logic_vector(0 to NAHBAMR-1);      --memory bank select
    s3_hcache  : out std_logic;                             --cacheable
    s3_hirq    : out std_logic;                             --interrupt
    s3_hready_o : in std_logic;                             --transfer done
    s3_hresp   : in std_logic_vector(1 downto 0);           --response type
    s3_hrdata  : in std_logic_vector(AHBDW-1 downto 0);     --read data
    s3_hsplit  : in std_logic_vector(15 downto 0);          --split completion
    s3_hcache_o : in std_logic;                             --cacheable
    s3_hirq_o  : in std_logic                               --interrupt
    
    );
end;

architecture rtl of leon3mp_core is

constant NCPU      : integer := 1;  
constant nahbm     : integer := ahbm_pt + 2;  -- Total number of master ports
constant nahbs     : integer := ahbs_pt + 7;  -- Total number of slave ports

constant m0_hindex : integer := 2;      -- master passthru port #0
constant m1_hindex : integer := 3;      -- master passtrhu port #1
constant s0_hindex : integer := 7;      -- Slave passthru port #0
constant s1_hindex : integer := 8;      -- Slave passthru port #1
constant s2_hindex : integer := 9;      -- Slave passthru port #2
constant s3_hindex : integer := 10;     -- Slave passthru port #3

signal dsui : dsu_in_type;
signal dsuo : dsu_out_type; 
signal dbgi : l3_debug_in_vector(0 to NCPU-1);
signal dbgo : l3_debug_out_vector(0 to NCPU-1);
signal apbi : apb_slv_in_type;
signal apbo : apb_slv_out_vector := (others => apb_none);
signal ahbsi : ahb_slv_in_type;
signal ahbso : ahb_slv_out_vector := (others => ahbs_none);
signal ahbmi : ahb_mst_in_type;
signal ahbmo : ahb_mst_out_vector := (others => ahbm_none);

signal dui : uart_in_type;
signal duo : uart_out_type;

signal tck, tms, tdi, tdo : std_ulogic;
signal irqn, lclk, gnd : std_logic;

signal bus_error : std_logic_vector(1 downto 0);

signal irqi : irq_in_vector(0 to NCPU-1);
signal irqo : irq_out_vector(0 to NCPU-1);

signal gpioi : gpio_in_type;
signal gpioo : gpio_out_type;

begin

----------------------------------------------------------------------
---  LEON3 processor and DSU -----------------------------------------
----------------------------------------------------------------------

  -- hindex 0, Master 0, no MEMBAR
  l3 : if CFG_LEON3 = 1 generate
    cpu : for i in 0 to NCPU-1 generate
      u0 : leon3s                       -- LEON3 processor      
      generic map (i, fabtech, memtech, CFG_NWIN, CFG_DSU, CFG_FPU, CFG_V8, 
        0, CFG_MAC, pclow, 0, CFG_NWP, CFG_ICEN, CFG_IREPL, CFG_ISETS, CFG_ILINE, 
        CFG_ISETSZ, CFG_ILOCK, CFG_DCEN, CFG_DREPL, CFG_DSETS, CFG_DLINE, CFG_DSETSZ,
        CFG_DLOCK, CFG_DSNOOP, CFG_ILRAMEN, CFG_ILRAMSZ, CFG_ILRAMADDR, CFG_DLRAMEN,
        CFG_DLRAMSZ, CFG_DLRAMADDR, CFG_MMUEN, CFG_ITLBNUM, CFG_DTLBNUM, CFG_TLB_TYPE, CFG_TLB_REP, 
        CFG_LDDEL, disas, CFG_ITBSZ, CFG_PWD, CFG_SVT, CFG_RSTADDR, NCPU-1)
      port map (clk, rstn, ahbmi, ahbmo(i), ahbsi, ahbso, 
                irqi(i), irqo(i), dbgi(i), dbgo(i));
    end generate;
    bus_error(0) <= not dbgo(0).error;
  
-- hindex 2, slave 2, MEMBAR: x900, 256MByte
    dsugen : if CFG_DSU = 1 generate
      dsu0 : dsu3                       -- LEON3 Debug Support Unit
      generic map (hindex => 2, haddr => 16#900#, hmask => 16#F00#, 
         ncpu => NCPU, tbits => 30, tech => memtech, irq => 0, kbytes => CFG_ATBSZ)
      port map (rstn, clk, ahbmi, ahbsi, ahbso(2), dbgo, dbgi, dsui, dsuo);
      dsui.enable <= '1';
--      dsui.break <= gpioo.val(11); --  South Button
--      led(4) <= dsuo.active;
      dsui.break <= dsubreak;
      dsuactive  <= dsuo.active;
    end generate;
  end generate;

  nodsu : if CFG_DSU = 0 generate 
    dsuo.tstop <= '0'; dsuo.active <= '0';
  end generate;

-- hindex 0,1.  APB 7
  dcomgen : if CFG_AHB_UART = 1 generate
    dcom0: ahbuart              -- Debug UART
    generic map (hindex => NCPU, pindex => 7, paddr => 7)
    port map (rstn, clk, dui, duo, apbi, apbo(7), ahbmi, ahbmo(NCPU));
    dui.rxd <= rxd1;
  end generate;
  txd1 <= duo.txd;

-- hindex 0, 1
  ahbjtaggen0 :if CFG_AHB_JTAG = 1 generate
    ahbjtag0 : ahbjtag generic map(tech => fabtech, hindex => NCPU)
      port map(rstn, clk, tck, tms, tdi, tdo, ahbmi, ahbmo(NCPU),
               open, open, open, open, open, open, open, gnd);
  end generate;

-----------------------------------------------------------------------
---  AHB ROM ----------------------------------------------------------
-----------------------------------------------------------------------

-- hindex 6, slave 6, MEMBAR: 0x000, 512MByte
  bpromgen : if CFG_AHBROMEN /= 0 generate
    brom : entity work.ahbrom
      generic map (hindex => 6, haddr => CFG_AHBRODDR, pipe => CFG_AHBROPIP)
      port map ( rstn, clk, ahbsi, ahbso(6));
  end generate;
  nobpromgen : if CFG_AHBROMEN = 0 generate
     ahbso(6) <= ahbs_none;
  end generate;

----------------------------------------------------------------------
---  AHB CONTROLLER --------------------------------------------------
----------------------------------------------------------------------

  ahb0 : ahbctrl                -- AHB arbiter/multiplexer
  generic map (nahbm => nahbm, nahbs => nahbs, ioen => 0)
  port map (rstn, clk, ahbmi, ahbmo, ahbsi, ahbso);

----------------------------------------------------------------------
---  AHB/APB Bridge  -------------------------------------------------
----------------------------------------------------------------------

-- hindex 0, Address x800
  apb0 : apbctrl                        -- AHB/APB bridge
  generic map (hindex => 0, haddr => 16#800#)
  port map (rstn, clk, ahbsi, ahbso(0), apbi, apbo );

  irqctrl : if CFG_IRQ3_ENABLE /= 0 generate
    irqctrl0 : irqmp			-- interrupt controller
    generic map (pindex => 2, paddr => 2, ncpu => NCPU)
    port map (rstn, clk, apbi, apbo(2), irqo, irqi);
  end generate;
  irq3 : if CFG_IRQ3_ENABLE = 0 generate
    x : for i in 0 to NCPU-1 generate
      irqi(i).irl <= "0000";
    end generate;
    apbo(2) <= apb_none;
  end generate;

  
----------------------------------------------------------------------
---  GPIO on APB -----------------------------------------------------
----------------------------------------------------------------------
  
  gpio0 : if CFG_GRGPIO_ENABLE /= 0 generate     -- GPIO unit
    grgpio0: grgpio
    generic map(pindex => 3, paddr => 3, imask => 16#00F0#, nbits => 31)
    port map(rst => rstn, clk => clk, apbi => apbi, apbo => apbo(3),
    gpioi => gpioi, gpioo => gpioo);
    gpioi.din <= gpio_in;
    gpio_out  <= gpioo.dout;
    gpio_oen  <= gpioo.oen;
    
  -- type gpio_in_type is record
  --  din      : std_logic_vector(31 downto 0);
  --  sig_in   : std_logic_vector(31 downto 0);
  --  sig_en   : std_logic_vector(31 downto 0);
  --end record;

  --type gpio_out_type is record
  --  dout     : std_logic_vector(31 downto 0);
  --  oen      : std_logic_vector(31 downto 0);
  --  val      : std_logic_vector(31 downto 0);
  --  sig_out  : std_logic_vector(31 downto 0);
  --end record;
  end generate;
  nogpiogen: if CFG_GRGPIO_ENABLE = 0 generate
    gpio_out <= (others => '0');
    gpio_oen <= (others => '0');
  end generate;
  
----------------------------------------------------------------------
---  AHB Master Passthrough ------------------------------------------
----------------------------------------------------------------------

  ahbpassthru_mastergen1 : if ahbm_pt >= 1 generate
    
    thru1 : ahbpassthru_master_vhdl
      generic map (hindex_set   => m0_hindex,
                   hbaseaddr    => m0_haddr0,
                   hmask        => m0_hmask0,
                   htype        => m0_htype0,
                   PREFETCHABLE => m0_pf0,
                   CACHEABLE    => m0_ca0,
                   AHBDW        => AHBDW)
      port map (
        -- inputs
        hgrant                   => ahbmi.hgrant(m0_hindex),
        hready                   => ahbmi.hready,
        hresp                    => ahbmi.hresp,
        hrdata                   => ahbmi.hrdata,
        hcache                   => ahbmi.hcache,
        hirq                     => ahbmi.hirq(m0_hindex),
        -- outputs
        hbusreq                  => ahbmo(m0_hindex).hbusreq,
        hlock                    => ahbmo(m0_hindex).hlock,  
        htrans                   => ahbmo(m0_hindex).htrans, 
        haddr                    => ahbmo(m0_hindex).haddr,  
        hwrite                   => ahbmo(m0_hindex).hwrite, 
        hsize                    => ahbmo(m0_hindex).hsize,  
        hburst                   => ahbmo(m0_hindex).hburst, 
        hprot                    => ahbmo(m0_hindex).hprot,  
        hwdata                   => ahbmo(m0_hindex).hwdata, 
        hirq_o                   => ahbmo(m0_hindex).hirq(m0_hindex),
        hconfig                  => ahbmo(m0_hindex).hconfig,
        hindex                   => ahbmo(m0_hindex).hindex,
        -- inputs
        pt_hgrant                => m0_hgrant,
        pt_hready                => m0_hready,
        pt_hresp                 => m0_hresp,
        pt_hrdata                => m0_hrdata,
        pt_hcache                => m0_hcache,
        pt_hirq                  => m0_hirq,
        -- outputs
        pt_hbusreq               => m0_hbusreq,
        pt_hlock                 => m0_hlock,  
        pt_htrans                => m0_htrans, 
        pt_haddr                 => m0_haddr,  
        pt_hwrite                => m0_hwrite, 
        pt_hsize                 => m0_hsize,  
        pt_hburst                => m0_hburst, 
        pt_hprot                 => m0_hprot,  
        pt_hwdata                => m0_hwdata, 
        pt_hirq_o                => m0_hirq_o);   
  end generate;

  ahbpassthru_mastergen2: if ahbm_pt = 2 generate

    thru2 : ahbpassthru_master_vhdl
      generic map (hindex_set   => m1_hindex,
                   hbaseaddr    => m1_haddr0,
                   hmask        => m1_hmask0,
                   htype        => m1_htype0,
                   PREFETCHABLE => m1_pf0,
                   CACHEABLE    => m1_ca0,
                   AHBDW        => AHBDW)
      port map (
        -- inputs
        hgrant                   => ahbmi.hgrant(m1_hindex),
        hready                   => ahbmi.hready,
        hresp                    => ahbmi.hresp,
        hrdata                   => ahbmi.hrdata,
        hcache                   => ahbmi.hcache,
        hirq                     => ahbmi.hirq(m1_hindex),
        -- outputs
        hbusreq                  => ahbmo(m1_hindex).hbusreq,
        hlock                    => ahbmo(m1_hindex).hlock,  
        htrans                   => ahbmo(m1_hindex).htrans, 
        haddr                    => ahbmo(m1_hindex).haddr,  
        hwrite                   => ahbmo(m1_hindex).hwrite, 
        hsize                    => ahbmo(m1_hindex).hsize,  
        hburst                   => ahbmo(m1_hindex).hburst, 
        hprot                    => ahbmo(m1_hindex).hprot,  
        hwdata                   => ahbmo(m1_hindex).hwdata, 
        hirq_o                   => ahbmo(m1_hindex).hirq(m1_hindex),   
        hconfig                  => ahbmo(m1_hindex).hconfig,
        hindex                   => ahbmo(m1_hindex).hindex,
        -- pass through outputs
        pt_hgrant                => m1_hgrant,
        pt_hready                => m1_hready,
        pt_hresp                 => m1_hresp,
        pt_hrdata                => m1_hrdata,
        pt_hcache                => m1_hcache,
        pt_hirq                  => m1_hirq,
        -- pass through inputs
        pt_hbusreq               => m1_hbusreq,
        pt_hlock                 => m1_hlock,  
        pt_htrans                => m1_htrans, 
        pt_haddr                 => m1_haddr,  
        pt_hwrite                => m1_hwrite, 
        pt_hsize                 => m1_hsize,  
        pt_hburst                => m1_hburst, 
        pt_hprot                 => m1_hprot,  
        pt_hwdata                => m1_hwdata, 
        pt_hirq_o                => m1_hirq_o);   
  end generate;

    
----------------------------------------------------------------------
---  AHB Slave Passthrough -------------------------------------------
----------------------------------------------------------------------

  ahbpassthru_slavegen1 : if ahbs_pt >= 1 generate
    
    thru1 : ahbpassthru_slave_vhdl
      generic map (hindex_set   => s0_hindex,
                   hbaseaddr    => s0_haddr0,
                   hmask        => s0_hmask0,
                   htype        => s0_htype0,
                   PREFETCHABLE => s0_pf0,
                   CACHEABLE    => s0_ca0,
                   NAHBAMR      => NAHBAMR,
                   AHBDW        => AHBDW)
      port map (
        -- inputs
        hsel                    => ahbsi.hsel(s0_hindex),
        haddr                   => ahbsi.haddr,
        hwrite                  => ahbsi.hwrite,
        htrans                  => ahbsi.htrans,
        hsize                   => ahbsi.hsize,
        hburst                  => ahbsi.hburst,
        hwdata                  => ahbsi.hwdata,
        hprot                   => ahbsi.hprot,
        hready                  => ahbsi.hready,
        hmaster                 => ahbsi.hmaster,
        hmastlock               => ahbsi.hmastlock,
        hmbsel                  => ahbsi.hmbsel,
        hcache                  => ahbsi.hcache,
        hirq                    => ahbsi.hirq(s0_hindex),
        -- outputs
        hready_o                => ahbso(s0_hindex).hready,
        hresp                   => ahbso(s0_hindex).hresp,
        hrdata                  => ahbso(s0_hindex).hrdata,
        hsplit                  => ahbso(s0_hindex).hsplit,
        hcache_o                => ahbso(s0_hindex).hcache,
        hirq_o                  => ahbso(s0_hindex).hirq(s0_hindex),        
        hconfig                 => ahbso(s0_hindex).hconfig,
        hindex                  => ahbso(s0_hindex).hindex,
        -- pass through outputs
        pt_hsel                 => s0_hsel,
        pt_haddr                => s0_haddr,
        pt_hwrite               => s0_hwrite,
        pt_htrans               => s0_htrans,
        pt_hsize                => s0_hsize,
        pt_hburst               => s0_hburst,
        pt_hwdata               => s0_hwdata,
        pt_hprot                => s0_hprot,
        pt_hready               => s0_hready,
        pt_hmaster              => s0_hmaster,
        pt_hmastlock            => s0_hmastlock,
        pt_hmbsel               => s0_hmbsel,
        pt_hcache               => s0_hcache,
        pt_hirq                 => s0_hirq,
        -- pass through inputs
        pt_hready_o             => s0_hready_o,
        pt_hresp                => s0_hresp,
        pt_hrdata               => s0_hrdata,
        pt_hsplit               => s0_hsplit,
        pt_hcache_o             => s0_hcache_o,
        pt_hirq_o               => s0_hirq_o);

  end generate;

  ahbpassthru_slavegen2: if ahbs_pt >= 2 generate

    thru2 : ahbpassthru_slave_vhdl
      generic map (hindex_set   => s1_hindex,
                   hbaseaddr    => s1_haddr0,
                   hmask        => s1_hmask0,
                   htype        => s1_htype0,
                   PREFETCHABLE => s1_pf0,
                   CACHEABLE    => s1_ca0,
                   NAHBAMR      => NAHBAMR,
                   AHBDW        => AHBDW)
      port map (
        -- inputs
        hsel                    => ahbsi.hsel(s1_hindex),
        haddr                   => ahbsi.haddr,
        hwrite                  => ahbsi.hwrite,
        htrans                  => ahbsi.htrans,
        hsize                   => ahbsi.hsize,
        hburst                  => ahbsi.hburst,
        hwdata                  => ahbsi.hwdata,
        hprot                   => ahbsi.hprot,
        hready                  => ahbsi.hready,
        hmaster                 => ahbsi.hmaster,
        hmastlock               => ahbsi.hmastlock,
        hmbsel                  => ahbsi.hmbsel,
        hcache                  => ahbsi.hcache,
        hirq                    => ahbsi.hirq(s1_hindex),
        -- outputs
        hready_o                => ahbso(s1_hindex).hready,
        hresp                   => ahbso(s1_hindex).hresp,
        hrdata                  => ahbso(s1_hindex).hrdata,
        hsplit                  => ahbso(s1_hindex).hsplit,
        hcache_o                => ahbso(s1_hindex).hcache,
        hirq_o                  => ahbso(s1_hindex).hirq(s1_hindex),        
        hconfig                 => ahbso(s1_hindex).hconfig,
        hindex                  => ahbso(s1_hindex).hindex,
        -- pass through outputs
        pt_hsel                 => s1_hsel,
        pt_haddr                => s1_haddr,
        pt_hwrite               => s1_hwrite,
        pt_htrans               => s1_htrans,
        pt_hsize                => s1_hsize,
        pt_hburst               => s1_hburst,
        pt_hwdata               => s1_hwdata,
        pt_hprot                => s1_hprot,
        pt_hready               => s1_hready,
        pt_hmaster              => s1_hmaster,
        pt_hmastlock            => s1_hmastlock,
        pt_hmbsel               => s1_hmbsel,
        pt_hcache               => s1_hcache,
        pt_hirq                 => s1_hirq,
        -- pass through inputs
        pt_hready_o             => s1_hready_o,
        pt_hresp                => s1_hresp,
        pt_hrdata               => s1_hrdata,
        pt_hsplit               => s1_hsplit,
        pt_hcache_o             => s1_hcache_o,
        pt_hirq_o               => s1_hirq_o);
  end generate;


  ahbpassthru_slavegen3: if ahbs_pt >= 3 generate

    thru3 : ahbpassthru_slave_vhdl
      generic map (hindex_set   => s2_hindex,
                   hbaseaddr    => s2_haddr0,
                   hmask        => s2_hmask0,
                   htype        => s2_htype0,
                   PREFETCHABLE => s2_pf0,
                   CACHEABLE    => s2_ca0,
                   NAHBAMR      => NAHBAMR,
                   AHBDW        => AHBDW)
      port map (
        -- inputs
        hsel                    => ahbsi.hsel(s2_hindex),
        haddr                   => ahbsi.haddr,
        hwrite                  => ahbsi.hwrite,
        htrans                  => ahbsi.htrans,
        hsize                   => ahbsi.hsize,
        hburst                  => ahbsi.hburst,
        hwdata                  => ahbsi.hwdata,
        hprot                   => ahbsi.hprot,
        hready                  => ahbsi.hready,
        hmaster                 => ahbsi.hmaster,
        hmastlock               => ahbsi.hmastlock,
        hmbsel                  => ahbsi.hmbsel,
        hcache                  => ahbsi.hcache,
        hirq                    => ahbsi.hirq(s2_hindex),
        -- outputs
        hready_o                => ahbso(s2_hindex).hready,
        hresp                   => ahbso(s2_hindex).hresp,
        hrdata                  => ahbso(s2_hindex).hrdata,
        hsplit                  => ahbso(s2_hindex).hsplit,
        hcache_o                => ahbso(s2_hindex).hcache,
        hirq_o                  => ahbso(s2_hindex).hirq(s2_hindex),        
        hconfig                 => ahbso(s2_hindex).hconfig,
        hindex                  => ahbso(s2_hindex).hindex,
        -- pass through outputs
        pt_hsel                 => s2_hsel,
        pt_haddr                => s2_haddr,
        pt_hwrite               => s2_hwrite,
        pt_htrans               => s2_htrans,
        pt_hsize                => s2_hsize,
        pt_hburst               => s2_hburst,
        pt_hwdata               => s2_hwdata,
        pt_hprot                => s2_hprot,
        pt_hready               => s2_hready,
        pt_hmaster              => s2_hmaster,
        pt_hmastlock            => s2_hmastlock,
        pt_hmbsel               => s2_hmbsel,
        pt_hcache               => s2_hcache,
        pt_hirq                 => s2_hirq,
        -- pass through inputs
        pt_hready_o             => s2_hready_o,
        pt_hresp                => s2_hresp,
        pt_hrdata               => s2_hrdata,
        pt_hsplit               => s2_hsplit,
        pt_hcache_o             => s2_hcache_o,
        pt_hirq_o               => s2_hirq_o);
  end generate;

  ahbpassthru_slavegen4: if ahbs_pt = 4 generate

    thru4 : ahbpassthru_slave_vhdl
      generic map (hindex_set   => s3_hindex,
                   hbaseaddr    => s3_haddr0,
                   hmask        => s3_hmask0,
                   htype        => s3_htype0,
                   PREFETCHABLE => s3_pf0,
                   CACHEABLE    => s3_ca0,
                   NAHBAMR      => NAHBAMR,
                   AHBDW        => AHBDW)
      port map (
        -- inputs
        hsel                    => ahbsi.hsel(s3_hindex),
        haddr                   => ahbsi.haddr,
        hwrite                  => ahbsi.hwrite,
        htrans                  => ahbsi.htrans,
        hsize                   => ahbsi.hsize,
        hburst                  => ahbsi.hburst,
        hwdata                  => ahbsi.hwdata,
        hprot                   => ahbsi.hprot,
        hready                  => ahbsi.hready,
        hmaster                 => ahbsi.hmaster,
        hmastlock               => ahbsi.hmastlock,
        hmbsel                  => ahbsi.hmbsel,
        hcache                  => ahbsi.hcache,
        hirq                    => ahbsi.hirq(s3_hindex),
        -- outputs
        hready_o                => ahbso(s3_hindex).hready,
        hresp                   => ahbso(s3_hindex).hresp,
        hrdata                  => ahbso(s3_hindex).hrdata,
        hsplit                  => ahbso(s3_hindex).hsplit,
        hcache_o                => ahbso(s3_hindex).hcache,
        hirq_o                  => ahbso(s3_hindex).hirq(s3_hindex),        
        hconfig                 => ahbso(s3_hindex).hconfig,
        hindex                  => ahbso(s3_hindex).hindex,
        -- pass through outputs
        pt_hsel                 => s3_hsel,
        pt_haddr                => s3_haddr,
        pt_hwrite               => s3_hwrite,
        pt_htrans               => s3_htrans,
        pt_hsize                => s3_hsize,
        pt_hburst               => s3_hburst,
        pt_hwdata               => s3_hwdata,
        pt_hprot                => s3_hprot,
        pt_hready               => s3_hready,
        pt_hmaster              => s3_hmaster,
        pt_hmastlock            => s3_hmastlock,
        pt_hmbsel               => s3_hmbsel,
        pt_hcache               => s3_hcache,
        pt_hirq                 => s3_hirq,
        -- pass through inputs
        pt_hready_o             => s3_hready_o,
        pt_hresp                => s3_hresp,
        pt_hrdata               => s3_hrdata,
        pt_hsplit               => s3_hsplit,
        pt_hcache_o             => s3_hcache_o,
        pt_hirq_o               => s3_hirq_o);
  end generate;

end;
