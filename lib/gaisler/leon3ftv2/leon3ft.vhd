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
-- Entity: 	leon3ft
-- File:	leon3ft.vhd
-- Author:	Jiri Gaisler, Edvin Catovic, Gaisler Research
-- Description:	Top-level LEON3FT component
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
library techmap;
use techmap.gencomp.all;
use techmap.netcomp.all;
library gaisler;
use gaisler.leon3.all;

entity leon3ft is
  generic (
    hindex    : integer               := 0;
    fabtech   : integer range 0 to NTECH  := DEFFABTECH;
    memtech   : integer range 0 to NTECH  := DEFMEMTECH;
    nwindows  : integer range 2 to 32 := 8;
    dsu       : integer range 0 to 1  := 1;
    fpu       : integer range 0 to 31 := 0;
    v8        : integer range 0 to 63 := 0;
    cp        : integer range 0 to 1  := 0;
    mac       : integer range 0 to 1  := 0;
    pclow     : integer range 0 to 2  := 2;
    notag     : integer range 0 to 1  := 0;
    nwp       : integer range 0 to 4  := 2;
    icen      : integer range 0 to 1  := 1;
    irepl     : integer range 0 to 2  := 2;
    isets     : integer range 1 to 4  := 1;
    ilinesize : integer range 4 to 8  := 8;
    isetsize  : integer range 1 to 256 := 8;
    isetlock  : integer range 0 to 1  := 0;
    dcen      : integer range 0 to 1  := 0;
    drepl     : integer range 0 to 2  := 2;
    dsets     : integer range 1 to 4  := 1;
    dlinesize : integer range 4 to 8  := 4;
    dsetsize  : integer range 1 to 256 := 4;
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
    lddel     : integer range 1 to 2  := 1;
    disas     : integer range 0 to 2  := 0;
    tbuf      : integer range 0 to 64 := 2;
    pwd       : integer range 0 to 2  := 2;     -- power-down
    svt       : integer range 0 to 1  := 1;     -- single vector trapping
    rstaddr   : integer               := 0;
    smp       : integer range 0 to 15 := 0;    -- support SMP systems
    iuft      : integer range 0 to 4  := 2;
    fpft      : integer range 0 to 4  := 0;
    cmft      : integer range 0 to 1  := 0;
    iuinj     : integer               := 0;
    ceinj     : integer range 0 to 3  := 0;
    cached    : integer               := 0;
    netlist   : integer               := 1;
    scantest  : integer               := 0;
    mmupgsz   : integer range 0 to 5  := 0;
    bp        : integer               := 1
  );
  port (
    clk    : in  std_ulogic;	-- free-running clock
    rstn   : in  std_ulogic;
    ahbi   : in  ahb_mst_in_type;
    ahbo   : out ahb_mst_out_type;
    ahbsi  : in  ahb_slv_in_type;
    ahbso  : in  ahb_slv_out_vector;    
    irqi   : in  l3_irq_in_type;
    irqo   : out l3_irq_out_type;
    dbgi   : in  l3_debug_in_type;
    dbgo   : out l3_debug_out_type;
    gclk   : in  std_ulogic	-- gated clock
  );
end; 

architecture rtl of leon3ft is

constant fpuarch   : integer := fpu mod 16;
constant fpunet    : integer := fpu / 16;

--attribute sync_set_reset : string;
--attribute sync_set_reset of rst : signal is "true";

begin

  l3s : if (netlist = 0) generate
      u0 : leon3s			-- LEON3 processor      
      generic map (hindex, fabtech, memtech, nwindows, dsu, fpu, v8, 
    	cp, mac, pclow, notag, nwp, icen, irepl, isets, 
    	ilinesize, isetsize, isetlock, dcen, drepl, dsets, dlinesize, 
    	dsetsize, dsetlock, dsnoop, ilram, ilramsize, ilramstart, dlram, 
    	dlramsize, dlramstart, mmuen, itlbnum, dtlbnum, tlb_type, tlb_rep, 
    	lddel, disas, tbuf, pwd, svt, rstaddr, smp, cached, scantest, mmupgsz)
      port map (clk, rstn, ahbi, ahbo, ahbsi, ahbso, irqi, irqo, dbgi, dbgo);
  end generate;

ntl : if netlist /= 0 generate

  l3fnet : leon3ft_net 
  generic map (hindex, fabtech, memtech, nwindows, dsu, fpuarch, v8, cp, mac,      
    pclow, notag, nwp, icen, irepl, isets, ilinesize, isetsize, isetlock, 
    dcen, drepl, dsets, dlinesize, dsetsize, dsetlock, dsnoop, ilram, 
    ilramsize, ilramstart, dlram, dlramsize, dlramstart, mmuen, itlbnum, dtlbnum,
    tlb_type, tlb_rep, lddel, disas, tbuf, pwd, svt, rstaddr, smp, iuft, fpft, 
    cmft, cached, scantest, mmupgsz)
  port map (clk => clk, gclk => gclk, rstn => rstn, ahbix => ahbi, ahbox =>ahbo, 
		ahbsix => ahbsi, ahbso => ahbso, 
         irqi_irl          => irqi.irl,
         irqi_rst          => irqi.rst,
         irqi_run          => irqi.run,
         irqo_intack       => irqo.intack,
         irqo_irl          => irqo.irl,
         irqo_pwd          => irqo.pwd,
         dbgi_dsuen        => dbgi.dsuen,
         dbgi_denable      => dbgi.denable,
         dbgi_dbreak       => dbgi.dbreak,
         dbgi_step         => dbgi.step,
         dbgi_halt         => dbgi.halt,
         dbgi_reset        => dbgi.reset,
         dbgi_dwrite       => dbgi.dwrite,
         dbgi_daddr        => dbgi.daddr,
         dbgi_ddata        => dbgi.ddata,
         dbgi_btrapa       => dbgi.btrapa,
         dbgi_btrape       => dbgi.btrape,
         dbgi_berror       => dbgi.berror,
         dbgi_bwatch       => dbgi.bwatch,
         dbgi_bsoft        => dbgi.bsoft,
         dbgi_tenable      => dbgi.tenable,
         dbgi_timer        => dbgi.timer,
         dbgo_data         => dbgo.data,
         dbgo_crdy         => dbgo.crdy,
         dbgo_dsu          => dbgo.dsu,
         dbgo_dsumode      => dbgo.dsumode,
         dbgo_error        => dbgo.error,
         dbgo_halt         => dbgo.halt,
         dbgo_pwd          => dbgo.pwd,
         dbgo_idle         => dbgo.idle,
         dbgo_ipend        => dbgo.ipend,
         dbgo_icnt         => dbgo.icnt
    );


end generate;

-- pragma translate_off
  msg: if netlist = 0 generate
    bootmsg : report_version 
    generic map (
      "leon3ft_" & tost(hindex) & ": LEON3FT SPARC V8 processor rev " & tost(LEON3_VERSION) 
	 & ": iuft: " & tost(iuft) & ", fpft: " & tost(fpft),
      "leon3ft_" & tost(hindex) & ": icache " & tost(isets*icen) & "*" & tost(isetsize*icen) &
	" kbyte, dcache "  & tost(dsets*dcen) & "*" & tost(dsetsize*dcen) & " kbyte"
    );
  end generate;
-- pragma translate_on

end;
