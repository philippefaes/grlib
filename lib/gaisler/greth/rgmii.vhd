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
-- Entity: 	rgmii
-- File:	rgmii.vhd
-- Author:	Fredrik Ringhage - Aeroflex Gaisler
-- Description: GMII to RGMII interface 
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library gaisler;
use gaisler.net.all;

library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;

library techmap;
use techmap.gencomp.all;
use techmap.allclkgen.all;

library eth;
use eth.grethpkg.all;

entity rgmii is
  generic (
    pindex   : integer := 0;
    paddr    : integer := 0;
    pmask    : integer := 16#fff#;
    tech     : integer := 0;
    gmii     : integer := 0;
    extclk   : integer := 0;
    clkdiv2  : integer := 0;
    debugmem : integer := 0
    );
  port (
    rstn     : in  std_ulogic;
    clk_tx_g : in  std_ulogic;
    gmiii    : out eth_in_type;
    gmiio    : in  eth_out_type;
    rgmiii   : in  eth_in_type;
    rgmiio   : out eth_out_type;
    -- APB Status bus
    apb_clk  : in    std_logic;
    apb_rstn : in    std_logic;
    apbi     : in    apb_slv_in_type;
    apbo     : out   apb_slv_out_type

    );
end ;

architecture rtl of rgmii is

constant pconfig : apb_config_type := (
  0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_RGMII, 0, 0, 0),
  1 => apb_iobar(paddr, pmask));

  attribute keep : boolean;
  attribute syn_keep : boolean;
  attribute syn_preserve : boolean;

  signal vcc, gnd : std_ulogic;
  signal tx_en, tx_ctlp, tx_ctl : std_ulogic;
  signal txd : std_logic_vector(7 downto 0);
  signal rxd, rxd_int : std_logic_vector(7 downto 0);
  signal rx_clk, nrx_clk : std_ulogic;
  signal rx_dv, rx_dv_int, rx_ctl, rx_ctl_int, rx_error : std_logic;
  signal clk50i,clk50ni, clk25i, clk25ni, clk125i, clk2_5i, clk2_5ni : std_ulogic;
  signal txp, txn, tx_clk_ddr, tx_clk, tx_clki, ntx_clk : std_ulogic;
  signal cnt2_5, cnt25 : unsigned(5 downto 0);
  signal rst50n,rsttxclkn,rsttxclk,rsttxclk90n,rsttxclk90 : std_logic;

  -- RGMII Inband status signals
  signal inbandopt,inbandreq  : std_logic;
  signal link_status          : std_logic;
  signal clock_speed          : std_logic_vector(1 downto 0);
  signal duplex_status        : std_logic;
  signal false_carrier_ind    : std_logic;
  signal carrier_ext          : std_logic;
  signal carrier_ext_error    : std_logic;
  signal carrier_sense        : std_logic;
 
  -- Extra registers to ease IOB placement
  signal status_vector_apb : std_logic_vector(15 downto 0);

  -- debug signal
  signal WMemRgmiioData       : std_logic_vector(15 downto 0);
  signal RMemRgmiioData       : std_logic_vector(15 downto 0);
  signal RMemRgmiioAddr       : std_logic_vector(9 downto 0);
  signal WMemRgmiioAddr       : std_logic_vector(9 downto 0);
  signal WMemRgmiioWrEn       : std_logic;
  signal WMemRgmiiiData       : std_logic_vector(15 downto 0);
  signal RMemRgmiiiData       : std_logic_vector(15 downto 0);
  signal RMemRgmiiiAddr       : std_logic_vector(9 downto 0);
  signal WMemRgmiiiAddr       : std_logic_vector(9 downto 0);
  signal WMemRgmiiiWrEn       : std_logic;
  signal RMemRgmiiiRead       : std_logic;
  signal RMemRgmiioRead       : std_logic;

  signal clk_tx_g_n           : std_logic;
  
begin  -- rtl

  vcc <= '1'; gnd <= '0';

  ---------------------------------------------------------------------------------------
  -- MDIO path
  ---------------------------------------------------------------------------------------

  gmiii.mdint    <= rgmiii.mdint;
  gmiii.mdio_i   <= rgmiii.mdio_i;
  rgmiio.mdio_o  <= gmiio.mdio_o;
  rgmiio.mdio_oe <= gmiio.mdio_oe;
  rgmiio.mdc     <= gmiio.mdc;

  ---------------------------------------------------------------------------------------
  -- TX path
  ---------------------------------------------------------------------------------------

  
  -- Generate transmit clocks.
  tx_clk <= rgmiii.gtx_clk;
  ntx_clk <= not tx_clk;
  
  gmiii.gtx_clk <= tx_clk;  
  gmiii.tx_clk <= tx_clk;

  process (tx_clk)
  begin  -- process
    if rising_edge(tx_clk) then

      if cnt25 = to_unsigned(4,cnt25'length) then 
        cnt25 <= to_unsigned(0,cnt25'length);
      else 
        cnt25 <= cnt25 + 1; 
      end if;
      if cnt25 = to_unsigned(0,cnt25'length) then 
        clk25i <= '1';
      elsif cnt25 = to_unsigned(3,cnt25'length) then 
        clk25i <= '0';
      else 
        clk25i <= clk25i; 
      end if;
      clk25ni <= not clk25i;
      
      if cnt2_5 = to_unsigned(49,cnt2_5'length) then 
        cnt2_5 <= to_unsigned(0,cnt2_5'length);
      else 
        cnt2_5 <= cnt2_5 + 1; 
      end if;
      if cnt2_5 = to_unsigned(0,cnt2_5'length) then 
        clk2_5i <= '1';
      elsif cnt2_5 = to_unsigned(49,cnt2_5'length) then 
        clk2_5i <= '0';
      else 
        clk2_5i <= clk2_5i; 
      end if;
      clk2_5ni <= not clk2_5i;
      
      if rsttxclkn = '0' then clk25i <= '0'; clk2_5i <= '0'; cnt2_5 <= to_unsigned(0,cnt2_5'length); cnt25 <= to_unsigned(0,cnt25'length); end if;

    end if;
  end process;

  -- Generate RGMII control signal and check data rate
  process (tx_clk)
  begin  -- process
    if rising_edge(tx_clk) then
      if (gmiio.gbit = '1') then 
         txd(7 downto 0) <= gmiio.txd(7 downto 0);
      else
         txd(7 downto 4) <= gmiio.txd(3 downto 0);
         txd(3 downto 0) <= gmiio.txd(3 downto 0);
      end if;
      tx_en  <= gmiio.tx_en;
      tx_ctl <= gmiio.tx_en xor gmiio.tx_er;
    end if;
    
    if (gmii = 1) and (gmiio.gbit = '1') then
       txp <= '1';
       txn <= '0';
    else
       if gmiio.speed = '1' then
          txp <= clk25i;
          txn <= clk25ni;
       else
          txp <= clk2_5i;
          txn <= clk2_5ni;
       end if;
    end if;
    
  end process;

  clk_tx_rst : eth_rstgen
  port map(rstn, tx_clk, vcc, rsttxclkn, open);
  rsttxclk <= not rsttxclkn;

  clk_tx90_rst : eth_rstgen
  port map(rstn, clk_tx_g, vcc, rsttxclk90n, open);
  rsttxclk90 <= not rsttxclk90n;

  clk_tx_g_n <= not clk_tx_g;

  -- DDR outputs
  rgmii_txd : for i in 0 to 3 generate
      ddr_oreg0 : ddr_oreg generic map (tech, arch => 1)
        port map (q => rgmiio.txd(i), c1 => tx_clk, c2 => ntx_clk, ce => vcc,
                  d1 => txd(i), d2 => txd(i+4), r => rsttxclk, s => gnd);
  end generate;
  rgmii_tx_ctl : ddr_oreg generic map (tech, arch => 1)
        port map (q => rgmiio.tx_en, c1 => tx_clk, c2 => ntx_clk, ce => vcc,
                  d1 => tx_en, d2 => tx_ctl, r => rsttxclk, s => gnd);
  rgmii_tx_clk : ddr_oreg generic map (tech, arch => 1) 
        port map (q =>tx_clk_ddr, c1 => clk_tx_g, c2 => clk_tx_g_n, ce => vcc,
                  d1 => txp, d2 => txn, r => rsttxclk90, s => gnd);
  
  rgmiio.tx_er  <= '0';
  rgmiio.tx_clk <= tx_clk_ddr;
  rgmiio.reset  <= rstn;
  rgmiio.gbit   <= gmiio.gbit;
  rgmiio.speed  <= gmiio.speed when (gmii = 1) else '0';

  -- Not used in RGMII mode
  rgmiio.txd(7 downto 4) <= (others => '0');

  ---------------------------------------------------------------------------------------
  -- RX path
  ---------------------------------------------------------------------------------------

  -- Rx Clocks
  rx_clk <= rgmiii.rx_clk;
  nrx_clk <= not rgmiii.rx_clk;

  -- DDR inputs
  rgmii_rxd : for i in 0 to 3 generate
      ddr_ireg0 : ddr_ireg generic map (tech)
        port map (q1 => rxd_int(i), q2 => rxd_int(i+4), c1 => rx_clk, c2 => nrx_clk,
                  ce => vcc, d => rgmiii.rxd(i), r => gnd, s => gnd);

     V7D : if (tech = virtex7) or (tech = kintex7) generate
       process (rx_clk)
       begin
         if rising_edge(rx_clk) then
           rxd(i) <= rxd_int(i+4);
         end if;
       end process;
       rxd(i+4) <= rxd_int(i);
     end generate;

     S6D : if (tech = spartan6) generate
       rxd(i) <= rxd_int(i);
       rxd(i+4) <= rxd_int(i+4);
     end generate;

  end generate;
  ddr_dv0 : ddr_ireg generic map (tech)
     port map (q1 => rx_dv_int, q2 => rx_ctl_int, c1 => rx_clk, c2 => nrx_clk,
               ce => vcc, d => rgmiii.rx_dv, r => gnd, s => gnd);
 
  V7DV : if (tech = virtex7) or (tech = kintex7) generate
    process (rx_clk)
    begin
      if rising_edge(rx_clk) then
        rx_dv <= rx_ctl_int;
      end if;
    end process;
    rx_ctl <= rx_dv_int;
  end generate;

  S6DV : if (tech = spartan6) generate
     rx_dv <= rx_dv_int;
     rx_ctl <= rx_ctl_int;
  end generate;


  -- Decode GMII error signal
  rx_error <= rx_dv xor rx_ctl;

  -- Enable inband status registers during Interframe Gap
  inbandopt <= not ( rx_dv or rx_error );
  inbandreq <= rx_error and not rx_dv;

  -- Sample RGMII inband information
  process (rx_clk)
   begin
    if rising_edge(rx_clk) then
      if (inbandopt = '1') then
         link_status   <= rxd(0);
         clock_speed   <= rxd(2 downto 1);
         duplex_status <= rxd(3);
      end if;
      if (inbandreq = '1') then
         if (rxd = x"0E") then false_carrier_ind <= '1'; else false_carrier_ind <= '0'; end if;
         if (rxd = x"0F") then carrier_ext       <= '1'; else carrier_ext       <= '0'; end if;
         if (rxd = x"1F") then carrier_ext_error <= '1'; else carrier_ext_error <= '0'; end if;
         if (rxd = x"FF") then carrier_sense     <= '1'; else carrier_sense     <= '0'; end if;
      end if;
    end if;
  end process;

  -- GMII output
  gmiii.rxd      <= rxd;
  gmiii.rx_dv    <= rx_dv;
  gmiii.rx_er    <= rx_error;
  gmiii.rx_clk   <= rx_clk;
  gmiii.rx_col   <= '0';
  gmiii.rx_crs   <= rx_dv;
  gmiii.rmii_clk <= '0';

  -- GMII output controlled via generics
  gmiii.edclsepahb  <= '0';
  gmiii.edcldisable <= '0';
  gmiii.phyrstaddr  <= (others => '0');
  gmiii.edcladdr    <= (others => '0');

  ---------------------------------------------------------------------------------------
  -- APB Section
  ---------------------------------------------------------------------------------------
  
  apbo.pindex  <= pindex;
  apbo.pconfig <= pconfig;
  apbo.pirq    <= (others => '0');
  apbo.prdata(31 downto 16) <= (others => '0'); 
  apbo.prdata(15 downto 0)  <= (others => '0') when apbi.psel(pindex) = '0' else
                               RMemRgmiiiData  when RMemRgmiiiRead = '1'  else 
                               RMemRgmiioData  when RMemRgmiioRead = '1'  else
                               status_vector_apb;

  -- Extra registers to ease CDC placement 
   process (apb_clk)
   begin
      if apb_clk'event and apb_clk = '1' then
         status_vector_apb(15 downto 12) <= (others => '0');
         status_vector_apb(11) <= '0';
         status_vector_apb(10) <= '0';
         status_vector_apb(9) <= gmiio.speed;
         status_vector_apb(8) <= gmiio.gbit;
         status_vector_apb(7) <= carrier_sense;
         status_vector_apb(6) <= carrier_ext_error;
         status_vector_apb(5) <= carrier_ext;
         status_vector_apb(4) <= false_carrier_ind;
         status_vector_apb(3) <= duplex_status;
         status_vector_apb(2) <= clock_speed(1);
         status_vector_apb(1) <= clock_speed(0);
         status_vector_apb(0) <= link_status;
      end if;
   end process;

  debugmem0 : if (debugmem /= 0) generate

    -- Write GMII IN data
    process (tx_clk)
    begin  -- process
      if rising_edge(tx_clk) then
        WMemRgmiioData(15 downto 0) <= "000" & tx_en & "000" & tx_ctl & txd;
        if (tx_en = '1') and ((WMemRgmiioAddr < "0111111110") or (WMemRgmiioAddr = "1111111111")) then
           WMemRgmiioAddr <= WMemRgmiioAddr + 1;
           WMemRgmiioWrEn <= '1';
        else
           if (rx_dv = '0') then
              WMemRgmiioAddr <= (others => '1');
           else
              WMemRgmiioAddr <= WMemRgmiioAddr;
           end if;
           WMemRgmiioWrEn <= '0';
        end if;
      end if;
    end process;

    -- Read
    RMemRgmiioRead <= apbi.paddr(10) and apbi.psel(pindex);
    RMemRgmiioAddr <= "00" & apbi.paddr(10-1 downto 2);

    gmiii0 : syncram_2p generic map (tech, 10, 16, 1, 0, 0) port map(
      apb_clk, RMemRgmiioRead, RMemRgmiioAddr, RMemRgmiioData,
      tx_clk, WMemRgmiioWrEn, WMemRgmiioAddr(10-1 downto 0), WMemRgmiioData); 

  end generate;

  debugmem1 : if (debugmem /= 0) generate

    -- Write GMII IN data
    process (rx_clk)
    begin  -- process
      if rising_edge(rx_clk) then
        WMemRgmiiiData(15 downto 0) <= "000" & rx_dv & "000" & rx_ctl & rxd(7 downto 4) & rxd(3 downto 0);
        if ((rx_dv = '1') or (rx_ctl = '1')) and ((WMemRgmiiiAddr < "0111111110") or (WMemRgmiiiAddr = "1111111111")) then
           WMemRgmiiiAddr <= WMemRgmiiiAddr + 1;
           WMemRgmiiiWrEn <= '1';
        else       
           if (rx_dv = '0') then
              WMemRgmiiiAddr <= (others => '1');
           else
              WMemRgmiiiAddr <= WMemRgmiiiAddr;
           end if;
           WMemRgmiiiWrEn <= '0';
        end if;
      end if;
    end process;

    -- Read
    RMemRgmiiiRead <= apbi.paddr(11) and apbi.psel(pindex);
    RMemRgmiiiAddr <= "00" & apbi.paddr(10-1 downto 2);

    rgmiii0 : syncram_2p generic map (tech, 10, 16, 1, 0, 0) port map(
      apb_clk, RMemRgmiiiRead, RMemRgmiiiAddr, RMemRgmiiiData,
      tx_clk, WMemRgmiiiWrEn, WMemRgmiiiAddr(10-1 downto 0), WMemRgmiiiData); 

  end generate;


end rtl;
