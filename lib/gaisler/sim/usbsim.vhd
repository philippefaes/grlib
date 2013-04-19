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
-- Package:     usbsim
-- File:        usbsim.vhd
-- Author:      Jonas Ekergarn - Aeroflex Gaisler
-- Description: Types, constants and procedures used when simulating both
-- GRUSBDC and GRUSB_DCL
------------------------------------------------------------------------------

-- pragma translate_off

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
library grlib;
use grlib.stdlib.all;

package usbsim is

  type octet_vector  is array (natural range <>) of std_logic_vector(7 downto 0);

  type grusb_in_type is record
    datain         : std_logic_vector(15 downto 0);
    rxactive       : std_ulogic;
    rxvalid        : std_ulogic;
    rxvalidh       : std_ulogic;
    rxerror        : std_ulogic;
    txready        : std_ulogic;
    linestate      : std_logic_vector(1 downto 0);
    nxt            : std_ulogic;
    dir            : std_ulogic;
    vbusvalid      : std_ulogic;
    hostdisconnect : std_ulogic;
    functesten     : std_ulogic;
  end record;
  type grusb_out_type is record
    dataout           : std_logic_vector(15 downto 0);
    txvalid           : std_ulogic;
    txvalidh          : std_ulogic;
    opmode            : std_logic_vector(1 downto 0);
    xcvrselect        : std_logic_vector(1 downto 0);
    termselect        : std_ulogic;
    suspendm          : std_ulogic;
    reset             : std_ulogic;
    stp               : std_ulogic;
    oen               : std_ulogic;
    databus16_8       : std_ulogic;
    dppulldown        : std_ulogic;
    dmpulldown        : std_ulogic;
    idpullup          : std_ulogic;
    drvvbus           : std_ulogic;
    dischrgvbus       : std_ulogic;
    chrgvbus          : std_ulogic;
    txbitstuffenable  : std_ulogic;
    txbitstuffenableh : std_ulogic;
    fslsserialmode    : std_ulogic;
    tx_enable_n       : std_ulogic;
    tx_dat            : std_ulogic;
    tx_se0            : std_ulogic;
  end record;
        
  -----------------------------------------------------------------------------
  -- various test procedures for usb.
  -----------------------------------------------------------------------------
  --Endpoint numbers
  constant EP0  : std_logic_vector(3 downto 0) := "0000";
  constant EP1  : std_logic_vector(3 downto 0) := "0001";
  constant EP2  : std_logic_vector(3 downto 0) := "0010";
  constant EP3  : std_logic_vector(3 downto 0) := "0011";
  constant EP4  : std_logic_vector(3 downto 0) := "0100";
  constant EP5  : std_logic_vector(3 downto 0) := "0101";
  constant EP6  : std_logic_vector(3 downto 0) := "0110";
  constant EP7  : std_logic_vector(3 downto 0) := "0111";
  constant EP8  : std_logic_vector(3 downto 0) := "1000";
  constant EP9  : std_logic_vector(3 downto 0) := "1001";
  constant EP10 : std_logic_vector(3 downto 0) := "1010";
  constant EP11 : std_logic_vector(3 downto 0) := "1011";
  constant EP12 : std_logic_vector(3 downto 0) := "1100";
  constant EP13 : std_logic_vector(3 downto 0) := "1101";
  constant EP14 : std_logic_vector(3 downto 0) := "1110";
  constant EP15 : std_logic_vector(3 downto 0) := "1111";
 
  -------------------------------------------------------------------------------
  --usb pid constants
  constant TOUT     : std_logic_vector( 3 downto 0) := "0001";
  constant TIN      : std_logic_vector( 3 downto 0) := "1001";
  constant SOF      : std_logic_vector( 3 downto 0) := "0101";
  constant SETUP    : std_logic_vector( 3 downto 0) := "1101";
  --data
  constant DATA0    : std_logic_vector( 3 downto 0) := "0011";
  constant DATA1    : std_logic_vector( 3 downto 0) := "1011";
  constant DATA2    : std_logic_vector( 3 downto 0) := "0111";
  constant MDATA    : std_logic_vector( 3 downto 0) := "1111";
  --handshake
  constant TACK     : std_logic_vector( 3 downto 0) := "0010";
  constant TNAK     : std_logic_vector( 3 downto 0) := "1010";
  constant TSTALL   : std_logic_vector( 3 downto 0) := "1110";
  constant TNYET    : std_logic_vector( 3 downto 0) := "0110";
  --special
  constant PRE      : std_logic_vector( 3 downto 0) := "1100";
  constant ERR      : std_logic_vector( 3 downto 0) := "1100";
  constant SPLIT    : std_logic_vector( 3 downto 0) := "1000";
  constant PING     : std_logic_vector( 3 downto 0) := "0100";
  constant RESERVED : std_logic_vector( 3 downto 0) := "0000";
  
  -- line states
  constant SE0          : std_logic_vector(1 downto 0) := "00";
  constant J_STATE      : std_logic_vector(1 downto 0) := "01";
  constant K_STATE      : std_logic_vector(1 downto 0) := "10";
  constant SE1          : std_logic_vector(1 downto 0) := "11";
  
  -- opcode
  constant NORM_OP : std_logic_vector(1 downto 0) := "00";
  constant NON_DRIV : std_logic_vector(1 downto 0) := "01";
  constant NO_NRZI : std_logic_vector(1 downto 0) := "10";

  -- ULPI PHY registers combined with regwrite bits
  constant FCTRL_WADDR : std_logic_vector(7 downto 0)  := X"84";
  constant FCTRL_SADDR  : std_logic_vector(7 downto 0) := X"85";
  constant FCTRL_CADDR  : std_logic_vector(7 downto 0) := X"86";

  -- ULPI RXCMDs
  constant RXCMD_novbus   : std_logic_vector(7 downto 0) := "00000000";
  constant RXCMD_fsidle   : std_logic_vector(7 downto 0) := "00001101";
  constant RXCMD_hsidle   : std_logic_vector(7 downto 0) := "00001100";
  constant RXCMD_jstate   : std_logic_vector(7 downto 0) := "00001101";
  constant RXCMD_kstate   : std_logic_vector(7 downto 0) := "00001110";
  constant RXCMD_se0state : std_logic_vector(7 downto 0) := "00001100";
  constant RXCMD_fsrxactive : std_logic_vector(7 downto 0) := "00011110";
  constant RXCMD_hsrxactive : std_logic_vector(7 downto 0) := "00011101";
  constant RXCMD_eopj : std_logic_vector(7 downto 0) := "00011101";
  constant RXCMD_eopse0 : std_logic_vector(7 downto 0) := "00011100";

  type uctrl_type is record
    termselect : std_ulogic;
    xcvrselect : std_logic_vector(1 downto 0);
    opmode     : std_logic_vector(1 downto 0);
    suspendm   : std_ulogic;
  end record;
  
  -- init usb signals
  constant usbi_none : grusb_in_type := (
    datain => "ZZZZZZZZ" & "00000000",
    rxactive => '0',
    rxvalid => '0',
    rxvalidh => 'Z',
    rxerror => '0',
    txready => '0',
    linestate => "00",
    nxt => '0',
    dir => '0',
    vbusvalid => '1',
    hostdisconnect => '0',
    functesten => '1');
  
  constant usbo_none : grusb_out_type := (
    dataout           => "ZZZZZZZZ" & "00000000",
    txvalid           => '0',
    txvalidh          => 'Z',
    opmode            => "00",
    xcvrselect        => "00",
    termselect        => '0', 
    suspendm          => '0',
    reset             => '0',
    stp               => '0',
    oen               => '0',
    databus16_8       => '0',
    dppulldown        => '0',
    dmpulldown        => '0',
    idpullup          => '0',
    drvvbus           => '0',
    dischrgvbus       => '0',
    chrgvbus          => '0',
    txbitstuffenable  => '0',
    txbitstuffenableh => '0',
    fslsserialmode    => '0',
    tx_enable_n       => '0',
    tx_dat            => '0',
    tx_se0            => '0'
    );

  function crc5 (
    constant din : std_logic_vector(10 downto 0))
    return std_logic_vector;

  function crc16 (
    constant din     :    std_logic_vector(7 downto 0);
    constant crc16in :    std_logic_vector(15 downto 0))
    return std_logic_vector;
  
  function pidtostr(
    constant pid     : std_logic_vector(3 downto 0))
    return   string;
  
  procedure uprint(
    constant Comment:    in    String         := "-";
    constant Severe:     in    Severity_Level := Note;
    constant Screen:     in    Boolean        := True);

  procedure gen_rxcmd (
    signal clk     : in std_ulogic;
    signal usbi    : out grusb_in_type;
    constant rxcmd : in std_logic_vector(7 downto 0));

  procedure accept_regwrite (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    signal uctrl : out uctrl_type);

  procedure accept_regread (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    constant vbus : in std_ulogic);

  procedure ulpi_reset (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    signal uctrl : out uctrl_type;
    constant pullup : in boolean;
    constant keepclk : in boolean);

  procedure sendpacket(
    signal   clk            : in  std_ulogic;
    constant len            : in  integer;
    constant data           : in  octet_vector;
    constant uiface         : in integer;
    constant dwidth         : in  integer;
    signal   rand           : in  std_logic_vector(7 downto 0);
    signal   usbi           : out grusb_in_type;
    signal   hs             : in std_ulogic);

  procedure receivepacket(
    signal   clk            : in    std_ulogic;
    constant uiface         : in integer;
    constant dwidth         : in    integer;
    signal   rand           : in    std_logic_vector(7 downto 0);
    variable len            : out   integer;
    variable data           : out   octet_vector;
    variable TP             : inout boolean;
    signal   usbi           : out   grusb_in_type;
    signal   usbo           : in    grusb_out_type;
    signal   hs             : in std_ulogic;
    variable timeout        : out boolean);

  procedure ttoken(
    signal   clk             : in  std_ulogic;
    constant len             : in  integer range 0 to 16:= 3;
    constant pid             : in  std_logic_vector(3 downto 0);
    constant piderr          : in  boolean := false;
    constant crcerr          : in  boolean := false;
    constant device_address  : in  std_logic_vector(6 downto 0);
    constant endpoint_number : in  std_logic_vector(3 downto 0);
    constant uiface          : in  integer;
    constant dwidth          : in  integer;
    signal   rand            : in  std_logic_vector(7 downto 0);
    signal   usbi            : out grusb_in_type;
    signal   hs              : in  std_ulogic);

  procedure tsof(
    signal   clk             : in  std_ulogic;
    constant len             : in  integer range 0 to 16 := 3;
    constant fno             : in  std_logic_vector(10 downto 0);
    constant piderr          : in  boolean;
    constant crcerr          : in  boolean;
    signal   rand            : in  std_logic_vector(7 downto 0);
    constant uiface          : in  integer;
    constant dwidth          : in  integer;
    signal   usbi            : out grusb_in_type;
    signal   hs              : in  std_ulogic);

  procedure tdata (
    signal   clk      : in  std_ulogic;
    constant pid      : in  std_logic_vector(3 downto 0);
    constant piderr   : in  boolean := false;
    constant crcerr   : in  boolean := false;
    constant data     : in  octet_vector;
    constant len      : in  integer range 0 to 3072;
    signal   rand     : in  std_logic_vector(7 downto 0);
    constant uiface   : in  integer;
    constant dwidth   : in  integer;
    signal   usbi     : out grusb_in_type;
    signal   hs       : in  std_ulogic);

  procedure rhandshake (
    signal   clk      : in    std_ulogic;
    constant expected : in    std_logic_vector(3 downto 0);
    constant nyet     : in    boolean := false;
    constant nak      : in    boolean := false;
    signal   rand     : in    std_logic_vector(7 downto 0);
    constant uiface   : in    integer;
    constant dwidth   : in    integer;
    signal   usbi     : out   grusb_in_type;
    signal   usbo     : in    grusb_out_type;
    variable TP       : inout boolean;
    variable gotnak   : out   boolean;
    signal   hs       : in    std_ulogic;
    variable timeout  : out   boolean);

  procedure rhandshake (
    signal   clk      : in    std_ulogic;
    constant expected : in    std_logic_vector(3 downto 0);
    constant nyet     : in    boolean := false;
    constant nak      : in    boolean := false;
    signal   rand     : in    std_logic_vector(7 downto 0);
    constant uiface   : in    integer;
    constant dwidth   : in    integer;
    signal   usbi     : out   grusb_in_type;
    signal   usbo     : in    grusb_out_type;
    variable TP       : inout boolean;
    variable gotnak   : out   boolean;
    variable gotnyet  : out   boolean;
    signal   hs       : in    std_ulogic;
    variable timeout  : out   boolean);

  procedure rdata(
    signal   clk            : in    std_ulogic;
    constant expected       : in    std_logic_vector(3 downto 0);
    constant nak            : in    boolean := false;
    constant nbytes         : in    integer;
    constant expdata        : in    octet_vector; 
    constant ep             : in    integer; 
    constant device_address : in    std_logic_vector(6 downto 0);
    signal   rand           : in    std_logic_vector(7 downto 0);
    constant uiface         : in    integer;
    constant dwidth         : in    integer;
    signal   usbi           : out   grusb_in_type;
    signal   usbo           : in    grusb_out_type;
    variable TP             : inout boolean;
    constant verbose        : in    boolean;
    signal   hs             : in    std_ulogic;
    constant retryiso       : in    boolean;
    variable timeout        : out   boolean);

  procedure rdata(
    signal   clk            : in    std_ulogic;
    constant expected       : in    std_logic_vector(3 downto 0);
    constant nak            : in    boolean := false;
    constant nbytes         : in    integer;
    constant expdata        : in    octet_vector; 
    constant ep             : in    integer; 
    constant device_address : in    std_logic_vector(6 downto 0);
    signal   rand           : in    std_logic_vector(7 downto 0);
    constant uiface         : in    integer;
    constant dwidth         : in    integer;
    signal   usbi           : out   grusb_in_type;
    signal   usbo           : in    grusb_out_type;
    variable TP             : inout boolean;
    constant verbose        : in    boolean;
    signal   hs             : in    std_ulogic;
    constant retryiso       : in    boolean;
    variable timeout        : out   boolean;
    variable recdata        : out   octet_vector;
    constant checkdata      : in    boolean);

  procedure shandshake (
    signal   clk    : in  std_ulogic;
    constant hpid   : in  std_logic_vector(3 downto 0);
    constant uiface : in  integer;
    constant dwidth : in  integer;
    signal   rand   : in  std_logic_vector(7 downto 0);
    signal   usbi   : out grusb_in_type;
    signal   hs     : in std_ulogic);

  procedure getstatus (
    constant dir            : in    std_logic_vector(3 downto 0);
    constant stall          : in    boolean := false;
    constant nak            : in    boolean := true;
    signal   clk            : in    std_ulogic;
    signal   usbo           : in    grusb_out_type;
    signal   usbi           : out   grusb_in_type;
    constant ep             : in    integer;
    signal   rand           : in    std_logic_vector(7 downto 0);
    constant uiface         : in    integer;
    constant dwidth         : in    integer;
    constant device_address : in    std_logic_vector(6 downto 0);
    variable TP             : inout boolean;
    signal   hs             : in    std_ulogic;
    variable timeout        : out   boolean);
  
  procedure hs_handshake (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    signal uctrl : out uctrl_type;
    signal hs : in std_ulogic;
    constant uiface : in integer);
  
end usbsim;

package body usbsim is

  -----------------------------------------------------------------------------
  --usb crc5 calculator.
  --in: std_logic_vector(10 downto 0)
  --out: std_logic_vector(4 downto 0)
  --desrciption: calculates the inverted usb crc5 value on argument.
  -----------------------------------------------------------------------------
  function crc5 (
    constant din : std_logic_vector(10 downto 0))
    return std_logic_vector is

    variable dout : std_logic_vector(4 downto 0);
  begin
    dout(4) := din(0) xor din(1) xor din(4) xor din(5) xor din(7) xor din(10);
    dout(3) := din(0) xor din(3) xor din(4) xor din(6) xor din (9);
    dout(2) := din(0) xor din(1) xor din(2) xor din(3) xor din(4) xor din(7) xor din(8) xor din(10);
    dout(1) := din(0) xor din(1) xor din(2) xor din(3) xor din(6) xor din(7) xor din(9) xor '1';
    dout(0) := din(0) xor din(1) xor din(2) xor din(5) xor din(6) xor din(8);

    return dout;
  end function crc5;
  -----------------------------------------------------------------------------
  --usb crc16 calculator
  --in: old crc16, din(7 downto 0)
  --out new crc16 value
  --descripton: calculates the usb crc16 value from earlier crc16 value and din
  --crc16in set to X"FFFF" for first calculation.
  -----------------------------------------------------------------------------

  function crc16 (
    constant din     :    std_logic_vector(7 downto 0);
    constant crc16in :    std_logic_vector(15 downto 0))
    return std_logic_vector is

    variable dout : std_logic_vector(15 downto 0);
  begin
    dout(15) := din(0) xor din(1) xor din(2) xor din(3) xor din(4) xor din(5) xor din(6) xor din(7) xor
                crc16in(7) xor crc16in(6) xor crc16in(5) xor crc16in(4) xor crc16in(3) xor crc16in(2) xor
                crc16in(1) xor crc16in(0);
    dout(14) := din(0) xor din(1) xor din(2) xor din(3) xor din(4) xor din(5) xor din(6) xor
                crc16in(6) xor crc16in(5) xor crc16in(4) xor crc16in(3) xor crc16in(2) xor
                crc16in(1) xor crc16in(0);
    dout(13) := din(6) xor din(7) xor crc16in(7) xor crc16in(6);
    dout(12) := din(5) xor din(6) xor crc16in(6) xor crc16in(5);
    dout(11) := din(4) xor din(5) xor crc16in(5) xor crc16in(4);
    dout(10) := din(3) xor din(4) xor crc16in(4) xor crc16in(3);
    dout(9)  := din(2) xor din(3) xor crc16in(3) xor crc16in(2);
    dout(8)  := din(1) xor din(2) xor crc16in(2) xor crc16in(1);

    dout(7) := din(0) xor din(1) xor crc16in(15) xor crc16in(1) xor crc16in(0);
    dout(6) := din(0) xor crc16in(14) xor crc16in(0);
    dout(5) := crc16in(13);
    dout(4) := crc16in(12);
    dout(3) := crc16in(11);
    dout(2) := crc16in(10);
    dout(1) := crc16in(9);
    dout(0) := din(0) xor din(1) xor din(2) xor din(3) xor din(4) xor din(5) xor din(6) xor din(7) xor
               crc16in(8) xor crc16in(7) xor crc16in(6) xor crc16in(5) xor crc16in(4) xor crc16in(3) xor crc16in(2) xor
               crc16in(1) xor crc16in(0);
    return dout;
  end function crc16;

  function pidtostr(
    constant pid     : std_logic_vector(3 downto 0))
    return   string is
    variable s       : string(1 to 8);
  begin
    case pid is
      when TOUT =>
        s := "OUT     ";
      when TIN =>
        s := "IN      ";
      when SOF =>
        s := "SOF     ";
      when SETUP =>
        s := "SETUP   ";
      when DATA0 =>
        s := "DATA0   ";
      when DATA1 =>
        s := "DATA1   ";
      when DATA2 =>
        s := "DATA2   ";
      when MDATA =>
        s := "MDATA   ";
      when TACK =>
        s := "ACK     ";
      when TNAK =>
        s := "NAK     ";
      when TSTALL =>
        s := "STALL   ";
      when TNYET =>
        s := "NYET    ";
      when PRE =>
        s := "PRE     ";
      when SPLIT =>
        s := "SPLIT   ";
      when PING =>
        s := "PING    ";
      when RESERVED =>
        s := "RESERVED";
      when others =>
        s := "Illegal ";
    end case;
    return s;
  end function;

  -----------------------------------------------------------------------------
  -- This procedure prints a message to standard output
  -----------------------------------------------------------------------------
  procedure uprint(
    constant Comment:    in    String         := "-";
    constant Severe:     in    Severity_Level := Note;
    constant Screen:     in    Boolean        := True) is
    variable L:                Line;
  begin
    if Screen then
      Write(L, Now, Right, 15);
      Write(L, " : " & Comment);
      if    Severe = Warning then
        Write(L, String'(" # Warning, "));
      elsif Severe = Error then
        Write(L, String'(" # Error, "));
      elsif Severe = Failure then
        Write(L, String'(" # Failure, "));
      end if;
      WriteLine(Output, L);
    end if;
  end procedure uprint;
       
  -----------------------------------------------------------------------------
  -- ULPI procedures
  -----------------------------------------------------------------------------
  procedure gen_rxcmd (
    signal clk     : in std_ulogic;
    signal usbi    : out grusb_in_type;
    constant rxcmd : in std_logic_vector(7 downto 0)) is
  begin
    wait until rising_edge(clk);
    usbi.dir <= '1'; usbi.nxt <= '0';
    wait until rising_edge(clk);
    usbi.datain(7 downto 0) <= rxcmd;
    wait until rising_edge(clk);
    usbi.dir <= '0'; usbi.datain(7 downto 0) <= X"00";
  end procedure;

  procedure accept_regwrite (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    signal uctrl : out uctrl_type) is
    variable fw, fs, fc : boolean := false;
    variable suspend : std_ulogic := '1';
  begin
--    if usbo.dataout(7 downto 6) /= "10" then
--      wait until usbo.dataout(7 downto 6) = "10";
--    end if;
    while usbo.dataout(7 downto 6) /= "10" loop
      wait for 1 ns;
    end loop;
    wait until rising_edge(clk);
    wait for 1 ps;
    usbi.nxt <= '1';
    if usbo.dataout(7 downto 0) = FCTRL_WADDR then fw := true; end if;
    if usbo.dataout(7 downto 0) = FCTRL_SADDR then fs := true; end if;
    if usbo.dataout(7 downto 0) = FCTRL_CADDR then fc := true; end if;
    wait until falling_edge(clk);
    wait until falling_edge(clk);
    if fw then
      uctrl.xcvrselect(0) <= usbo.dataout(0);
      uctrl.termselect <= usbo.dataout(2);
      uctrl.opmode(0)  <= usbo.dataout(3);
      uctrl.opmode(1)  <= usbo.dataout(4);
      suspend          := usbo.dataout(6);
    end if;
    if fs then
      if usbo.dataout(0) = '1' then uctrl.xcvrselect(0) <= '1'; end if;
      if usbo.dataout(2) = '1' then uctrl.termselect <= '1'; end if;
      if usbo.dataout(3) = '1' then uctrl.opmode(0) <= '1'; end if;
      if usbo.dataout(4) = '1' then uctrl.opmode(1) <= '1'; end if;
      if usbo.dataout(6) = '1' then suspend := '1'; end if;
    end if;
    if fc then
      if usbo.dataout(0) = '1' then uctrl.xcvrselect(0) <= '0'; end if;
      if usbo.dataout(2) = '1' then uctrl.termselect <= '0'; end if;
      if usbo.dataout(3) = '1' then uctrl.opmode(0) <= '0'; end if;
      if usbo.dataout(4) = '1' then uctrl.opmode(1) <= '0'; end if;
      if usbo.dataout(6) = '1' then suspend := '0'; end if;
    end if;    
    wait until rising_edge(usbo.stp);
    usbi.nxt <= '0';
    if suspend = '0' then
      wait until rising_edge(clk);
      usbi.dir <= '1';
      wait until rising_edge(clk);
      usbi.datain(7 downto 0) <= "000000" & J_STATE;
      for i in 0 to 4 loop
        wait until rising_edge(clk);
      end loop;  -- i
      wait until falling_edge(clk);
      uctrl.suspendm <= '0';
    else
      wait until rising_edge(clk);
    end if;    
  end procedure;

  procedure accept_regread (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    constant vbus : in std_ulogic) is
  begin
--    if usbo.dataout(7 downto 6) /= "11" then
--      wait until usbo.dataout(7 downto 6) = "11";
--    end if;
    while usbo.dataout(7 downto 6) /= "11" loop
      wait for 1 ns;
    end loop;
    wait until rising_edge(clk);
    usbi.nxt <= '1';
    wait until rising_edge(clk);
    usbi.nxt <= '0'; usbi.dir <= '1';
    wait until rising_edge(clk);
    usbi.datain(7 downto 0) <= "000000" & vbus & '0';
    wait until rising_edge(clk);
    usbi.dir <= '0';
  end procedure;
    
  
  procedure ulpi_reset (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    signal uctrl : out uctrl_type;
    constant pullup : in boolean;
    constant keepclk : in boolean)  is
  begin
    usbi.dir <= '0';
    -- Wait for first txcmd (ulpi reset)
    accept_regwrite(clk,usbi,usbo,uctrl);

    -- Assert dir and then generate an rxcmd
    wait until rising_edge(clk);
    usbi.dir <= '1';
    for i in 0 to 4 loop
      wait until rising_edge(clk);
    end loop;
    usbi.dir <= '0';
    gen_rxcmd(clk,usbi,RXCMD_novbus);

    -- Wait for second txcmd (otg register write)
    accept_regwrite(clk,usbi,usbo,uctrl);
    -- Wait for third txcmd (interrupt register write)
    accept_regwrite(clk,usbi,usbo,uctrl);
    -- Wait for fourth txcmd (interrupt register write)
    accept_regwrite(clk,usbi,usbo,uctrl);
    -- Wait for fifth txcmd (ulpi reset)
    accept_regwrite(clk,usbi,usbo,uctrl);

    -- Assert dir and then generate an rxcmd
    wait until rising_edge(clk);
    usbi.dir <= '1';
    for i in 0 to 4 loop
      wait until rising_edge(clk);
    end loop;
    usbi.dir <= '0';
    gen_rxcmd(clk,usbi,RXCMD_novbus);

    -- If pull-up bit is enabled an extra register write will occur
    if pullup then
      accept_regwrite(clk,usbi,usbo,uctrl);
    end if;
        
    if not keepclk then
      accept_regwrite(clk,usbi,usbo,uctrl);
      if usbo.suspendm = '1' then
        if usbo.xcvrselect /= "00" or usbo.termselect /= '0' or
          usbo.opmode /= "00" then
          -- Wait for suspend (due to no vbus)
          wait until usbo.suspendm = '0';
        end if;
      end if;
    end if;
    
  end procedure;   
  
  procedure sendpacket(
    signal   clk            : in  std_ulogic;
    constant len            : in  integer;
    constant data           : in  octet_vector;
    constant uiface         : in integer;
    constant dwidth         : in  integer;
    signal   rand           : in  std_logic_vector(7 downto 0);
    signal   usbi           : out grusb_in_type;
    signal   hs             : in std_ulogic) is
    variable i              : integer;
    variable ws             : integer;
  begin
    wait until rising_edge(clk);
    if uiface = 0 then
      usbi.linestate <= K_STATE;
      if hs = '0' then
        wait until rising_edge(clk);
      end if;
      usbi.rxactive <= '1';
      if (dwidth = 8) then --8-bit UTMI mode
        i := 0;
        while i < len loop
          ws := conv_integer(rand(1 downto 0));
          if ws /= 0 then
            for i in 0 to ws-1 loop
              wait until rising_edge(clk);
            end loop;
          end if;
          usbi.rxvalid <= '1'; usbi.datain(7 downto 0) <= data(i);
          wait until rising_edge(clk);
          usbi.rxvalid <= '0';
          i := i + 1;
        end loop;
      else --16-bit UTMI mode
        i := 0;
        while i < len loop
          ws := conv_integer(rand(1 downto 0));
          if ws /= 0 then
            for i in 0 to ws-1 loop
              wait until rising_edge(clk);
            end loop;
          end if;
          usbi.rxvalid <= '1'; usbi.datain(7 downto 0) <= data(i);
          i := i + 1;
          if (rand(7) = '1') and (i < len) then
            usbi.rxvalidh <= '1'; usbi.datain(15 downto 8) <= data(i);
            i := i + 1;
          end if;
          wait until rising_edge(clk);
          usbi.rxvalid <= '0'; usbi.rxvalidh <= '0';
        end loop;
      end if;
      ws := conv_integer(rand(1 downto 0));
      if ws /= 0 then
        for i in 0 to ws-1 loop
          wait until rising_edge(clk);
        end loop;
      end if;
      usbi.rxactive <= '0';
      if hs = '0' then
        usbi.linestate <= SE0;
        wait until clk = '1';
        usbi.linestate <= J_STATE;
      end if;
    else
      if hs = '0' then
        gen_rxcmd(clk,usbi,RXCMD_kstate);
        wait until rising_edge(clk);
      end if;      
      usbi.dir <= '1'; usbi.nxt <= '1';
      wait until rising_edge(clk);
      usbi.nxt <= '0';
      if hs = '0' then
        usbi.datain(7 downto 0) <= RXCMD_hsrxactive;
      else
        usbi.datain(7 downto 0) <= RXCMD_fsrxactive;
      end if;              
      i := 0;
      while i < len loop
        ws := conv_integer(rand(1 downto 0));
        if ws /= 0 then
          for i in 0 to ws-1 loop
            wait until rising_edge(clk);
          end loop;
        end if;
        usbi.nxt <= '1'; usbi.datain(7 downto 0) <= data(i);
        wait until rising_edge(clk);
        usbi.nxt <= '0';
        if hs = '0' then
          usbi.datain(7 downto 0) <= RXCMD_hsrxactive;
        else
          usbi.datain(7 downto 0) <= RXCMD_fsrxactive;
        end if;              
        i := i + 1;
      end loop;
      ws := conv_integer(rand(1 downto 0));
      if ws /= 0 then
        for i in 0 to ws-1 loop
          wait until rising_edge(clk);
        end loop;
      end if;
      if hs = '1' then
        usbi.datain(7 downto 0) <= RXCMD_eopse0;
      else
        usbi.datain(7 downto 0) <= RXCMD_eopse0;
        wait until rising_edge(clk);
        usbi.datain(7 downto 0) <= RXCMD_eopj;
      end if;      
      wait until rising_edge(clk);
      usbi.dir <= '0'; usbi.datain(7 downto 0) <= (others=>'0');
    end if;
    wait until rising_edge(clk);
  end procedure;

  procedure receivepacket(
    signal   clk            : in    std_ulogic;
    constant uiface         : in integer;
    constant dwidth         : in    integer;
    signal   rand           : in    std_logic_vector(7 downto 0);
    variable len            : out   integer;
    variable data           : out   octet_vector;
    variable TP             : inout boolean;
    signal   usbi           : out   grusb_in_type;
    signal   usbo           : in    grusb_out_type;
    signal   hs             : in std_ulogic;
    variable timeout        : out boolean) is
    variable ws             : integer;
    variable i              : integer;
    variable pvalid         : std_ulogic;
    variable stp            : std_ulogic;
  begin
    stp := '0';
    if uiface = 0 then
      usbi.linestate <= K_STATE;
      if usbo.txvalid = '0' then
        wait until usbo.txvalid = '1';
      end if;
      i := 0;
      pvalid := '1';
      while usbo.txvalid = '1' loop
        ws := conv_integer(rand(1 downto 0));
        if ws /= 0 then
          for i in 0 to ws-1 loop
            wait until rising_edge(clk);
          end loop;
        end if;
        usbi.txready <= '1';
        wait until rising_edge(clk);
        if usbo.txvalid = '1' then
          data(i) := usbo.dataout(7 downto 0); i := i + 1;
          if (dwidth = 16) then
            if usbo.txvalidh = '1' then
              if pvalid = '0' then
                uprint("ERROR:  txvalidh asserted irregularly");
                TP := False;
              end if;
              pvalid := '1';
              data(i) := usbo.dataout(15 downto 8); i := i + 1;
            else
              pvalid := '0';
            end if;
          end if;
        end if;
        usbi.txready <= '0';
        wait until falling_edge(clk);
        if usbo.txvalid = '0' then
        end if;
      end loop;
      usbi.txready <= '0'; len := i;
      if hs = '0' then
        wait until rising_edge(clk);
        usbi.linestate <= SE0;
        wait until rising_edge(clk);
        usbi.linestate <= J_STATE;        
      end if;
    else
      i := 0;
--      if usbo.dataout(7 downto 6) /= "01" then
--        wait until usbo.dataout(7 downto 6) = "01" for 500 ns;
--      end if;
      while usbo.dataout(7 downto 6) /= "01" loop
        wait for 1 ns;
      end loop;
      if usbo.dataout(7 downto 6) /= "01" then
        timeout := true;
      else
        timeout := false;
        wait until rising_edge(clk);
        while stp = '0' loop
          usbi.nxt <= '1';
          wait until rising_edge(clk);
          data(i) := usbo.dataout(7 downto 0);
          if i = 0 then
            data(i)(7 downto 4) := not usbo.dataout(3 downto 0);
          end if;
          i := i+1;
          wait until falling_edge(clk);
          stp := usbo.stp;
        end loop;
        wait until rising_edge(clk);
        usbi.nxt <= '0';
        len := i;
        if hs = '1' then
          gen_rxcmd(clk,usbi,RXCMD_jstate);
          gen_rxcmd(clk,usbi,RXCMD_se0state);
        else
          gen_rxcmd(clk,usbi,RXCMD_se0state);
          gen_rxcmd(clk,usbi,RXCMD_jstate);
        end if;
      end if;
    end if;
  end procedure;

  -----------------------------------------------------------------------------
  -- usb token packet procedure.
  -- transmits a token packet, as specified by the input signals
  -----------------------------------------------------------------------------
  procedure ttoken(
    signal   clk             : in  std_ulogic;
    constant len             : in  integer range 0 to 16:= 3;
    constant pid             : in  std_logic_vector(3 downto 0);
    constant piderr          : in  boolean := false;
    constant crcerr          : in  boolean := false;
    constant device_address  : in  std_logic_vector(6 downto 0);
    constant endpoint_number : in  std_logic_vector(3 downto 0);
    constant uiface          : in  integer;
    constant dwidth          : in  integer;
    signal   rand            : in  std_logic_vector(7 downto 0);
    signal   usbi            : out grusb_in_type;
    signal   hs              : in  std_ulogic) is
    variable p               : octet_vector(0 to 15);
    variable tmp             : std_logic_vector(10 downto 0);
    variable i               : integer;
    variable ws              : integer;
  begin
    --build packet
    for i in 0 to len-1 loop
      case i is
        when 0 => --PID
          p(0) := not PID & PID;
          --generate pid error
          if piderr then
            p(0)(conv_integer(rand(2 downto 0))) :=
              not p(0)(conv_integer(rand(2 downto 0)));
          end if;
        when 1 => --ADDR & EP
          p(1) := endpoint_number(0) & device_address;
        when 2 => --EP & CRC
          tmp := endpoint_number & device_address;
          p(2) := crc5(tmp) & endpoint_number(3 downto 1);
          if crcerr then
            p(2)(3+conv_integer(rand(1 downto 0))) :=
              not p(2)(3+conv_integer(rand(1 downto 0)));
          end if;
        when others => --EXCESSIVE DATA
          p(i) := rand;
      end case;
    end loop;
    
    --packet transmission
    sendpacket(clk, len, p, uiface, dwidth, rand, usbi, hs);
  end ttoken;

  -----------------------------------------------------------------------------
  -- usb sof packet procedure.
  -- transmit specified framenumber

  procedure tsof(
    signal   clk             : in  std_ulogic;
    constant len             : in  integer range 0 to 16 := 3;
    constant fno             : in  std_logic_vector(10 downto 0);
    constant piderr          : in  boolean;
    constant crcerr          : in  boolean;
    signal   rand            : in  std_logic_vector(7 downto 0);
    constant uiface          : in  integer;
    constant dwidth          : in  integer;
    signal   usbi            : out grusb_in_type;
    signal   hs              : in  std_ulogic) is
    variable ws              : integer;
    variable p               : octet_vector(0 to 15);
  begin
    --build packet
    for i in 0 to len-1 loop
      case i is
        when 0 => --PID
          p(0) := not SOF & SOF;
          --generate pid error
          if piderr then
            p(0)(conv_integer(rand(2 downto 0))) :=
              not p(0)(conv_integer(rand(2 downto 0)));
          end if;
        when 1 => --fno
          p(1) := fno(7 downto 0);
        when 2 => --EP & CRC
          p(2) := crc5(fno) & fno(10 downto 8);
          if crcerr then
            p(2)(3+conv_integer(rand(1 downto 0))) :=
              not p(2)(3+conv_integer(rand(1 downto 0)));
          end if;
        when others => --EXCESSIVE DATA
          p(i) := rand;
      end case;
    end loop;
    
    --packet transmission
    sendpacket(clk, len, p, uiface, dwidth, rand, usbi, hs);
  end tsof;

  -----------------------------------------------------------------------------
  -- usb data packet procedure
  -- transmits the number of bytes provided.
  -- calculates and transmits crc16 value

  procedure tdata (
    signal   clk      : in  std_ulogic;
    constant pid      : in  std_logic_vector(3 downto 0);
    constant piderr   : in  boolean := false;
    constant crcerr   : in  boolean := false;
    constant data     : in  octet_vector;
    constant len      : in  integer range 0 to 3072;
    signal   rand     : in  std_logic_vector(7 downto 0);
    constant uiface   : in  integer;
    constant dwidth   : in  integer;
    signal   usbi     : out grusb_in_type;
    signal   hs       : in  std_ulogic) is
    variable crc      : std_logic_vector(15 downto 0) := X"FFFF";
    variable p        : octet_vector(0 to len+2);
    variable ws       : integer;
  begin
    --build packet
    for i in 0 to len loop
      case i is
        when 0 => -- PID
          p(0) := not pid & pid;
          if piderr then
            p(0)(conv_integer(rand(2 downto 0))) :=
              not p(0)(conv_integer(rand(2 downto 0)));
          end if;
        when others =>
          p(i) := data(data'low+i-1);
          crc := crc16(p(i), crc);
      end case;
    end loop;
    crc := not crc;
    if crcerr then
      crc(conv_integer(rand(2 downto 0))) :=
        not crc(conv_integer(rand(2 downto 0)));
    end if;
    p(len+1) := crc(7 downto 0);
    p(len+2) := crc(15 downto 8);
    
    --packet transmission
    sendpacket(clk, len+3, p, uiface, dwidth, rand, usbi, hs);
  end tdata;

  ---------------------------------------------------------------------------
  -- usb receive handshake procedure
  -- checks if the expected handshake was received properly

  procedure rhandshake (
    signal   clk      : in    std_ulogic;
    constant expected : in    std_logic_vector(3 downto 0);
    constant nyet     : in    boolean := false;
    constant nak      : in    boolean := false;
    signal   rand     : in    std_logic_vector(7 downto 0);
    constant uiface   : in    integer;
    constant dwidth   : in    integer;
    signal   usbi     : out   grusb_in_type;
    signal   usbo     : in    grusb_out_type;
    variable TP       : inout boolean;
    variable gotnak   : out   boolean;
    signal   hs       : in    std_ulogic;
    variable timeout  : out   boolean) is
    variable res      : boolean := false;
    variable data     : octet_vector(0 to 3071);
    variable len      : integer;
    variable timeoutv : boolean;
  begin
    --receive packet
    receivepacket(clk, uiface, dwidth, rand, len, data, TP, usbi, usbo, hs, timeoutv);
    timeout := timeoutv;
    if not timeoutv then
      --check packet
      if (len /= 1) then
        uprint("ERROR: Handshake of illegal length(" & tost(len) &") received");
        TP := False;
      elsif (not data(0)(7 downto 4)) /= data(0)(3 downto 0) then
        uprint("ERROR: PID and inverted PID fields do not match");
        TP := False;
      end if;
      gotnak := (data(0)(3 downto 0) = TNAK) and TP;
      
      if not ((data(0)(3 downto 0) = expected) or
              ((data(0)(3 downto 0) = TNYET) and nyet) or
              ((data(0)(3 downto 0) = TNAK) and nak)) then
        uprint("ERROR: PIDs do not match");
        uprint("Expected: " & pidtostr(expected) & " Received: " & pidtostr(data(0)(3 downto 0)));
        TP := False;
      end if;
    end if;
  end rhandshake;

  procedure rhandshake (
    signal   clk      : in    std_ulogic;
    constant expected : in    std_logic_vector(3 downto 0);
    constant nyet     : in    boolean := false;
    constant nak      : in    boolean := false;
    signal   rand     : in    std_logic_vector(7 downto 0);
    constant uiface   : in    integer;
    constant dwidth   : in    integer;
    signal   usbi     : out   grusb_in_type;
    signal   usbo     : in    grusb_out_type;
    variable TP       : inout boolean;
    variable gotnak   : out   boolean;
    variable gotnyet  : out   boolean;
    signal   hs       : in    std_ulogic;
    variable timeout  : out   boolean) is
    variable res      : boolean := false;
    variable data     : octet_vector(0 to 3071);
    variable len      : integer;
    variable timeoutv : boolean;
  begin
    --receive packet
    receivepacket(clk, uiface, dwidth, rand, len, data, TP, usbi, usbo, hs, timeoutv);
    timeout := timeoutv;
    if not timeoutv then
      --check packet
      if (len /= 1) then
        uprint("ERROR: Handshake of illegal length(" & tost(len) &") received");
        TP := False;
      elsif (not data(0)(7 downto 4)) /= data(0)(3 downto 0) then
        uprint("ERROR: PID and inverted PID fields do not match");
        TP := False;
      end if;
      gotnak := (data(0)(3 downto 0) = TNAK) and TP;
      gotnyet := (data(0)(3 downto 0) = TNYET) and TP;
      
      if not ((data(0)(3 downto 0) = expected) or
              ((data(0)(3 downto 0) = TNYET) and nyet) or
              ((data(0)(3 downto 0) = TNAK) and nak)) then
        uprint("ERROR: PIDs do not match");
        uprint("Expected: " & pidtostr(expected) & " Received: " & pidtostr(data(0)(3 downto 0)));
        TP := False;
      end if;
    end if;
  end rhandshake;
  
-----------------------------------------------------------------------------
  -- usb receive data packet procedure
  -- calculates and compare crc16 value

  procedure rdata(
    signal   clk            : in    std_ulogic;
    constant expected       : in    std_logic_vector(3 downto 0);
    constant nak            : in    boolean := false;
    constant nbytes         : in    integer;
    constant expdata        : in    octet_vector; 
    constant ep             : in    integer; 
    constant device_address : in    std_logic_vector(6 downto 0);
    signal   rand           : in    std_logic_vector(7 downto 0);
    constant uiface         : in    integer;
    constant dwidth         : in    integer;
    signal   usbi           : out   grusb_in_type;
    signal   usbo           : in    grusb_out_type;
    variable TP             : inout boolean;
    constant verbose        : in    boolean;
    signal   hs             : in    std_ulogic;
    constant retryiso       : in    boolean;  -- set to true only when a
                                              -- zero byte DATA0 response
                                              -- from a  isochronous ep
                                              -- should lead to a retry of
                                              -- the IN
    variable timeout        : out   boolean) is

    variable res   : boolean                      := false;
    variable crc      : std_logic_vector(15 downto 0) := X"FFFF";
    variable s        : line;
    variable bytes    : integer                       := 0;
    variable msg      : boolean                       := false;
    variable dout     : std_logic_vector(7 downto 0);
    variable err      : boolean                       := false;
    constant str      : string                        := ", ";
    variable data     : octet_vector(0 to 3071);
    variable len      : integer;
  begin
    usbi <= usbi_none; usbi.linestate <= K_STATE;
    while true loop
      ttoken(clk, 3, TIN, false, false, device_address, conv_std_logic_vector(ep, 4), uiface, dwidth, rand, usbi, hs);
      receivepacket(clk, uiface, dwidth, rand, len, data, TP, usbi, usbo, hs, timeout);
      if (len > 0) then
        if (data(0)(3 downto 0) = not data(0)(7 downto 4)) then
          if (nak and (data(0)(3 downto 0) = TNAK)) or (retryiso and data(0)(3 downto 0) = DATA0 and len = 3) then
            if not msg then
              if (retryiso and data(0)(3 downto 0) = DATA0 and len = 3) then
                if verbose then
                  uprint("Zero byte DATA0 received from isochornous endpoint, retry IN");
                end if;
              else
                if verbose then
                  uprint("NAK received. Device not ready to send data. Trying new IN");
                end if;
              end if;              
              msg := true;
            end if;
            next;
          else
            if (data(0)(3 downto 0) = expected) then
              case expected is
                when TNAK =>
                  if not msg then
                    uprint("NAK received. Device not ready to send data. Trying new IN");
                    msg := true;
                  end if;
                  next;
                when TSTALL =>
                  uprint("STALL PID received. Aborting receive");
                  err := true;
                  exit;
                when TNYET =>
                  uprint("NYET PID received. Should not be returned for IN tokens. Aborting Receive");
                  TP := false; err := true;
                  exit;
                when DATA0 =>
                  exit;
                when DATA1 =>
                  exit;
                when DATA2 =>
                  exit;
                when others =>
                  uprint("Illegal PID returned for this stage. Aborting Receive");
                  TP := false; err := true;
                  exit;
              end case;
            else 
              uprint("ERROR: Incorrect PID received. Got: " & pidtostr(data(0)(3 downto 0)) & " Expected: " & pidtostr(expected));
              TP := false; err := true;
              exit;
            end if;
          end if;  
        else
          uprint("ERROR: PID and Inverted PID fields do not match");
          TP := False; err := true;
          exit;
        end if;
      else
        uprint("ERROR: Zero length packet received");
        TP := False; err := true;
        exit;
      end if;
    end loop;
    if not err then
      if verbose then
        uprint("Total amount of received bytes: " & tost(len));
      end if;
      if (len-3 /= nbytes) then
        uprint("ERROR: Wrong amount of data accepted. Expected: " & tost(nbytes) & " Got: " & tost(len-3));
        TP := False;
      end if;
      for i in 0 to len-1 loop
        if (i > 0) and (i < len-2) then
          crc := crc16(data(data'low+i), crc);
          if data(data'low+i) /= expdata(expdata'low+i-1) then
            uprint("ERROR in received data. Index: " & tost(i) & " Expected: " & tost(expdata(expdata'low+i-1)) & " got: " & tost(data(data'low+i)));
            TP := false;
          end if;  
        end if;
        if verbose then
          uprint(tost(data(data'low+i)));
        end if;
      end loop;
      if ((not crc(7 downto 0)) /= data(data'low+len-2)) or
         ((not crc(15 downto 8)) /= data(data'low+len-1)) then
        uprint("ERROR: CRC16 checksum do not match");
        TP := False;
      end if;
    end if;
  end rdata;

-----------------------------------------------------------------------------
  -- usb receive data packet procedure
  -- calculates and compare crc16 value

  procedure rdata(
    signal   clk            : in    std_ulogic;
    constant expected       : in    std_logic_vector(3 downto 0);
    constant nak            : in    boolean := false;
    constant nbytes         : in    integer;
    constant expdata        : in    octet_vector; 
    constant ep             : in    integer; 
    constant device_address : in    std_logic_vector(6 downto 0);
    signal   rand           : in    std_logic_vector(7 downto 0);
    constant uiface         : in    integer;
    constant dwidth         : in    integer;
    signal   usbi           : out   grusb_in_type;
    signal   usbo           : in    grusb_out_type;
    variable TP             : inout boolean;
    constant verbose        : in    boolean;
    signal   hs             : in    std_ulogic;
    constant retryiso       : in    boolean;  -- set to true only when a
                                              -- zero byte DATA0 response
                                              -- from a  isochronous ep
                                              -- should lead to a retry of
                                              -- the IN
    variable timeout        : out   boolean;
    variable recdata        : out   octet_vector;
    constant checkdata      : in    boolean) is

    variable res   : boolean                      := false;
    variable crc      : std_logic_vector(15 downto 0) := X"FFFF";
    variable s        : line;
    variable bytes    : integer                       := 0;
    variable msg      : boolean                       := false;
    variable dout     : std_logic_vector(7 downto 0);
    variable err      : boolean                       := false;
    constant str      : string                        := ", ";
    variable data     : octet_vector(0 to 3071);
    variable len      : integer;
  begin
    usbi <= usbi_none; usbi.linestate <= K_STATE;
    while true loop
      ttoken(clk, 3, TIN, false, false, device_address, conv_std_logic_vector(ep, 4), uiface, dwidth, rand, usbi, hs);
      receivepacket(clk, uiface, dwidth, rand, len, data, TP, usbi, usbo, hs, timeout);
      if (len > 0) then
        if (data(0)(3 downto 0) = not data(0)(7 downto 4)) then
          if (nak and (data(0)(3 downto 0) = TNAK)) or (retryiso and data(0)(3 downto 0) = DATA0 and len = 3) then
            if not msg then
              if (retryiso and data(0)(3 downto 0) = DATA0 and len = 3) then
                if verbose then
                  uprint("Zero byte DATA0 received from isochornous endpoint, retry IN");
                end if;
              else
                if verbose then
                  uprint("NAK received. Device not ready to send data. Trying new IN");
                end if;
              end if;              
              msg := true;
            end if;
            next;
          else
            if (data(0)(3 downto 0) = expected) then
              case expected is
                when TNAK =>
                  if not msg then
                    uprint("NAK received. Device not ready to send data. Trying new IN");
                    msg := true;
                  end if;
                  next;
                when TSTALL =>
                  uprint("STALL PID received. Aborting receive");
                  err := true;
                  exit;
                when TNYET =>
                  uprint("NYET PID received. Should not be returned for IN tokens. Aborting Receive");
                  TP := false; err := true;
                  exit;
                when DATA0 =>
                  exit;
                when DATA1 =>
                  exit;
                when DATA2 =>
                  exit;
                when others =>
                  uprint("Illegal PID returned for this stage. Aborting Receive");
                  TP := false; err := true;
                  exit;
              end case;
            else 
              uprint("ERROR: Incorrect PID received. Got: " & pidtostr(data(0)(3 downto 0)) & " Expected: " & pidtostr(expected));
              TP := false; err := true;
              exit;
            end if;
          end if;  
        else
          uprint("ERROR: PID and Inverted PID fields do not match");
          TP := False; err := true;
          exit;
        end if;
      else
        uprint("ERROR: Zero length packet received");
        TP := False; err := true;
        exit;
      end if;
    end loop;
    if not err then
      if verbose then
        uprint("Total amount of received bytes: " & tost(len));
      end if;
      if (len-3 /= nbytes) then
        uprint("ERROR: Wrong amount of data accepted. Expected: " & tost(nbytes) & " Got: " & tost(len-3));
        TP := False;
      end if;
      for i in 0 to len-1 loop
        if (i > 0) and (i < len-2) then
          crc := crc16(data(data'low+i), crc);
          if checkdata then
            if data(data'low+i) /= expdata(expdata'low+i-1) then
              uprint("ERROR in received data. Index: " & tost(i) & " Expected: " & tost(expdata(expdata'low+i-1)) & " got: " & tost(data(data'low+i)));
              TP := false;
            end if;
          end if;
          recdata(recdata'low+i-1) := data(data'low+i);
        end if;
        if verbose then
          uprint(tost(data(data'low+i)));
        end if;
      end loop;
      if ((not crc(7 downto 0)) /= data(data'low+len-2)) or
         ((not crc(15 downto 8)) /= data(data'low+len-1)) then
        uprint("ERROR: CRC16 checksum do not match");
        TP := False;
      end if;
    end if;
  end rdata;  

  ---------------------------------------------------------------------------
  -- usb transmit handshake procedure
  -- sends specified handshake packet

  procedure shandshake (
    signal   clk    : in  std_ulogic;
    constant hpid   : in  std_logic_vector(3 downto 0);
    constant uiface : in  integer;
    constant dwidth : in  integer;
    signal   rand   : in  std_logic_vector(7 downto 0);
    signal   usbi   : out grusb_in_type;
    signal   hs     : in std_ulogic) is
    variable p      : octet_vector(0 to 0);
  begin
    p(0) := not hpid & hpid;
    sendpacket(clk, 1, p, uiface, dwidth, rand, usbi, hs);
  end shandshake;

  -----------------------------------------------------------------------------
  -- get device status
  procedure getstatus (
    constant dir            : in    std_logic_vector(3 downto 0);
    constant stall          : in    boolean := false;
    constant nak            : in    boolean := true;
    signal   clk            : in    std_ulogic;
    signal   usbo           : in    grusb_out_type;
    signal   usbi           : out   grusb_in_type;
    constant ep             : in    integer;
    signal   rand           : in    std_logic_vector(7 downto 0);
    constant uiface         : in    integer;
    constant dwidth         : in    integer;
    constant device_address : in    std_logic_vector(6 downto 0);
    variable TP             : inout boolean;
    signal   hs             : in    std_ulogic;
    variable timeout        : out   boolean) is
    variable pid            : std_logic_vector(3 downto 0);
    variable data           : octet_vector(0 to 0);
    variable gotnak         : boolean;
  begin
    if dir = TIN then
      if stall then
        pid := TSTALL;
      else
        pid := DATA1;
      end if;
      rdata(clk, pid, nak, 0, data, ep, device_address, rand,
            uiface, dwidth, usbi, usbo, TP, false, hs, false, timeout);
      shandshake(clk, TACK, uiface, dwidth, rand, usbi, hs);
    elsif dir = TOUT then
      if stall then
        pid := TSTALL;
      else
        pid := TACK; 
      end if;
      gotnak := true;
      while gotnak loop
        ttoken(clk, 3, TOUT, false, false, device_address, conv_std_logic_vector(ep, 4), uiface, dwidth, rand, usbi, hs);
        tdata(clk, DATA1, false, false, data(0 to 0), 0, rand, uiface, dwidth, usbi, hs);
        rhandshake (clk, pid, false, nak, rand, uiface, dwidth, usbi, usbo, TP, gotnak, hs, timeout);
      end loop;
    end if;
  end getstatus;
  
  procedure hs_handshake (
    signal clk  : in std_ulogic;
    signal usbi : out grusb_in_type;
    signal usbo : in grusb_out_type;
    signal uctrl : out uctrl_type;
    signal hs : in std_ulogic;
    constant uiface : in integer) is
  begin
    usbi.linestate <= SE0;
    if uiface = 1 then
      gen_rxcmd(clk,usbi,RXCMD_se0state);
      accept_regwrite(clk,usbi,usbo,uctrl);
      if usbo.xcvrselect(0) = '1' then
        wait until usbo.xcvrselect(0) = '0';
      end if;
    else
      wait until usbo.xcvrselect(0) = '0';
    end if;                  

    if uiface = 0 then
      if usbo.txvalid = '0' then wait until usbo.txvalid = '1'; end if;
    else
      if usbo.dataout(7 downto 0) = "00000000" then
        wait until usbo.dataout(7 downto 0) /= "00000000";
      end if;           
    end if;

    if uiface = 0 then
      usbi.txready <= '1'; usbi.linestate <= K_STATE;
      wait until usbo.txvalid = '0';
      usbi.linestate <= K_STATE;
      usbi.txready <= '0'; 
    else
      wait until rising_edge(clk);
      usbi.nxt <= '1';
      wait until rising_edge(usbo.stp);
      wait until rising_edge(clk);
      usbi.nxt <= '0';      
    end if;
       
    wait for 50 us; 
    
    for i in 0 to 5 loop
      if (i mod 2) = 0 then
        usbi.linestate <= K_STATE;
        if uiface = 1 then
          gen_rxcmd(clk,usbi,RXCMD_kstate);
        end if;
      else
        usbi.linestate <= J_STATE;
        if uiface = 1 then
          gen_rxcmd(clk,usbi,RXCMD_jstate);
        end if;
      end if;
      if uiface = 1 then
        if i = 5 then
          accept_regwrite(clk,usbi,usbo,uctrl);
        end if;
      end if;         
      wait for 45 us;
    end loop;
    usbi.linestate <= SE0;
    if uiface = 1 then
      gen_rxcmd(clk,usbi,RXCMD_se0state);
    else
      if usbo.termselect /= '0' then 
        wait until usbo.termselect = '0';
      end if;
    end if;    
  end hs_handshake;

end usbsim;
