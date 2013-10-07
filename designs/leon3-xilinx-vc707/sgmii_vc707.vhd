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
-- Entity: 	sgmii
-- File:	sgmii.vhd
-- Author:	Fredrik Ringhage - Aeroflex Gaisler
-- Description: GMII to SGMII interface
------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Description: This is the top level vhdl example design for the
--              Ethernet 1000BASE-X PCS/PMA core.
--
--              This design example instantiates IOB flip-flops
--              and input/output buffers on the GMII.
--
--              A Transmitter Elastic Buffer is instantiated on the Tx
--              GMII path to perform clock compenstation between the
--              core and the external MAC driving the Tx GMII.
--
--              This design example can be synthesised.
--
--
--
--    ----------------------------------------------------------------
--    |                             Example Design                   |
--    |                                                              |
--    |             ----------------------------------------------   |
--    |             |           Core Block (wrapper)             |   |
--    |             |                                            |   |
--    |             |   --------------          --------------   |   |
--    |             |   |    Core    |          | tranceiver |   |   |
--    |             |   |            |          |            |   |   |
--    |  ---------  |   |            |          |            |   |   |
--    |  |       |  |   |            |          |            |   |   |
--    |  |  Tx   |  |   |            |          |            |   |   |
--  ---->|Elastic|----->| GMII       |--------->|        TXP |--------->
--    |  |Buffer |  |   | Tx         |          |        TXN |   |   |
--    |  |       |  |   |            |          |            |   |   |
--    |  ---------  |   |            |          |            |   |   |
--    | GMII        |   |            |          |            |   |   |
--    | IOBs        |   |            |          |            |   |   |
--    |             |   |            |          |            |   |   |
--    |             |   | GMII       |          |        RXP |   |   |
--  <-------------------| Rx         |<---------|        RXN |<---------
--    |             |   |            |          |            |   |   |
--    |             |   --------------          --------------   |   |
--    |             |                                            |   |
--    |             ----------------------------------------------   |
--    |                                                              |
--    ----------------------------------------------------------------
--
--------------------------------------------------------------------------------


library unisim;
use unisim.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

library grlib;
use grlib.amba.all;
use grlib.stdlib.all;
use grlib.devices.all;

library gaisler;
use gaisler.misc.all;
use gaisler.net.all;


--------------------------------------------------------------------------------
-- The entity declaration for the example design
--------------------------------------------------------------------------------

entity sgmii_vc707 is
      generic(
        pindex          : integer := 0;
        paddr           : integer := 0;
        pmask           : integer := 16#fff#;
        autonegotiation : integer := 1
      );
        port(
      -- Tranceiver Interface
      sgmiii            :  in  eth_sgmii_in_type;
      sgmiio            :  out eth_sgmii_out_type;
      -- GMII Interface (client MAC <=> PCS)
      gmiii             : out eth_in_type;
      gmiio             : in  eth_out_type;
      -- Asynchronous reset for entire core.
      reset             : in std_logic;
      -- APB Status bus
      apb_clk           : in    std_logic;
      apb_rstn          : in    std_logic;
      apbi              : in    apb_slv_in_type;
      apbo              : out   apb_slv_out_type

      );
end sgmii_vc707;

architecture top_level of sgmii_vc707 is

  ------------------------------------------------------------------------------
  -- Component Declaration for the Core Block (core wrapper).
  ------------------------------------------------------------------------------
   component sgmii
      port(
      -- Transceiver Interface
      ------------------------

      drpaddr_in           : in std_logic_vector(8 downto 0);
      drpclk_in            : in std_logic;
      drpdi_in             : in std_logic_vector(15 downto 0);
      drpdo_out            : out std_logic_vector(15 downto 0);
      drpen_in             : in std_logic;
      drprdy_out           : out std_logic;
      drpwe_in             : in std_logic;

      gtrefclk             : in std_logic;                     -- Very high quality 125MHz clock for GT transceiver
      txp                  : out std_logic;                    -- Differential +ve of serial transmission from PMA to PMD.
      txn                  : out std_logic;                    -- Differential -ve of serial transmission from PMA to PMD.
      rxp                  : in std_logic;                     -- Differential +ve for serial reception from PMD to PMA.
      rxn                  : in std_logic;                     -- Differential -ve for serial reception from PMD to PMA.

      txoutclk             : out std_logic;                    -- txoutclk from GT transceiver (62.5MHz)
      resetdone            : out std_logic;                    -- The GT transceiver has completed its reset cycle
      mmcm_locked          : in std_logic;                     -- Locked signal from MMCM
      userclk              : in std_logic;                     -- 62.5MHz clock.
      userclk2             : in std_logic;                     -- 125MHz clock.
      independent_clock_bufg : in std_logic;
      pma_reset            : in std_logic;                     -- transceiver PMA reset signal


      -- GMII Interface
      -----------------
      sgmii_clk_r          : out std_logic;                    -- Clock for client MAC (125Mhz, 12.5MHz or 1.25MHz).
      sgmii_clk_f          : out std_logic;                    -- Clock for client MAC (125Mhz, 12.5MHz or 1.25MHz).
      sgmii_clk_en         : out std_logic;                    -- Clock enable for client MAC

      gmii_txd             : in std_logic_vector(7 downto 0);  -- Transmit data from client MAC.
      gmii_tx_en           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_tx_er           : in std_logic;                     -- Transmit control signal from client MAC.
      gmii_rxd             : out std_logic_vector(7 downto 0); -- Received Data to client MAC.
      gmii_rx_dv           : out std_logic;                    -- Received control signal to client MAC.
      gmii_rx_er           : out std_logic;                    -- Received control signal to client MAC.
      gmii_isolate         : out std_logic;                    -- Tristate control to electrically isolate GMII.

      -- Management: MDIO Interface
      -----------------------------

      configuration_vector : in std_logic_vector(4 downto 0);  -- Alternative to MDIO interface.

      an_interrupt         : out std_logic;                    -- Interrupt to processor to signal that Auto-Negotiation has completed
      an_adv_config_vector : in std_logic_vector(15 downto 0); -- Alternate interface to program REG4 (AN ADV)
      an_restart_config    : in std_logic;                     -- Alternate signal to modify AN restart bit in REG0
      link_timer_value     : in std_logic_vector(8 downto 0);  -- Programmable Auto-Negotiation Link Timer Control

      -- Speed Control
      ----------------
      speed_is_10_100      : in std_logic;                     -- Core should operate at either 10Mbps or 100Mbps speeds
      speed_is_100         : in std_logic;                      -- Core should operate at 100Mbps speed

      -- General IO's
      ---------------
      status_vector        : out std_logic_vector(15 downto 0); -- Core status.
      reset                : in std_logic;                     -- Asynchronous reset for entire core.
      signal_detect        : in std_logic                      -- Input from PMD to indicate presence of optical input.

      );

   end component;

component MMCME2_ADV
  generic (
     BANDWIDTH : string := "OPTIMIZED";
     CLKFBOUT_MULT_F : real := 5.000;
     CLKFBOUT_PHASE : real := 0.000;
     CLKFBOUT_USE_FINE_PS : boolean := FALSE;
     CLKIN1_PERIOD : real := 0.000;
     CLKIN2_PERIOD : real := 0.000;
     CLKOUT0_DIVIDE_F : real := 1.000;
     CLKOUT0_DUTY_CYCLE : real := 0.500;
     CLKOUT0_PHASE : real := 0.000;
     CLKOUT0_USE_FINE_PS : boolean := FALSE;
     CLKOUT1_DIVIDE : integer := 1;
     CLKOUT1_DUTY_CYCLE : real := 0.500;
     CLKOUT1_PHASE : real := 0.000;
     CLKOUT1_USE_FINE_PS : boolean := FALSE;
     CLKOUT2_DIVIDE : integer := 1;
     CLKOUT2_DUTY_CYCLE : real := 0.500;
     CLKOUT2_PHASE : real := 0.000;
     CLKOUT2_USE_FINE_PS : boolean := FALSE;
     CLKOUT3_DIVIDE : integer := 1;
     CLKOUT3_DUTY_CYCLE : real := 0.500;
     CLKOUT3_PHASE : real := 0.000;
     CLKOUT3_USE_FINE_PS : boolean := FALSE;
     CLKOUT4_CASCADE : boolean := FALSE;
     CLKOUT4_DIVIDE : integer := 1;
     CLKOUT4_DUTY_CYCLE : real := 0.500;
     CLKOUT4_PHASE : real := 0.000;
     CLKOUT4_USE_FINE_PS : boolean := FALSE;
     CLKOUT5_DIVIDE : integer := 1;
     CLKOUT5_DUTY_CYCLE : real := 0.500;
     CLKOUT5_PHASE : real := 0.000;
     CLKOUT5_USE_FINE_PS : boolean := FALSE;
     CLKOUT6_DIVIDE : integer := 1;
     CLKOUT6_DUTY_CYCLE : real := 0.500;
     CLKOUT6_PHASE : real := 0.000;
     CLKOUT6_USE_FINE_PS : boolean := FALSE;
     COMPENSATION : string := "ZHOLD";
     DIVCLK_DIVIDE : integer := 1;
     REF_JITTER1 : real := 0.0;
     REF_JITTER2 : real := 0.0;
     SS_EN : string := "FALSE";
     SS_MODE : string := "CENTER_HIGH";
     SS_MOD_PERIOD : integer := 10000;
     STARTUP_WAIT : boolean := FALSE
  );
  port (
     CLKFBOUT : out std_ulogic := '0';
     CLKFBOUTB : out std_ulogic := '0';
     CLKFBSTOPPED : out std_ulogic := '0';
     CLKINSTOPPED : out std_ulogic := '0';
     CLKOUT0 : out std_ulogic := '0';
     CLKOUT0B : out std_ulogic := '0';
     CLKOUT1 : out std_ulogic := '0';
     CLKOUT1B : out std_ulogic := '0';
     CLKOUT2 : out std_ulogic := '0';
     CLKOUT2B : out std_ulogic := '0';
     CLKOUT3 : out std_ulogic := '0';
     CLKOUT3B : out std_ulogic := '0';
     CLKOUT4 : out std_ulogic := '0';
     CLKOUT5 : out std_ulogic := '0';
     CLKOUT6 : out std_ulogic := '0';
     DO : out std_logic_vector (15 downto 0);
     DRDY : out std_ulogic := '0';
     LOCKED : out std_ulogic := '0';
     PSDONE : out std_ulogic := '0';
     CLKFBIN : in std_ulogic;
     CLKIN1 : in std_ulogic;
     CLKIN2 : in std_ulogic;
     CLKINSEL : in std_ulogic;
     DADDR : in std_logic_vector(6 downto 0);
     DCLK : in std_ulogic;
     DEN : in std_ulogic;
     DI : in std_logic_vector(15 downto 0);
     DWE : in std_ulogic;
     PSCLK : in std_ulogic;
     PSEN : in std_ulogic;
     PSINCDEC : in std_ulogic;
     PWRDWN : in std_ulogic;
     RST : in std_ulogic
  );
end component;

----- component IBUFDS_GTE2 -----
component IBUFDS_GTE2
  generic (
     CLKCM_CFG : boolean := TRUE;
     CLKRCV_TRST : boolean := TRUE;
     CLKSWING_CFG : bit_vector := "11"
  );
  port (
     O : out std_ulogic;
     ODIV2 : out std_ulogic;
     CEB : in std_ulogic;
     I : in std_ulogic;
     IB : in std_ulogic
  );
end component;

constant pconfig : apb_config_type := (
  0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_SGMII, 0, 0, 0),
  1 => apb_iobar(paddr, pmask));

  ------------------------------------------------------------------------------
  -- internal signals used in this top level example design.
  ------------------------------------------------------------------------------

  -- clock generation signals for tranceiver
  signal gtrefclk              : std_logic;
  signal txoutclk              : std_logic;
  signal resetdone             : std_logic;
  signal mmcm_locked           : std_logic;
  signal mmcm_reset            : std_logic;
  signal clkfbout              : std_logic;
  signal clkout0               : std_logic;
  signal clkout1               : std_logic;
  signal userclk               : std_logic;
  signal userclk2              : std_logic;

  -- PMA reset generation signals for tranceiver
  signal pma_reset_pipe        : std_logic_vector(3 downto 0);
  signal pma_reset             : std_logic;

  -- clock generation signals for SGMII clock
  signal sgmii_clk_r           : std_logic;
  signal sgmii_clk_f           : std_logic;
  signal sgmii_clk_en          : std_logic;
  signal sgmii_clk             : std_logic;
  signal sgmii_clk_int         : std_logic;

  -- GMII signals
  signal gmii_txd              : std_logic_vector(7 downto 0);
  signal gmii_tx_en            : std_logic;
  signal gmii_tx_er            : std_logic;
  signal gmii_rxd              : std_logic_vector(7 downto 0);
  signal gmii_rx_dv            : std_logic;
  signal gmii_rx_er            : std_logic;
  signal gmii_isolate          : std_logic;
  signal gmii_txd_int          : std_logic_vector(7 downto 0);
  signal gmii_tx_en_int        : std_logic;
  signal gmii_tx_er_int        : std_logic;
  signal gmii_rxd_int          : std_logic_vector(7 downto 0);
  signal gmii_rx_dv_int        : std_logic;
  signal gmii_rx_er_int        : std_logic;

  -- Extra registers to ease IOB placement
  signal status_vector_int : std_logic_vector(15 downto 0);
  signal status_vector_apb : std_logic_vector(15 downto 0);

  -- These attributes will stop timing errors being reported in back annotated
  -- SDF simulation.
  attribute ASYNC_REG                   : string;
  attribute ASYNC_REG of pma_reset_pipe : signal is "TRUE";

  -- Configuration register

  signal speed_is_10_100      : std_logic;
  signal speed_is_100         : std_logic;

  signal configuration_vector : std_logic_vector(4 downto 0);

  signal an_interrupt         : std_logic;
  signal an_adv_config_vector : std_logic_vector(15 downto 0);
  signal an_restart_config    : std_logic;
  signal link_timer_value     : std_logic_vector(8 downto 0);

  signal status_vector        : std_logic_vector(15 downto 0);
  signal synchronization_done : std_logic;
  signal linkup               : std_logic;
  signal signal_detect        : std_logic;

  attribute clock_signal : string;
  attribute clock_signal of sgmii_clk : signal is "yes";
  attribute clock_signal of sgmii_clk_int : signal is "yes";

begin

   -----------------------------------------------------------------------------
   -- Default for VC707
   -----------------------------------------------------------------------------

  -- Remove AN during simulation i.e. "00000"
  configuration_vector <= "10000" when (autonegotiation = 1) else "00000";

  --an_adv_config_vector <= x"4001";
  an_adv_config_vector <= "0000000000100001";
  an_restart_config    <= '0';
  link_timer_value     <= "000110010";

  --  Core Status vector outputs
  synchronization_done <= status_vector_int(1);
  linkup               <= status_vector_int(0);
  signal_detect        <= '1';

  apbo.pindex  <= pindex;
  apbo.pconfig <= pconfig;
  apbo.pirq    <= (others => '0');
  apbo.prdata(31 downto 16)  <= (others => '0');
  apbo.prdata(15 downto  0)   <= status_vector_apb;

  gmiii.gtx_clk <= sgmii_clk;
  gmiii.tx_clk  <= sgmii_clk;
  gmiii.rx_clk  <= sgmii_clk;
  gmii_txd      <= gmiio.txd;
  gmii_tx_en    <= gmiio.tx_en;
  gmii_tx_er    <= gmiio.tx_er;
  gmiii.rxd     <= gmii_rxd;
  gmiii.rx_dv   <= gmii_rx_dv;
  gmiii.rx_er   <= gmii_rx_er;

  gmiii.edclsepahb <= '0';
  gmiii.edcldisable <= '0';
  gmiii.phyrstaddr <= (others => '0');
  gmiii.edcladdr <= (others => '0');

  gmiii.rmii_clk <= sgmii_clk;
  gmiii.rx_col <= '0';
  gmiii.rx_crs <= '0';

  sgmiio.mdio_o   <= gmiio.mdio_o;
  sgmiio.mdio_oe  <= gmiio.mdio_oe;
  gmiii.mdio_i    <= sgmiii.mdio_i;
  sgmiio.mdc      <= gmiio.mdc;
  gmiii.mdint     <= sgmiii.mdint;
  sgmiio.reset    <= apb_rstn;

   -----------------------------------------------------------------------------
   -- Transceiver Clock Management
   -----------------------------------------------------------------------------

   -- Clock circuitry for the GT Transceiver uses a differential input clock.
   -- gtrefclk is routed to the tranceiver.
   ibufds_gtrefclk : IBUFDS_GTE2
   port map (
      I     => sgmiii.clkp,
      IB    => sgmiii.clkn,
      CEB   => '0',
      O     => gtrefclk,
      ODIV2 => open
   );

  -- The GT transceiver provides a 62.5MHz clock to the FPGA fabrix.  This is
  -- routed to an MMCM module where it is used to create phase and frequency
  -- related 62.5MHz and 125MHz clock sources
  mmcm_adv_inst : MMCME2_ADV
  generic map
   (BANDWIDTH            => "OPTIMIZED",
    CLKOUT4_CASCADE      => FALSE,
    COMPENSATION         => "ZHOLD",
--    STARTUP_WAIT         => FALSE,
    DIVCLK_DIVIDE        => 1,
    CLKFBOUT_MULT_F      => 16.000,
    CLKFBOUT_PHASE       => 0.000,
    CLKFBOUT_USE_FINE_PS => FALSE,
    CLKOUT0_DIVIDE_F     => 8.000,
    CLKOUT0_PHASE        => 0.000,
    CLKOUT0_DUTY_CYCLE   => 0.5,
    CLKOUT0_USE_FINE_PS  => FALSE,
    CLKOUT1_DIVIDE       => 16,
    CLKOUT1_PHASE        => 0.000,
    CLKOUT1_DUTY_CYCLE   => 0.5,
    CLKOUT1_USE_FINE_PS  => FALSE,
    CLKIN1_PERIOD        => 16.0,
    REF_JITTER1          => 0.010)
  port map
    -- Output clocks
   (CLKFBOUT             => clkfbout,
    CLKFBOUTB            => open,
    CLKOUT0              => clkout0,
    CLKOUT0B             => open,
    CLKOUT1              => clkout1,
    CLKOUT1B             => open,
    CLKOUT2              => open,
    CLKOUT2B             => open,
    CLKOUT3              => open,
    CLKOUT3B             => open,
    CLKOUT4              => open,
    CLKOUT5              => open,
    CLKOUT6              => open,
    -- Input clock control
    CLKFBIN              => clkfbout,
    CLKIN1               => txoutclk,
    CLKIN2               => '0',
    -- Tied to always select the primary input clock
    CLKINSEL             => '1',
    -- Ports for dynamic reconfiguration
    DADDR                => (others => '0'),
    DCLK                 => '0',
    DEN                  => '0',
    DI                   => (others => '0'),
    DO                   => open,
    DRDY                 => open,
    DWE                  => '0',
    -- Ports for dynamic phase shift
    PSCLK                => '0',
    PSEN                 => '0',
    PSINCDEC             => '0',
    PSDONE               => open,
    -- Other control and status signals
    LOCKED               => mmcm_locked,
    CLKINSTOPPED         => open,
    CLKFBSTOPPED         => open,
    PWRDWN               => '0',
    RST                  => mmcm_reset);

    mmcm_reset <= reset or (not resetdone);

   -- This 62.5MHz clock is placed onto global clock routing and is then used
   -- for tranceiver TXUSRCLK/RXUSRCLK.
   bufg_userclk: BUFG
   port map (
      I     => clkout1,
      O     => userclk
   );

   -- This 125MHz clock is placed onto global clock routing and is then used
   -- to clock all Ethernet core logic.
   bufg_userclk2: BUFG
   port map (
      I     => clkout0,
      O     => userclk2
   );

   -----------------------------------------------------------------------------
   -- Transceiver PMA reset circuitry
   -----------------------------------------------------------------------------

   -- Create a reset pulse of a decent length
   process(reset, apb_clk)
   begin
     if (reset = '1') then
       pma_reset_pipe <= "1111";
     elsif apb_clk'event and apb_clk = '1' then
       pma_reset_pipe <= pma_reset_pipe(2 downto 0) & reset;
     end if;
   end process;

   pma_reset <= pma_reset_pipe(3);

  ------------------------------------------------------------------------------
  -- Instantiate the Core Block (core wrapper).
  ------------------------------------------------------------------------------

  speed_is_10_100 <= not gmiio.gbit;
  speed_is_100    <= gmiio.speed;

  core_wrapper : sgmii
    port map (

      drpaddr_in           => "000000000", 
      drpclk_in            => '0',
      drpdi_in             => "0000000000000000",
      drpdo_out            => OPEN,
      drpen_in             => '0',
      drprdy_out           => OPEN,
      drpwe_in             => '0',

      gtrefclk             => gtrefclk,
      txp                  => sgmiio.txp,
      txn                  => sgmiio.txn,
      rxp                  => sgmiii.rxp,
      rxn                  => sgmiii.rxn,
      txoutclk             => txoutclk,
      resetdone            => resetdone,
      mmcm_locked          => mmcm_locked,
      userclk              => userclk,
      userclk2             => userclk2,
      independent_clock_bufg => apb_clk,
      pma_reset              => pma_reset,
      sgmii_clk_r          => sgmii_clk_r,
      sgmii_clk_f          => sgmii_clk_f,
      sgmii_clk_en         => sgmii_clk_en,
      gmii_txd             => gmii_txd_int,
      gmii_tx_en           => gmii_tx_en_int,
      gmii_tx_er           => gmii_tx_er_int,
      gmii_rxd             => gmii_rxd_int,
      gmii_rx_dv           => gmii_rx_dv_int,
      gmii_rx_er           => gmii_rx_er_int,
      gmii_isolate         => gmii_isolate,
      configuration_vector => configuration_vector,
      an_interrupt         => an_interrupt,
      an_adv_config_vector => an_adv_config_vector,
      an_restart_config    => an_restart_config,
      link_timer_value     => link_timer_value,
      speed_is_10_100      => speed_is_10_100,
      speed_is_100         => speed_is_100,
      status_vector        => status_vector_int,
      reset                => reset,
      signal_detect        => signal_detect
      );

   -----------------------------------------------------------------------------
   -- GMII transmitter data logic
   -----------------------------------------------------------------------------

   -- Drive input GMII signals through IOB input flip-flops (inferred).
   process (userclk2)
   begin
      if userclk2'event and userclk2 = '1' then
         gmii_txd_int    <= gmii_txd;
         gmii_tx_en_int  <= gmii_tx_en;
         gmii_tx_er_int  <= gmii_tx_er;

      end if;
   end process;

   -----------------------------------------------------------------------------
   -- SGMII clock logic
   -----------------------------------------------------------------------------

   process (userclk2)
   begin
      if userclk2'event and userclk2 = '1' then
         sgmii_clk_int   <= sgmii_clk_r;
      end if;
   end process;

   sgmii_clk <= userclk2 when (gmiio.gbit = '1') else sgmii_clk_int;

   -----------------------------------------------------------------------------
   -- GMII receiver data logic
   -----------------------------------------------------------------------------

   -- Drive input GMII signals through IOB output flip-flops (inferred).
   process (userclk2)
   begin
      if userclk2'event and userclk2 = '1' then
         gmii_rxd    <= gmii_rxd_int;
         gmii_rx_dv  <= gmii_rx_dv_int;
         gmii_rx_er  <= gmii_rx_er_int;

      end if;
   end process;

   -----------------------------------------------------------------------------
   -- Extra registers to ease IOB placement
   -----------------------------------------------------------------------------
   process (userclk2)
   begin
      if userclk2'event and userclk2 = '1' then
         status_vector <= status_vector_int;
      end if;
   end process;

   -----------------------------------------------------------------------------
   -- Extra registers to ease CDC placement
   -----------------------------------------------------------------------------
   process (apb_clk)
   begin
      if apb_clk'event and apb_clk = '1' then
         status_vector_apb <= status_vector_int;
      end if;
   end process;

end top_level;
