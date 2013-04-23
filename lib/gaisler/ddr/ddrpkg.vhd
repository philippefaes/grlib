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
use ieee.numeric_std.all;
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
  component ddr2buf is
    generic (tech : integer := 0; wabits : integer := 6; wdbits : integer := 8;
    rabits : integer := 6; rdbits : integer := 8;
    sepclk : integer := 0; wrfst : integer := 0; testen : integer := 0);
    port (
      rclk     : in std_ulogic;
      renable  : in std_ulogic;
      raddress : in std_logic_vector((rabits -1) downto 0);
      dataout  : out std_logic_vector((rdbits -1) downto 0);
      wclk     : in std_ulogic;
      write    : in std_ulogic;
      writebig : in std_ulogic;
      waddress : in std_logic_vector((wabits -1) downto 0);
      datain   : in std_logic_vector((wdbits -1) downto 0);
      testin   : in std_logic_vector(3 downto 0) := "0000");
  end component;
  
  type ddr_request_type is record
    startaddr : std_logic_vector(31 downto 0);
    endaddr   : std_logic_vector(9 downto 0);
    hsize     : std_logic_vector(2 downto 0);
    hwrite    : std_ulogic;
    hio       : std_ulogic;
    maskdata  : std_ulogic;
    maskcb    : std_ulogic;
    burst     : std_ulogic;
  end record;
  
  type ddr_response_type is record
    done_tog : std_ulogic;
    rctr_gray: std_logic_vector(3 downto 0);
    readerr  : std_ulogic;
  end record;

  constant ddr_request_none: ddr_request_type :=
    ((others => '0'), (others => '0'), "000", '0','0','0','0','0');

  constant ddr_response_none: ddr_response_type := ('0',"0000",'0');
  
component ddr2spax_ahb is
   generic (
      hindex     : integer := 0;
      haddr      : integer := 0;
      hmask      : integer := 16#f00#;
      ioaddr     : integer := 16#000#;
      iomask     : integer := 16#fff#;
      burstlen   : integer := 8;
      nosync     : integer := 0;
      ahbbits    : integer := ahbdw;
      revision   : integer := 0;
      devid      : integer := GAISLER_DDR2SP;
      ddrbits    : integer := 32
   );
   port (
      rst       : in  std_ulogic;
      clk_ahb   : in  std_ulogic;
      ahbsi     : in  ahb_slv_in_type;
      ahbso     : out ahb_slv_out_type;
      request   : out ddr_request_type;
      start_tog : out std_logic;
      response  : in ddr_response_type;
      wbwaddr   : out std_logic_vector(log2(burstlen) downto 0);
      wbwdata   : out std_logic_vector(ahbdw-1 downto 0);
      wbwrite   : out std_logic;
      wbwritebig: out std_logic;
      rbraddr   : out std_logic_vector(log2(burstlen*32/ahbdw)-1 downto 0);
      rbrdata   : in std_logic_vector(ahbdw-1 downto 0)
   );  
end component;

component ft_ddr2spax_ahb is
   generic (
      hindex     : integer := 0;
      haddr      : integer := 0;
      hmask      : integer := 16#f00#;
      ioaddr     : integer := 16#000#;
      iomask     : integer := 16#fff#;
      burstlen   : integer := 8;
      nosync     : integer := 0;
      ahbbits    : integer := 64;
      bufbits    : integer := 96;
      ddrbits    : integer := 16;
      hwidthen   : integer := 0;
      revision   : integer := 0;
      devid      : integer := GAISLER_DDR2SP      
   );
   port (
      rst       : in  std_ulogic;
      clk_ahb   : in  std_ulogic;
      ahbsi     : in  ahb_slv_in_type;
      ahbso     : out ahb_slv_out_type;
      ce        : out std_logic;
      request   : out ddr_request_type;
      start_tog : out std_logic;
      response  : in ddr_response_type;
      wbwaddr   : out std_logic_vector(log2(burstlen)-2 downto 0);
      wbwdata   : out std_logic_vector(bufbits-1 downto 0);
      wbwrite   : out std_logic;
      wbwritebig: out std_logic;
      rbraddr   : out std_logic_vector(log2(burstlen*32/ahbbits)-1 downto 0);
      rbrdata   : in std_logic_vector(bufbits-1 downto 0);
      hwidth    : in std_logic;
      synccfg   : in std_logic;
      request2  : out ddr_request_type;
      start_tog2: out std_logic;
      beid      : in  std_logic_vector(3 downto 0)
   );  
end component;

constant FTFE_BEID_DDR2: std_logic_vector(3 downto 0) := "0000";
constant FTFE_BEID_SDR : std_logic_vector(3 downto 0) := "0001";
constant FTFE_BEID_DDR1: std_logic_vector(3 downto 0) := "0010";
constant FTFE_BEID_SSR : std_logic_vector(3 downto 0) := "0011";  

component ddr2spax_ddr is
   generic (
      ddrbits    : integer := 32;
      burstlen   : integer := 8;
      MHz        : integer := 100;
      TRFC       : integer := 130;
      col        : integer := 9;
      Mbyte      : integer := 8;
      pwron      : integer := 0;
      oepol      : integer := 0;
      readdly    : integer := 1;
      odten      : integer := 0;
      octen      : integer := 0;
      dqsgating  : integer := 0;
      nosync     : integer := 0;
      eightbanks : integer range 0 to 1 := 0; -- Set to 1 if 8 banks instead of 4
      dqsse      : integer range 0 to 1 := 0;  -- single ended DQS
      ddr_syncrst: integer range 0 to 1 := 0;
      chkbits    : integer := 0;
      bigmem     : integer range 0 to 1 := 0;
      raspipe    : integer range 0 to 1 := 0;
      hwidthen   : integer range 0 to 1 := 0;
      phytech    : integer := 0;
      hasdqvalid : integer := 0;
      rstdel     : integer := 200;
      phyptctrl  : integer := 0;
      scantest   : integer := 0
   );
   port (
      ddr_rst  : in  std_ulogic;
      clk_ddr  : in  std_ulogic;
      request  : in ddr_request_type;
      start_tog: in std_logic;
      response : out ddr_response_type;
      sdi      : in  sdctrl_in_type;
      sdo      : out sdctrl_out_type;
      wbraddr  : out std_logic_vector(log2((16*burstlen)/ddrbits) downto 0);
      wbrdata  : in std_logic_vector(2*(ddrbits+chkbits)-1 downto 0);
      rbwaddr  : out std_logic_vector(log2((16*burstlen)/ddrbits)-1 downto 0);
      rbwdata  : out std_logic_vector(2*(ddrbits+chkbits)-1 downto 0);
      rbwrite  : out std_logic;
      hwidth   : in std_ulogic;
      -- dynamic sync (nosync=2)
      reqsel   : in std_ulogic;
      frequest : in ddr_request_type;
      response2: out ddr_response_type;
      testen   : in std_ulogic;
      testrst  : in std_ulogic;
      testoen  : in std_ulogic
   );  
end component;

component ddr2spax is
   generic (
      memtech    : integer := 0;
      phytech    : integer := 0;
      hindex     : integer := 0;
      haddr      : integer := 0;
      hmask      : integer := 16#f00#;
      ioaddr     : integer := 16#000#;
      iomask     : integer := 16#fff#;
      ddrbits    : integer := 32;
      burstlen   : integer := 8;
      MHz        : integer := 100;
      TRFC       : integer := 130;
      col        : integer := 9;
      Mbyte      : integer := 8;
      pwron      : integer := 0;
      oepol      : integer := 0;
      readdly    : integer := 1;
      odten      : integer := 0;
      octen      : integer := 0;
      dqsgating  : integer := 0;
      nosync     : integer := 0;
      eightbanks : integer range 0 to 1 := 0; -- Set to 1 if 8 banks instead of 4
      dqsse      : integer range 0 to 1 := 0;  -- single ended DQS
      ddr_syncrst: integer range 0 to 1 := 0;
      ahbbits    : integer := ahbdw;
      ft         : integer range 0 to 1 := 0;
      bigmem     : integer range 0 to 1 := 0;
      raspipe    : integer range 0 to 1 := 0;
      hwidthen   : integer range 0 to 1 := 0;
      rstdel     : integer := 200;
      scantest   : integer := 0
   );
   port (
      ddr_rst : in  std_ulogic;
      ahb_rst : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
      ahbsi   : in  ahb_slv_in_type;
      ahbso   : out ahb_slv_out_type;
      sdi     : in  sdctrl_in_type;
      sdo     : out sdctrl_out_type;
      hwidth  : in  std_ulogic
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
    cbdelayb0 : integer := 0;
    cbdelayb1 : integer := 0;
    cbdelayb2 : integer := 0;
    cbdelayb3 : integer := 0;
    numidelctrl : integer := 4; 
    norefclk : integer := 0;
    odten    : integer := 0;
    octen    : integer := 0;
    dqsgating : integer := 0;
    nosync    : integer := 0;
    eightbanks : integer := 0;
    dqsse      : integer range 0 to 1 := 0;
    burstlen : integer range 4 to 128 := 8;
    ahbbits    : integer := ahbdw;
    ft : integer range 0 to 1 := 0;
    ftbits : integer := 0;
    bigmem : integer range 0 to 1 := 0;
    raspipe : integer range 0 to 1 := 0;
    nclk    : integer range 1 to 3 := 3;
    scantest: integer := 0
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
    ddr_clk 	: out std_logic_vector(nclk-1 downto 0);
    ddr_clkb	: out std_logic_vector(nclk-1 downto 0);
    ddr_clk_fb_out  : out std_logic;
    ddr_clk_fb  : in std_logic;
    ddr_cke  	: out std_logic_vector(1 downto 0);
    ddr_csb  	: out std_logic_vector(1 downto 0);
    ddr_web  	: out std_ulogic;                       -- ddr write enable
    ddr_rasb  	: out std_ulogic;                       -- ddr ras
    ddr_casb  	: out std_ulogic;                       -- ddr cas
    ddr_dm   	: out std_logic_vector ((ddrbits+ftbits)/8-1 downto 0);   -- ddr dm
    ddr_dqs  	: inout std_logic_vector ((ddrbits+ftbits)/8-1 downto 0); -- ddr dqs
    ddr_dqsn  	: inout std_logic_vector ((ddrbits+ftbits)/8-1 downto 0); -- ddr dqsn
    ddr_ad      : out std_logic_vector (13 downto 0);                     -- ddr address
    ddr_ba      : out std_logic_vector (1+eightbanks downto 0);           -- ddr bank address
    ddr_dq    	: inout  std_logic_vector (ddrbits+ftbits-1 downto 0);    -- ddr data
    ddr_odt	: out std_logic_vector(1 downto 0);
    ce          : out std_logic
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
    resync      : integer := 0;       custombits : integer := 8; extraio: integer := 0;
    scantest    : integer := 0);
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
      customdout     : out   std_logic_vector(custombits-1 downto 0);
    
      testen      : in std_ulogic;
      testrst     : in std_ulogic;
      scanen      : in std_ulogic;
      testoen     : in std_ulogic);
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
        chkbits     : integer := 0;       resync     : integer := 0;   custombits : integer := 8;
        scantest    : integer := 0);
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
      customdout     : out   std_logic_vector(custombits-1 downto 0);
    
      testen      : in std_ulogic;
      testrst     : in std_ulogic;
      scanen      : in std_ulogic;
      testoen     : in std_ulogic);
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
      resync      : integer := 0;          custombits: integer := 8;
      scantest    : integer := 0);
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
      customdout     : out   std_logic_vector(custombits-1 downto 0);

      testen      : in std_ulogic;
      testrst     : in std_ulogic;
      scanen      : in std_ulogic;
      testoen     : in std_ulogic);
  end component;
  
  -----------------------------------------------------------------------------
  -- DDRSPA types and components
  -----------------------------------------------------------------------------

  component ddr1spax_ddr is
    generic (
      ddrbits    : integer := 32;
      burstlen   : integer := 8;
      MHz        : integer := 100;
      col        : integer := 9;
      Mbyte      : integer := 8;
      pwron      : integer := 0;
      oepol      : integer := 0;
      mobile     : integer := 0;
      confapi    : integer := 0;
      conf0      : integer := 0;
      conf1      : integer := 0;
      nosync     : integer := 0;
      ddr_syncrst: integer range 0 to 1 := 0;
      chkbits    : integer := 0;
      hasdqvalid : integer := 0;
      readdly    : integer := 0;
      regoutput  : integer := 1;
      ddr400     : integer := 1;
      rstdel     : integer := 200;
      phyptctrl  : integer := 0;
      scantest   : integer := 0
      );
    port (
      ddr_rst  : in  std_ulogic;
      clk_ddr  : in  std_ulogic;
      request  : in  ddr_request_type;
      start_tog: in  std_logic;
      response : out ddr_response_type;
      sdi      : in  sdctrl_in_type;
      sdo      : out sdctrl_out_type;
      wbraddr  : out std_logic_vector(log2((16*burstlen)/ddrbits) downto 0);
      wbrdata  : in  std_logic_vector(2*(ddrbits+chkbits)-1 downto 0);
      rbwaddr  : out std_logic_vector(log2((16*burstlen)/ddrbits)-1 downto 0);
      rbwdata  : out std_logic_vector(2*(ddrbits+chkbits)-1 downto 0);
      rbwrite  : out std_logic;
      reqsel   : in std_ulogic;
      frequest : in  ddr_request_type;
      response2: out ddr_response_type;
      testen   : in std_ulogic;
      testrst  : in std_ulogic;
      testoen  : in std_ulogic
      );  
  end component;
  
  component ddr1spax is
    generic (
      memtech    : integer := 0;
      phytech    : integer := 0;
      hindex     : integer := 0;
      haddr      : integer := 0;
      hmask      : integer := 16#f00#;
      ioaddr     : integer := 16#000#;
      iomask     : integer := 16#fff#;
      ddrbits    : integer := 32;
      burstlen   : integer := 8;
      MHz        : integer := 100;
      col        : integer := 9;
      Mbyte      : integer := 8;
      pwron      : integer := 0;
      oepol      : integer := 0;
      nosync     : integer := 0;
      ddr_syncrst: integer range 0 to 1 := 0;
      ahbbits    : integer := ahbdw;
      mobile     : integer := 0;
      confapi    : integer := 0;
      conf0      : integer := 0;
      conf1      : integer := 0;
      regoutput  : integer := 0;
      ft         : integer := 0;
      ddr400     : integer := 1;
      rstdel     : integer := 200;
      scantest   : integer := 0
      );
    port (
      ddr_rst : in  std_ulogic;
      ahb_rst : in  std_ulogic;
      clk_ddr : in  std_ulogic;
      clk_ahb : in  std_ulogic;
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
      regoutput : integer  range 0 to 1 := 0;
      ddr400  : integer := 1;
      scantest: integer := 0;
      phyiconf: integer := 0
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
	rskew : integer := 0; mobile : integer := 0;
        scantest : integer := 0; phyiconf : integer := 0);
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
    sdo         : in  sdctrl_out_type;
    
    testen      : in std_ulogic;
    testrst     : in std_ulogic;
    scanen      : in std_ulogic;
    testoen     : in std_ulogic);
  end component;

  component ddrphy_wrap_cbd is
    generic (
      tech : integer := virtex2; MHz : integer := 100; 
      rstdelay : integer := 200; dbits : integer := 16;
      chkbits: integer := 0; padbits : integer := 0;
      clk_mul : integer := 2 ; clk_div : integer := 2;
      rskew : integer :=0; mobile : integer := 0;
      abits: integer := 14; nclk: integer := 3; ncs: integer := 2;
      scantest : integer := 0; phyiconf : integer := 0);
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
      sdo            : in    sdctrl_out_type;
    
      testen      : in std_ulogic;
      testrst     : in std_ulogic;
      scanen      : in std_ulogic;
      testoen     : in std_ulogic);
  end component;

  component ddrphy_wrap_cbd_wo_pads is
    generic (
      tech : integer := virtex2; MHz : integer := 100; 
      rstdelay : integer := 200; dbits : integer := 16; padbits : integer := 0;
      clk_mul : integer := 2; clk_div : integer := 2;
      rskew : integer := 0; mobile: integer := 0;
      abits : integer := 14; nclk : integer := 3; ncs : integer := 2;
      chkbits : integer := 0; scantest : integer := 0);
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
      sdo            : in    sdctrl_out_type;
          
      testen      : in std_ulogic;
      testrst     : in std_ulogic;
      scanen      : in std_ulogic;
      testoen     : in std_ulogic);
  end component;    

  -----------------------------------------------------------------------------
  -- Gray-code routines
  -----------------------------------------------------------------------------
  function lin2gray(l: std_logic_vector) return std_logic_vector;
  function gray2lin(g: std_logic_vector) return std_logic_vector;
  function nextgray(g: std_logic_vector) return std_logic_vector;
  
end package;

package body ddrpkg is

  function lin2gray(l: std_logic_vector) return std_logic_vector is
    variable lx,r: std_logic_vector(l'length-1 downto 0);
  begin
    lx := l;    
    r(l'length-1) := lx(l'length-1);
    if l'length > 1 then
      r(l'length-2 downto 0) := lx(l'length-1 downto 1) xor lx(l'length-2 downto 0);
    end if;
    return r;
  end lin2gray;

  function gray2lin(g: std_logic_vector) return std_logic_vector is
    variable x: std_logic_vector(15 downto 0);
    variable r: std_logic_vector(g'length-1 downto 0);
  begin
    x := (others => '0');
    x(g'length-1 downto 0) := g;
    if g'length > 1 then
      x(14 downto 0) := x(14 downto 0) xor x(15 downto 1);
    end if;
    if g'length > 2 then
      x(13 downto 0) := x(13 downto 0) xor x(15 downto 2);
    end if;
    if g'length > 4 then
      x(11 downto 0) := x(11 downto 0) xor x(15 downto 4);
    end if;
    if g'length > 8 then
      x(7 downto 0) := x(7 downto 0) xor x(15 downto 8);
    end if;
    r := x(g'length-1 downto 0);
    return r;
  end gray2lin;

  function nextgray(g: std_logic_vector) return std_logic_vector is
    variable gx,r: std_logic_vector(g'length-1 downto 0);
    variable gx3,r3: std_logic_vector(2 downto 0) := "000";
    variable l,nl: std_logic_vector(g'length-1 downto 0);
  begin
    gx := g;
    if gx'length = 1 then
      r(0) := not gx(0);
    elsif gx'length = 2 then
      r(1) := gx(0);
      r(0) := not gx(1);
    elsif gx'length = 3 then
--      r(2) := (gx(1) or gx(0)) and (not gx(2) or not gx(0));
--      r(1) := (gx(1) or gx(0)) and (gx(2) or not gx(0));
--      r(0) := gx(2) xor gx(1);
      gx3 := gx(2 downto 0);
      case gx3 is
        when "000"  => r3 := "001";
        when "001"  => r3 := "011";
        when "011"  => r3 := "010";
        when "010"  => r3 := "110";
        when "110"  => r3 := "111";
        when "111"  => r3 := "101";
        when "101"  => r3 := "100";
        when others => r3 := "000";
      end case;
      r(2 downto 0) := r3;
    else
      l := gray2lin(g);
      nl := std_logic_vector(unsigned(l)+1);
      r := lin2gray(nl);
    end if;
    return r;
  end nextgray;
  
end;
