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
-----------------------------------------------------------------------------
-- package: 	jtag
-- File:	jtag.vhd
-- Author:	Edvin Catovic - Gaisler Research
-- Description:	JTAG components
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
library techmap;
use techmap.gencomp.all;

package jtag is

-- JTAG manufacturer IDs
constant JTAG_MANF_ID_GR   : integer range 0 to 2047 := 804;

-- JTAG part numbers
-- Do NOT select an existing part number for your custom design!
constant JTAG_NEXTREME     : integer range 0 to 65535 := 16#102#;
constant JTAG_IHP25RH1     : integer range 0 to 65535 := 16#251#;
constant JTAG_NGMP_PROTO   : integer range 0 to 65535 := 16#281#;
constant JTAG_NGMP_PROTO2  : integer range 0 to 65535 := 16#282#;
constant JTAG_EXAMPLE_PART : integer range 0 to 65535 := 16#300#;
constant JTAG_ORBITA1      : integer range 0 to 65535 := 16#631#;
constant JTAG_ORBITA_OBTMP : integer range 0 to 65535 := 16#632#;
constant JTAG_UT699RH      : integer range 0 to 65535 := 16#699#;
constant JTAG_UT700RH      : integer range 0 to 65535 := 16#700#;
constant JTAG_GR702        : integer range 0 to 65535 := 16#702#;
constant JTAG_GR712        : integer range 0 to 65535 := 16#712#;
constant JTAG_SPWRTRASIC   : integer range 0 to 65535 := 16#718#;
constant JTAG_UT840        : integer range 0 to 65535 := 16#840#;

component ahbjtag 
  generic (
    tech    : integer range 0 to NTECH := 0;
    hindex  : integer := 0;
    nsync : integer range 1 to 2 := 1;
    idcode : integer range 0 to 255 := 9;
    manf   : integer range 0 to 2047 := 804;
    part   : integer range 0 to 65535 := 0;
    ver    : integer range 0 to 15 := 0;
    ainst   : integer range 0 to 255 := 2;
    dinst   : integer range 0 to 255 := 3;
    scantest : integer := 0;
    oepol  : integer := 1;
    tcknen : integer := 0);
  port (
    rst     : in  std_ulogic;
    clk     : in  std_ulogic;
    tck     : in  std_ulogic;
    tms     : in  std_ulogic;
    tdi     : in  std_ulogic;
    tdo     : out std_ulogic;
    ahbi    : in  ahb_mst_in_type;
    ahbo    : out ahb_mst_out_type;
    tapo_tck    : out std_ulogic;
    tapo_tdi    : out std_ulogic;
    tapo_inst   : out std_logic_vector(7 downto 0);
    tapo_rst    : out std_ulogic;
    tapo_capt   : out std_ulogic;
    tapo_shft   : out std_ulogic;
    tapo_upd    : out std_ulogic;
    tapi_tdo    : in std_ulogic;
    trst        : in std_ulogic := '1';
    tdoen   : out std_ulogic;
    tckn    : in std_ulogic := '0';
    tapo_tckn   : out std_ulogic;
    tapo_ninst  : out std_logic_vector(7 downto 0);
    tapo_iupd   : out std_ulogic
    );
end component;      


component ahbjtag_bsd 
  generic (
    tech    : integer range 0 to NTECH := 0;
    hindex  : integer := 0;
    nsync : integer range 1 to 2 := 1;
    ainst   : integer range 0 to 255 := 2;
    dinst   : integer range 0 to 255 := 3);
  port (
    rst         : in  std_ulogic;
    clk         : in  std_ulogic;
    ahbi        : in  ahb_mst_in_type;
    ahbo        : out ahb_mst_out_type;
    asel        : in  std_ulogic;
    dsel        : in  std_ulogic;
    tck         : in  std_ulogic;
    regi        : in  std_ulogic;
    shift       : in  std_ulogic;
    rego        : out std_ulogic
    );
end component;

component bscanctrl
  generic (
    spinst: integer := 5;               -- sample/preload
    etinst: integer := 6;               -- extest
    itinst: integer := 7;                --intest
    hzinst: integer := 8;               -- highz
    clinst: integer := 10;              -- clamp
    mbist : integer := 11;              -- clamp
    scantest : integer := 0
    );
  port (
    trst        : in std_ulogic;
    tapo_tck    : in std_ulogic;
    tapo_tckn   : in std_ulogic;
    tapo_tdi    : in std_ulogic;
    tapo_ninst  : in std_logic_vector(7 downto 0);
    tapo_iupd   : in std_ulogic;
    tapo_rst    : in std_ulogic;
    tapo_capt   : in std_ulogic;
    tapo_shft   : in std_ulogic;
    tapo_upd    : in std_ulogic;
    tapi_tdo    : out std_ulogic;
    chain_tdi   : out std_ulogic;
    chain_tdo   : in std_ulogic;    
    bsshft      : out std_ulogic;
    bscapt      : out std_ulogic;
    bsupdi      : out std_ulogic;
    bsupdo      : out std_ulogic;
    bsdrive     : out std_ulogic;
    bshighz     : out std_ulogic;
    bsmbist     : out std_ulogic;
    testen      : in std_ulogic;
    testrst     : in std_ulogic
    );
end component;

component bscanregs
  generic (
    tech: integer := 0;
    nsigs: integer range 1 to 30 := 8;
    dirmask: integer := 2#00000000#;
    enable: integer range 0 to 1 := 1
    );
  port (
    sigi: in  std_logic_vector(nsigs-1 downto 0);
    sigo: out std_logic_vector(nsigs-1 downto 0);
    tck: in std_ulogic;
    tckn:in std_ulogic;
    tdi: in std_ulogic;
    tdo: out std_ulogic;
    bsshft: in std_ulogic;
    bscapt: in std_ulogic;
    bsupdi: in std_ulogic;
    bsupdo: in std_ulogic;
    bsdrive: in std_ulogic;
    bshighz: in std_ulogic
    );
end component;

component bscanregsbd
  generic (
    tech: integer:= 0;
    nsigs: integer := 8;
    enable: integer range 0 to 1 := 1;
    hzsup: integer range 0 to 1 := 1
    );
  port (
    pado    : out std_logic_vector(nsigs-1 downto 0);
    padoen  : out std_logic_vector(nsigs-1 downto 0);
    padi    : in std_logic_vector(nsigs-1 downto 0);
    coreo   : in std_logic_vector(nsigs-1 downto 0);
    coreoen : in std_logic_vector(nsigs-1 downto 0);
    corei   : out std_logic_vector(nsigs-1 downto 0);
    
    tck     : in std_ulogic;
    tckn    : in std_ulogic;
    tdi     : in std_ulogic;
    tdo     : out std_ulogic;
    bsshft  : in std_ulogic;
    bscapt  : in std_ulogic;    -- capture signals to scan regs on next tck edge
    bsupdi  : in std_ulogic;    -- update indata reg from scan reg on next tck edge
    bsupdo  : in std_ulogic;    -- update outdata reg from scan reg on next tck edge
    bsdrive : in std_ulogic;    -- drive outdata regs to pad,
                                -- drive datareg(coreoen=0) or coreo(coreoen=1) to corei
    bshighz : in std_ulogic     -- tri-state output if hzsup, sample 1 on input
    );
end component;

end;
