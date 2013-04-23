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
-- Entity:      ddr2sp16a
-- File:        ddr2sp16a.vhd
-- Author:      Nils-Johan Wessman - Gaisler Research
-- Description: 16-bit DDR2 memory controller with asynch AHB interface
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
library gaisler;
use grlib.devices.all;
use gaisler.memctrl.all;
library techmap;
use techmap.gencomp.all;

entity ddr2sp16a is
   generic (
      memtech    : integer := 0;
      hindex     : integer := 0;
      haddr      : integer := 0;
      hmask      : integer := 16#f00#;
      ioaddr     : integer := 16#000#;
      iomask     : integer := 16#fff#;
      MHz        : integer := 100;
      TRFC       : integer := 130;
      col        : integer := 9;
      Mbyte      : integer := 8;
      fast       : integer := 0;
      pwron      : integer := 0;
      oepol      : integer := 0;
      readdly    : integer := 1;
      odten      : integer := 0;
      octen      : integer := 0;
      dqsgating  : integer := 0;
      nosync     : integer := 0;
      eightbanks : integer range 0 to 1 := 0; -- Set to 1 if 8 banks instead of 4
      dqsse      : integer range 0 to 1 := 0  -- single ended DQS
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
end;

architecture rtl of ddr2sp16a is

constant REVISION  : integer := 0;

constant CMD_PRE  : std_logic_vector(2 downto 0) := "010";
constant CMD_REF  : std_logic_vector(2 downto 0) := "100";
constant CMD_LMR  : std_logic_vector(2 downto 0) := "110";
constant CMD_EMR  : std_logic_vector(2 downto 0) := "111";

constant odtvalue : std_logic_vector(1 downto 0) := conv_std_logic_vector(odten, 2);

constant abuf : integer := 6;

constant hconfig : ahb_config_type := (
   0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_DDR2SP, 0, REVISION, 0),
   4 => ahb_membar(haddr, '1', '1', hmask),
   5 => ahb_iobar(ioaddr, iomask),
   others => zero32);

type mcycletype is (midle, active, ext, leadout);
type ahb_state_type is (midle, rhold, dread, dwrite, whold1, whold2);
type sdcycletype is (act1, act2, act3, rd1, rd2, rd3, rd4, rd5, rd6, rd7, rd8,
             wr0, wr1, wr2, wr3, wr4a, wr4b, wr4, wr5, sidle, ioreg1, ioreg2, ioreg3);
type icycletype is (iidle, pre, ref1, ref2, emode23, emode, lmode, emodeocd, finish);

-- sdram configuration register

type sdram_cfg_type is record
   command     : std_logic_vector(2 downto 0);
   csize       : std_logic_vector(1 downto 0);
   bsize       : std_logic_vector(2 downto 0);
   trcd        : std_ulogic;  -- tCD : 2/3 clock cycles
   trfc        : std_logic_vector(4 downto 0);
   trp         : std_ulogic;  -- precharge to activate: 2/3 clock cycles
   refresh     : std_logic_vector(11 downto 0);
   renable     : std_ulogic;
   dllrst      : std_ulogic;
   refon       : std_ulogic;
   cke         : std_ulogic;
   cal_en      : std_logic_vector(7 downto 0);
   cal_inc     : std_logic_vector(7 downto 0);
   cal_pll     : std_logic_vector(1 downto 0);  -- *** ??? pll_reconf
   cal_rst     : std_logic;
   readdly     : std_logic_vector(1 downto 0);
   twr         : std_logic_vector(4 downto 0);
   emr         : std_logic_vector(1 downto 0); -- selects EM register
   ocd         : std_ulogic; -- enable/disable ocd
   dqsctrl    : std_logic_vector(7 downto 0);
   eightbanks : std_ulogic;
end record;

type access_param is record
   haddr       : std_logic_vector(31 downto 0);
   size        : std_logic_vector(1 downto 0);
   hwrite      : std_ulogic;
   hio         : std_ulogic;
end record;

-- local registers

type ahb_reg_type is record
   hready      : std_ulogic;
   hsel        : std_ulogic;
   hio         : std_ulogic;
   startsd     : std_ulogic;
   write       : std_ulogic;
   state       : ahb_state_type;
   haddr       : std_logic_vector(31 downto 0);
   hrdata      : std_logic_vector(31 downto 0);
   hwrite      : std_ulogic;
   htrans      : std_logic_vector(1 downto 0);
   hresp       : std_logic_vector(1 downto 0);
   raddr       : std_logic_vector(abuf-1 downto 0);
   size        : std_logic_vector(1 downto 0);
   acc         : access_param;
   sync        : std_logic_vector(2 downto 1);
   startsd_ack : std_logic;
end record;

type ddr_reg_type is record
   startsd     : std_ulogic;
   startsdold  : std_ulogic;
   burst       : std_ulogic;
   hready      : std_ulogic;
   bdrive      : std_ulogic;
   qdrive      : std_ulogic;
   nbdrive     : std_ulogic;
   mstate      : mcycletype;
   sdstate     : sdcycletype;
   cmstate     : mcycletype;
   istate      : icycletype;
   trfc        : std_logic_vector(4 downto 0);
   refresh     : std_logic_vector(11 downto 0);
   sdcsn       : std_logic_vector(1  downto 0);
   sdwen       : std_ulogic;
   rasn        : std_ulogic;
   casn        : std_ulogic;
   dqm         : std_logic_vector(3 downto 0);
   dqm_dly     : std_logic_vector(3 downto 0);  -- *** ??? delay ctrl
   address     : std_logic_vector(15 downto 2);  -- memory address
   ba          : std_logic_vector(2  downto 0);
   waddr       : std_logic_vector(abuf-1 downto 0);
   waddr_d     : std_logic_vector(abuf-1 downto 0); -- Same as waddr but delayed to compensate for pipelined output data
   cfg         : sdram_cfg_type;
   readdly     : std_logic_vector(1 downto 0); -- added read latency
   newcom      : std_logic; -- start sec. read/write
   wdata       : std_logic_vector(31 downto 0);
   initnopdly  : std_logic_vector(7 downto 0); -- 400 ns delay
   sync        : std_logic;
   odt         : std_logic_vector(1 downto 0);
   sdo_bdrive  : std_logic; -- *** ??? delay ctrl
   sdo_qdrive  : std_logic; -- *** ??? delay ctrl
   oct         : std_logic;
   dqsctrl     : std_logic_vector(6 downto 0);
   dqsgate     : std_ulogic;
end record;

constant ramwt : integer := 0;
signal vcc, rwrite : std_ulogic;
signal r, ri : ddr_reg_type;
signal ra, rai : ahb_reg_type;
signal rdata, wdata, rwdata, rbdrive, ribdrive : std_logic_vector(31 downto 0);
signal hwdata : std_logic_vector(31 downto 0);
signal waddr2 : std_logic_vector(abuf-1 downto 0);
signal ddr_rst : std_logic;
signal ddr_rst_gen  : std_logic_vector(3 downto 0);
signal dqsgate180   : std_ulogic;
attribute syn_preserve : boolean;
attribute syn_preserve of rbdrive : signal is true;

begin

   vcc <= '1';

   ddr_rst <= (ddr_rst_gen(3) and ddr_rst_gen(2) and ddr_rst_gen(1) and rst); -- Reset signal in DDR clock domain

   ahb_ctrl : process(rst, ahbsi, r, ra, rdata)
   variable v       : ahb_reg_type;		-- local variables for registers
   variable startsd : std_ulogic;
   variable dout    : std_logic_vector(31 downto 0);
   variable ready   : std_logic;
   begin

      v := ra; v.hrdata := rdata; v.hresp := HRESP_OKAY; 
      v.write := '0';

      -- Sync ------------------------------------------------
      if nosync = 0 then
        v.sync(1) := r.startsdold; v.sync(2) := ra.sync(1);
        ready := ra.startsd_ack xor ra.sync(2);
      else
        v.sync(1) := r.startsdold; v.sync(2) := '0';
        ready := ra.startsd_ack xor r.startsdold;
      end if;
      --------------------------------------------------------

      if ((ahbsi.hready and ahbsi.hsel(hindex)) = '1') then
         v.htrans := ahbsi.htrans; v.haddr := ahbsi.haddr;
         v.size := ahbsi.hsize(1 downto 0); v.hwrite := ahbsi.hwrite;
         if ahbsi.htrans(1) = '1' then
            v.hio := ahbsi.hmbsel(1);
            v.hsel := '1'; v.hready := '0';
         end if;
      end if;

      if ahbsi.hready = '1' then v.hsel := ahbsi.hsel(hindex); end if;

      case ra.state is
      when midle =>
         if ((v.hsel and v.htrans(1)) = '1') then
            if v.hwrite = '0' then
               v.state := rhold; v.startsd := not ra.startsd;
            else v.state := dwrite; v.hready := '1'; v.write := '1'; end if;
         end if;
         v.raddr := ra.haddr(7 downto 2);
         if ahbsi.hready = '1' then
            v.acc := (v.haddr, v.size, v.hwrite, v.hio);
         end if;
      when rhold =>
         v.raddr := ra.haddr(7 downto 2);
 	 if (nosync = 1) and (ra.haddr(4 downto 3) = "11") and (ramwt = 0) then
            ready := ra.startsd_ack xor ra.sync(1);
 	 end if;
         if ready = '1' then 
            v.state := dread; v.hready := '1'; v.raddr := ra.raddr + 1;
         end if;
      when dread =>
         v.raddr := ra.raddr + 1; v.hready := '1';
         if ((v.hsel and v.htrans(1) and v.htrans(0)) = '0')
            or (ra.raddr(2 downto 0) = "000") or (ra.hio = '1') then
            v.state := midle; v.hready := not (v.hsel and v.htrans(1));
            if (v.hsel and v.htrans(1) and v.hwrite) = '1' then
               v.state := dwrite; v.hready := '1'; v.write := '1';
            end if;
            v.startsd_ack := ra.startsd; 
         end if;
         v.acc := (v.haddr, v.size, v.hwrite, v.hio);
      when dwrite => 
         v.raddr := ra.haddr(7 downto 2); v.write := '1'; v.hready := '1';
         if ((v.hsel and v.htrans(1) and v.htrans(0)) = '0') or (ra.hio = '1') 
            or ((ra.haddr(4 downto 2) = "111") and (ra.write = '1')) then
            v.startsd := not ra.startsd; v.state := whold1;
            v.write := '0'; v.hready := not (v.hsel and v.htrans(1));
         end if;
      when whold1 =>
         v.state := whold2; 
      when whold2 =>
         if ready = '1' then 
            v.state := midle; v.acc := (v.haddr, v.size, v.hwrite, v.hio);
            v.startsd_ack := ra.startsd; 
         end if;
      end case;

      if (ahbsi.hready and ahbsi.hsel(hindex) ) = '1' then
         if ahbsi.htrans(1) = '0' then v.hready := '1'; end if;
      end if;

      dout := ra.hrdata(31 downto 0);

      if rst = '0' then
         v.hsel         := '0';
         v.hready       := '1';
         v.state        := midle;
         v.startsd      := '0';
         v.startsd_ack  := '0';
         v.hio          := '0';
      end if;

      rai <= v;
      ahbso.hready  <= ra.hready;
      ahbso.hresp   <= ra.hresp;
      ahbso.hrdata  <= ahbdrivedata(dout);

   end process;

   ddr_ctrl : process(ddr_rst, r, ra, sdi, rbdrive, wdata)
   variable v       : ddr_reg_type;    -- local variables for registers
   variable startsd : std_ulogic;
   variable dataout : std_logic_vector(31 downto 0); -- data from memory
   variable dqm     : std_logic_vector(3 downto 0);
   variable raddr   : std_logic_vector(13 downto 0);
   variable adec    : std_ulogic;
   variable rams    : std_logic_vector(1 downto 0);
   variable ba      : std_logic_vector(2 downto 0);
   variable haddr   : std_logic_vector(31 downto 0);
   variable hsize   : std_logic_vector(1 downto 0);
   variable hwrite  : std_ulogic;
   variable htrans  : std_logic_vector(1 downto 0);
   variable hready  : std_ulogic;
   variable vbdrive : std_logic_vector(31 downto 0);
   variable bdrive  : std_ulogic; 
   variable writecfg: std_ulogic; 
   variable regsd   : std_logic_vector(31 downto 0);   -- data from registers
   variable readdata: std_logic_vector(31 downto 0);   -- data from DDR
   begin

-- Variable default settings to avoid latches

      v := r; v.hready := '0'; writecfg := '0'; vbdrive := rbdrive; 
      readdata := sdi.data(31 downto 0); 
      v.qdrive :='0';
      v.cfg.cal_en    :=  (others => '0'); v.cfg.cal_inc   :=  (others => '0');
      v.cfg.cal_pll   :=  (others => '0');                                            -- *** ??? pll_reconf
      v.cfg.cal_rst   :=  '0';
      v.wdata := wdata; -- pipeline output data
      v.dqm_dly := r.dqm;                                                             -- *** ??? delay ctrl

      regsd := (others => '0');
      if ra.acc.haddr(3 downto 2) = "00" then
         regsd(31 downto 15) := r.cfg.refon & r.cfg.ocd & r.cfg.emr & '0' & r.cfg.trcd &
                                r.cfg.bsize & r.cfg.csize & r.cfg.command &
                                r.cfg.dllrst & r.cfg.renable & r.cfg.cke; 
         regsd(11 downto 0) := r.cfg.refresh;
      elsif ra.acc.haddr(3 downto 2) = "01" then
         regsd(8 downto 0) := conv_std_logic_vector(MHz, 9);
         regsd(14 downto 12) := conv_std_logic_vector(1, 3);
      elsif ra.acc.haddr(3 downto 2) = "10" then
         regsd(17 downto 16) := r.cfg.readdly;
         regsd(22 downto 18) := r.cfg.trfc;
         regsd(27 downto 23) := r.cfg.twr;
         regsd(28) := r.cfg.trp;
      else
        if dqsgating = 1 then regsd(7 downto 0) := r.cfg.dqsctrl; end if;
        regsd(8) := r.cfg.eightbanks;
      end if;


-- generate DQM from address and write size

      case ra.acc.size is
      when "00" =>
         case ra.acc.haddr(1 downto 0) is
         when "00" => dqm := "0111";
         when "01" => dqm := "1011";
         when "10" => dqm := "1101";
         when others => dqm := "1110";
         end case;
      when "01" =>
         if ra.acc.haddr(1) = '0' then dqm := "0011"; else  dqm := "1100"; end if;
      when others => dqm := "0000";
      end case;

      -- Sync ------------------------------------------
       if nosync = 0 then
        v.sync := ra.startsd; v.startsd := r.sync;
      else
        v.sync := '0'; v.startsd := '0';
      end if;
      --------------------------------------------------

      --v.startsd := ra.startsd;

---- main FSM
--
--      case r.mstate is
--      when midle =>
--         if  r.startsd = '1' then
--            if (r.sdstate = sidle) and (r.cfg.command = "000") 
--               and (r.cmstate = midle) then
--               startsd := '1'; v.mstate := active;
--            end if;
--         end if;
--      when others => null;
--      end case;

      if nosync = 0 then
        startsd := r.startsd xor r.startsdold;
      else
        startsd := ra.startsd xor r.startsdold;
      end if;

-- generate row and column address size

      haddr := ra.acc.haddr;
      haddr(31 downto 20) := haddr(31 downto 20) and not conv_std_logic_vector(hmask, 12);

      case r.cfg.csize is
      when "00" => raddr := haddr(23 downto 10);
      when "01" => raddr := haddr(24 downto 11);
      when "10" => raddr := haddr(25 downto 12);
      when others => raddr := haddr(26 downto 13);
      end case;

-- generate bank address

      if r.cfg.eightbanks = '0' then
        ba := '0' &
              genmux(r.cfg.bsize, haddr(29 downto 22)) &
              genmux(r.cfg.bsize, haddr(28 downto 21));
      else
        ba := genmux(r.cfg.bsize, haddr(29 downto 22)) &
              genmux(r.cfg.bsize, haddr(28 downto 21)) &
              genmux(r.cfg.bsize, haddr(27 downto 20));
      end if;

-- generate chip select

      adec := genmux(r.cfg.bsize, haddr(30 downto 23));

      rams := adec & not adec;

-- sdram access FSM

      if r.trfc /= "00000" then v.trfc := r.trfc - 1; end if;

      -- DQS strobe enable control
      if dqsgating = 1 then
        if r.dqsctrl(6) = '1' then
          v.dqsgate := '1';
        elsif r.dqsctrl = "0000000" then
          v.dqsgate := '1';
        end if;
        if r.dqsctrl(6) /= '1' then 
          v.dqsctrl := r.dqsctrl - '1';
        end if;
      end if;

      case r.sdstate is
      when sidle =>
         v.oct := '0';
         if (startsd = '1') and (r.cfg.command = "000") and (r.cmstate = midle)
            and (r.istate = finish) then
            v.address := raddr; v.ba := ba;
            if ra.acc.hio = '0' then
               v.sdcsn := not rams(1 downto 0); v.rasn := '0'; v.sdstate := act1;
            else v.sdstate := ioreg1; end if;
         end if;
         v.waddr := ra.acc.haddr(7 downto 2);
      when act1 =>
         v.rasn := '1'; v.trfc := r.cfg.trfc;
         if r.cfg.trcd = '1' then v.sdstate := act2; 
         else v.sdstate := act3; 
         end if;
         --v.waddr := ra.acc.haddr(7 downto 2);
         v.waddr := ra.acc.haddr(7 downto 3) & '0'; --& ra.acc.haddr(2);
         v.waddr_d := ra.acc.haddr(7 downto 3) & '0'; --& ra.acc.haddr(2);
         if ra.acc.hwrite = '1' then
           if odten /= 0 then v.odt := (others => '1'); end if; -- *** ??? odt
         end if;
      when act2 =>
         v.sdstate := act3; 
      when act3 =>
         v.casn := '0'; 
         --v.address := ra.acc.haddr(13 downto 11) & '0' & ra.acc.haddr(10 downto 2) & '0';
         v.address := ra.acc.haddr(13 downto 11) & '0' & ra.acc.haddr(10 downto 3) & "00";
         v.hready := ra.acc.hwrite;
         if ra.acc.hwrite = '1' then
            v.sdstate := wr0;
            v.sdwen := '0'; 
            --v.waddr := r.waddr + 1;                           -- *** ??? delay ctrl
            v.trfc := r.cfg.twr;
         else 
           v.sdstate := rd1; 
           if dqsgating = 1 then
             v.dqsctrl := r.cfg.dqsctrl(7 downto 1); v.dqsgate := '0';
           end if;
         end if;
         v.burst := '0';
      when wr0 =>
         v.casn := '1'; v.sdwen := '1'; v.bdrive := '0'; v.qdrive := '1';
         if r.waddr_d = ra.acc.haddr(7 downto 2) then
            v.dqm := dqm;
            v.waddr_d := r.waddr_d + 1;
            v.waddr := r.waddr + 1;
            v.sdstate := wr1;
            if (r.waddr_d /= ra.raddr) then v.hready := '1'; end if;
         else
            v.burst := '1';
            v.waddr_d := r.waddr_d + 1;
            v.waddr := r.waddr + 1;
            v.dqm := (others => '1');
         end if;
         if r.burst = '1' and r.address(5 downto 4) < ra.raddr(2 downto 1) then
            v.address(5 downto 4) := r.address(5 downto 4) + 1;
            v.sdwen := '0'; v.casn := '0';
            v.trfc := r.cfg.twr;
         end if;
      when wr1 =>
         v.sdwen := '1';  v.casn := '1';  v.qdrive := '1';
         v.waddr_d := r.waddr_d + 1;
         v.waddr := r.waddr + 1;
         if (r.waddr_d <= ra.raddr) and (r.waddr_d /= "000000") and (r.hready = '1') then
            v.hready := '1';
            v.burst := '0';
            if r.burst = '0' and r.address(5 downto 4) < ra.raddr(2 downto 1) then
               v.address(5 downto 4) := r.address(5 downto 4) + 1;
               v.sdwen := '0'; v.casn := '0';
               v.trfc := r.cfg.twr;
               v.burst := '1';
            end if;
         else
            v.sdstate := wr2;
            v.dqm := (others => '1');
            if nosync = 0 then
              v.startsdold := r.startsd;
            else
              v.startsdold := ra.startsd;
            end if;   
         end if;
      when wr2 =>
         v.sdstate := wr3; v.qdrive := '1';
      when wr3 =>
         v.sdstate := wr4a; v.qdrive := '1';
      when wr4a =>
         v.bdrive := '1'; v.qdrive := '1';
         if r.trfc = "00000" then -- wait to not violate TWR timing
            v.sdstate := wr4b;
         end if;
      when wr4b =>
         v.bdrive := '1'; 
         v.rasn := '0'; v.sdwen := '0'; v.sdstate := wr4; v.qdrive := '1';
      when wr4 =>
         v.sdcsn := "11"; v.rasn := '1'; v.sdwen := '1';  v.qdrive := '0';
         v.sdstate := wr5;
      when wr5 =>
         v.odt := (others => '0'); -- *** ??? odt
         v.sdstate := sidle;
      when rd1 =>
         if octen = 1 then v.oct := '1'; end if;
         v.casn := '1'; v.sdstate := rd7;
         v.newcom := '1';
      when rd7 =>
         v.casn := '1'; v.sdstate := rd8; 
         --v.readdly := r.cfg.readdly;
         v.readdly := r.cfg.readdly + 1;                                              -- *** ??? delay ctrl
         v.newcom := not r.newcom;
         if r.address(5 downto 4) /= "11" then
            v.casn := '0'; v.burst := '1'; v.address(5 downto 4) := r.address(5 downto 4) + 1;
            if dqsgating = 1 then
              v.dqsctrl := r.cfg.dqsctrl(7 downto 1);
            end if;
         end if;
      when rd8 => -- (CL = 3)
         v.casn := '1'; 
         v.newcom := not r.newcom;
         if r.readdly = "00" then -- add read delay 
            v.sdstate := rd2;
         else
            v.readdly := r.readdly - 1;
         end if;
         if r.address(5 downto 4) /= "11" and r.newcom = '1' then
            v.casn := '0'; v.burst := '1'; v.address(5 downto 4) := r.address(5 downto 4) + 1;
            if dqsgating = 1 then
              v.dqsctrl := r.cfg.dqsctrl(7 downto 1);
            end if;
         end if;
      when rd2 =>
         v.casn := '1'; v.sdstate := rd3;
         v.newcom := not r.newcom;
         if r.address(5 downto 4) /= "11" and r.newcom = '1' then 
            v.casn := '0'; v.burst := '1'; v.address(5 downto 4) := r.address(5 downto 4) + 1;
            if dqsgating = 1 then
              v.dqsctrl := r.cfg.dqsctrl(7 downto 1);
            end if;
         end if;
      when rd3 =>
         if nosync = 0 then
           if fast = 0 then v.startsdold := r.startsd; end if;
         end if;
         v.sdstate := rd4; v.hready := '1'; v.casn := '1';
         v.newcom := not r.newcom;
         if r.sdwen = '0' then
            v.rasn := '1'; v.sdwen := '1'; v.sdcsn := "11"; v.dqm := (others => '1');
         end if;
         if v.hready = '1' then v.waddr := r.waddr + 1; end if;
         if r.address(5 downto 4) /= "11" and r.newcom = '1' then
            v.casn := '0'; v.burst := '1'; v.address(5 downto 4) := r.address(5 downto 4) + 1;
            if dqsgating = 1 then
              v.dqsctrl := r.cfg.dqsctrl(7 downto 1);
            end if;
         end if;
      when rd4 =>
         v.hready := '1'; v.casn := '1';
         v.newcom := not r.newcom;
         if (r.sdcsn /= "11") and (r.waddr(1 downto 0) = "11") and (r.burst = '1') then
            v.burst := '0';
         elsif (r.sdcsn = "11") or (r.waddr(1 downto 0) = "11") then
            v.dqm := (others => '1'); v.burst := '0';
            if nosync = 0 then
              if fast /= 0 then v.startsdold := r.startsd; end if;
            else
              v.startsdold := ra.startsd;
            end if;
            if (r.sdcsn /= "11") then
               v.rasn := '0'; v.sdwen := '0'; v.sdstate := rd5;
            else
               if r.cfg.trp = '1' then v.sdstate := rd6;
               else v.sdstate := sidle; end if;
            end if;
         end if;
         if v.hready = '1' then v.waddr := r.waddr + 1; end if;
         if r.address(5 downto 4) /= "11" and r.newcom = '1' then
            v.casn := '0'; v.burst := '1'; v.address(5 downto 4) := r.address(5 downto 4) + 1;
            if dqsgating = 1 then
              v.dqsctrl := r.cfg.dqsctrl(7 downto 1);
            end if;
         end if;
      when rd5 =>
         if r.cfg.trp = '1' then v.sdstate := rd6;
         else v.sdstate := sidle; end if;
         v.sdcsn := (others => '1'); v.rasn := '1'; v.sdwen := '1';
         v.dqm := (others => '1');
      when rd6 =>
         v.sdstate := sidle; v.dqm := (others => '1');
         v.sdcsn := (others => '1'); v.rasn := '1'; v.sdwen := '1';
      when ioreg1 =>
         readdata := regsd;
         if nosync = 0 then v.sdstate := ioreg3; else v.sdstate := ioreg2; end if;
         if ra.acc.hwrite = '0' then v.hready := '1'; end if;
      when ioreg2 =>
         v.sdstate := ioreg3;
      when ioreg3 =>
         readdata := regsd; 
         writecfg := ra.acc.hwrite;
         if nosync = 0 then
           v.startsdold := r.startsd;
         else
           v.startsdold := ra.startsd;
         end if;
         v.sdstate := sidle;
      when others =>
         v.sdstate := sidle;
      end case;

-- sdram commands

      case r.cmstate is
      when midle =>
         if r.sdstate = sidle then
            case r.cfg.command is
            when CMD_PRE => -- precharge
               v.sdcsn := (others => '0'); v.rasn := '0'; v.sdwen := '0';
               v.address(12) := '1'; v.cmstate := active;
            when CMD_REF => -- auto-refresh
               v.sdcsn := (others => '0'); v.rasn := '0'; v.casn := '0';
               v.cmstate := active;
            when CMD_EMR => -- load-ext-mode-reg
               v.sdcsn := (others => '0'); v.rasn := '0'; v.casn := '0';
               v.sdwen := '0'; v.cmstate := active; v.ba := '0' & r.cfg.emr; --v.ba := "01";
               --v.address := "0000"&r.cfg.ocd&r.cfg.ocd&r.cfg.ocd&"0000000"; 
               if r.cfg.emr = "01" then
                 v.address := "000"&conv_std_logic(dqsse=1)&r.cfg.ocd&r.cfg.ocd&r.cfg.ocd
                              & odtvalue(1)&"000"&odtvalue(0)&"00"; 
               else
                 v.address := "000"&conv_std_logic(dqsse=1)&r.cfg.ocd&r.cfg.ocd&r.cfg.ocd&"0000000"; 
               end if;
            when CMD_LMR => -- load-mode-reg
               v.sdcsn := (others => '0'); v.rasn := '0'; v.casn := '0'; 
               v.sdwen := '0'; v.cmstate := active; v.ba := "000";
               v.address := "00010" & r.cfg.dllrst & "0" & "01" & "10010";  -- CAS = 3 WR = 3
            when others => null;
            end case;
         end if;
      when active =>
         v.sdcsn := (others => '1'); v.rasn := '1'; v.casn := '1'; 
         v.sdwen := '1'; v.cfg.command := "000";
         v.cmstate := leadout; v.trfc := r.cfg.trfc;
      when others =>
         if r.trfc = "00000" then v.cmstate := midle; end if;
      end case;

-- sdram init

      case r.istate is
      when iidle =>
         if r.cfg.renable = '1' then
            v.cfg.cke := '1'; v.cfg.dllrst := '1';
            v.ba := "000"; v.cfg.ocd := '0'; v.cfg.emr := "10"; -- EMR(2)
            if r.cfg.cke = '1' then 
               if r.initnopdly = "00000000" then -- 400 ns of NOP and CKE
                  v.istate := pre; v.cfg.command := CMD_PRE; 
               else
                  v.initnopdly := r.initnopdly - 1;
               end if;
            end if;
         end if;
      when pre =>
         if r.cfg.command = "000" then
            v.cfg.command := "11" & r.cfg.dllrst; -- CMD_LMR/CMD_EMR 
            if r.cfg.dllrst = '1' then v.istate := emode23; else v.istate := lmode; end if;
         end if;
      when emode23 =>
         if r.cfg.command = "000" then
            if r.cfg.emr = "11" then
               v.cfg.emr := "01"; -- (EMR(1))
               v.istate := emode; v.cfg.command := CMD_EMR;
            else
               v.cfg.emr := "11"; v.cfg.command := CMD_EMR; -- EMR(3)
            end if;
         end if;
      when emode =>
         if r.cfg.command = "000" then
            v.istate := lmode; v.cfg.command := CMD_LMR;
         end if;
      when lmode =>
         if r.cfg.command = "000" then
            if r.cfg.dllrst = '1' then
               if r.refresh(9 downto 8) = "00" then -- > 200 clocks delay
                  v.cfg.command := CMD_PRE; v.istate := ref1;
               end if;
            else
               v.istate := emodeocd;
               v.cfg.ocd := '1'; v.cfg.command := CMD_EMR;
            end if;
         end if;
      when ref1 =>
         if r.cfg.command = "000" then
            v.cfg.command := CMD_REF; v.cfg.dllrst := '0'; v.istate := ref2; 
         end if;
      when ref2 =>
         if r.cfg.command = "000" then
            v.cfg.command := CMD_REF; v.istate := pre;
         end if;
      when emodeocd =>
         if r.cfg.command = "000" then
            if r.cfg.ocd = '0' then   -- Exit OCD
               v.istate := finish;
               v.cfg.refon := '1'; v.cfg.renable := '0';
            else                      -- Default OCD
               v.cfg.ocd := '0';      
               v.cfg.command := CMD_EMR;
            end if;
         end if;
         v.cfg.cal_rst   :=  '1'; -- reset data bit delay
      when others =>
         --if odten /= 0 then v.odt := (others => '1'); end if; -- *** ??? odt
         if r.cfg.renable = '1' then
            v.istate := iidle; v.cfg.dllrst := '1';
            v.initnopdly := (others => '1');
            v.odt := (others => '0');
         end if;
      end case;

---- second part of main fsm
--
--      case r.mstate is
--      when active =>
--         if v.hready = '1' then
--            v.mstate := midle;
--         end if;
--      when others => null;
--      end case;

-- sdram refresh counter

      if ((r.cfg.refon = '1') and (r.istate = finish)) or (r.cfg.dllrst = '1') then
         v.refresh := r.refresh - 1;
         if (v.refresh(11) and not r.refresh(11))  = '1' then
            v.refresh := r.cfg.refresh;
            if r.cfg.dllrst = '0' then v.cfg.command := "100"; end if;
         end if;
      end if;

-- AHB register access

      if (ra.acc.hio and ra.acc.hwrite and writecfg) = '1' then
         if r.waddr(1 downto 0) = "00" then
            v.cfg.refresh   :=  r.wdata(11 downto 0);
            v.cfg.cke       :=  r.wdata(15);
            v.cfg.renable   :=  r.wdata(16);
            v.cfg.dllrst    :=  r.wdata(17);
            v.cfg.command   :=  r.wdata(20 downto 18);
            v.cfg.csize     :=  r.wdata(22 downto 21);
            v.cfg.bsize     :=  r.wdata(25 downto 23);
            v.cfg.trcd      :=  r.wdata(26);
            v.cfg.emr       :=  r.wdata(29 downto 28);
            v.cfg.ocd       :=  r.wdata(30);
            v.cfg.refon     :=  r.wdata(31);
         elsif r.waddr(1 downto 0) = "10" then
            v.cfg.cal_en    :=  r.wdata( 7 downto  0);
            v.cfg.cal_inc   :=  r.wdata(15 downto  8);
            v.cfg.readdly   :=  r.wdata(17 downto 16);
            v.cfg.trfc      :=  r.wdata(22 downto 18);
            v.cfg.twr       :=  r.wdata(27 downto 23);
            v.cfg.trp       :=  r.wdata(28);
            v.cfg.cal_pll   :=  r.wdata(30 downto 29);                -- *** ??? pll_reconf
            v.cfg.cal_rst   :=  r.wdata(31);
         elsif r.waddr(1 downto 0) = "11" and (dqsgating=1 or eightbanks=1) then
            v.cfg.dqsctrl(6 downto 0)     :=  r.wdata(6 downto 0);
            v.cfg.eightbanks              :=  r.wdata(8);
         end if;
      end if;

      v.nbdrive := not v.bdrive;

      if oepol = 1 then bdrive := r.nbdrive; vbdrive := (others => v.nbdrive);
      else bdrive := r.bdrive; vbdrive := (others => v.bdrive);end if;

-- reset

      if ddr_rst = '0' then
         v.sdstate      := sidle;
         v.mstate       := midle;
         v.istate       := finish;
         v.cmstate      := midle;
         v.cfg.command  := "000";
         v.cfg.csize    := conv_std_logic_vector(col-9, 2);
         v.cfg.bsize    := conv_std_logic_vector(log2(Mbyte/8), 3);
         v.cfg.refon    :=  '0';
         v.cfg.trfc     := conv_std_logic_vector(TRFC*MHz/1000-2, 5);
         v.cfg.refresh  := conv_std_logic_vector(7800*MHz/1000, 12);
         v.cfg.twr      := conv_std_logic_vector((15)*MHz/1000+3, 5);
         v.refresh      :=  (others => '0');
         v.dqm          := (others => '1');
         v.sdwen        := '1';
         v.rasn         := '1';
         v.casn         := '1';
         v.hready       := '0';
         v.startsd      := '0';
         v.startsdold   := '0';
         v.cfg.dllrst   := '0';
         v.cfg.cke      := '0';
         v.cfg.ocd      := '0';
         v.cfg.readdly  := conv_std_logic_vector(readdly, 2);
         v.initnopdly   := (others => '1');
         if MHz > 130 then v.cfg.trcd :=  '1'; else v.cfg.trcd :=  '0'; end if;
         if MHz > 130 then v.cfg.trp := '1'; else v.cfg.trp := '0'; end if;
         if pwron = 1 then v.cfg.renable :=  '1';
         else v.cfg.renable :=  '0'; end if;
         v.odt          := (others => '0');
         v.oct          := '0';
         if dqsgating = 1 then
           v.cfg.dqsctrl := (others => '0');
           v.dqsctrl     := (others => '0');
           v.dqsgate     := '1';
         end if;
         v.cfg.eightbanks := conv_std_logic_vector(eightbanks, 1)(0);
      end if;
      
      if oepol = 1 then v.sdo_bdrive := r.nbdrive;            -- *** ??? delay ctrl
      else v.sdo_bdrive := r.bdrive; end if;
      v.sdo_qdrive := not (v.qdrive or r.nbdrive);                          

      ri <= v;
      ribdrive <= vbdrive;
      rwdata <= readdata;

   end process;

   sdo.sdcke     <= (others => r.cfg.cke);
   ahbso.hconfig <= hconfig;
   ahbso.hirq    <= (others => '0');
   ahbso.hindex  <= hindex;
   ahbso.hsplit  <= (others => '0');

   ahbregs : process(clk_ahb) begin
      if rising_edge(clk_ahb) then
         ra <= rai;
      end if;
   end process;

   ddrregs : process(clk_ddr, rst, ddr_rst) begin
      if rising_edge(clk_ddr) then
         r <= ri; rbdrive <= ribdrive;
         ddr_rst_gen <= ddr_rst_gen(2 downto 0) & '1'; 
      end if;
      if (rst = '0') then
         ddr_rst_gen <= "0000";
      end if;
      if (ddr_rst = '0') then
         r.sdcsn  <= (others => '1'); r.bdrive <= '1'; r.nbdrive <= '0';
         if oepol = 0 then rbdrive <= (others => '1');
         else rbdrive <= (others => '0'); end if;
         r.cfg.cke <= '0';
         r.sdo_bdrive <= '1';
         r.sdo_qdrive <= '1';
         r.odt <= (others => '0');
      end if;
   end process;

   dqsgate180reg : if dqsgating = 1 generate
     process (clk_ddr)
     begin
       if falling_edge(clk_ddr) then
         dqsgate180 <= r.dqsgate;
       end if;
     end process;
   end generate;

   sdo.address  <= '0' & r.address; --'0' & ri.address;                     -- *** ??? delay ctrl
   sdo.ba       <= r.ba; --ri.ba;                                           -- *** ??? delay ctrl
   sdo.bdrive   <= r.sdo_bdrive; --r.nbdrive when oepol = 1 else r.bdrive;  -- *** ??? delay ctrl
   sdo.qdrive   <= r.sdo_qdrive; --not (ri.qdrive or r.nbdrive);            -- *** ??? delay ctrl
   sdo.vbdrive(31 downto 0) <= rbdrive;
   sdo.sdcsn    <= r.sdcsn; --ri.sdcsn;                                     -- *** ??? delay ctrl
   sdo.sdwen    <= r.sdwen; --ri.sdwen;                                     -- *** ??? delay ctrl
   sdo.dqm      <= "111111111111" & r.dqm_dly; --"111111111111" & r.dqm;    -- *** ??? delay ctrl
   sdo.rasn     <= r.rasn; --ri.rasn;                                       -- *** ??? delay ctrl
   sdo.casn     <= r.casn; --ri.casn;                                       -- *** ??? delay ctrl
   --sdo.data     <= zero32 & zero32 & zero32 & wdata;
   sdo.data     <= zero32 & zero32 & zero32 & r.wdata;

   sdo.cal_en   <= r.cfg.cal_en;
   sdo.cal_inc  <= r.cfg.cal_inc;
   sdo.cal_pll  <= r.cfg.cal_pll;                                           -- *** ??? pll_reconf
   sdo.cal_rst  <= r.cfg.cal_rst;
   sdo.odt      <= r.odt;
   sdo.oct      <= r.oct;
   sdo.dqs_gate <= r.dqsgate when r.cfg.dqsctrl(0) = '0' else
                   dqsgate180;

   hwdata <= ahbreadword(ahbsi.hwdata, ra.haddr(4 downto 2));
   
   read_buff : syncram_2p
   generic map (tech => memtech, abits => 6, dbits => 32, sepclk => 1, wrfst => ramwt)
   port map ( rclk => clk_ahb, renable => vcc, raddress => rai.raddr,
              dataout => rdata, wclk => clk_ddr, write => ri.hready,
              waddress => r.waddr, datain => rwdata);

   write_buff : syncram_2p
   generic map (tech => memtech, abits => 6, dbits => 32, sepclk => 1, wrfst => 0)
   port map ( rclk => clk_ddr, renable => vcc, raddress => r.waddr,
              dataout => wdata, wclk => clk_ahb, write => ra.write,
              waddress => ra.haddr(7 downto 2), datain => hwdata);

-- pragma translate_off
   bootmsg : report_version 
   generic map (
      msg1 => "ddr2sp" & tost(hindex) & ": 16-bit DDR2 controller rev " & 
              tost(REVISION) & ", " & tost(Mbyte) & " Mbyte, " & tost(MHz) &
              " MHz DDR clock");
-- pragma translate_on
end;
