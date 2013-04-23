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
-------------------------------------------------------------------------------
-- Entity:      ahb2mig
-- File:        ahb2mig.vhd
-- Author:      Fredrik Ringhage - Aeroflex Gaisler AB
--
--  This is a AHB-2.0 interface for the Xilinx Virtex-7 MIG.
--
-------------------------------------------------------------------------------

library ieee,work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;

entity ahb2mig is
  generic(
    hindex                  : integer := 0;
    haddr                   : integer := 0;
    hmask                   : integer := 16#f00#;
    pindex                  : integer := 0;
    paddr                   : integer := 0;
    pmask                   : integer := 16#fff#;
    maxwriteburst           : integer := 8;
    maxreadburst            : integer := 8;
    SIM_BYPASS_INIT_CAL     : string := "OFF";
    SIMULATION              : string  := "FALSE";
    USE_MIG_INTERFACE_MODEL : boolean := false
  );
  port(
    ddr3_dq           : inout std_logic_vector(63 downto 0);
    ddr3_dqs_p        : inout std_logic_vector(7 downto 0);
    ddr3_dqs_n        : inout std_logic_vector(7 downto 0);
    ddr3_addr         : out   std_logic_vector(13 downto 0);
    ddr3_ba           : out   std_logic_vector(2 downto 0);
    ddr3_ras_n        : out   std_logic;
    ddr3_cas_n        : out   std_logic;
    ddr3_we_n         : out   std_logic;
    ddr3_reset_n      : out   std_logic;
    ddr3_ck_p         : out   std_logic_vector(0 downto 0);
    ddr3_ck_n         : out   std_logic_vector(0 downto 0);
    ddr3_cke          : out   std_logic_vector(0 downto 0);
    ddr3_cs_n         : out   std_logic_vector(0 downto 0);
    ddr3_dm           : out   std_logic_vector(7 downto 0);
    ddr3_odt          : out   std_logic_vector(0 downto 0);
    ahbso             : out   ahb_slv_out_type;
    ahbsi             : in    ahb_slv_in_type;
    apbi              : in    apb_slv_in_type;
    apbo              : out   apb_slv_out_type;
    calib_done        : out   std_logic;
    rst_n_syn         : in    std_logic;
    rst_n_async       : in    std_logic;
    clk_amba          : in    std_logic;
    sys_clk_p         : in    std_logic;
    sys_clk_n         : in    std_logic;
    ui_clk            : out   std_logic;
    ui_clk_sync_rst   : out   std_logic
   );
end ;

architecture rtl of ahb2mig is

type bstate_type is (idle, start, read_cmd, read_data, read_output, write_cmd, write_burst);

constant hconfig : ahb_config_type := (
   0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_MIGDDR3, 0, 0, 0),
   4 => ahb_membar(haddr, '1', '1', hmask),
   others => zero32);

constant pconfig : apb_config_type := (
  0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_MIGDDR3, 0, 0, 0),
  1 => apb_iobar(paddr, pmask));

type reg_type is record
  bstate          : bstate_type;
  cmd             : std_logic_vector(2 downto 0);
  cmd_en          : std_logic;
  wr_en           : std_logic;
  wr_end          : std_logic;
  cmd_count       : unsigned(6 downto 0);
  wr_count        : unsigned(6 downto 0);
  rd_count        : unsigned(6 downto 0);
  hready          : std_logic;
  hwrite          : std_logic;
  hwdata          : std_logic_vector(31 downto 0);
  hwdata_burst    : std_logic_vector(1023 downto 0);
  mask_burst      : std_logic_vector(127 downto 0);
  htrans          : std_logic_vector(1 downto 0);
  hburst          : std_logic_vector(2 downto 0);
  hsize           : std_logic_vector(2 downto 0);
  hrdata          : std_logic_vector(31 downto 0);
  haddr           : std_logic_vector(31 downto 0);
  haddr_start     : std_logic_vector(31 downto 0);
  haddr_burst     : std_logic_vector(31 downto 0);
  hmaster         : std_logic_vector(3 downto 0);
  int_buffer      : unsigned(1024-1 downto 0);
  rd_buffer       : unsigned(1024-1 downto 0);
  wdf_data_buffer : std_logic_vector(511 downto 0);
  wdf_mask_buffer : std_logic_vector(63 downto 0);
end record;

type mig_in_type is record
  cmd_en          : std_logic;
  app_addr        : std_logic_vector(27 downto 0);
  app_cmd         : std_logic_vector(2 downto 0);
  app_en          : std_logic;
  app_wdf_data    : std_logic_vector(511 downto 0);
  app_wdf_end     : std_logic;
  app_wdf_mask    : std_logic_vector(63 downto 0);
  app_wdf_wren    : std_logic;
end record;

type mig_out_type is record
  app_rd_data       : std_logic_vector(511 downto 0);
  app_rd_data_end   : std_logic;
  app_rd_data_valid : std_logic;
  app_rdy           : std_logic;
  app_wdf_rdy       : std_logic;
end record;

signal r, rin           : reg_type;
signal migin            : mig_in_type;
signal migout,migoutraw : mig_out_type;

component mig is
  generic(
    SIM_BYPASS_INIT_CAL : string := "OFF";
    SIMULATION          : string := "FALSE"
  );
  port (
   ddr3_dq              : inout std_logic_vector(63 downto 0);
   ddr3_addr            : out   std_logic_vector(13 downto 0);
   ddr3_ba              : out   std_logic_vector(2 downto 0);
   ddr3_ras_n           : out   std_logic;
   ddr3_cas_n           : out   std_logic;
   ddr3_we_n            : out   std_logic;
   ddr3_reset_n         : out   std_logic;
   ddr3_dqs_n           : inout std_logic_vector(7 downto 0);
   ddr3_dqs_p           : inout std_logic_vector(7 downto 0);
   ddr3_ck_p            : out   std_logic_vector(0 downto 0);
   ddr3_ck_n            : out   std_logic_vector(0 downto 0);
   ddr3_cke             : out   std_logic_vector(0 downto 0);
   ddr3_cs_n            : out   std_logic_vector(0 downto 0);
   ddr3_dm              : out   std_logic_vector(7 downto 0);
   ddr3_odt             : out   std_logic_vector(0 downto 0);
   sys_clk_p            : in    std_logic;
   sys_clk_n            : in    std_logic;
   app_addr             : in    std_logic_vector(27 downto 0);
   app_cmd              : in    std_logic_vector(2 downto 0);
   app_en               : in    std_logic;
   app_wdf_data         : in    std_logic_vector(511 downto 0);
   app_wdf_end          : in    std_logic;
   app_wdf_mask         : in    std_logic_vector(63 downto 0);
   app_wdf_wren         : in    std_logic;
   app_rd_data          : out   std_logic_vector(511 downto 0);
   app_rd_data_end      : out   std_logic;
   app_rd_data_valid    : out   std_logic;
   app_rdy              : out   std_logic;
   app_wdf_rdy          : out   std_logic;
   app_sr_req           : in    std_logic;
   app_sr_active        : out   std_logic;
   app_ref_req          : in    std_logic;
   app_ref_ack          : out   std_logic;
   app_zq_req           : in    std_logic;
   app_zq_ack           : out   std_logic;
   ui_clk               : out   std_logic;
   ui_clk_sync_rst      : out   std_logic;
   init_calib_complete  : out   std_logic;
   sys_rst              : in    std_logic
   );
end component mig;

component mig_interface_model is
  port (
   app_addr             : in    std_logic_vector(27 downto 0);
   app_cmd              : in    std_logic_vector(2 downto 0);
   app_en               : in    std_logic;
   app_wdf_data         : in    std_logic_vector(511 downto 0);
   app_wdf_end          : in    std_logic;
   app_wdf_mask         : in    std_logic_vector(63 downto 0);
   app_wdf_wren         : in    std_logic;
   app_rd_data          : out   std_logic_vector(511 downto 0);
   app_rd_data_end      : out   std_logic;
   app_rd_data_valid    : out   std_logic;
   app_rdy              : out   std_logic;
   app_wdf_rdy          : out   std_logic;
   ui_clk               : out   std_logic;
   ui_clk_sync_rst      : out   std_logic;
   init_calib_complete  : out   std_logic;
   sys_rst              : in    std_logic
   );
end component mig_interface_model;


begin

  comb: process( rst_n_syn, r, ahbsi, migout )

  -- Design temp variables
  variable v                      : reg_type;
  variable wmask                  : std_logic_vector(3 downto 0);
  variable writedata              : std_logic_vector(31 downto 0);
  variable shift_steps            : natural;
  variable hrdata_temp            : unsigned(v.rd_buffer'length-1 downto 0);
  variable hrdata_shift_steps     : natural;
  variable shift_steps_write      : natural;
  variable shift_steps_write_mask : natural;

  begin

    -- Make all register visible for the statemachine
    v := r;

    case r.bstate is
    when idle =>

      -- Clear Read data response
      v.hrdata          := (others => '0');

      -- Clear old pointers and MIG command signals
      v.cmd      := (others => '0');
      v.cmd_en   := '0';
      v.wr_en    := '0';
      v.wr_end   := '0';
      v.hready   := '1';
      v.hwrite   := '0';
      v.hwdata_burst := (others => '0');
      v.mask_burst := (others => '0');
      v.rd_count := (others => '0');

      -- Check if this is a single or burst transfer (and not a BUSY transfer)
      if ((ahbsi.hready and ahbsi.hsel(hindex) and ahbsi.htrans(1)) = '1' 
         and (ahbsi.hwrite = '0' or ahbsi.hwrite = '1' )) then

        -- Hold info regarding transaction and execute
        v.hburst      := ahbsi.hburst;
        v.hwrite      := ahbsi.hwrite;
        v.hsize       := ahbsi.hsize;
        v.hmaster     := ahbsi.hmaster;
        v.hready      := '0';
        v.htrans      := ahbsi.htrans;
        v.bstate      := start;
        v.haddr       := "0" & "000000" & ahbsi.haddr(27 downto 6) & "000";
        v.haddr_start := ahbsi.haddr;
        v.cmd         := (others => '0');
        v.cmd(0)      := not ahbsi.hwrite;

      end if;

    when start =>
      -- Check if a write command shall be issued to the DDR3 memory
      if r.hwrite = '1' then

         case r.hsize is
            when "000"  =>
               case r.haddr_start(1 downto 0) is
                  when "00"   => wmask := "0010";
                  when "01"   => wmask := "0001";
                  when "10"   => wmask := "1000";
                  when others => wmask := "0100";
               end case;

            when "001"  =>
              case r.haddr_start(1) is
                 when '0'    => wmask := "0011";
                 when others => wmask := "1100";
              end case;
            when "010"  => wmask := "1111";
            when others => wmask := "1111";
         end case;

         -- Work out write offset/start
         if ((r.htrans = "11") or ahbsi.htrans = "11") then
            shift_steps_write      := to_integer(unsigned(v.rd_count - 2)&"00000") 
               + to_integer(unsigned(r.haddr_start(5 downto 2))&"00000");
            shift_steps_write_mask := to_integer(unsigned(v.rd_count - 2)&"00")    
               + to_integer(unsigned(r.haddr_start(5 downto 2))&"00")   ;
         else
            shift_steps_write      := to_integer(unsigned(v.rd_count)&"00000") 
               + to_integer(unsigned(r.haddr_start(5 downto 2))&"00000");
            shift_steps_write_mask := to_integer(unsigned(v.rd_count)&"00")    
               + to_integer(unsigned(r.haddr_start(5 downto 2))&"00")   ;
         end if;

         if (ahbsi.htrans = "11") then
           v.htrans := "11";
         end if;

         -- generate mask for complete burst
         v.mask_burst := v.mask_burst or std_logic_vector(shift_left(resize(unsigned(wmask),
            v.mask_burst'length),shift_steps_write_mask));

         -- fetch all wdata before write to memory can begin
         writedata := ahbsi.hwdata(15 downto 0) & ahbsi.hwdata(31 downto 16);
         v.hwdata_burst := v.hwdata_burst or std_logic_vector(shift_left(resize(unsigned(writedata),
            v.hwdata_burst'length ) ,shift_steps_write));

         -- Check if this is acont burst longer than internal buffer
         if (ahbsi.htrans = "11") then

            if ((v.rd_count < maxwriteburst) and (v.rd_count > 0)) then
               v.hready := '1';
            else
               v.hready := '0';
            end if;

            if (v.rd_count >= maxwriteburst) and (r.hready = '0') then
                 if (r.htrans = "11") then
                   v.bstate   := write_cmd;
                 end if;
               v.htrans   := ahbsi.htrans;
               v.haddr_burst := ahbsi.haddr;
            end if;

         else
            v.bstate   := write_cmd;
            v.htrans   := ahbsi.htrans;
         end if;

      -- Else issue a read command when ready
      else
        if migout.app_rdy = '1' and migout.app_wdf_rdy = '1' then
           v.cmd := "001";
           v.bstate := read_cmd;
           v.htrans := ahbsi.htrans;
           v.cmd_count := to_unsigned(0,v.cmd_count'length);

           -- Always do a read burst
           if (ahbsi.htrans /= "11") then
               v.rd_count := to_unsigned(0,v.rd_count'length);
           else
               v.rd_count := to_unsigned(1,v.rd_count'length);
           end if;
        end if;
      end if;

    when write_cmd =>
      -- Check if burst has ended due to max size burst
      if (ahbsi.hsel(hindex) = '0') then
         v.htrans := (others => '0');
      end if;

      -- Stop when addr and write command is accepted by mig
      if (v.wr_count >= 2) and (v.cmd_count >= 2) then
          if (r.htrans /= "11") then
             --v.bstate      := idle;
             if ((ahbsi.hsel(hindex) = '1') and (ahbsi.htrans = "11")) then
                 -- Hold info regarding transaction and execute
                 v.hburst      := ahbsi.hburst;
                 v.hwrite      := ahbsi.hwrite;
                 v.hsize       := ahbsi.hsize;
                 v.hmaster     := ahbsi.hmaster;
                 v.hready      := '0';
                 v.htrans      := ahbsi.htrans;
                 v.bstate      := start;

                 -- Need to work-out the offset by looking at transfer size
                 if (ahbsi.hsize = "000") then
                   v.haddr_start := ahbsi.haddr - 1;
                 elsif (ahbsi.hsize = "001") then
                   v.haddr_start := ahbsi.haddr - 2;
                 else
                   v.haddr_start := ahbsi.haddr - 4;
                 end if;
                 
                 v.haddr        := "0"&"000000" & v.haddr_start(27 downto 6)&"000";
                 v.cmd          := (others => '0');
                 v.cmd(0)       := not ahbsi.hwrite;
                 v.hwdata_burst := (others => '0');
                 v.mask_burst   := (others => '0');
                 v.rd_count     := (others => '0');
                 v.cmd_count    := (others => '0');
                 v.wr_count     := (others => '0');
                 v.rd_count     := (others => '0');
             else
                 v.bstate      := idle;
             end if;

          else -- Cont burst and work out new offset for next write command
             v.bstate      := write_burst;
             v.haddr       := "0" & "000000" & r.haddr_burst(27 downto 6) & "000";
             v.haddr_start := r.haddr_burst;
          end if;
      end if;

    when write_burst =>
       v.bstate := start;
       v.hready := '1';

    when read_cmd =>
      v.hready := '0';

      v.rd_count := (others => '0');

      -- stop when read command is accepted ny mig.
      if (v.cmd_count >= 2) then
          v.bstate := read_data;
      end if;

    when read_data =>

      -- We are not ready yet so issue a read command to the memory controller
      v.hready := '0';

      -- If read data is valid store data in buffers
      if (migout.app_rd_data_valid = '1') then
         if (v.rd_count = 0) then
            v.int_buffer(511 downto 0) := unsigned(migout.app_rd_data);
            v.rd_count   := to_unsigned(1,v.rd_count'length);
            -- Check if this wasn't a burst command
            if (v.htrans /= "11") then
               v.rd_count   := to_unsigned(2,v.rd_count'length);
               v.int_buffer(1023 downto 512) := (others => '0');
            end if;
         else
            v.int_buffer(1023 downto 512) := unsigned(migout.app_rd_data);
            v.rd_count   := to_unsigned(2,v.rd_count'length);
         end if;
      end if;

      if (v.rd_count >= 2) then
         shift_steps := to_integer(unsigned(r.haddr_start(5 downto 2))&"00000");
         v.rd_buffer := shift_right(v.int_buffer,shift_steps);
         v.bstate := read_output;
         v.rd_count := to_unsigned(0,v.rd_count'length);
      end if;

    when read_output =>
      -- Data is fetched from memory and ready to be transfered
      v.hready := '1';

      -- uses the "wr_count" signal to keep track of number of bytes output'd to AHB
      -- Select correct 32bit to output
      hrdata_shift_steps := to_integer(v.wr_count & "00000");
      hrdata_temp := shift_right(v.rd_buffer,hrdata_shift_steps);

      case r.hsize is
         when "000"  =>
            case r.haddr_start(1 downto 0) is
               when "11"   => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(23 downto 16) 
                  & hrdata_temp(23 downto 16) & hrdata_temp(23 downto 16) & hrdata_temp(23 downto 16));
               when "10"   => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(31 downto 24) 
                  & hrdata_temp(31 downto 24) & hrdata_temp(31 downto 24) & hrdata_temp(31 downto 24));
               when "01"   => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(7  downto  0) 
                  & hrdata_temp(7  downto  0) & hrdata_temp(7  downto  0) & hrdata_temp(7  downto  0));
               when others => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(15 downto  8) 
                  & hrdata_temp(15 downto  8) & hrdata_temp(15 downto  8) & hrdata_temp(15 downto  8));
            end case;
         when "001"  =>
           case r.haddr_start(1) is
              when '1'     => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(31 downto 16) 
                 & hrdata_temp(31 downto 16));
              when others  => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(15 downto 0) 
                 & hrdata_temp(15 downto 0));
           end case;
         when "010"  => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(15 downto 0) & hrdata_temp(31 downto 16));
         when others => v.hrdata(31 downto 0) := std_logic_vector(hrdata_temp(15 downto 0) & hrdata_temp(31 downto 16));
      end case;

      -- Count number of bytes send
      v.wr_count := v.wr_count + 1;

      -- Check if this was the last transaction
      if (v.wr_count >= maxreadburst) then
         v.bstate := idle;
         v.wr_count := (others => '0');
      end if;

      -- Check if transfer was interrupted or no burst
      if (ahbsi.htrans = "00") or ((ahbsi.htrans = "10") and (v.wr_count < 7)) then
         v.bstate := idle;
         v.wr_count := (others => '0');
      end if;

    when others =>
          v.bstate := idle;
    end case;

     if ((ahbsi.hsel(hindex) = '0') and ((r.bstate = write_cmd) or (r.bstate = write_burst) or (r.bstate = start))) then
        v.hready  := '0';
     elsif ((ahbsi.htrans /= "11") and (r.bstate = start)) then  
        v.hready  := '0';
     end if;

    if rst_n_syn = '0' then
      v.bstate := idle; v.hready := '1'; v.cmd_en := '0'; v.wr_en := '0'; v.wr_end := '0';
    end if;

    rin <= v;

  end process;

  comb_hready: process(r, ahbsi)
  begin
     if ((ahbsi.hsel(hindex) = '0') and ((r.bstate = write_cmd) or (r.bstate = write_burst) or (r.bstate = start))) then
        ahbso.hready  <= '0';
     elsif ((ahbsi.htrans /= "11") and (r.bstate = start)) then  
        ahbso.hready  <= '0';
     else
        ahbso.hready  <= r.hready;
     end if;
  end process;

  ahbso.hresp   <= "00"; --r.hresp;
  ahbso.hrdata  <= r.hrdata;

  migin.app_addr <= r.haddr(27 downto 2) & "00";
  migin.app_cmd  <= r.cmd;
  migin.app_en   <= r.cmd_en;

  migin.app_wdf_data  <= r.wdf_data_buffer;
  migin.app_wdf_end   <= r.wr_end;
  migin.app_wdf_mask  <= r.wdf_mask_buffer;
  migin.app_wdf_wren  <= r.wr_en;

  ahbso.hconfig <= hconfig;
  ahbso.hirq    <= (others => '0');
  ahbso.hindex  <= hindex;
  ahbso.hsplit  <= (others => '0');

  apbo.pindex  <= pindex;
  apbo.pconfig <= pconfig;
  apbo.pirq    <= (others => '0');
  apbo.prdata  <= (others => '0');

  regs : process(clk_amba)
  begin
    if rising_edge(clk_amba) then

      -- Copy variables into registers (Default values)
      r <= rin;

      -- add extra pipe-stage for read data
      migout <= migoutraw;

      -- IDLE Clear
      if r.bstate = idle then
         r.cmd_count <= (others => '0');
         r.wr_count <= (others => '0');
         r.rd_count <= (others => '0');
      end if;

      -- Read AHB write data
      if (r.bstate = start) and (r.hwrite = '1') then
         if ((r.htrans = "11") and (r.rd_count = 0)) then
            r.rd_count <= (others => '0');
            r.htrans <= "10";
         else
            r.rd_count <= r.rd_count + 1;
         end if;
      end if;

      -- Write command repsonse
      if r.bstate = write_cmd then
          if (r.cmd_count < 1) then
             r.cmd_en   <= '1';
          end if;
          if (migoutraw.app_rdy = '1') and (r.cmd_en = '1' ) then
             r.cmd_count <= r.cmd_count + 1;
             if (r.cmd_count = 0 ) then
                r.haddr <= r.haddr + 8;
             end if;
             if (r.cmd_count >= 1) then
                r.cmd_en   <= '0';
             end if;
          end if;
          if (r.wr_count < 1 ) then
             r.wr_en    <= '1';
             r.wr_end   <= '1';
             r.wdf_mask_buffer <= not r.mask_burst(63 downto 0);
             r.wdf_data_buffer <= r.hwdata_burst(511 downto 0);
          end if;          
          if (migoutraw.app_wdf_rdy = '1') and (r.wr_en = '1' ) then
                r.wdf_mask_buffer <= not r.mask_burst(127 downto 64);
                r.wdf_data_buffer <= r.hwdata_burst(1023 downto 512);
                r.wr_count <= r.wr_count + 1;
                if (r.wr_count >= 1 ) then
                   r.wr_en    <= '0';
                   r.wr_end   <= '0';
                end if;
           end if;
      end if;

      -- Burst Write Wait
      if r.bstate = write_burst then
         r.cmd_count <= (others => '0');
         r.wr_count <= (others => '0');
         r.rd_count <= (others => '0');
         -- To make it easier to debug
         r.mask_burst <= (others => '0');
         r.hwdata_burst <= (others => '0');
      end if;

      -- Read command repsonse
      if r.bstate = read_cmd then
         if (r.cmd_count < 1) then
            r.cmd_en   <= '1';
         end if;
         if (migoutraw.app_rdy = '1')  and (r.cmd_en = '1' ) then
            r.cmd_count <= r.cmd_count + 1;
            if (r.cmd_count = 0 ) then
               r.haddr <= r.haddr + 8;
               if (ahbsi.htrans /= "11") then
                  r.cmd_en    <= '0';
                  r.cmd_count <= to_unsigned(2,r.cmd_count'length);
               end if;
            end if;
            if (r.cmd_count >= 1) then
               r.cmd_en   <= '0';
            end if;
         end if;
      end if;
    end if;
  end process;

 gen_mig : if (USE_MIG_INTERFACE_MODEL /= true) generate
  MCB_inst : mig
  generic map(
    SIM_BYPASS_INIT_CAL => SIM_BYPASS_INIT_CAL,
    SIMULATION          => SIMULATION)
  port map (
   ddr3_dq              => ddr3_dq,
   ddr3_dqs_p           => ddr3_dqs_p,
   ddr3_dqs_n           => ddr3_dqs_n,
   ddr3_addr            => ddr3_addr,
   ddr3_ba              => ddr3_ba,
   ddr3_ras_n           => ddr3_ras_n,
   ddr3_cas_n           => ddr3_cas_n,
   ddr3_we_n            => ddr3_we_n,
   ddr3_reset_n         => ddr3_reset_n,
   ddr3_ck_p            => ddr3_ck_p,
   ddr3_ck_n            => ddr3_ck_n,
   ddr3_cke             => ddr3_cke,
   ddr3_cs_n            => ddr3_cs_n,
   ddr3_dm              => ddr3_dm,
   ddr3_odt             => ddr3_odt,
   sys_clk_p            => sys_clk_p,
   sys_clk_n            => sys_clk_n,
   app_addr             => migin.app_addr,
   app_cmd              => migin.app_cmd,
   app_en               => migin.app_en,
   app_rdy              => migoutraw.app_rdy,
   app_wdf_data         => migin.app_wdf_data,
   app_wdf_end          => migin.app_wdf_end,
   app_wdf_mask         => migin.app_wdf_mask,
   app_wdf_wren         => migin.app_wdf_wren,
   app_wdf_rdy          => migoutraw.app_wdf_rdy,
   app_rd_data          => migoutraw.app_rd_data,
   app_rd_data_end      => migoutraw.app_rd_data_end,
   app_rd_data_valid    => migoutraw.app_rd_data_valid,
   app_sr_req           => '0',  
   app_sr_active        => open, 
   app_ref_req          => '0',  
   app_ref_ack          => open, 
   app_zq_req           => '0',  
   app_zq_ack           => open, 
   ui_clk               => ui_clk,
   ui_clk_sync_rst      => ui_clk_sync_rst,
   init_calib_complete  => calib_done,
   sys_rst              => rst_n_async
   );
 end generate gen_mig;

 gen_mig_model : if (USE_MIG_INTERFACE_MODEL = true) generate
  MCB_model_inst : mig_interface_model
  port map (
   -- user interface signals
   app_addr             => migin.app_addr,
   app_cmd              => migin.app_cmd,
   app_en               => migin.app_en,
   app_rdy              => migoutraw.app_rdy,
   app_wdf_data         => migin.app_wdf_data,
   app_wdf_end          => migin.app_wdf_end,
   app_wdf_mask         => migin.app_wdf_mask,
   app_wdf_wren         => migin.app_wdf_wren,
   app_wdf_rdy          => migoutraw.app_wdf_rdy,
   app_rd_data          => migoutraw.app_rd_data,
   app_rd_data_end      => migoutraw.app_rd_data_end,
   app_rd_data_valid    => migoutraw.app_rd_data_valid,
   ui_clk               => ui_clk,
   ui_clk_sync_rst      => ui_clk_sync_rst,
   init_calib_complete  => calib_done,
   sys_rst              => rst_n_async
   );
 end generate gen_mig_model;


end;
