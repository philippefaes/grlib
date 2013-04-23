----------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2004-2008 Gaisler Research
--  Copyright (C) 2008-2009 Aeroflex Gaisler
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE GAISLER LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING.
-----------------------------------------------------------------------------
-- Entity: 	grfpuw
-- File:	grfpuw.vhd
-- Author:	Edvin Catovic - Gaisler Research
-- Description:	GRFPU wrapper emulating GRFPU lite interface
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library fpu;
use fpu.libfpu.all;


  entity grfpuw is
    port (
      ss_clock   : in  std_logic;
      fpinst     : in  std_logic_vector(9 downto 0);
      fpop       : in  std_logic;
      fpld       : in  std_logic;
      reset      : in  std_logic;
      fprf_dout1 : in  std_logic_vector(63 downto 0);
      fprf_dout2 : in  std_logic_vector(63 downto 0);
      roundingmode : in  std_logic_vector(1 downto 0);
      fpbusy     : out std_logic;
      fracresult : out std_logic_vector(54 downto 3);
      expresult  : out std_logic_vector(10 downto 0);
      signresult : out std_logic;
      snnotdb    : out std_logic;
      excep      : out std_logic_vector(5 downto 0);
      conditioncodes : out std_logic_vector(1 downto 0);
      ss_scan_mode : in  std_logic;
      fp_ctl_scan_in : in  std_logic;
      fp_ctl_scan_out : out std_logic
    );
  end;


  architecture rtl of grfpuw is

    signal rst, start, nonstd, flush, rdy, rdy2, busy_r : std_ulogic;
    signal flop    : std_logic_vector(8 downto 0);
    signal opid    : std_logic_vector(5 downto 0);
    signal flushid : std_logic_vector(5 downto 0);
    signal rndmode : std_logic_vector(1 downto 0);
    signal res     : std_logic_vector(63 downto 0);
    signal exc     : std_logic_vector(5 downto 0);
    signal cc      : std_logic_vector(1 downto 0);
    signal fpop_r    : std_ulogic;
      
  begin
      
    rst <= not reset;
    start <= fpld and fpop_r;
    nonstd <= '0';
    opid <= (others => '0');
    flush <= reset;
    flushid <= (others => '0');
      
    process (ss_clock)
    begin
      if rising_edge(ss_clock) then
        fracresult <= res(51 downto 0);
        expresult  <= res(62 downto 52);
        signresult <= res(63);
        conditioncodes <= cc;
        excep <= exc;
        busy_r <=  (fpld or busy_r) and not (rdy or reset);
        rdy2 <= rdy;
        flop <= fpinst(8 downto 0);
        fpop_r <= fpop; 
      end if;
    end process;

    fpbusy <= (fpld or (busy_r and not rdy2)) and not reset;
      
    grfpu0 : grfpu port map (ss_clock, rst, start, nonstd, flop, fprf_dout1, fprf_dout2,
                             opid, flush, flushid, roundingmode, res, exc, open, rdy, cc, open);     
      
  end;
