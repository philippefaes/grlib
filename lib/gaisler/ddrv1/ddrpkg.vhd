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
-- Package:     ddrpkg
-- File:        ddrpkg.vhd
-- Author:      Magnus Hjorth - Aeroflex Gaisler
-- Description:	Components and types for DDR SDRAM controllers
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library techmap;
use techmap.gencomp.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;
library gaisler;
use gaisler.memctrl.sdctrl_in_type;
use gaisler.memctrl.sdctrl_out_type;

package ddrpkg is

  -----------------------------------------------------------------------------
  -- DDR2SPA types and components
  -----------------------------------------------------------------------------

  component ddr2sp16a
    generic (
      memtech : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      TRFC    : integer := 130;
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      readdly : integer := 1;
      odten      : integer := 0;
      octen      : integer := 0;
      dqsgating  : integer := 0;
      nosync     : integer := 0;
      eightbanks : integer  range 0 to 1 := 0;
      dqsse      : integer range 0 to 1 := 0
      );
    port (
      rst     : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component;

  component ddr2sp32a
    generic (
      memtech : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      TRFC    : integer := 130;
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      readdly : integer := 1;
      odten      : integer := 0;
      octen      : integer := 0;
      dqsgating  : integer := 0;
      nosync     : integer := 0;
      eightbanks : integer  range 0 to 1 := 0;
      dqsse      : integer range 0 to 1 := 0
      );
    port (
      rst     : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component;

  component ddr2sp64a
    generic (
      memtech : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      TRFC    : integer := 130;
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      readdly : integer := 1;
      odten      : integer := 0;
      octen      : integer := 0;
      dqsgating  : integer := 0;
      nosync     : integer := 0;
      eightbanks : integer  range 0 to 1 := 0;
      dqsse      : integer range 0 to 1 := 0
      );
    port (
      rst     : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component;
  
  component ddr2spa
    generic (
      fabtech : integer := 0;
      memtech : integer := 0;
      rskew   : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      TRFC    : integer := 130;
      clkmul  : integer := 2; 
      clkdiv  : integer := 2; 
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      rstdel  : integer := 200; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      ddrbits : integer := 16;
      ahbfreq : integer := 50;
      readdly : integer := 1;
      ddelayb0 : integer := 0;
      ddelayb1 : integer := 0;
      ddelayb2 : integer := 0;
      ddelayb3 : integer := 0;
      ddelayb4 : integer := 0;
      ddelayb5 : integer := 0;
      ddelayb6 : integer := 0;
      ddelayb7 : integer := 0;
      numidelctrl : integer := 4; 
      norefclk : integer := 0;
      odten    : integer := 0;
      octen    : integer := 0;
      dqsgating : integer := 0;
      nosync    : integer := 0;
      eightbanks : integer := 0;
      dqsse      : integer range 0 to 1 := 0
      );
    port (
      rst_ddr    : in  std_ulogic;
      rst_ahb    : in  std_ulogic;
      clk_ddr    : in  std_ulogic;
      clk_ahb    : in  std_ulogic;
      clkref200  : in  std_ulogic;
      lock       : out std_ulogic;			-- DCM locked
      clkddro    : out std_ulogic;			-- DCM locked
      clkddri    : in  std_ulogic;
      ahbsi      : in  ahb_slv_in_type;
      ahbso      : out ahb_slv_out_type;
      ddr_clk 	: out std_logic_vector(2 downto 0);
      ddr_clkb	: out std_logic_vector(2 downto 0);
      ddr_clk_fb_out  : out std_logic;
      ddr_clk_fb  : in std_logic;
      ddr_cke  	: out std_logic_vector(1 downto 0);
      ddr_csb  	: out std_logic_vector(1 downto 0);
      ddr_web  	: out std_ulogic;                       -- ddr write enable
      ddr_rasb  	: out std_ulogic;                       -- ddr ras
      ddr_casb  	: out std_ulogic;                       -- ddr cas
      ddr_dm   	: out std_logic_vector (ddrbits/8-1 downto 0);   -- ddr dm
      ddr_dqs  	: inout std_logic_vector (ddrbits/8-1 downto 0); -- ddr dqs
      ddr_dqsn  	: inout std_logic_vector (ddrbits/8-1 downto 0); -- ddr dqsn
      ddr_ad      : out std_logic_vector (13 downto 0);                     -- ddr address
      ddr_ba      : out std_logic_vector (1+eightbanks downto 0);           -- ddr bank address
      ddr_dq    	: inout  std_logic_vector (ddrbits-1 downto 0);    -- ddr data
      ddr_odt	: out std_logic_vector(1 downto 0)
      );
  end component; 

  component ddr2phy_wrap_cbd is
    generic (tech     : integer := virtex2; MHz        : integer := 100; 
    rstdelay    : integer := 200;     dbits      : integer := 16;  padbits  : integer := 0;
    clk_mul     : integer := 2 ;      clk_div    : integer := 2;
    ddelayb0    : integer := 0;       ddelayb1   : integer := 0;   ddelayb2 : integer := 0;
    ddelayb3    : integer := 0;       ddelayb4   : integer := 0;   ddelayb5 : integer := 0;
    ddelayb6    : integer := 0;       ddelayb7   : integer := 0;
    cbdelayb0   : integer := 0;       cbdelayb1: integer := 0;     cbdelayb2: integer := 0;
    cbdelayb3   : integer := 0;
    numidelctrl : integer := 4;       norefclk   : integer := 0;   odten    : integer := 0;
    rskew       : integer := 0;       eightbanks : integer range 0 to 1 := 0;
    dqsse       : integer range 0 to 1 := 0;
    abits       : integer := 14;      nclk     : integer := 3;     ncs      : integer := 2;
    chkbits  : integer := 0;          ctrl2en  : integer := 0;
    resync      : integer := 0;       custombits : integer := 8; extraio: integer := 0);
    port (
      rst            : in    std_ulogic;
      clk            : in    std_logic;   -- input clock
      clkref200      : in    std_logic;   -- input 200MHz clock
      clkout         : out   std_ulogic;  -- system clock
      clkoutret      : in    std_ulogic;  -- system clock returned
      clkresync      : in    std_ulogic;
      lock           : out   std_ulogic;  -- DCM locked

      ddr_clk        : out   std_logic_vector(nclk-1 downto 0);
      ddr_clkb       : out   std_logic_vector(nclk-1 downto 0);
      ddr_clk_fb_out : out   std_logic;
      ddr_clk_fb     : in    std_logic;
      ddr_cke        : out   std_logic_vector(ncs-1 downto 0);
      ddr_csb        : out   std_logic_vector(ncs-1 downto 0);
      ddr_web        : out   std_ulogic;                               -- ddr write enable
      ddr_rasb       : out   std_ulogic;                               -- ddr ras
      ddr_casb       : out   std_ulogic;                               -- ddr cas
      ddr_dm         : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dm
      ddr_dqs        : inout std_logic_vector (extraio+(dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_dqsn       : inout std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_ad         : out   std_logic_vector (abits-1 downto 0);           -- ddr address
      ddr_ba         : out   std_logic_vector (1+eightbanks downto 0); -- ddr bank address
      ddr_dq         : inout std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      ddr_odt        : out   std_logic_vector(ncs-1 downto 0);
      
      ddr_web2       : out   std_ulogic;                               -- ddr write enable
      ddr_rasb2      : out   std_ulogic;                               -- ddr ras
      ddr_casb2      : out   std_ulogic;                               -- ddr cas
      ddr_ad2        : out   std_logic_vector (abits-1 downto 0);      -- ddr address
      ddr_ba2        : out   std_logic_vector (1+eightbanks downto 0); -- ddr bank address
      
      sdi            : out   sdctrl_in_type;
      sdo            : in    sdctrl_out_type;

      customclk      : in    std_ulogic;
      customdin      : in    std_logic_vector(custombits-1 downto 0);
      customdout     : out   std_logic_vector(custombits-1 downto 0)
      );
  end component;

  component ddr2phy_wrap_cbd_wo_pads is
    generic (tech     : integer := virtex2; MHz        : integer := 100; 
	rstdelay    : integer := 200;     dbits      : integer := 16;  padbits  : integer := 0;
	clk_mul     : integer := 2 ;      clk_div    : integer := 2;
	ddelayb0    : integer := 0;       ddelayb1   : integer := 0;   ddelayb2 : integer := 0;
	ddelayb3    : integer := 0;       ddelayb4   : integer := 0;   ddelayb5 : integer := 0;
	ddelayb6    : integer := 0;       ddelayb7   : integer := 0;
        cbdelayb0   : integer := 0;       cbdelayb1: integer := 0;     cbdelayb2: integer := 0;
        cbdelayb3   : integer := 0;
        numidelctrl : integer := 4;       norefclk   : integer := 0;   odten    : integer := 0;
        rskew       : integer := 0;       eightbanks : integer range 0 to 1 := 0;
        dqsse       : integer range 0 to 1 := 0;
        abits       : integer := 14;      nclk     : integer := 3;     ncs      : integer := 2;
        chkbits     : integer := 0;       resync     : integer := 0;   custombits : integer := 8);
    port (
      rst            : in    std_ulogic;
      clk            : in    std_logic;   -- input clock
      clkref200      : in    std_logic;   -- input 200MHz clock
      clkout         : out   std_ulogic;  -- system clock
      clkoutret      : in    std_ulogic;  -- system clock return
      clkresync      : in    std_ulogic;
      lock           : out   std_ulogic;  -- DCM locked

      ddr_clk        : out   std_logic_vector(nclk-1 downto 0);
      ddr_clkb       : out   std_logic_vector(nclk-1 downto 0);
      ddr_clk_fb_out : out   std_logic;
      ddr_clk_fb     : in    std_logic;
      ddr_cke        : out   std_logic_vector(ncs-1 downto 0);
      ddr_csb        : out   std_logic_vector(ncs-1 downto 0);
      ddr_web        : out   std_ulogic;                               -- ddr write enable
      ddr_rasb       : out   std_ulogic;                               -- ddr ras
      ddr_casb       : out   std_ulogic;                               -- ddr cas
      ddr_dm         : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dm
      ddr_dqs_in     : in    std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_dqs_out    : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_dqs_oen    : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_ad         : out   std_logic_vector (abits-1 downto 0);           -- ddr address
      ddr_ba         : out   std_logic_vector (1+eightbanks downto 0); -- ddr bank address
      ddr_dq_in      : in    std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      ddr_dq_out     : out   std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      ddr_dq_oen     : out   std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      ddr_odt        : out   std_logic_vector(ncs-1 downto 0);
    
      sdi            : out   sdctrl_in_type;
      sdo            : in    sdctrl_out_type;

      customclk      : in    std_ulogic;
      customdin      : in    std_logic_vector(custombits-1 downto 0);
      customdout     : out   std_logic_vector(custombits-1 downto 0)
      );
  end component;

  component ddr2phy_wrap
    generic (
      tech        : integer := virtex2;    MHz      : integer := 100;
      rstdelay    : integer := 200;        dbits    : integer := 16;    padbits  : integer := 0;
      clk_mul     : integer := 2;          clk_div  : integer := 2;
      ddelayb0    : integer := 0;          ddelayb1 : integer := 0;     ddelayb2 : integer := 0;
      ddelayb3    : integer := 0;          ddelayb4 : integer := 0;     ddelayb5 : integer := 0;
      ddelayb6    : integer := 0;          ddelayb7 : integer := 0;
      cbdelayb0   : integer := 0;          cbdelayb1: integer := 0;     cbdelayb2: integer := 0;
      cbdelayb3   : integer := 0;
      numidelctrl : integer := 4;          norefclk : integer := 0;     rskew    : integer := 0;
      eightbanks  : integer range 0 to 1 := 0; dqsse : integer range 0 to 1 := 0;
      abits       : integer := 14;         nclk     : integer := 3;     ncs      : integer := 2;
      cben        : integer := 0;          chkbits  : integer := 8;     ctrl2en  : integer := 0;
      resync      : integer := 0;          custombits: integer := 8);
    port (
      rst            : in    std_ulogic;
      clk            : in    std_logic;   -- input clock
      clkref200      : in    std_logic;   -- input 200MHz clock
      clkout         : out   std_ulogic;  -- system clock
      clkoutret      : in    std_ulogic;  -- system clock returned
      clkresync      : in    std_ulogic;
      lock           : out   std_ulogic;  -- DCM locked

      ddr_clk        : out   std_logic_vector(nclk-1 downto 0);
      ddr_clkb       : out   std_logic_vector(nclk-1 downto 0);
      ddr_clk_fb_out : out   std_logic;
      ddr_clk_fb     : in    std_logic;
      ddr_cke        : out   std_logic_vector(ncs-1 downto 0);
      ddr_csb        : out   std_logic_vector(ncs-1 downto 0);
      ddr_web        : out   std_ulogic;                               -- ddr write enable
      ddr_rasb       : out   std_ulogic;                               -- ddr ras
      ddr_casb       : out   std_ulogic;                               -- ddr cas
      ddr_dm         : out   std_logic_vector ((dbits+padbits)/8-1 downto 0);    -- ddr dm
      ddr_dqs        : inout std_logic_vector ((dbits+padbits)/8-1 downto 0);    -- ddr dqs
      ddr_dqsn       : inout std_logic_vector ((dbits+padbits)/8-1 downto 0);    -- ddr dqs
      ddr_ad         : out   std_logic_vector (abits-1 downto 0);           -- ddr address
      ddr_ba         : out   std_logic_vector (1+eightbanks downto 0); -- ddr bank address
      ddr_dq         : inout std_logic_vector (dbits+padbits-1 downto 0);      -- ddr data
      ddr_odt        : out   std_logic_vector(ncs-1 downto 0);
      ddr_cbdm       : out   std_logic_vector(chkbits/8-1 downto 0);
      ddr_cbdqs      : inout std_logic_vector(chkbits/8-1 downto 0);
      ddr_cbdqsn     : inout std_logic_vector(chkbits/8-1 downto 0);
      ddr_cbdq       : inout std_logic_vector(chkbits-1 downto 0);
      ddr_web2       : out   std_ulogic;                               -- ddr write enable
      ddr_rasb2      : out   std_ulogic;                               -- ddr ras
      ddr_casb2      : out   std_ulogic;                               -- ddr cas
      ddr_ad2        : out   std_logic_vector (abits-1 downto 0);      -- ddr address
      ddr_ba2        : out   std_logic_vector (1+eightbanks downto 0); -- ddr bank address
      
      sdi            : out   sdctrl_in_type;
      sdo            : in    sdctrl_out_type;

      customclk      : in    std_ulogic;
      customdin      : in    std_logic_vector(custombits-1 downto 0);
      customdout     : out   std_logic_vector(custombits-1 downto 0)
      );
  end component;
  
  -----------------------------------------------------------------------------
  -- DDRSPA types and components
  -----------------------------------------------------------------------------
  component ddrsp64a
    generic (
      memtech : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      mobile  : integer := 0;
      confapi : integer := 0;
      conf0   : integer := 0;
      conf1   : integer := 0;
      regoutput : integer := 0
      );
    port (
      rst     : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component;

  component ddrsp32a 
    generic (
      memtech : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      mobile  : integer := 0;
      confapi : integer := 0;
      conf0   : integer := 0;
      conf1   : integer := 0;
      regoutput : integer := 0
      );
    port (
      rst     : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component; 

  component ddrsp16a 
    generic (
      memtech : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      mobile  : integer := 0;
      confapi : integer := 0;
      conf0   : integer := 0;
      conf1   : integer := 0;
      regoutput : integer := 0
      );
    port (
      rst     : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      clkread : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component; 
  
  component ddrspa
    generic (
      fabtech : integer := 0;
      memtech : integer := 0;
      rskew   : integer := 0;
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      clkmul  : integer := 2; 
      clkdiv  : integer := 2; 
      col     : integer := 9; 
      Mbyte   : integer := 16; 
      rstdel  : integer := 200; 
      pwron   : integer := 0;
      oepol   : integer := 0;
      ddrbits : integer := 16;
      ahbfreq : integer := 50;
      mobile  : integer := 0;
      confapi : integer := 0;
      conf0   : integer := 0;
      conf1   : integer := 0;
      regoutput : integer  range 0 to 1 := 0
      );
    port (
      rst_ddr : in  std_ulogic;
      rst_ahb : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      lock    : out std_ulogic;			-- DCM locked
      clkddro : out std_ulogic;			-- DCM locked
      clkddri : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      ddr_clk 	: out std_logic_vector(2 downto 0);
      ddr_clkb	: out std_logic_vector(2 downto 0);
      ddr_clk_fb_out  : out std_logic;
      ddr_clk_fb  : in std_logic;
      ddr_cke  	: out std_logic_vector(1 downto 0);
      ddr_csb  	: out std_logic_vector(1 downto 0);
      ddr_web  	: out std_ulogic;                       -- ddr write enable
      ddr_rasb  	: out std_ulogic;                       -- ddr ras
      ddr_casb  	: out std_ulogic;                       -- ddr cas
      ddr_dm   	: out std_logic_vector (ddrbits/8-1 downto 0);    -- ddr dm
      ddr_dqs  	: inout std_logic_vector (ddrbits/8-1 downto 0);    -- ddr dqs
      ddr_ad      : out std_logic_vector (13 downto 0);   -- ddr address
      ddr_ba      : out std_logic_vector (1 downto 0);    -- ddr bank address
      ddr_dq    	: inout  std_logic_vector (ddrbits-1 downto 0) -- ddr data

      );
  end component; 

  component ddrphy_wrap
  generic (tech : integer := virtex2; MHz : integer := 100; 
	rstdelay : integer := 200; dbits : integer := 16; 
	clk_mul : integer := 2 ; clk_div : integer := 2;
	rskew : integer := 0; mobile : integer := 0);
  port (
    rst       : in  std_ulogic;
    clk       : in  std_logic;          	-- input clock
    clkout    : out std_ulogic;			-- system clock
    clkoutret : in  std_ulogic;
    clkread   : out std_ulogic;			-- system clock
    lock      : out std_ulogic;			-- DCM locked
    ddr_clk 	: out std_logic_vector(2 downto 0);
    ddr_clkb	: out std_logic_vector(2 downto 0);
    ddr_clk_fb_out  : out std_logic;
    ddr_clk_fb  : in std_logic;
    ddr_cke  	: out std_logic_vector(1 downto 0);
    ddr_csb  	: out std_logic_vector(1 downto 0);
    ddr_web  	: out std_ulogic;                       -- ddr write enable
    ddr_rasb  	: out std_ulogic;                       -- ddr ras
    ddr_casb  	: out std_ulogic;                       -- ddr cas
    ddr_dm   	: out std_logic_vector (dbits/8-1 downto 0);    -- ddr dm
    ddr_dqs  	: inout std_logic_vector (dbits/8-1 downto 0);    -- ddr dqs
    ddr_ad      : out std_logic_vector (13 downto 0);   -- ddr address
    ddr_ba      : out std_logic_vector (1 downto 0);    -- ddr bank address
    ddr_dq    	: inout  std_logic_vector (dbits-1 downto 0); -- ddr data
 
    sdi         : out sdctrl_in_type;
    sdo         : in  sdctrl_out_type);
  end component;

  component ddrphy_wrap_cbd is
    generic (
      tech : integer := virtex2; MHz : integer := 100; 
      rstdelay : integer := 200; dbits : integer := 16;
      chkbits: integer := 0; padbits : integer := 0;
      clk_mul : integer := 2 ; clk_div : integer := 2;
      rskew : integer :=0; mobile : integer := 0;
      abits: integer := 14; nclk: integer := 3; ncs: integer := 2);
    port (
      rst            : in    std_ulogic;
      clk            : in    std_logic;   -- input clock
      clkout         : out   std_ulogic;  -- system clock
      clkoutret      : in    std_ulogic;  -- system clock return
      clkread        : out   std_ulogic;
      lock           : out   std_ulogic;  -- DCM locked
      
      ddr_clk        : out   std_logic_vector(nclk-1 downto 0);
      ddr_clkb       : out   std_logic_vector(nclk-1 downto 0);
      ddr_clk_fb_out : out   std_logic;
      ddr_clk_fb     : in    std_logic;
      ddr_cke        : out   std_logic_vector(ncs-1 downto 0);
      ddr_csb        : out   std_logic_vector(ncs-1 downto 0);
      ddr_web        : out   std_ulogic;                               -- ddr write enable
      ddr_rasb       : out   std_ulogic;                               -- ddr ras
      ddr_casb       : out   std_ulogic;                               -- ddr cas
      ddr_dm         : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dm
      ddr_dqs        : inout std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_ad         : out   std_logic_vector (abits-1 downto 0);           -- ddr address
      ddr_ba         : out   std_logic_vector (1 downto 0); -- ddr bank address
      ddr_dq         : inout std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      
      sdi            : out   sdctrl_in_type;
      sdo            : in    sdctrl_out_type
      );
  end component;

  component ddrphy_wrap_cbd_wo_pads is
    generic (
      tech : integer := virtex2; MHz : integer := 100; 
      rstdelay : integer := 200; dbits : integer := 16; padbits : integer := 0;
      clk_mul : integer := 2; clk_div : integer := 2;
      rskew : integer := 0; mobile: integer := 0;
      abits : integer := 14; nclk : integer := 3; ncs : integer := 2;
      chkbits : integer := 0);
    port (
      rst            : in    std_ulogic;
      clk            : in    std_logic;   -- input clock
      clkout         : out   std_ulogic;  -- system clock
      clkoutret      : in    std_ulogic;  -- system clock return
      lock           : out   std_ulogic;  -- DCM locked

      ddr_clk        : out   std_logic_vector(nclk-1 downto 0);
      ddr_clkb       : out   std_logic_vector(nclk-1 downto 0);
      ddr_clk_fb_out : out   std_logic;
      ddr_clk_fb     : in    std_logic;
      ddr_cke        : out   std_logic_vector(ncs-1 downto 0);
      ddr_csb        : out   std_logic_vector(ncs-1 downto 0);
      ddr_web        : out   std_ulogic;                               -- ddr write enable
      ddr_rasb       : out   std_ulogic;                               -- ddr ras
      ddr_casb       : out   std_ulogic;                               -- ddr cas
      ddr_dm         : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dm
      ddr_dqs_in     : in    std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_dqs_out    : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_dqs_oen    : out   std_logic_vector ((dbits+padbits+chkbits)/8-1 downto 0);    -- ddr dqs
      ddr_ad         : out   std_logic_vector (abits-1 downto 0);           -- ddr address
      ddr_ba         : out   std_logic_vector (1 downto 0); -- ddr bank address
      ddr_dq_in      : in    std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      ddr_dq_out     : out   std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
      ddr_dq_oen     : out   std_logic_vector (dbits+padbits+chkbits-1 downto 0);      -- ddr data
    
      sdi            : out   sdctrl_in_type;
      sdo            : in    sdctrl_out_type
      );
  end component;    

  -----------------------------------------------------------------------------
  -- Unmaintained legacy controllers
  -----------------------------------------------------------------------------
  component ddrsp
    generic (
      hindex  : integer := 0;
      haddr   : integer := 0;
      hmask   : integer := 16#f00#;
      ioaddr  : integer := 16#000#;
      iomask  : integer := 16#fff#;
      MHz     : integer := 100;
      col     : integer := 9; 
      Mbit    : integer := 256; 
      fast    : integer := 0; 
      pwron   : integer := 0;
      oepol   : integer := 0
      );
    port (
      rst     : in  std_ulogic;
      clk     : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type
      );
  end component; 
    
  type ddrmem_in_type is record
    cke        : std_ulogic;
    cs         : std_logic_vector(1 downto 0);
    control    : std_logic_vector(2 downto 0);  --RAS,CAS,WE
    ba         : std_logic_vector(1 downto 0);
    adr        : std_logic_vector(13 downto 0);
    dq         : std_logic_vector(63 downto 0);
    dm         : std_logic_vector(15 downto 0);
    dqs        : std_logic_vector(15 downto 0);
    dq_oe      : std_logic_vector(63 downto 0);
    dqs_oe     : std_logic_vector(15 downto 0);
  end record;

  type ddrmem_out_type is record
    dq         : std_logic_vector(63 downto 0);
    dqs        : std_logic_vector(15 downto 0);
  end record;

  component ddrctrl
    generic (
      hindex1    :     integer := 0;
      haddr1     :     integer := 0;
      hmask1     :     integer := 16#f80#;
      hindex2    :     integer := 0;
      haddr2     :     integer := 0;
      hmask2     :     integer := 16#f80#;
      pindex     :     integer := 3;
      paddr      :     integer := 0;
      numahb     :     integer := 1;       -- Allowed: 1, 2
      ahb1sepclk :     integer := 0;       -- Allowed: 0, 1
      ahb2sepclk :     integer := 0;       -- Allowed: 0, 1
      modbanks   :     integer := 1;       -- Allowed: 1, 2
      numchips   :     integer := 8;       -- Allowed: 1, 2, 4, 8, 16
      chipbits   :     integer := 8;       -- Allowed: 4, 8, 16
      chipsize   :     integer := 128;     -- Allowed: 64, 128, 256, 512, 1024 (MB)
      plldelay   :     integer := 0;       -- Allowed: 0, 1 (Use 200us start up delay)
      tech       :     integer := 0;
      clkperiod  :     integer := 10);     -- 100 Mhz
    port (
      rst       : in  std_ulogic;
      clk0      : in  std_ulogic;
      clk90     : in  std_ulogic;
      clk180    : in  std_ulogic;
      clk270    : in  std_ulogic;
      hclk1     : in  std_ulogic;
      hclk2     : in  std_ulogic;
      pclk      : in  std_ulogic;
      ahb1si    : in  ahb_slv_in_type;
      ahb1so    : out ahb_slv_out_type;
      ahb2si    : in  ahb_slv_in_type;
      ahb2so    : out ahb_slv_out_type;
      apbsi     : in  apb_slv_in_type;
      apbso     : out apb_slv_out_type;
--    dapbso    : out apb_slv_out_type;
      ddsi      : out ddrmem_in_type;
      ddso      : in  ddrmem_out_type);
  end component;

  
end package;
