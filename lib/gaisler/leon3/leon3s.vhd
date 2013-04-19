------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2012, Aeroflex Gaisler
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
-----------------------------------------------------------------------------
-- Entity: 	leon3s
-- File:	leon3s.vhd
-- Author:	Jiri Gaisler, Edvin Catovic, Gaisler Research
-- Description:	Top-level LEON3 component
------------------------------------------------------------------------------
-- GRLIB2 CORE
-- VENDOR:      VENDOR_GAISLER
-- DEVICE:      GAISLER_LEON3
-- VERSION:     0
-- AHBMASTER:   0
-------------------------------------------------------------------------------
--                                 GENERICS                                  --
-------------------------------------------------------------------------------
-- hindex: AHB master index
--
-- fabtech: Target technology
--
-- memtech: Vendor library for regfile and cache RAMs
--
-- nwindows: Number of SPARC register windows. Choose 8 windows to be
-- compatible with Bare-C and RTEMS cross-compilers.
--
-- dsu: Enable Debug Support Unit (DSU) interface
--
-- fpu: Floating-point Unit 0 : no FPU 1 - 7: GRFPU 1 - inferred
-- multiplier, 2 - DW multiplier, 3 - Module Generator multiplier 8
-- - 14: GRFPU-Lite 8 - simple FPC, 9 - data forwarding FPC, 10 -
-- non-blocking FPC 15: Meiko 16 - 31: as above (modulo 16) but use
-- netlist
--
-- v8: Generate SPARC V8 MUL and DIV instructions 0 : No multiplier or
-- divider 1 : 16x16 multiplier 2: 16x16 pipelined multiplier 16#32# :
-- 32x32 pipelined multiplier
-- 
-- cp: Generate co-processor interface
--
-- mac: Generate SPARC V8e SMAC/UMAC instruction
--
-- pclow: Least significant bit of PC (Program Counter) that is
-- actually generated. PC[1:0] are always zero and are normally not
-- generated. Generating PC[1:0] makes VHDL-debugging easier.
--
-- notag: Currently not used
--
-- nwp: Currently not used
--
-- icen: Enable instruction cache
--
-- irepl: Instruction cache replacement policy. 0 - least recently
-- used (LRU), 1 - least recently replaced (LRR), 2 - random
--
-- isets: Number of instruction cache sets
--
-- ilinesize: Instruction cache line size in number of words
--
-- isetsize: Number of instruction cache sets
--
-- isetlock: Enable instruction cache line locking
--
-- dcen: Data cache enable
--
-- drepl: Data cache replacement policy. 0 - least recently used
-- (LRU), 1 - least recently replaced (LRR), 2 - random
--
-- dsets: Number of data cache sets
--
-- dlinesize: Data cache line size in number of words
--
-- dsetsize: Size of each data cache set in kByte
--
-- dsetlock: Enable data cache line locking
--
-- dsnoop: Enable data cache snooping Bit 0-1: 0: disable, 1: slow, 2:
-- fast (see text) Bit 2: 0: simple snooping, 1: save extra physical
-- tags (MMU snooping)
--
-- ilram: Enable local instruction RAM
--
-- ilramsize: Local instruction RAM size in kB
--
-- ilramstart: 8 MSB bits used to decode local instruction RAM area
--
-- dlram: Enable local data RAM (scratch-pad RAM)
--
-- dlramsize: Local data RAM size in kB
--
-- dlramstart: 8 MSB bits used to decode local data RAM area
--
-- mmuen: Enable memory management unit (MMU)
--
-- itlbnum: Number of instruction TLB entries
--
-- dtlbnum: Number of data TLB entries
--
-- tlb_type: 0 : separate TLB with slow write 1: shared TLB with slow
-- write 2: separate TLB with fast write
--
-- tlb_rep: LRU (0) or Random (1) TLB replacement
--
-- lddel: Load delay. One cycle gives best performance, but might
-- create a critical path on targets with slow (data) cache memories.
-- A 2-cycle delay can improve timing but will reduce performance with
-- about 5%.
--
-- disas: Print instruction disassembly in VHDL simulator console.
--
-- tbuf: Size of instruction trace buffer in kB (0 - instruction trace
-- disabled)
--
-- pwd: Power-down. 0 - disabled, 1 - area efficient, 2 - timing efficient.
--
-- svt: Enable single-vector trapping
--
-- rstaddr: Default reset start address
--
-- smp: Enable multi-processor support
--
-- cached: Fixed cacheability mask
--
-- scantest: Enable scan test support
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
library gaisler;
library techmap;
use techmap.gencomp.all;
use gaisler.leon3.all;
use gaisler.libiu.all;
use gaisler.libcache.all;
use gaisler.libproc3.all;
use gaisler.arith.all;
--library fpu;
--use fpu.libfpu.all;

entity leon3s is
  generic (
    hindex    : integer               := 0;
    fabtech   : integer range 0 to NTECH  := DEFFABTECH;
    memtech   : integer range 0 to NTECH  := DEFMEMTECH;
    nwindows  : integer range 2 to 32 := 8;
    dsu       : integer range 0 to 1  := 0;
    fpu       : integer range 0 to 31 := 0;
    v8        : integer range 0 to 63 := 0;
    cp        : integer range 0 to 1  := 0;
    mac       : integer range 0 to 1  := 0;
    pclow     : integer range 0 to 2  := 2;
    notag     : integer range 0 to 1  := 0;
    nwp       : integer range 0 to 4  := 0;
    icen      : integer range 0 to 1  := 0;
    irepl     : integer range 0 to 3  := 2;
    isets     : integer range 1 to 4  := 1;
    ilinesize : integer range 4 to 8  := 4;
    isetsize  : integer range 1 to 256 := 1;
    isetlock  : integer range 0 to 1  := 0;
    dcen      : integer range 0 to 1  := 0;
    drepl     : integer range 0 to 3  := 2;
    dsets     : integer range 1 to 4  := 1;
    dlinesize : integer range 4 to 8  := 4;
    dsetsize  : integer range 1 to 256 := 1;
    dsetlock  : integer range 0 to 1  := 0;
    dsnoop    : integer range 0 to 6  := 0;
    ilram      : integer range 0 to 1 := 0;
    ilramsize  : integer range 1 to 512 := 1;
    ilramstart : integer range 0 to 255 := 16#8e#;
    dlram      : integer range 0 to 1 := 0;
    dlramsize  : integer range 1 to 512 := 1;
    dlramstart : integer range 0 to 255 := 16#8f#;
    mmuen     : integer range 0 to 1  := 0;
    itlbnum   : integer range 2 to 64 := 8;
    dtlbnum   : integer range 2 to 64 := 8;
    tlb_type  : integer range 0 to 3  := 1;
    tlb_rep   : integer range 0 to 1  := 0;
    lddel     : integer range 1 to 2  := 2;
    disas     : integer range 0 to 2  := 0;
    tbuf      : integer range 0 to 64 := 0;
    pwd       : integer range 0 to 2  := 2;     -- power-down
    svt       : integer range 0 to 1  := 1;     -- single vector trapping
    rstaddr   : integer               := 0;
    smp       : integer range 0 to 15 := 0;     -- support SMP systems
    cached    : integer               := 0;	-- cacheability table
    scantest  : integer               := 0;
    mmupgsz   : integer range 0 to 5  := 0;
    bp        : integer               := 1
  );
  port (
    clk    : in  std_ulogic;
    rstn   : in  std_ulogic;
    ahbi   : in  ahb_mst_in_type;
    ahbo   : out ahb_mst_out_type;
    ahbsi  : in  ahb_slv_in_type;
    ahbso  : in  ahb_slv_out_vector;
    irqi   : in  l3_irq_in_type;
    irqo   : out l3_irq_out_type;
    dbgi   : in  l3_debug_in_type;
    dbgo   : out l3_debug_out_type
  );
end; 

architecture rtl of leon3s is

constant IRFBITS  : integer range 6 to 10 := log2(NWINDOWS+1) + 4;
constant IREGNUM  : integer := NWINDOWS * 16 + 8;

signal holdn : std_logic;
signal rfi   : iregfile_in_type;
signal rfo   : iregfile_out_type;
signal crami : cram_in_type;
signal cramo : cram_out_type;
signal tbi   : tracebuf_in_type;
signal tbo   : tracebuf_out_type;
signal rst   : std_ulogic;
signal fpi   : fpc_in_type;
signal fpo   : fpc_out_type;
signal cpi   : fpc_in_type;
signal cpo   : fpc_out_type;
signal cpodb : fpc_debug_out_type;

signal rd1, rd2, wd : std_logic_vector(35 downto 0);
signal gnd, vcc : std_logic;

constant IRFWT     : integer := 1;--regfile_3p_write_through(memtech);
constant FPURFHARD : integer := 1; --1-is_fpga(memtech);
constant fpuarch   : integer := fpu mod 16;
constant fpunet    : integer := fpu / 16;

attribute sync_set_reset : string;
attribute sync_set_reset of rst : signal is "true";

begin

   gnd <= '0'; vcc <= '1';

-- leon3 processor core (iu, caches & mul/div)

  p0 : proc3 
  generic map (hindex, fabtech, memtech, nwindows, dsu, fpuarch, v8, cp, mac,      
    pclow, notag, nwp, icen, irepl, isets, ilinesize, isetsize, isetlock, 
    dcen, drepl, dsets, dlinesize, dsetsize, dsetlock, dsnoop, ilram, 
    ilramsize, ilramstart, dlram, dlramsize, dlramstart, mmuen, itlbnum, dtlbnum,
    tlb_type, tlb_rep, lddel, disas, tbuf, pwd, svt, rstaddr, smp, cached, 0, 
    scantest, mmupgsz, bp)
  port map (clk, rst, holdn, ahbi, ahbo, ahbsi, ahbso, rfi, rfo, crami, cramo, 
    tbi, tbo, fpi, fpo, cpi, cpo, irqi, irqo, dbgi, dbgo, gnd, clk, vcc);
  
-- IU register file
  
    rf0 : regfile_3p generic map (memtech, IRFBITS, 32, IRFWT, IREGNUM)
        port map (clk, rfi.waddr(IRFBITS-1 downto 0), rfi.wdata, rfi.wren, 
		  clk, rfi.raddr1(IRFBITS-1 downto 0), rfi.ren1, rfo.data1, 
		  rfi.raddr2(IRFBITS-1 downto 0), rfi.ren2, rfo.data2, rfi.diag);

-- cache memory

    cmem0 : cachemem 
    generic map (memtech, icen, irepl, isets, ilinesize, isetsize, isetlock, dcen,
                 drepl, dsets,  dlinesize, dsetsize, dsetlock, dsnoop, ilram,
                 ilramsize, dlram, dlramsize, mmuen) 
    port map (clk, crami, cramo, clk);

-- instruction trace buffer memory

  tbmem_gen : if (tbuf /= 0) generate
    tbmem0 : tbufmem
      generic map (tech => memtech, tbuf => tbuf)
      port map (clk, tbi, tbo);
  end generate;
    
-- FPU

  fpu0 : if (fpu = 0) generate fpo <= fpc_out_none; end generate;

  grfpw0gen : if (fpuarch > 0) and (fpuarch < 8) generate
    fpu0: grfpwx
      generic map (fabtech, FPURFHARD*memtech, (fpuarch-1), pclow, dsu, disas, fpunet, hindex)
      port map (rst, clk, holdn, fpi, fpo);
  end generate;

  mfpw0gen : if (fpuarch = 15) generate
    fpu0 : mfpwx
      generic map (FPURFHARD*memtech, pclow, dsu, disas)
      port map (rst, clk, holdn, fpi, fpo);
  end generate;

   grlfpc0gen : if (fpuarch >= 8) and (fpuarch < 15) generate
     fpu0 : grlfpwx
       generic map (FPURFHARD*memtech, pclow, dsu, disas, (fpuarch-8), fpunet, hindex)
       port map (rst, clk, holdn, fpi, fpo);
   end generate;

-- Default Co-Proc drivers

  cpodb.data <= zero32;
  cpo <= (zero32, '0', "00", '0', '0', '0', cpodb);
 
-- 1-clock reset delay

  rstreg : process(clk)
  begin if rising_edge(clk) then rst <= rstn; end if; end process;
  
-- pragma translate_off
  bootmsg : report_version 
  generic map (
    "leon3_" & tost(hindex) & ": LEON3 SPARC V8 processor rev " & tost(LEON3_VERSION),
    "leon3_" & tost(hindex) & ": icache " & tost(isets*icen) & "*" & tost(isetsize*icen) &
	" kbyte, dcache "  & tost(dsets*dcen) & "*" & tost(dsetsize*dcen) & " kbyte"
  );
-- pragma translate_on


end;
