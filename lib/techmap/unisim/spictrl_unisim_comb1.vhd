------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2011, Aeroflex Gaisler AB - all rights reserved.
--
-- ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
-- ACCORDANCE WITH THE GAISLER LICENSE AGREEMENT AND MUST BE APPROVED 
-- IN ADVANCE IN WRITING. 
------------------------------------------------------------------------------
--
-- Written by Synplicity
-- Product Version "E-2010_09-SP3"
-- Program "Synplify Pro", Mapper "maprc, Build 312R"
-- Mon May 16 13:56:36 2011
--
--
-- Written by Synplify Pro version Build 312R
-- Mon May 16 13:56:36 2011
--
-- @N: Setting default value for generic rev to 3;
-- @N: Setting default value for generic fdepth to 3;
-- @N: Setting default value for generic slvselen to 0;
-- @N: Setting default value for generic slvselsz to 32;
-- @N: Setting default value for generic oepol to 0;
-- @N: Setting default value for generic odmode to 0;
-- @N: Setting default value for generic automode to 0;
-- @N: Setting default value for generic acntbits to 32;
-- @N: Setting default value for generic aslvsel to 0;
-- @N: Setting default value for generic twen to 1;
-- @N: Setting default value for generic maxwlen to 0;
--
-- Resource Usage Report for spictrlx 
--
-- Mapping to part: xc3s1500fg456-4
-- Cell usage:
-- FD              15 uses
-- FDE             347 uses
-- FDR             38 uses
-- FDRE            59 uses
-- FDRSE           5 uses
-- FDS             11 uses
-- FDSE            6 uses
-- GND             1 use
-- MUXCY_L         23 uses
-- MUXF5           68 uses
-- MUXF6           13 uses
-- MUXF7           3 uses
-- MUXF8           1 use
-- VCC             1 use
-- XORCY           26 uses
-- LUT1            25 uses
-- LUT2            86 uses
-- LUT3            222 uses
-- LUT4            340 uses
--
-- I/O Register bits:                  0
-- Register bits not including I/Os:   481 (1%)
--
-- RAM/ROM usage summary
-- Dual Port Rams (RAM16X1D): 32
--
-- Total load per clock:
--    spictrlx|clk: 513
--
--Mapping Summary:
--Total  LUTs: 737 (2%)
--
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify_components_all;
library UNISIM;
use UNISIM.VCOMPONENTS.all;

entity spictrl_unisim_comb1 is
port(
  rstn :  in std_logic;
  clk :  in std_logic;
  apbi_psel :  in std_logic;
  apbi_penable :  in std_logic;
  apbi_paddr : in std_logic_vector(31 downto 0);
  apbi_pwrite :  in std_logic;
  apbi_pwdata : in std_logic_vector(31 downto 0);
  apbi_testen :  in std_logic;
  apbi_testrst :  in std_logic;
  apbi_scanen :  in std_logic;
  apbi_testoen :  in std_logic;
  apbo_prdata : out std_logic_vector(31 downto 0);
  apbo_pirq :  out std_logic;
  spii_miso :  in std_logic;
  spii_mosi :  in std_logic;
  spii_sck :  in std_logic;
  spii_spisel :  in std_logic;
  spii_astart :  in std_logic;
  spio_miso :  out std_logic;
  spio_misooen :  out std_logic;
  spio_mosi :  out std_logic;
  spio_mosioen :  out std_logic;
  spio_sck :  out std_logic;
  spio_sckoen :  out std_logic;
  spio_enable :  out std_logic;
  spio_astart :  out std_logic;
  slvsel : out std_logic_vector(31 downto 0));
end spictrl_unisim_comb1;

architecture beh of spictrl_unisim_comb1 is
  signal R_MODE_LEN : std_logic_vector(3 downto 0);
  signal R_CGCNT : std_logic_vector(5 downto 0);
  signal R_DIVCNT : std_logic_vector(9 downto 0);
  signal R_RFREECNT : std_logic_vector(3 downto 0);
  signal R_TFREECNT : std_logic_vector(3 downto 0);
  signal R_RXFIFO : std_logic_vector(31 downto 0);
  signal R_RDFI : std_logic_vector(2 downto 0);
  signal R_RXD : std_logic_vector(31 downto 0);
  signal R_RDLI : std_logic_vector(2 downto 0);
  signal R_TDLI : std_logic_vector(2 downto 0);
  signal R_SYNCSAMP : std_logic_vector(1 downto 0);
  signal R_TDFI : std_logic_vector(2 downto 0);
  signal COMB_TINDEX_1 : std_logic_vector(4 downto 0);
  signal R_TBITCNT : std_logic_vector(4 downto 0);
  signal R_MODE_PM : std_logic_vector(3 downto 0);
  signal UN152_CHANGE_7 : std_logic_vector(30 downto 0);
  signal R_TXFIFO_0 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_1 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_2 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_3 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_4 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_5 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_6 : std_logic_vector(31 downto 0);
  signal R_TXFIFO_7 : std_logic_vector(31 downto 0);
  signal R_MODE_CG : std_logic_vector(4 downto 0);
  signal R_TD : std_logic_vector(31 downto 0);
  signal R_RBITCNT : std_logic_vector(4 downto 0);
  signal R_RD : std_logic_vector(31 downto 0);
  signal COMB_V_RD_3 : std_logic_vector(29 downto 2);
  signal R_TFREECNT_RNI919U1_0 : std_logic_vector(0 to 0);
  signal R_TFREECNT_RNID3142 : std_logic_vector(1 to 1);
  signal R_TFREECNT_RNIG5GJ2 : std_logic_vector(2 to 2);
  signal R_MODE_PM_RNIOEJG : std_logic_vector(2 to 2);
  signal R_TFREECNT_RNIABDRE : std_logic_vector(0 to 0);
  signal R_TDFI_RNO : std_logic_vector(2 downto 0);
  signal R_TDLI_RNO : std_logic_vector(2 downto 0);
  signal COMB_V_TFREECNT_30 : std_logic_vector(3 to 3);
  signal COMB_V_DIVCNT_1 : std_logic_vector(9 downto 0);
  signal UN1_RELOAD : std_logic_vector(5 downto 2);
  signal COMB_V_TXFIFO_0_5_0 : std_logic_vector(31 downto 1);
  signal R_TDLI_RNIJFCB1_6 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_5 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_4 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_3 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_2 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_1 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_0 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1 : std_logic_vector(2 to 2);
  signal UN152_CHANGE_1 : std_logic_vector(29 downto 1);
  signal UN152_CHANGE_2 : std_logic_vector(29 downto 1);
  signal UN152_CHANGE_3 : std_logic_vector(30 downto 3);
  signal UN152_CHANGE_4 : std_logic_vector(29 downto 3);
  signal UN152_CHANGE_5 : std_logic_vector(29 downto 3);
  signal UN152_CHANGE_6 : std_logic_vector(30 downto 3);
  signal R_RD_M_0 : std_logic_vector(15 to 15);
  signal R_RD_M : std_logic_vector(14 downto 0);
  signal RDATA : std_logic_vector(19 downto 2);
  signal LEN_1_0 : std_logic_vector(3 downto 1);
  signal COMB_V_TXFIFO_0_5 : std_logic_vector(0 to 0);
  signal COMB_V_TXFIFO_4_5 : std_logic_vector(0 to 0);
  signal COMB_V_DIVCNT_5 : std_logic_vector(9 downto 0);
  signal UN1_R_RFREECNT_0 : std_logic_vector(3 downto 0);
  signal UN1_V_TXFIFO_76_0_I : std_logic_vector(3 to 3);
  signal R_TBITCNT_LM : std_logic_vector(4 downto 0);
  signal R_TBITCNT_QXU : std_logic_vector(3 downto 1);
  signal R_TBITCNT_CRY : std_logic_vector(3 downto 1);
  signal R_TBITCNT_S : std_logic_vector(4 downto 1);
  signal R_CGCNT_CRY : std_logic_vector(4 downto 0);
  signal R_CGCNT_S : std_logic_vector(5 downto 0);
  signal R_CGCNT_LM : std_logic_vector(5 downto 0);
  signal R_CGCNT_QXU : std_logic_vector(5 downto 1);
  signal R_RBITCNT_QXU : std_logic_vector(3 downto 0);
  signal R_RBITCNT_LM : std_logic_vector(4 downto 0);
  signal R_RBITCNT_CRY : std_logic_vector(3 downto 1);
  signal R_RBITCNT_S : std_logic_vector(4 downto 1);
  signal APBO_PRDATA_0_IV_0 : std_logic_vector(31 downto 3);
  signal APBO_PRDATA_0_IV_1 : std_logic_vector(10 downto 8);
  signal APBO_PRDATA_0_IV_I_0 : std_logic_vector(29 to 29);
  signal APBO_PRDATA_IV_1 : std_logic_vector(11 to 11);
  signal APBO_PRDATA_IV_2 : std_logic_vector(11 to 11);
  signal COMB_V_RD_3_I_0 : std_logic_vector(20 downto 11);
  signal UN152_CHANGE_3_AM : std_logic_vector(30 downto 14);
  signal UN152_CHANGE_3_BM : std_logic_vector(30 downto 14);
  signal UN152_CHANGE_6_AM : std_logic_vector(30 downto 14);
  signal UN152_CHANGE_6_BM : std_logic_vector(30 downto 14);
  signal UN152_CHANGE_7_AM : std_logic_vector(28 downto 0);
  signal UN152_CHANGE_7_BM : std_logic_vector(28 downto 0);
  signal COMB_V_DIVCNT_1_0_AM : std_logic_vector(4 downto 2);
  signal COMB_V_DIVCNT_1_0_BM : std_logic_vector(4 downto 2);
  signal UN1_RELOAD_AM : std_logic_vector(3 downto 2);
  signal UN1_RELOAD_BM : std_logic_vector(3 downto 2);
  signal R_TBITCNT_LM_0_1 : std_logic_vector(0 to 0);
  signal UN152_CHANGE_7_BM_1 : std_logic_vector(28 downto 0);
  signal UN152_CHANGE_7_AM_1 : std_logic_vector(28 downto 0);
  signal R_TFREECNT_FAST : std_logic_vector(3 downto 0);
  signal R_TFREECNT_RNIA67S5_0 : std_logic_vector(2 to 2);
  signal R_TFREECNT_RNIA67S5 : std_logic_vector(2 to 2);
  signal R_TFREECNT_RNIJ7GQ7 : std_logic_vector(0 to 0);
  signal R_MODE_LEN_FAST : std_logic_vector(3 downto 0);
  signal R_SPII_1_SPISEL : std_logic ;
  signal R_MODE_TW : std_logic ;
  signal R_RD_FREE : std_logic ;
  signal R_MODE_REV : std_logic ;
  signal R_TWDIR : std_logic ;
  signal R_MODE_MS : std_logic ;
  signal R_UF : std_logic ;
  signal R_MODE_FACT : std_logic ;
  signal R_OV : std_logic ;
  signal R_MODE_CPHA : std_logic ;
  signal R_MODE_EN : std_logic ;
  signal R_TD_OCC : std_logic ;
  signal R_EVENT_NF : std_logic ;
  signal R_EVENT_NE : std_logic ;
  signal R_MODE_TTO : std_logic ;
  signal R_MODE_DIV16 : std_logic ;
  signal R_SAMP : std_logic ;
  signal R_CHNG : std_logic ;
  signal R_EVENT_MME : std_logic ;
  signal R_MODE_LOOPB : std_logic ;
  signal R_EVENT_OV : std_logic ;
  signal R_RUNNING : std_logic ;
  signal R_EVENT_TIP : std_logic ;
  signal R_EVENT_LT : std_logic ;
  signal R_SPII_0_MISO : std_logic ;
  signal R_SPII_0_MOSI : std_logic ;
  signal R_SPII_0_SCK : std_logic ;
  signal R_SPII_0_SPISEL : std_logic ;
  signal R_RXDONE : std_logic ;
  signal R_SPII_1_SCK : std_logic ;
  signal R_PSCK : std_logic ;
  signal R_MODE_CPOL : std_logic ;
  signal R_INCRDLI : std_logic ;
  signal R_TOGGLE : std_logic ;
  signal R_SPII_1_MISO : std_logic ;
  signal R_SPII_1_MOSI : std_logic ;
  signal R_EVENT_UN : std_logic ;
  signal R_MASK_NF : std_logic ;
  signal COMB_UN1_R_MODE_EN : std_logic ;
  signal REG_R_SPIO_SCK_3 : std_logic ;
  signal R_MASK_MME : std_logic ;
  signal COMB_OP_EQ_V_SPIO_SCK2 : std_logic ;
  signal TINDEX_0_SQMUXA : std_logic ;
  signal TINDEX_1_SQMUXA : std_logic ;
  signal R_OV2 : std_logic ;
  signal R_RXDONE2 : std_logic ;
  signal COMB_V_MODE_EN_1 : std_logic ;
  signal COMB_V_MODE_MS_1 : std_logic ;
  signal V_EVENT_LT_1_SQMUXA : std_logic ;
  signal V_MASK_LT_1_SQMUXA : std_logic ;
  signal V_MODE_CPHA_0_SQMUXA : std_logic ;
  signal COMB_V_RD4 : std_logic ;
  signal APBOUT_2_SQMUXA : std_logic ;
  signal APBOUT_3_SQMUXA : std_logic ;
  signal R_MASK_LT : std_logic ;
  signal R_MASK_NE : std_logic ;
  signal R_MASK_OV : std_logic ;
  signal R_MASK_TIP : std_logic ;
  signal R_MASK_UN : std_logic ;
  signal COMB_V_EVENT_UN_3 : std_logic ;
  signal V_EVENT_NF_0_SQMUXA : std_logic ;
  signal V_EVENT_NE_0_SQMUXA_1 : std_logic ;
  signal V_TD_OCC_1_SQMUXA : std_logic ;
  signal UN1_R_DIVCNT_1_S_1 : std_logic ;
  signal UN1_R_DIVCNT_1_S_2 : std_logic ;
  signal UN1_R_DIVCNT_1_S_3 : std_logic ;
  signal UN1_R_DIVCNT_1_S_4 : std_logic ;
  signal UN1_R_DIVCNT_1_S_5 : std_logic ;
  signal UN1_R_DIVCNT_1_S_6 : std_logic ;
  signal UN1_R_DIVCNT_1_S_7 : std_logic ;
  signal UN1_R_DIVCNT_1_S_8 : std_logic ;
  signal UN1_R_DIVCNT_1_S_9 : std_logic ;
  signal V_TOGGLE_0_SQMUXA : std_logic ;
  signal V_EVENT_OV_0_SQMUXA : std_logic ;
  signal COMB_CHANGE_1_1 : std_logic ;
  signal COMB_UN40_CHANGE_RNIDTL41_0 : std_logic ;
  signal R_MODE_DIV16_RNIPI88 : std_logic ;
  signal R_MODE_DIV16_RNIOUDC : std_logic ;
  signal COMB_V_INCRDLI_1 : std_logic ;
  signal V_EVENT_TIP_0_SQMUXA_1 : std_logic ;
  signal COMB_V_TXFIFO_76_RNI32075 : std_logic ;
  signal R_EVENT_LTD_1 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC5 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC6 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC7 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9 : std_logic ;
  signal R_LST : std_logic ;
  signal COMB_V_LST_1 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_18 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_21 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_23 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_24 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_28 : std_logic ;
  signal N_2182_0 : std_logic ;
  signal COMB_UN27_CHANGE : std_logic ;
  signal COMB_V_UF_7 : std_logic ;
  signal UN1_V_OV10_0 : std_logic ;
  signal COMB_V_SPIO_MOSIOEN25 : std_logic ;
  signal V_IRQ_0_SQMUXA_3_1 : std_logic ;
  signal V_IRQ_0_SQMUXA_2_1 : std_logic ;
  signal V_TWDIR_0_SQMUXA : std_logic ;
  signal R_RXFIFO_N_4 : std_logic ;
  signal R_RXFIFO_N_5 : std_logic ;
  signal R_RXFIFO_N_6 : std_logic ;
  signal R_RXFIFO_N_7 : std_logic ;
  signal R_RXFIFO_N_8 : std_logic ;
  signal R_RXFIFO_N_9 : std_logic ;
  signal R_RXFIFO_N_10 : std_logic ;
  signal R_RXFIFO_N_11 : std_logic ;
  signal R_RXFIFO_N_12 : std_logic ;
  signal R_RXFIFO_N_13 : std_logic ;
  signal R_RXFIFO_N_14 : std_logic ;
  signal R_RXFIFO_N_15 : std_logic ;
  signal R_RXFIFO_N_16 : std_logic ;
  signal R_RXFIFO_N_17 : std_logic ;
  signal R_RXFIFO_N_18 : std_logic ;
  signal R_RXFIFO_N_19 : std_logic ;
  signal R_RXFIFO_N_20 : std_logic ;
  signal R_RXFIFO_N_21 : std_logic ;
  signal R_RXFIFO_N_22 : std_logic ;
  signal R_RXFIFO_N_23 : std_logic ;
  signal R_RXFIFO_N_24 : std_logic ;
  signal R_RXFIFO_N_25 : std_logic ;
  signal R_RXFIFO_N_26 : std_logic ;
  signal R_RXFIFO_N_27 : std_logic ;
  signal R_RXFIFO_N_28 : std_logic ;
  signal R_RXFIFO_N_29 : std_logic ;
  signal R_RXFIFO_N_30 : std_logic ;
  signal R_RXFIFO_N_31 : std_logic ;
  signal R_RXFIFO_N_32 : std_logic ;
  signal R_RXFIFO_N_33 : std_logic ;
  signal R_RXFIFO_N_34 : std_logic ;
  signal R_RXFIFO_N_35 : std_logic ;
  signal R_SYNCSAMPC_1 : std_logic ;
  signal COMB_V_INCRDLI_5 : std_logic ;
  signal COMB_UN30_SAMPLE : std_logic ;
  signal V_OV_0_SQMUXA_1 : std_logic ;
  signal COMB_UN1_SAMPLE : std_logic ;
  signal V_SPIO_MOSIOEN_2_SQMUXA : std_logic ;
  signal N_833 : std_logic ;
  signal N_835 : std_logic ;
  signal N_836 : std_logic ;
  signal N_839 : std_logic ;
  signal N_840 : std_logic ;
  signal N_842 : std_logic ;
  signal N_843 : std_logic ;
  signal N_853 : std_logic ;
  signal N_856 : std_logic ;
  signal N_860 : std_logic ;
  signal N_102 : std_logic ;
  signal N_103 : std_logic ;
  signal N_104 : std_logic ;
  signal N_105 : std_logic ;
  signal N_106 : std_logic ;
  signal N_107 : std_logic ;
  signal N_108 : std_logic ;
  signal N_109 : std_logic ;
  signal N_116 : std_logic ;
  signal N_850 : std_logic ;
  signal N_851 : std_logic ;
  signal N_857 : std_logic ;
  signal N_858 : std_logic ;
  signal V_TDFI_0_SQMUXA_1 : std_logic ;
  signal COMB_UN54_SAMPLE : std_logic ;
  signal APBOUT_4_SQMUXA : std_logic ;
  signal APBOUT_5_SQMUXA : std_logic ;
  signal COMB_UN30_APBI_PSEL : std_logic ;
  signal COMB_SPILEN_LEN : std_logic ;
  signal COMB_UN1_R_RUNNING_1 : std_logic ;
  signal N_2120_0 : std_logic ;
  signal COMB_UN1_APBI_PSEL : std_logic ;
  signal N_628 : std_logic ;
  signal COMB_UN17_APBI_PSEL : std_logic ;
  signal UN1_V_CGCNT_0_SQMUXA_2_0 : std_logic ;
  signal CO0_0 : std_logic ;
  signal COMB_V_SPIO_SCK20 : std_logic ;
  signal V_CGCNT_0_SQMUXA : std_logic ;
  signal V_DIVCNT_0_SQMUXA_1 : std_logic ;
  signal COMB_CHANGE_4 : std_logic ;
  signal R_MASK_UN_M : std_logic ;
  signal N_141 : std_logic ;
  signal V_CGCNT_0_SQMUXA_1 : std_logic ;
  signal V_CGCNT_0_SQMUXA_2 : std_logic ;
  signal COMB_UN1_R_MODE_EN_2 : std_logic ;
  signal COMB_UN21_SAMPLE_0 : std_logic ;
  signal N_62 : std_logic ;
  signal N_131 : std_logic ;
  signal N_137 : std_logic ;
  signal N_83 : std_logic ;
  signal N_40 : std_logic ;
  signal N_84 : std_logic ;
  signal N_2122_0 : std_logic ;
  signal N_1752_0 : std_logic ;
  signal COMB_SLV_START_UN13_AM_EN : std_logic ;
  signal V_CHNG_0_SQMUXA : std_logic ;
  signal SAMPLE_0_SQMUXA_1 : std_logic ;
  signal N_2161_0 : std_logic ;
  signal N_2178 : std_logic ;
  signal N_132 : std_logic ;
  signal N_93 : std_logic ;
  signal N_2159_0 : std_logic ;
  signal N_885 : std_logic ;
  signal COMB_V_TXFIFO_76 : std_logic ;
  signal V_TDFI_0_SQMUXA : std_logic ;
  signal V_TXFIFO_7_1_SQMUXA_1_4 : std_logic ;
  signal V_TXFIFO_6_1_SQMUXA_1_4 : std_logic ;
  signal COMB_UN40_CHANGE : std_logic ;
  signal N_2121_0 : std_logic ;
  signal SAMPLE_0_SQMUXA_2 : std_logic ;
  signal COMB_UN65_SAMPLE_0 : std_logic ;
  signal COMB_UN1_R_TFREECNT : std_logic ;
  signal COMB_UN1_R_TFREECNT_S0 : std_logic ;
  signal N_2167 : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_M2 : std_logic ;
  signal COMB_UN47_SAMPLE_0 : std_logic ;
  signal V_PSCK_0_SQMUXA : std_logic ;
  signal COMB_V_CHNG_1 : std_logic ;
  signal N_2137 : std_logic ;
  signal COMB_UN16_SAMPLE : std_logic ;
  signal V_IRQ_0_SQMUXA_1 : std_logic ;
  signal V_IRQ_0_SQMUXA_2 : std_logic ;
  signal COMB_UN1_AM_EN : std_logic ;
  signal R_MASK_OV_M : std_logic ;
  signal N_120 : std_logic ;
  signal N_846 : std_logic ;
  signal N_861 : std_logic ;
  signal N_838 : std_logic ;
  signal N_832 : std_logic ;
  signal N_1566 : std_logic ;
  signal N_1659 : std_logic ;
  signal N_1550 : std_logic ;
  signal N_1643 : std_logic ;
  signal N_1597 : std_logic ;
  signal N_1628 : std_logic ;
  signal N_1581 : std_logic ;
  signal N_1612 : std_logic ;
  signal N_1504 : std_logic ;
  signal N_1535 : std_logic ;
  signal N_1488 : std_logic ;
  signal N_1519 : std_logic ;
  signal COMB_UN30_AM_EN : std_logic ;
  signal COMB_UN26_AM_EN_0 : std_logic ;
  signal N_2216 : std_logic ;
  signal COMB_UN1_R_RUNNING_M : std_logic ;
  signal COMB_INDATA_1 : std_logic ;
  signal N_1458 : std_logic ;
  signal COMB_INDATA_1_SN_N_6_0 : std_logic ;
  signal COMB_V_EVENT_NF3 : std_logic ;
  signal COMB_UN1_R_MODE_TW : std_logic ;
  signal CO0_3 : std_logic ;
  signal V_TD_OCC_1_SQMUXA_4 : std_logic ;
  signal COMB_UN40_SAMPLE : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_SM0_0 : std_logic ;
  signal N_136 : std_logic ;
  signal N_1746_1 : std_logic ;
  signal N_1746 : std_logic ;
  signal N_847 : std_logic ;
  signal N_848 : std_logic ;
  signal V_SPIO_MOSIOEN_0_SQMUXA_1 : std_logic ;
  signal N_1560 : std_logic ;
  signal N_1653 : std_logic ;
  signal N_1556 : std_logic ;
  signal N_1552 : std_logic ;
  signal N_1549 : std_logic ;
  signal N_1548 : std_logic ;
  signal N_1540 : std_logic ;
  signal N_1633 : std_logic ;
  signal N_1536 : std_logic ;
  signal N_1629 : std_logic ;
  signal N_1571 : std_logic ;
  signal N_1567 : std_logic ;
  signal N_1598 : std_logic ;
  signal N_1498 : std_logic ;
  signal N_1529 : std_logic ;
  signal N_122 : std_logic ;
  signal N_44 : std_logic ;
  signal N_139 : std_logic ;
  signal N_81 : std_logic ;
  signal N_134 : std_logic ;
  signal N_94 : std_logic ;
  signal N_95 : std_logic ;
  signal N_135 : std_logic ;
  signal N_118 : std_logic ;
  signal COMB_UN4_ASEL_EN_0 : std_logic ;
  signal N_795 : std_logic ;
  signal COMB_RELOAD_1_0 : std_logic ;
  signal N_789 : std_logic ;
  signal N_629 : std_logic ;
  signal N_875 : std_logic ;
  signal N_874 : std_logic ;
  signal N_630 : std_logic ;
  signal N_873 : std_logic ;
  signal N_870 : std_logic ;
  signal N_788 : std_logic ;
  signal N_787 : std_logic ;
  signal N_786 : std_logic ;
  signal R_EVENT_MMECE : std_logic ;
  signal R_EVENT_OVCE : std_logic ;
  signal UN1_R_RFREECNT_AXB_0 : std_logic ;
  signal UN1_R_RFREECNT_CRY_0 : std_logic ;
  signal UN1_R_RFREECNT_AXB_1 : std_logic ;
  signal UN1_R_RFREECNT_CRY_1 : std_logic ;
  signal UN1_R_RFREECNT_AXB_2 : std_logic ;
  signal UN1_R_RFREECNT_CRY_2 : std_logic ;
  signal UN1_R_RFREECNT_AXB_3 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_0 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_1 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_2 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_3 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_4 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_5 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_6 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_7 : std_logic ;
  signal UN1_R_DIVCNT_1_CRY_8 : std_logic ;
  signal UN1_R_TFREECNT_1_P7 : std_logic ;
  signal UN1_R_TFREECNT_1_AXB0 : std_logic ;
  signal UN1_R_TFREECNT_1_AXB3 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_P4 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_P7 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_C9 : std_logic ;
  signal COMB_V_TFREECNT_P4 : std_logic ;
  signal COMB_OP_EQ_V_SPIO_SCK2_5 : std_logic ;
  signal COMB_OP_EQ_V_SPIO_SCK2_6 : std_logic ;
  signal COMB_UN40_SAMPLE_NE_0 : std_logic ;
  signal COMB_UN40_SAMPLE_NE_1 : std_logic ;
  signal COMB_V_EVENT_LT6_3 : std_logic ;
  signal COMB_V_IRQ_1_IV_M5_E : std_logic ;
  signal COMB_V_TWDIR_1_IV_0_TZ : std_logic ;
  signal V_LST_1_SQMUXA_0 : std_logic ;
  signal COMB_UN9_APBI_PSEL_0 : std_logic ;
  signal RDATA_2_0_1 : std_logic ;
  signal V_IRQ_0_SQMUXA_1_0 : std_logic ;
  signal COMB_SAMPLE_6_0_I : std_logic ;
  signal UN1_R_DIVCNT_1_I : std_logic ;
  signal RSTN_I : std_logic ;
  signal V_OV_0_SQMUXA_1_I : std_logic ;
  signal COMB_V_TXFIFO_76_I : std_logic ;
  signal COMB_V_RD4_I : std_logic ;
  signal COMB_V_RXDONE_2_0_I : std_logic ;
  signal COMB_UN1_R_SYNCSAMP_0_I : std_logic ;
  signal N_16_I : std_logic ;
  signal N_14_I : std_logic ;
  signal N_12_I : std_logic ;
  signal N_117_I : std_logic ;
  signal N_30_I : std_logic ;
  signal N_28_I : std_logic ;
  signal N_26_I : std_logic ;
  signal N_24_I : std_logic ;
  signal N_22_I : std_logic ;
  signal N_20_I : std_logic ;
  signal N_18_I : std_logic ;
  signal N_123_I : std_logic ;
  signal N_121_I : std_logic ;
  signal N_119_I : std_logic ;
  signal N_2120_0_I : std_logic ;
  signal V_SPIO_SCKOEN_1_SQMUXA_I : std_logic ;
  signal UN1_V_SPIO_MOSIOEN24_0_I : std_logic ;
  signal V_SPIO_MISOOEN_2_SQMUXA_I : std_logic ;
  signal V_PSCK_1_SQMUXA_I : std_logic ;
  signal V_MODE_EN_1_SQMUXA_I : std_logic ;
  signal V_RD_FREE_0_SQMUXA_I : std_logic ;
  signal N_2109_0_I : std_logic ;
  signal V_SAMP_2_SQMUXA_I : std_logic ;
  signal V_TD_OCC_0_SQMUXA_I : std_logic ;
  signal V_CHNG_2_SQMUXA_I : std_logic ;
  signal V_SPIO_SCK_1_SQMUXA_I : std_logic ;
  signal COMB_V_TWDIR_1_0_I : std_logic ;
  signal V_TWDIR_2_SQMUXA_I : std_logic ;
  signal COMB_V_SPIO_MISO_3_0_I : std_logic ;
  signal COMB_UN133_CHANGE_0_I : std_logic ;
  signal V_RXDONE2_1_SQMUXA_I : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_0_I : std_logic ;
  signal V_SPIO_MOSIOEN_4_SQMUXA_I : std_logic ;
  signal V_EVENT_TIP_2_SQMUXA_I : std_logic ;
  signal V_LST_1_SQMUXA_1_I : std_logic ;
  signal R_RBITCNTE_0_I : std_logic ;
  signal R_CGCNTE_0_I : std_logic ;
  signal R_TBITCNTE_0_I : std_logic ;
  signal R_EVENT_UNCE : std_logic ;
  signal R_SYNCSAMPC : std_logic ;
  signal R_MODE_EN_I : std_logic ;
  signal R_RDFIC : std_logic ;
  signal R_RDFIC_0 : std_logic ;
  signal R_RDFIC_1 : std_logic ;
  signal R_RDLIC : std_logic ;
  signal R_RDLIC_0 : std_logic ;
  signal R_RDLIC_1 : std_logic ;
  signal R_RUNNINGC : std_logic ;
  signal R_TXFIFO_0S_I : std_logic ;
  signal R_TXFIFO_7S_I : std_logic ;
  signal R_TXFIFO_6S_I : std_logic ;
  signal R_TXFIFO_5S_I : std_logic ;
  signal R_TXFIFO_4S_I : std_logic ;
  signal R_TXFIFO_3S_I : std_logic ;
  signal R_TXFIFO_2S_I : std_logic ;
  signal R_TXFIFO_1S_I : std_logic ;
  signal COMB_UN17_APBI_PSEL_1 : std_logic ;
  signal COMB_UN13_APBI_PSEL_2 : std_logic ;
  signal APBOUT_0_SQMUXA_I_I_A2_3 : std_logic ;
  signal COMB_V_PSCK_1_0_159_I_O4_0 : std_logic ;
  signal V_TD_OCC_1_SQMUXA_2 : std_logic ;
  signal COMB_UN4_ASEL_EN_MB_1_0 : std_logic ;
  signal COMB_OP_EQ_UN2_ASEL_EN_3 : std_logic ;
  signal COMB_UN16_SAMPLE_1 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_1_5 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_1_6 : std_logic ;
  signal COMB_V_IRQ_1_IV_M3_E_0 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_0_2 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_0 : std_logic ;
  signal COMB_CHANGE_4_1 : std_logic ;
  signal V_TOGGLE_0_SQMUXA_A0_1 : std_logic ;
  signal R_SYNCSAMPC_0 : std_logic ;
  signal COMB_UN27_CHANGE_NE_0 : std_logic ;
  signal COMB_UN27_CHANGE_NE_1 : std_logic ;
  signal V_IRQ_0_SQMUXA_3_2 : std_logic ;
  signal UN1_R_MODE_EN_184_0 : std_logic ;
  signal UN1_R_MODE_EN_184_1 : std_logic ;
  signal COMB_V_RUNNING_9_IV_265_A0_1 : std_logic ;
  signal COMB_V_RUNNING_9_IV_265_A0_2 : std_logic ;
  signal COMB_V_RUNNING_9_IV_265_A0_5 : std_logic ;
  signal COMB_V_RUNNING_9_IV_265_A0_6 : std_logic ;
  signal R_RUNNINGC_1 : std_logic ;
  signal V_TXFIFO_0_1_SQMUXA_1_1 : std_logic ;
  signal V_TXFIFO_4_1_SQMUXA_1_2 : std_logic ;
  signal COMB_UN1_R_MODE_EN_2_0 : std_logic ;
  signal R_TXFIFO_1SR_0 : std_logic ;
  signal R_TXFIFO_2SR_0 : std_logic ;
  signal R_TXFIFO_6SR_0 : std_logic ;
  signal R_TXFIFO_7SR_0 : std_logic ;
  signal R_TXFIFO_3SR_0 : std_logic ;
  signal R_TXFIFO_5SR_0 : std_logic ;
  signal COMB_V_EVENT_LT6_3_1 : std_logic ;
  signal COMB_V_IRQ_1_IV_M6_0 : std_logic ;
  signal COMB_V_IRQ_1_IV_M6_2 : std_logic ;
  signal UN1_R_DIVCNT_1_S_9_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_8_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_7_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_6_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_5_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_4_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_3_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_2_SF : std_logic ;
  signal UN1_R_DIVCNT_1_S_1_SF : std_logic ;
  signal COMB_INDATA_1_U_1 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_19_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_19_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_23_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_23_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_24_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_24_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_26_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_26_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_27_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_27_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_20_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_20_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_17_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_17_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_16_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_16_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_14_1 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_7_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_7_BM : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_M2_AM : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_M2_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_15_1 : std_logic ;
  signal R_IRQD_0 : std_logic ;
  signal R_EVENT_LTD_0 : std_logic ;
  signal R_RXDONE2E_0 : std_logic ;
  signal G1 : std_logic ;
  signal G2_5 : std_logic ;
  signal G1_0_1_0 : std_logic ;
  signal G1_0 : std_logic ;
  signal G1_1 : std_logic ;
  signal G2_0_3 : std_logic ;
  signal G1_0_1_1 : std_logic ;
  signal G1_0_3 : std_logic ;
  signal G0_0_0 : std_logic ;
  signal G0_1_0 : std_logic ;
  signal G1_1_1 : std_logic ;
  signal R_SPII_1_SPISEL_FAST : std_logic ;
  signal UN1_R_TFREECNT_1_AXB0_FAST : std_logic ;
  signal R_MODE_CPOL_FAST : std_logic ;
  signal COMB_CHANGE_4_1_0 : std_logic ;
  signal G0_23_1 : std_logic ;
  signal G0_14_1 : std_logic ;
  signal R_EVENT_LTD_1_1 : std_logic ;
  signal R_IRQD_1 : std_logic ;
  signal G0_24_SX : std_logic ;
  signal COMB_UN40_CHANGE_RNIN3T07 : std_logic ;
  signal R_IRQD_1_X0 : std_logic ;
  signal G0_0_A3_0_0_SX : std_logic ;
  signal R_LST_RNO_7 : std_logic ;
  signal R_LST_RNO_8 : std_logic ;
  signal SAMPLE_0_SQMUXA_2_SX : std_logic ;
  signal G0_6_1_0 : std_logic ;
  signal R_MODE_EN_FAST : std_logic ;
  signal COMB_V_MODE_EN_1_FAST : std_logic ;
  signal COMB_UN4_ASEL_EN_SN : std_logic ;
  signal R_SPIO_SCK_FAST : std_logic ;
  signal REG_R_SPIO_SCK_3_FAST : std_logic ;
  signal R_MODE_MS_FAST : std_logic ;
  signal COMB_V_MODE_MS_1_FAST : std_logic ;
  signal R_MODE_MS_REP1 : std_logic ;
  signal COMB_V_MODE_MS_1_REP1 : std_logic ;
  signal R_RUNNING_FAST : std_logic ;
  signal R_RUNNINGC_FAST : std_logic ;
  signal COMB_UN4_ASEL_EN_MB_1 : std_logic ;
  signal COMB_CHANGE_4_1_0_1 : std_logic ;
  signal SPIO_MOSI_5 : std_logic ;
  signal SPIO_SCK_6 : std_logic ;
  signal NN_1 : std_logic ;
  signal NN_2 : std_logic ;
  component RAM16X1D

    generic (
      INIT : bit_vector := X"0000"
    );
    port(
      DPO :  out std_logic;
      SPO :  out std_logic;
      A0 :  in std_logic;
      A1 :  in std_logic;
      A2 :  in std_logic;
      A3 :  in std_logic;
      D :  in std_logic;
      DPRA0 :  in std_logic;
      DPRA1 :  in std_logic;
      DPRA2 :  in std_logic;
      DPRA3 :  in std_logic;
      WCLK :  in std_logic;
      WE :  in std_logic  );
  end component;
begin
UN1_R_DIVCNT_1_I_Z1574: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(0),
  O => UN1_R_DIVCNT_1_I);
R_DIVCNT_RNIN1QEq1z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(1),
  O => UN1_R_DIVCNT_1_S_1_SF);
R_DIVCNT_RNIO1QEq2z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(2),
  O => UN1_R_DIVCNT_1_S_2_SF);
R_DIVCNT_RNIP1QEq3z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(3),
  O => UN1_R_DIVCNT_1_S_3_SF);
R_DIVCNT_RNIQ1QEq4z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(4),
  O => UN1_R_DIVCNT_1_S_4_SF);
R_DIVCNT_RNIR1QEq5z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(5),
  O => UN1_R_DIVCNT_1_S_5_SF);
R_DIVCNT_RNIS1QEq6z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(6),
  O => UN1_R_DIVCNT_1_S_6_SF);
R_DIVCNT_RNIT1QEq7z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(7),
  O => UN1_R_DIVCNT_1_S_7_SF);
R_DIVCNT_RNIU1QEq8z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(8),
  O => UN1_R_DIVCNT_1_S_8_SF);
R_TBITCNT_QXUq1z_Z1583: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(1),
  O => R_TBITCNT_QXU(1));
R_TBITCNT_QXUq2z_Z1584: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(2),
  O => R_TBITCNT_QXU(2));
R_TBITCNT_QXUq3z_Z1585: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(3),
  O => R_TBITCNT_QXU(3));
R_CGCNT_QXUq0z: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(0),
  O => R_CGCNT_S(0));
R_CGCNT_QXUq1z_Z1587: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(1),
  O => R_CGCNT_QXU(1));
R_CGCNT_QXUq2z_Z1588: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(2),
  O => R_CGCNT_QXU(2));
R_CGCNT_QXUq3z_Z1589: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(3),
  O => R_CGCNT_QXU(3));
R_CGCNT_QXUq4z_Z1590: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(4),
  O => R_CGCNT_QXU(4));
R_RBITCNT_QXUq1z_Z1591: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(1),
  O => R_RBITCNT_QXU(1));
R_RBITCNT_QXUq2z_Z1592: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(2),
  O => R_RBITCNT_QXU(2));
R_RBITCNT_QXUq3z_Z1593: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(3),
  O => R_RBITCNT_QXU(3));
R_MODE_EN_RNIVS7B_0: INV port map (
    I => N_2120_0,
    O => N_2120_0_I);
R_MODE_EN_RNIKNV8: INV port map (
    I => R_MODE_EN,
    O => R_MODE_EN_I);
RSTN_RNIB582: INV port map (
    I => rstn,
    O => RSTN_I);
R_IRQ: FD port map (
    Q => apbo_pirq,
    D => R_IRQD_0,
    C => clk);
R_EVENT_LT_Z1598: FDR port map (
    Q => R_EVENT_LT,
    D => R_EVENT_LTD_0,
    C => clk,
    R => RSTN_I);
R_RXDONE2_Z1599: FDR port map (
    Q => R_RXDONE2,
    D => R_RXDONE2E_0,
    C => clk,
    R => N_2120_0_I);
R_CHNG_Z1600: FDE port map (
    Q => R_CHNG,
    D => COMB_V_CHNG_1,
    C => clk,
    CE => V_CHNG_2_SQMUXA_I);
R_SAMP_Z1601: FDE port map (
    Q => R_SAMP,
    D => N_2109_0_I,
    C => clk,
    CE => V_SAMP_2_SQMUXA_I);
R_PSCK_Z1602: FDE port map (
    Q => R_PSCK,
    D => N_2137,
    C => clk,
    CE => V_PSCK_1_SQMUXA_I);
R_TDq0z_Z1603: FDE port map (
    Q => R_TD(0),
    D => apbi_pwdata(0),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq1z_Z1604: FDE port map (
    Q => R_TD(1),
    D => apbi_pwdata(1),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq2z_Z1605: FDE port map (
    Q => R_TD(2),
    D => apbi_pwdata(2),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq3z_Z1606: FDE port map (
    Q => R_TD(3),
    D => apbi_pwdata(3),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq4z_Z1607: FDE port map (
    Q => R_TD(4),
    D => apbi_pwdata(4),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq5z_Z1608: FDE port map (
    Q => R_TD(5),
    D => apbi_pwdata(5),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq6z_Z1609: FDE port map (
    Q => R_TD(6),
    D => apbi_pwdata(6),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq7z_Z1610: FDE port map (
    Q => R_TD(7),
    D => apbi_pwdata(7),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq8z_Z1611: FDE port map (
    Q => R_TD(8),
    D => apbi_pwdata(8),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq9z_Z1612: FDE port map (
    Q => R_TD(9),
    D => apbi_pwdata(9),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq10z_Z1613: FDE port map (
    Q => R_TD(10),
    D => apbi_pwdata(10),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq11z_Z1614: FDE port map (
    Q => R_TD(11),
    D => apbi_pwdata(11),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq12z_Z1615: FDE port map (
    Q => R_TD(12),
    D => apbi_pwdata(12),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq13z_Z1616: FDE port map (
    Q => R_TD(13),
    D => apbi_pwdata(13),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq14z_Z1617: FDE port map (
    Q => R_TD(14),
    D => apbi_pwdata(14),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq15z_Z1618: FDE port map (
    Q => R_TD(15),
    D => apbi_pwdata(15),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq16z_Z1619: FDE port map (
    Q => R_TD(16),
    D => apbi_pwdata(16),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq17z_Z1620: FDE port map (
    Q => R_TD(17),
    D => apbi_pwdata(17),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq18z_Z1621: FDE port map (
    Q => R_TD(18),
    D => apbi_pwdata(18),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq19z_Z1622: FDE port map (
    Q => R_TD(19),
    D => apbi_pwdata(19),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq20z_Z1623: FDE port map (
    Q => R_TD(20),
    D => apbi_pwdata(20),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq21z_Z1624: FDE port map (
    Q => R_TD(21),
    D => apbi_pwdata(21),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq22z_Z1625: FDE port map (
    Q => R_TD(22),
    D => apbi_pwdata(22),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq23z_Z1626: FDE port map (
    Q => R_TD(23),
    D => apbi_pwdata(23),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq24z_Z1627: FDE port map (
    Q => R_TD(24),
    D => apbi_pwdata(24),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq25z_Z1628: FDE port map (
    Q => R_TD(25),
    D => apbi_pwdata(25),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq26z_Z1629: FDE port map (
    Q => R_TD(26),
    D => apbi_pwdata(26),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq27z_Z1630: FDE port map (
    Q => R_TD(27),
    D => apbi_pwdata(27),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq28z_Z1631: FDE port map (
    Q => R_TD(28),
    D => apbi_pwdata(28),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq29z_Z1632: FDE port map (
    Q => R_TD(29),
    D => apbi_pwdata(29),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq30z_Z1633: FDE port map (
    Q => R_TD(30),
    D => apbi_pwdata(30),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq31z_Z1634: FDE port map (
    Q => R_TD(31),
    D => apbi_pwdata(31),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_SYNCSAMPq1z_Z1635: FD port map (
    Q => R_SYNCSAMP(1),
    D => R_SYNCSAMP(0),
    C => clk);
R_TXFIFO_0q17z_Z1636: FDE port map (
    Q => R_TXFIFO_0(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q18z_Z1637: FDE port map (
    Q => R_TXFIFO_0(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q19z_Z1638: FDE port map (
    Q => R_TXFIFO_0(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q20z_Z1639: FDE port map (
    Q => R_TXFIFO_0(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q21z_Z1640: FDE port map (
    Q => R_TXFIFO_0(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q22z_Z1641: FDE port map (
    Q => R_TXFIFO_0(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q23z_Z1642: FDE port map (
    Q => R_TXFIFO_0(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q24z_Z1643: FDE port map (
    Q => R_TXFIFO_0(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q25z_Z1644: FDE port map (
    Q => R_TXFIFO_0(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q26z_Z1645: FDE port map (
    Q => R_TXFIFO_0(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q27z_Z1646: FDE port map (
    Q => R_TXFIFO_0(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q28z_Z1647: FDE port map (
    Q => R_TXFIFO_0(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q29z_Z1648: FDE port map (
    Q => R_TXFIFO_0(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q30z_Z1649: FDE port map (
    Q => R_TXFIFO_0(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q31z_Z1650: FDE port map (
    Q => R_TXFIFO_0(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q2z_Z1651: FDE port map (
    Q => R_TXFIFO_0(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q3z_Z1652: FDE port map (
    Q => R_TXFIFO_0(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q4z_Z1653: FDE port map (
    Q => R_TXFIFO_0(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q5z_Z1654: FDE port map (
    Q => R_TXFIFO_0(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q6z_Z1655: FDE port map (
    Q => R_TXFIFO_0(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q7z_Z1656: FDE port map (
    Q => R_TXFIFO_0(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q8z_Z1657: FDE port map (
    Q => R_TXFIFO_0(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q9z_Z1658: FDE port map (
    Q => R_TXFIFO_0(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q10z_Z1659: FDE port map (
    Q => R_TXFIFO_0(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q11z_Z1660: FDE port map (
    Q => R_TXFIFO_0(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q12z_Z1661: FDE port map (
    Q => R_TXFIFO_0(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q13z_Z1662: FDE port map (
    Q => R_TXFIFO_0(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q14z_Z1663: FDE port map (
    Q => R_TXFIFO_0(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q15z_Z1664: FDE port map (
    Q => R_TXFIFO_0(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q16z_Z1665: FDE port map (
    Q => R_TXFIFO_0(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q1z_Z1666: FDE port map (
    Q => R_TXFIFO_0(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_7q21z_Z1667: FDE port map (
    Q => R_TXFIFO_7(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q22z_Z1668: FDE port map (
    Q => R_TXFIFO_7(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q23z_Z1669: FDE port map (
    Q => R_TXFIFO_7(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q24z_Z1670: FDE port map (
    Q => R_TXFIFO_7(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q25z_Z1671: FDE port map (
    Q => R_TXFIFO_7(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q26z_Z1672: FDE port map (
    Q => R_TXFIFO_7(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q27z_Z1673: FDE port map (
    Q => R_TXFIFO_7(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q28z_Z1674: FDE port map (
    Q => R_TXFIFO_7(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q29z_Z1675: FDE port map (
    Q => R_TXFIFO_7(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q30z_Z1676: FDE port map (
    Q => R_TXFIFO_7(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q31z_Z1677: FDE port map (
    Q => R_TXFIFO_7(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q6z_Z1678: FDE port map (
    Q => R_TXFIFO_7(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q7z_Z1679: FDE port map (
    Q => R_TXFIFO_7(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q8z_Z1680: FDE port map (
    Q => R_TXFIFO_7(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q9z_Z1681: FDE port map (
    Q => R_TXFIFO_7(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q10z_Z1682: FDE port map (
    Q => R_TXFIFO_7(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q11z_Z1683: FDE port map (
    Q => R_TXFIFO_7(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q12z_Z1684: FDE port map (
    Q => R_TXFIFO_7(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q13z_Z1685: FDE port map (
    Q => R_TXFIFO_7(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q14z_Z1686: FDE port map (
    Q => R_TXFIFO_7(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q15z_Z1687: FDE port map (
    Q => R_TXFIFO_7(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q16z_Z1688: FDE port map (
    Q => R_TXFIFO_7(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q17z_Z1689: FDE port map (
    Q => R_TXFIFO_7(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q18z_Z1690: FDE port map (
    Q => R_TXFIFO_7(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q19z_Z1691: FDE port map (
    Q => R_TXFIFO_7(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q20z_Z1692: FDE port map (
    Q => R_TXFIFO_7(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_6q23z_Z1693: FDE port map (
    Q => R_TXFIFO_6(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q24z_Z1694: FDE port map (
    Q => R_TXFIFO_6(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q25z_Z1695: FDE port map (
    Q => R_TXFIFO_6(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q26z_Z1696: FDE port map (
    Q => R_TXFIFO_6(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q27z_Z1697: FDE port map (
    Q => R_TXFIFO_6(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q28z_Z1698: FDE port map (
    Q => R_TXFIFO_6(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q29z_Z1699: FDE port map (
    Q => R_TXFIFO_6(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q30z_Z1700: FDE port map (
    Q => R_TXFIFO_6(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q31z_Z1701: FDE port map (
    Q => R_TXFIFO_6(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_7q1z_Z1702: FDE port map (
    Q => R_TXFIFO_7(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q2z_Z1703: FDE port map (
    Q => R_TXFIFO_7(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q3z_Z1704: FDE port map (
    Q => R_TXFIFO_7(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q4z_Z1705: FDE port map (
    Q => R_TXFIFO_7(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q5z_Z1706: FDE port map (
    Q => R_TXFIFO_7(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_6q8z_Z1707: FDE port map (
    Q => R_TXFIFO_6(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q9z_Z1708: FDE port map (
    Q => R_TXFIFO_6(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q10z_Z1709: FDE port map (
    Q => R_TXFIFO_6(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q11z_Z1710: FDE port map (
    Q => R_TXFIFO_6(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q12z_Z1711: FDE port map (
    Q => R_TXFIFO_6(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q13z_Z1712: FDE port map (
    Q => R_TXFIFO_6(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q14z_Z1713: FDE port map (
    Q => R_TXFIFO_6(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q15z_Z1714: FDE port map (
    Q => R_TXFIFO_6(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q16z_Z1715: FDE port map (
    Q => R_TXFIFO_6(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q17z_Z1716: FDE port map (
    Q => R_TXFIFO_6(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q18z_Z1717: FDE port map (
    Q => R_TXFIFO_6(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q19z_Z1718: FDE port map (
    Q => R_TXFIFO_6(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q20z_Z1719: FDE port map (
    Q => R_TXFIFO_6(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q21z_Z1720: FDE port map (
    Q => R_TXFIFO_6(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q22z_Z1721: FDE port map (
    Q => R_TXFIFO_6(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_5q25z_Z1722: FDE port map (
    Q => R_TXFIFO_5(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q26z_Z1723: FDE port map (
    Q => R_TXFIFO_5(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q27z_Z1724: FDE port map (
    Q => R_TXFIFO_5(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q28z_Z1725: FDE port map (
    Q => R_TXFIFO_5(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q29z_Z1726: FDE port map (
    Q => R_TXFIFO_5(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q30z_Z1727: FDE port map (
    Q => R_TXFIFO_5(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q31z_Z1728: FDE port map (
    Q => R_TXFIFO_5(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_6q1z_Z1729: FDE port map (
    Q => R_TXFIFO_6(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q2z_Z1730: FDE port map (
    Q => R_TXFIFO_6(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q3z_Z1731: FDE port map (
    Q => R_TXFIFO_6(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q4z_Z1732: FDE port map (
    Q => R_TXFIFO_6(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q5z_Z1733: FDE port map (
    Q => R_TXFIFO_6(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q6z_Z1734: FDE port map (
    Q => R_TXFIFO_6(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q7z_Z1735: FDE port map (
    Q => R_TXFIFO_6(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_5q10z_Z1736: FDE port map (
    Q => R_TXFIFO_5(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q11z_Z1737: FDE port map (
    Q => R_TXFIFO_5(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q12z_Z1738: FDE port map (
    Q => R_TXFIFO_5(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q13z_Z1739: FDE port map (
    Q => R_TXFIFO_5(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q14z_Z1740: FDE port map (
    Q => R_TXFIFO_5(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q15z_Z1741: FDE port map (
    Q => R_TXFIFO_5(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q16z_Z1742: FDE port map (
    Q => R_TXFIFO_5(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q17z_Z1743: FDE port map (
    Q => R_TXFIFO_5(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q18z_Z1744: FDE port map (
    Q => R_TXFIFO_5(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q19z_Z1745: FDE port map (
    Q => R_TXFIFO_5(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q20z_Z1746: FDE port map (
    Q => R_TXFIFO_5(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q21z_Z1747: FDE port map (
    Q => R_TXFIFO_5(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q22z_Z1748: FDE port map (
    Q => R_TXFIFO_5(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q23z_Z1749: FDE port map (
    Q => R_TXFIFO_5(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q24z_Z1750: FDE port map (
    Q => R_TXFIFO_5(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_4q27z_Z1751: FDE port map (
    Q => R_TXFIFO_4(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q28z_Z1752: FDE port map (
    Q => R_TXFIFO_4(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q29z_Z1753: FDE port map (
    Q => R_TXFIFO_4(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q30z_Z1754: FDE port map (
    Q => R_TXFIFO_4(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q31z_Z1755: FDE port map (
    Q => R_TXFIFO_4(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_5q1z_Z1756: FDE port map (
    Q => R_TXFIFO_5(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q2z_Z1757: FDE port map (
    Q => R_TXFIFO_5(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q3z_Z1758: FDE port map (
    Q => R_TXFIFO_5(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q4z_Z1759: FDE port map (
    Q => R_TXFIFO_5(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q5z_Z1760: FDE port map (
    Q => R_TXFIFO_5(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q6z_Z1761: FDE port map (
    Q => R_TXFIFO_5(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q7z_Z1762: FDE port map (
    Q => R_TXFIFO_5(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q8z_Z1763: FDE port map (
    Q => R_TXFIFO_5(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q9z_Z1764: FDE port map (
    Q => R_TXFIFO_5(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_4q12z_Z1765: FDE port map (
    Q => R_TXFIFO_4(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q13z_Z1766: FDE port map (
    Q => R_TXFIFO_4(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q14z_Z1767: FDE port map (
    Q => R_TXFIFO_4(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q15z_Z1768: FDE port map (
    Q => R_TXFIFO_4(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q16z_Z1769: FDE port map (
    Q => R_TXFIFO_4(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q17z_Z1770: FDE port map (
    Q => R_TXFIFO_4(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q18z_Z1771: FDE port map (
    Q => R_TXFIFO_4(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q19z_Z1772: FDE port map (
    Q => R_TXFIFO_4(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q20z_Z1773: FDE port map (
    Q => R_TXFIFO_4(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q21z_Z1774: FDE port map (
    Q => R_TXFIFO_4(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q22z_Z1775: FDE port map (
    Q => R_TXFIFO_4(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q23z_Z1776: FDE port map (
    Q => R_TXFIFO_4(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q24z_Z1777: FDE port map (
    Q => R_TXFIFO_4(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q25z_Z1778: FDE port map (
    Q => R_TXFIFO_4(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q26z_Z1779: FDE port map (
    Q => R_TXFIFO_4(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_3q29z_Z1780: FDE port map (
    Q => R_TXFIFO_3(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q30z_Z1781: FDE port map (
    Q => R_TXFIFO_3(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q31z_Z1782: FDE port map (
    Q => R_TXFIFO_3(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_4q1z_Z1783: FDE port map (
    Q => R_TXFIFO_4(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q2z_Z1784: FDE port map (
    Q => R_TXFIFO_4(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q3z_Z1785: FDE port map (
    Q => R_TXFIFO_4(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q4z_Z1786: FDE port map (
    Q => R_TXFIFO_4(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q5z_Z1787: FDE port map (
    Q => R_TXFIFO_4(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q6z_Z1788: FDE port map (
    Q => R_TXFIFO_4(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q7z_Z1789: FDE port map (
    Q => R_TXFIFO_4(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q8z_Z1790: FDE port map (
    Q => R_TXFIFO_4(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q9z_Z1791: FDE port map (
    Q => R_TXFIFO_4(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q10z_Z1792: FDE port map (
    Q => R_TXFIFO_4(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q11z_Z1793: FDE port map (
    Q => R_TXFIFO_4(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_3q14z_Z1794: FDE port map (
    Q => R_TXFIFO_3(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q15z_Z1795: FDE port map (
    Q => R_TXFIFO_3(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q16z_Z1796: FDE port map (
    Q => R_TXFIFO_3(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q17z_Z1797: FDE port map (
    Q => R_TXFIFO_3(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q18z_Z1798: FDE port map (
    Q => R_TXFIFO_3(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q19z_Z1799: FDE port map (
    Q => R_TXFIFO_3(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q20z_Z1800: FDE port map (
    Q => R_TXFIFO_3(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q21z_Z1801: FDE port map (
    Q => R_TXFIFO_3(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q22z_Z1802: FDE port map (
    Q => R_TXFIFO_3(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q23z_Z1803: FDE port map (
    Q => R_TXFIFO_3(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q24z_Z1804: FDE port map (
    Q => R_TXFIFO_3(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q25z_Z1805: FDE port map (
    Q => R_TXFIFO_3(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q26z_Z1806: FDE port map (
    Q => R_TXFIFO_3(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q27z_Z1807: FDE port map (
    Q => R_TXFIFO_3(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q28z_Z1808: FDE port map (
    Q => R_TXFIFO_3(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_2q31z_Z1809: FDE port map (
    Q => R_TXFIFO_2(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_3q1z_Z1810: FDE port map (
    Q => R_TXFIFO_3(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q2z_Z1811: FDE port map (
    Q => R_TXFIFO_3(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q3z_Z1812: FDE port map (
    Q => R_TXFIFO_3(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q4z_Z1813: FDE port map (
    Q => R_TXFIFO_3(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q5z_Z1814: FDE port map (
    Q => R_TXFIFO_3(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q6z_Z1815: FDE port map (
    Q => R_TXFIFO_3(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q7z_Z1816: FDE port map (
    Q => R_TXFIFO_3(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q8z_Z1817: FDE port map (
    Q => R_TXFIFO_3(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q9z_Z1818: FDE port map (
    Q => R_TXFIFO_3(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q10z_Z1819: FDE port map (
    Q => R_TXFIFO_3(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q11z_Z1820: FDE port map (
    Q => R_TXFIFO_3(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q12z_Z1821: FDE port map (
    Q => R_TXFIFO_3(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q13z_Z1822: FDE port map (
    Q => R_TXFIFO_3(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_2q16z_Z1823: FDE port map (
    Q => R_TXFIFO_2(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q17z_Z1824: FDE port map (
    Q => R_TXFIFO_2(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q18z_Z1825: FDE port map (
    Q => R_TXFIFO_2(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q19z_Z1826: FDE port map (
    Q => R_TXFIFO_2(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q20z_Z1827: FDE port map (
    Q => R_TXFIFO_2(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q21z_Z1828: FDE port map (
    Q => R_TXFIFO_2(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q22z_Z1829: FDE port map (
    Q => R_TXFIFO_2(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q23z_Z1830: FDE port map (
    Q => R_TXFIFO_2(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q24z_Z1831: FDE port map (
    Q => R_TXFIFO_2(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q25z_Z1832: FDE port map (
    Q => R_TXFIFO_2(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q26z_Z1833: FDE port map (
    Q => R_TXFIFO_2(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q27z_Z1834: FDE port map (
    Q => R_TXFIFO_2(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q28z_Z1835: FDE port map (
    Q => R_TXFIFO_2(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q29z_Z1836: FDE port map (
    Q => R_TXFIFO_2(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q30z_Z1837: FDE port map (
    Q => R_TXFIFO_2(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q1z_Z1838: FDE port map (
    Q => R_TXFIFO_2(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q2z_Z1839: FDE port map (
    Q => R_TXFIFO_2(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q3z_Z1840: FDE port map (
    Q => R_TXFIFO_2(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q4z_Z1841: FDE port map (
    Q => R_TXFIFO_2(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q5z_Z1842: FDE port map (
    Q => R_TXFIFO_2(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q6z_Z1843: FDE port map (
    Q => R_TXFIFO_2(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q7z_Z1844: FDE port map (
    Q => R_TXFIFO_2(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q8z_Z1845: FDE port map (
    Q => R_TXFIFO_2(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q9z_Z1846: FDE port map (
    Q => R_TXFIFO_2(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q10z_Z1847: FDE port map (
    Q => R_TXFIFO_2(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q11z_Z1848: FDE port map (
    Q => R_TXFIFO_2(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q12z_Z1849: FDE port map (
    Q => R_TXFIFO_2(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q13z_Z1850: FDE port map (
    Q => R_TXFIFO_2(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q14z_Z1851: FDE port map (
    Q => R_TXFIFO_2(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q15z_Z1852: FDE port map (
    Q => R_TXFIFO_2(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_1q18z_Z1853: FDE port map (
    Q => R_TXFIFO_1(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q19z_Z1854: FDE port map (
    Q => R_TXFIFO_1(19),
    D => N_107,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q20z_Z1855: FDE port map (
    Q => R_TXFIFO_1(20),
    D => N_108,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q21z_Z1856: FDE port map (
    Q => R_TXFIFO_1(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q22z_Z1857: FDE port map (
    Q => R_TXFIFO_1(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q23z_Z1858: FDE port map (
    Q => R_TXFIFO_1(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q24z_Z1859: FDE port map (
    Q => R_TXFIFO_1(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q25z_Z1860: FDE port map (
    Q => R_TXFIFO_1(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q26z_Z1861: FDE port map (
    Q => R_TXFIFO_1(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q27z_Z1862: FDE port map (
    Q => R_TXFIFO_1(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q28z_Z1863: FDE port map (
    Q => R_TXFIFO_1(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q29z_Z1864: FDE port map (
    Q => R_TXFIFO_1(29),
    D => N_109,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q30z_Z1865: FDE port map (
    Q => R_TXFIFO_1(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q31z_Z1866: FDE port map (
    Q => R_TXFIFO_1(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q3z_Z1867: FDE port map (
    Q => R_TXFIFO_1(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q4z_Z1868: FDE port map (
    Q => R_TXFIFO_1(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q5z_Z1869: FDE port map (
    Q => R_TXFIFO_1(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q6z_Z1870: FDE port map (
    Q => R_TXFIFO_1(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q7z_Z1871: FDE port map (
    Q => R_TXFIFO_1(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q8z_Z1872: FDE port map (
    Q => R_TXFIFO_1(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q9z_Z1873: FDE port map (
    Q => R_TXFIFO_1(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q10z_Z1874: FDE port map (
    Q => R_TXFIFO_1(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q11z_Z1875: FDE port map (
    Q => R_TXFIFO_1(11),
    D => N_103,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q12z_Z1876: FDE port map (
    Q => R_TXFIFO_1(12),
    D => N_104,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q13z_Z1877: FDE port map (
    Q => R_TXFIFO_1(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q14z_Z1878: FDE port map (
    Q => R_TXFIFO_1(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q15z_Z1879: FDE port map (
    Q => R_TXFIFO_1(15),
    D => N_105,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q16z_Z1880: FDE port map (
    Q => R_TXFIFO_1(16),
    D => N_106,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q17z_Z1881: FDE port map (
    Q => R_TXFIFO_1(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_RDq27z_Z1882: FDE port map (
    Q => R_RD(27),
    D => N_119_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq28z_Z1883: FDE port map (
    Q => R_RD(28),
    D => COMB_V_RD_3(28),
    C => clk,
    CE => COMB_V_RD4);
R_RDq29z_Z1884: FDE port map (
    Q => R_RD(29),
    D => COMB_V_RD_3(29),
    C => clk,
    CE => COMB_V_RD4);
R_RDq30z_Z1885: FDE port map (
    Q => R_RD(30),
    D => N_121_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq31z_Z1886: FDE port map (
    Q => R_RD(31),
    D => N_123_I,
    C => clk,
    CE => COMB_V_RD4);
R_TXFIFO_1q1z_Z1887: FDE port map (
    Q => R_TXFIFO_1(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q2z_Z1888: FDE port map (
    Q => R_TXFIFO_1(2),
    D => N_102,
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_RDq12z_Z1889: FDE port map (
    Q => R_RD(12),
    D => COMB_V_RD_3(12),
    C => clk,
    CE => COMB_V_RD4);
R_RDq13z_Z1890: FDE port map (
    Q => R_RD(13),
    D => COMB_V_RD_3(13),
    C => clk,
    CE => COMB_V_RD4);
R_RDq14z_Z1891: FDE port map (
    Q => R_RD(14),
    D => N_18_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq15z_Z1892: FDE port map (
    Q => R_RD(15),
    D => N_20_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq16z_Z1893: FDE port map (
    Q => R_RD(16),
    D => N_22_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq17z_Z1894: FDE port map (
    Q => R_RD(17),
    D => N_24_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq18z_Z1895: FDE port map (
    Q => R_RD(18),
    D => COMB_V_RD_3(18),
    C => clk,
    CE => COMB_V_RD4);
R_RDq19z_Z1896: FDE port map (
    Q => R_RD(19),
    D => COMB_V_RD_3(19),
    C => clk,
    CE => COMB_V_RD4);
R_RDq20z_Z1897: FDE port map (
    Q => R_RD(20),
    D => N_26_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq21z_Z1898: FDE port map (
    Q => R_RD(21),
    D => COMB_V_RD_3(21),
    C => clk,
    CE => COMB_V_RD4);
R_RDq22z_Z1899: FDE port map (
    Q => R_RD(22),
    D => N_28_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq23z_Z1900: FDE port map (
    Q => R_RD(23),
    D => N_30_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq24z_Z1901: FDE port map (
    Q => R_RD(24),
    D => COMB_V_RD_3(24),
    C => clk,
    CE => COMB_V_RD4);
R_RDq25z_Z1902: FDE port map (
    Q => R_RD(25),
    D => COMB_V_RD_3(25),
    C => clk,
    CE => COMB_V_RD4);
R_RDq26z_Z1903: FDE port map (
    Q => R_RD(26),
    D => N_117_I,
    C => clk,
    CE => COMB_V_RD4);
R_RXDq29z_Z1904: FDE port map (
    Q => R_RXD(29),
    D => R_RXD(28),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq30z_Z1905: FDE port map (
    Q => R_RXD(30),
    D => R_RXD(29),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq31z_Z1906: FDE port map (
    Q => R_RXD(31),
    D => R_RXD(30),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RDq0z_Z1907: FDE port map (
    Q => R_RD(0),
    D => N_122,
    C => clk,
    CE => COMB_V_RD4);
R_RDq1z_Z1908: FDE port map (
    Q => R_RD(1),
    D => N_120,
    C => clk,
    CE => COMB_V_RD4);
R_RDq2z_Z1909: FDE port map (
    Q => R_RD(2),
    D => COMB_V_RD_3(2),
    C => clk,
    CE => COMB_V_RD4);
R_RDq3z_Z1910: FDE port map (
    Q => R_RD(3),
    D => COMB_V_RD_3(3),
    C => clk,
    CE => COMB_V_RD4);
R_RDq4z_Z1911: FDE port map (
    Q => R_RD(4),
    D => N_118,
    C => clk,
    CE => COMB_V_RD4);
R_RDq5z_Z1912: FDE port map (
    Q => R_RD(5),
    D => N_116,
    C => clk,
    CE => COMB_V_RD4);
R_RDq6z_Z1913: FDE port map (
    Q => R_RD(6),
    D => COMB_V_RD_3(6),
    C => clk,
    CE => COMB_V_RD4);
R_RDq7z_Z1914: FDE port map (
    Q => R_RD(7),
    D => COMB_V_RD_3(7),
    C => clk,
    CE => COMB_V_RD4);
R_RDq8z_Z1915: FDE port map (
    Q => R_RD(8),
    D => N_12_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq9z_Z1916: FDE port map (
    Q => R_RD(9),
    D => N_14_I,
    C => clk,
    CE => COMB_V_RD4);
R_RDq10z_Z1917: FDE port map (
    Q => R_RD(10),
    D => COMB_V_RD_3(10),
    C => clk,
    CE => COMB_V_RD4);
R_RDq11z_Z1918: FDE port map (
    Q => R_RD(11),
    D => N_16_I,
    C => clk,
    CE => COMB_V_RD4);
R_RXDq14z_Z1919: FDE port map (
    Q => R_RXD(14),
    D => R_RXD(13),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq15z_Z1920: FDE port map (
    Q => R_RXD(15),
    D => R_RXD(14),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq16z_Z1921: FDE port map (
    Q => R_RXD(16),
    D => R_RXD(15),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq17z_Z1922: FDE port map (
    Q => R_RXD(17),
    D => R_RXD(16),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq18z_Z1923: FDE port map (
    Q => R_RXD(18),
    D => R_RXD(17),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq19z_Z1924: FDE port map (
    Q => R_RXD(19),
    D => R_RXD(18),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq20z_Z1925: FDE port map (
    Q => R_RXD(20),
    D => R_RXD(19),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq21z_Z1926: FDE port map (
    Q => R_RXD(21),
    D => R_RXD(20),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq22z_Z1927: FDE port map (
    Q => R_RXD(22),
    D => R_RXD(21),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq23z_Z1928: FDE port map (
    Q => R_RXD(23),
    D => R_RXD(22),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq24z_Z1929: FDE port map (
    Q => R_RXD(24),
    D => R_RXD(23),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq25z_Z1930: FDE port map (
    Q => R_RXD(25),
    D => R_RXD(24),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq26z_Z1931: FDE port map (
    Q => R_RXD(26),
    D => R_RXD(25),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq27z_Z1932: FDE port map (
    Q => R_RXD(27),
    D => R_RXD(26),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq28z_Z1933: FDE port map (
    Q => R_RXD(28),
    D => R_RXD(27),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq0z_Z1934: FDE port map (
    Q => R_RXD(0),
    D => COMB_INDATA_1,
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq1z_Z1935: FDE port map (
    Q => R_RXD(1),
    D => R_RXD(0),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq2z_Z1936: FDE port map (
    Q => R_RXD(2),
    D => R_RXD(1),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq3z_Z1937: FDE port map (
    Q => R_RXD(3),
    D => R_RXD(2),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq4z_Z1938: FDE port map (
    Q => R_RXD(4),
    D => R_RXD(3),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq5z_Z1939: FDE port map (
    Q => R_RXD(5),
    D => R_RXD(4),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq6z_Z1940: FDE port map (
    Q => R_RXD(6),
    D => R_RXD(5),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq7z_Z1941: FDE port map (
    Q => R_RXD(7),
    D => R_RXD(6),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq8z_Z1942: FDE port map (
    Q => R_RXD(8),
    D => R_RXD(7),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq9z_Z1943: FDE port map (
    Q => R_RXD(9),
    D => R_RXD(8),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq10z_Z1944: FDE port map (
    Q => R_RXD(10),
    D => R_RXD(9),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq11z_Z1945: FDE port map (
    Q => R_RXD(11),
    D => R_RXD(10),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq12z_Z1946: FDE port map (
    Q => R_RXD(12),
    D => R_RXD(11),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq13z_Z1947: FDE port map (
    Q => R_RXD(13),
    D => R_RXD(12),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_OV2_Z1948: FD port map (
    Q => R_OV2,
    D => R_OV,
    C => clk);
R_RXDONE_Z1949: FD port map (
    Q => R_RXDONE,
    D => COMB_V_RXDONE_2_0_I,
    C => clk);
R_SPIO_ENABLE: FD port map (
    Q => spio_enable,
    D => R_MODE_EN,
    C => clk);
R_TOGGLE_Z1951: FD port map (
    Q => R_TOGGLE,
    D => V_TOGGLE_0_SQMUXA,
    C => clk);
R_SPII_0_SPISEL_Z1952: FD port map (
    Q => R_SPII_0_SPISEL,
    D => spii_spisel,
    C => clk);
R_SPII_1_MISO_Z1953: FD port map (
    Q => R_SPII_1_MISO,
    D => R_SPII_0_MISO,
    C => clk);
R_SPII_1_MOSI_Z1954: FD port map (
    Q => R_SPII_1_MOSI,
    D => R_SPII_0_MOSI,
    C => clk);
R_SPII_1_SCK_Z1955: FD port map (
    Q => R_SPII_1_SCK,
    D => R_SPII_0_SCK,
    C => clk);
R_SPII_1_SPISEL_Z1956: FD port map (
    Q => R_SPII_1_SPISEL,
    D => R_SPII_0_SPISEL,
    C => clk);
R_SPII_0_MISO_Z1957: FD port map (
    Q => R_SPII_0_MISO,
    D => spii_miso,
    C => clk);
R_SPII_0_MOSI_Z1958: FD port map (
    Q => R_SPII_0_MOSI,
    D => spii_mosi,
    C => clk);
R_SPII_0_SCK_Z1959: FD port map (
    Q => R_SPII_0_SCK,
    D => spii_sck,
    C => clk);
R_SPII_1_SPISEL_FAST_Z1960: FD port map (
    Q => R_SPII_1_SPISEL_FAST,
    D => R_SPII_0_SPISEL,
    C => clk);
V_SPIO_MOSIOEN_2_SQMUXA_Z1961: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => COMB_UN26_AM_EN_0,
  I1 => R_MODE_EN,
  I2 => R_RUNNING,
  I3 => R_MODE_MS,
  O => V_SPIO_MOSIOEN_2_SQMUXA);
R_SPII_1_SPISEL_RNISSI91: LUT3_L 
generic map(
  INIT => X"45"
)
port map (
  I0 => COMB_UN1_R_RUNNING_M,
  I1 => R_SPII_1_SPISEL,
  I2 => R_MODE_MS,
  LO => G0_23_1);
UN1_RELOADq5z_Z1963: LUT4 
generic map(
  INIT => X"4474"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_FACT,
  I2 => N_629,
  I3 => R_MODE_DIV16,
  O => UN1_RELOAD(5));
V_TD_OCC_1_SQMUXA_2_Z1964: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => apbi_paddr(4),
  I1 => apbi_paddr(2),
  I2 => apbi_paddr(7),
  I3 => apbi_paddr(6),
  O => V_TD_OCC_1_SQMUXA_2);
COMB_UN17_APBI_PSEL_1_Z1965: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => apbi_paddr(5),
  I1 => apbi_paddr(7),
  I2 => apbi_paddr(6),
  O => COMB_UN17_APBI_PSEL_1);
COMB_UN5_APBI_PSEL_0: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => apbi_paddr(4),
  I1 => apbi_paddr(3),
  I2 => apbi_paddr(7),
  I3 => apbi_paddr(6),
  O => COMB_UN9_APBI_PSEL_0);
TINDEX_1_SQMUXA_Z1967: LUT3 
generic map(
  INIT => X"20"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_RUNNING,
  I2 => R_MODE_EN,
  O => TINDEX_1_SQMUXA);
COMB_SAMPLE_5: LUT4 
generic map(
  INIT => X"C404"
)
port map (
  I0 => SAMPLE_0_SQMUXA_2_SX,
  I1 => R_SAMP,
  I2 => R_MODE_MS_REP1,
  I3 => R_TOGGLE,
  O => R_SYNCSAMPC_1);
COMB_CHANGE_4_1_0_Z1969: LUT4_L 
generic map(
  INIT => X"C4CC"
)
port map (
  I0 => COMB_CHANGE_4_1_0_1,
  I1 => R_MODE_MS_FAST,
  I2 => R_TFREECNT_FAST(0),
  I3 => R_TFREECNT_FAST(3),
  LO => COMB_CHANGE_4_1_0);
COMB_CHANGE_4_1_0_1_Z1970: LUT2_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_TFREECNT_FAST(1),
  I1 => R_TFREECNT_FAST(2),
  LO => COMB_CHANGE_4_1_0_1);
COMB_UN4_ASEL_EN_MB: LUT4_L 
generic map(
  INIT => X"7447"
)
port map (
  I0 => COMB_UN4_ASEL_EN_MB_1,
  I1 => COMB_UN4_ASEL_EN_SN,
  I2 => R_MODE_CPOL,
  I3 => R_SPIO_SCK_FAST,
  LO => COMB_UN4_ASEL_EN_0);
COMB_UN4_ASEL_EN_MB_1_Z1972: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_CGCNT(0),
  I1 => R_CGCNT(1),
  I2 => R_CGCNT(4),
  I3 => R_CGCNT(5),
  O => COMB_UN4_ASEL_EN_MB_1);
R_RUNNING_FAST_Z1973: FDR port map (
    Q => R_RUNNING_FAST,
    D => R_RUNNINGC_FAST,
    C => clk,
    R => R_MODE_EN_I);
R_RUNNINGC_FAST_Z1974: LUT4_L 
generic map(
  INIT => X"7F00"
)
port map (
  I0 => COMB_UN40_SAMPLE_NE_1,
  I1 => COMB_V_RUNNING_9_IV_265_A0_5,
  I2 => COMB_V_RUNNING_9_IV_265_A0_6,
  I3 => R_RUNNINGC_1,
  LO => R_RUNNINGC_FAST);
R_MODE_MS_REP1_Z1975: FDRE port map (
    Q => R_MODE_MS_REP1,
    D => COMB_V_MODE_MS_1_REP1,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
COMB_V_MODE_MS_1_REP1_Z1976: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(25),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_MS_1_REP1);
R_MODE_MS_FAST_Z1977: FDRE port map (
    Q => R_MODE_MS_FAST,
    D => COMB_V_MODE_MS_1_FAST,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
COMB_V_MODE_MS_1_FAST_Z1978: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(25),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_MS_1_FAST);
R_MODE_LEN_FASTq1z_Z1979: FDRE port map (
    Q => R_MODE_LEN_FAST(1),
    D => apbi_pwdata(21),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_FASTq3z_Z1980: FDRE port map (
    Q => R_MODE_LEN_FAST(3),
    D => apbi_pwdata(23),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_FASTq0z_Z1981: FDRE port map (
    Q => R_MODE_LEN_FAST(0),
    D => apbi_pwdata(20),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_SPIO_SCK_FAST_Z1982: FDRE port map (
    Q => R_SPIO_SCK_FAST,
    D => REG_R_SPIO_SCK_3_FAST,
    C => clk,
    R => RSTN_I,
    CE => V_SPIO_SCK_1_SQMUXA_I);
REG_R_SPIO_SCK_3_FAST_Z1983: LUT3_L 
generic map(
  INIT => X"2E"
)
port map (
  I0 => R_MODE_CPOL,
  I1 => R_RUNNING,
  I2 => R_SPIO_SCK_FAST,
  LO => REG_R_SPIO_SCK_3_FAST);
COMB_UN4_ASEL_EN_SN_Z1984: LUT4_L 
generic map(
  INIT => X"1001"
)
port map (
  I0 => R_CGCNT(2),
  I1 => R_CGCNT(3),
  I2 => R_MODE_CPOL,
  I3 => R_SPIO_SCK_FAST,
  LO => COMB_UN4_ASEL_EN_SN);
R_MODE_EN_FAST_Z1985: FDRE port map (
    Q => R_MODE_EN_FAST,
    D => COMB_V_MODE_EN_1_FAST,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
COMB_V_MODE_EN_1_FAST_Z1986: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(24),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_EN_1_FAST);
R_IRQD_1_Z1987: LUT4_L 
generic map(
  INIT => X"CAFA"
)
port map (
  I0 => R_IRQD_1_X0,
  I1 => R_EVENT_LT,
  I2 => R_EVENT_LTD_1,
  I3 => R_MASK_LT,
  LO => R_IRQD_1);
R_TFREECNT_RNIMFT6Fq3z: LUT4 
generic map(
  INIT => X"2D78"
)
port map (
  I0 => G0_6_1_0,
  I1 => R_TFREECNT_RNID3142(1),
  I2 => UN1_R_TFREECNT_1_AXB3,
  I3 => COMB_UN40_CHANGE_RNIDTL41_0,
  O => R_EVENT_LTD_1);
R_TFREECNT_RNIJ7GQ7_0q0z: LUT4 
generic map(
  INIT => X"4203"
)
port map (
  I0 => G0_0_A3_0_0_SX,
  I1 => R_TFREECNT_RNIG5GJ2(2),
  I2 => R_TFREECNT_RNID3142(1),
  I3 => UN1_V_TXFIFO_76_0_I(3),
  O => G0_6_1_0);
SAMPLE_0_SQMUXA_2_Z1990: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_MS_REP1,
  I1 => SAMPLE_0_SQMUXA_2_SX,
  O => SAMPLE_0_SQMUXA_2);
SAMPLE_0_SQMUXA_2_SX_Z1991: LUT4 
generic map(
  INIT => X"FFD7"
)
port map (
  I0 => R_MODE_EN_FAST,
  I1 => R_PSCK,
  I2 => R_SPII_1_SCK,
  I3 => R_SPII_1_SPISEL_FAST,
  O => SAMPLE_0_SQMUXA_2_SX);
R_LST_RNO_5: MUXF5 port map (
    I0 => R_LST_RNO_7,
    I1 => R_LST_RNO_8,
    S => COMB_UN40_CHANGE_RNIDTL41_0,
    O => G0_24_SX);
R_LST_RNO_8_Z1993: LUT4 
generic map(
  INIT => X"A999"
)
port map (
  I0 => R_TFREECNT_RNIG5GJ2(2),
  I1 => R_TFREECNT_RNID3142(1),
  I2 => R_TFREECNT_RNI919U1_0(0),
  I3 => UN1_V_TXFIFO_76_0_I(3),
  O => R_LST_RNO_8);
R_LST_RNO_7_Z1994: LUT4 
generic map(
  INIT => X"6AAA"
)
port map (
  I0 => R_TFREECNT_RNIG5GJ2(2),
  I1 => R_TFREECNT_RNID3142(1),
  I2 => R_TFREECNT_RNI919U1_0(0),
  I3 => UN1_V_TXFIFO_76_0_I(3),
  O => R_LST_RNO_7);
COMB_UN40_CHANGE_RNIABDRE: MUXF5 port map (
    I0 => R_TFREECNT_RNIA67S5(2),
    I1 => R_TFREECNT_RNIJ7GQ7(0),
    S => UN1_V_TXFIFO_76_0_I(3),
    O => UN1_R_TFREECNT_1_P7);
R_TFREECNT_RNIJ7GQ7q0z_Z1996: LUT4 
generic map(
  INIT => X"FD40"
)
port map (
  I0 => G0_0_A3_0_0_SX,
  I1 => R_TFREECNT_RNIG5GJ2(2),
  I2 => R_TFREECNT_RNID3142(1),
  I3 => COMB_UN40_CHANGE_RNIDTL41_0,
  O => R_TFREECNT_RNIJ7GQ7(0));
R_TFREECNT_RNIA67S5q2z_Z1997: LUT3 
generic map(
  INIT => X"E0"
)
port map (
  I0 => R_TFREECNT_RNIG5GJ2(2),
  I1 => R_TFREECNT_RNID3142(1),
  I2 => COMB_UN40_CHANGE_RNIDTL41_0,
  O => R_TFREECNT_RNIA67S5(2));
R_TFREECNT_RNI919U1q0z: LUT4 
generic map(
  INIT => X"807F"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => G1_1_1,
  I3 => R_TFREECNT(0),
  O => G0_0_A3_0_0_SX);
R_IRQD_1_X0_Z1999: LUT4 
generic map(
  INIT => X"FBBF"
)
port map (
  I0 => R_EVENT_LT,
  I1 => R_MASK_LT,
  I2 => UN1_R_TFREECNT_1_AXB3,
  I3 => UN1_R_TFREECNT_1_P7,
  O => R_IRQD_1_X0);
R_TFREECNT_RNIABDREq0z_Z2000: MUXF5 port map (
    I0 => R_TFREECNT_RNIA67S5_0(2),
    I1 => COMB_UN40_CHANGE_RNIN3T07,
    S => R_TFREECNT_RNI919U1_0(0),
    O => R_TFREECNT_RNIABDRE(0));
COMB_UN40_CHANGE_RNIN3T07_Z2001: LUT4 
generic map(
  INIT => X"A69A"
)
port map (
  I0 => R_TFREECNT_RNIG5GJ2(2),
  I1 => R_TFREECNT_RNID3142(1),
  I2 => COMB_UN40_CHANGE_RNIDTL41_0,
  I3 => UN1_V_TXFIFO_76_0_I(3),
  O => COMB_UN40_CHANGE_RNIN3T07);
R_TFREECNT_RNIA67S5_0q2z_Z2002: LUT3 
generic map(
  INIT => X"9A"
)
port map (
  I0 => R_TFREECNT_RNIG5GJ2(2),
  I1 => R_TFREECNT_RNID3142(1),
  I2 => COMB_UN40_CHANGE_RNIDTL41_0,
  O => R_TFREECNT_RNIA67S5_0(2));
R_LST_RNO_1: LUT4_L 
generic map(
  INIT => X"0020"
)
port map (
  I0 => G0_1_0,
  I1 => G0_24_SX,
  I2 => G1_0,
  I3 => COMB_V_TXFIFO_76_RNI32075,
  LO => G1_0_3);
R_IRQD: LUT4_L 
generic map(
  INIT => X"AFEF"
)
port map (
  I0 => COMB_UN1_R_MODE_EN_2,
  I1 => COMB_V_EVENT_LT6_3,
  I2 => COMB_V_IRQ_1_IV_M6_2,
  I3 => R_IRQD_1,
  LO => R_IRQD_0);
R_EVENT_LTD: LUT4_L 
generic map(
  INIT => X"CEEC"
)
port map (
  I0 => COMB_V_EVENT_LT6_3,
  I1 => R_EVENT_LTD_1_1,
  I2 => UN1_R_TFREECNT_1_AXB3,
  I3 => UN1_R_TFREECNT_1_P7,
  LO => R_EVENT_LTD_0);
R_EVENT_LTD_1_0: LUT3 
generic map(
  INIT => X"4C"
)
port map (
  I0 => apbi_pwdata(14),
  I1 => R_EVENT_LT,
  I2 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_LTD_1_1);
COMB_V_TXFIFO_76_RNI8A44E: LUT4 
generic map(
  INIT => X"3021"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => G0_14_1,
  I2 => R_TFREECNT_RNI919U1_0(0),
  I3 => V_TDFI_0_SQMUXA,
  O => COMB_V_EVENT_LT6_3_1);
R_LST_RNIIB51B: LUT2_L 
generic map(
  INIT => X"7"
)
port map (
  I0 => G1_1,
  I1 => R_LST,
  LO => G0_14_1);
R_SPII_1_SPISEL_RNINCTUA: LUT4_L 
generic map(
  INIT => X"80FF"
)
port map (
  I0 => COMB_UN40_SAMPLE_NE_1,
  I1 => COMB_V_RUNNING_9_IV_265_A0_5,
  I2 => COMB_V_RUNNING_9_IV_265_A0_6,
  I3 => G0_23_1,
  LO => G1_1);
COMB_CHANGE_4_Z2010: LUT4 
generic map(
  INIT => X"A888"
)
port map (
  I0 => COMB_CHANGE_4_1,
  I1 => COMB_CHANGE_4_1_0,
  I2 => COMB_SLV_START_UN13_AM_EN,
  I3 => SAMPLE_0_SQMUXA_1,
  O => COMB_CHANGE_4);
R_TFREECNT_FASTq3z_Z2011: FDS port map (
    Q => R_TFREECNT_FAST(3),
    D => R_EVENT_LTD_1,
    C => clk,
    S => N_2120_0_I);
R_TFREECNT_FASTq2z_Z2012: FDR port map (
    Q => R_TFREECNT_FAST(2),
    D => R_TFREECNT_RNIABDRE(0),
    C => clk,
    R => N_2120_0_I);
R_MODE_CPOL_FAST_Z2013: FDRE port map (
    Q => R_MODE_CPOL_FAST,
    D => apbi_pwdata(29),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_TFREECNT_FASTq1z_Z2014: FDR port map (
    Q => R_TFREECNT_FAST(1),
    D => COMB_V_TXFIFO_76_RNI32075,
    C => clk,
    R => N_2120_0_I);
R_TFREECNT_FASTq0z_Z2015: FDR port map (
    Q => R_TFREECNT_FAST(0),
    D => UN1_R_TFREECNT_1_AXB0_FAST,
    C => clk,
    R => N_2120_0_I);
UN1_R_TFREECNT_1_AXB0_FAST_Z2016: LUT4_L 
generic map(
  INIT => X"4BB4"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  I2 => R_TFREECNT_FAST(0),
  I3 => V_TDFI_0_SQMUXA,
  LO => UN1_R_TFREECNT_1_AXB0_FAST);
R_TFREECNT_RNI919U1_0q0z_Z2017: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => G1_1_1,
  I3 => R_TFREECNT(0),
  O => R_TFREECNT_RNI919U1_0(0));
COMB_UN40_CHANGE_RNIDTL41: LUT4 
generic map(
  INIT => X"FF80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => COMB_V_TXFIFO_76,
  O => UN1_V_TXFIFO_76_0_I(3));
R_TD_OCC_RNINU5D1: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => R_TD_OCC,
  O => G1_1_1);
R_LST_RNO_4: LUT3 
generic map(
  INIT => X"C4"
)
port map (
  I0 => N_2216,
  I1 => R_LST,
  I2 => V_IRQ_0_SQMUXA_1_0,
  O => G0_1_0);
COMB_UN26_AM_EN_RNIJ30IA: LUT4 
generic map(
  INIT => X"1555"
)
port map (
  I0 => COMB_UN1_R_RUNNING_M,
  I1 => COMB_UN40_SAMPLE_NE_1,
  I2 => COMB_V_RUNNING_9_IV_265_A0_5,
  I3 => COMB_V_RUNNING_9_IV_265_A0_6,
  O => N_2216);
R_RBITCNT_RNI5FM73q1z: LUT4 
generic map(
  INIT => X"1248"
)
port map (
  I0 => LEN_1_0(1),
  I1 => LEN_1_0(2),
  I2 => R_RBITCNT(1),
  I3 => R_RBITCNT(2),
  O => COMB_UN40_SAMPLE_NE_1);
COMB_V_TXFIFO_76_RNI32075_Z2023: LUT4 
generic map(
  INIT => X"3CC6"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TFREECNT_RNID3142(1),
  I2 => R_TFREECNT_RNI919U1_0(0),
  I3 => V_TDFI_0_SQMUXA,
  O => COMB_V_TXFIFO_76_RNI32075);
R_MODE_LEN_FAST_RNI5D5J1q0z: LUT4 
generic map(
  INIT => X"5554"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN_FAST(0),
  I2 => R_MODE_LEN_FAST(1),
  I3 => R_MODE_LEN_FAST(3),
  O => LEN_1_0(2));
R_MODE_LEN_FAST_RNI5D5J1_0q0z: LUT4 
generic map(
  INIT => X"0F0E"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN_FAST(0),
  I2 => R_MODE_LEN_FAST(1),
  I3 => R_MODE_LEN_FAST(3),
  O => LEN_1_0(1));
COMB_UN26_AM_EN_RNIOJLS: LUT3 
generic map(
  INIT => X"0B"
)
port map (
  I0 => COMB_UN26_AM_EN_0,
  I1 => R_MODE_EN,
  I2 => R_RUNNING,
  O => COMB_UN1_R_RUNNING_M);
COMB_UN40_CHANGE_RNIMMPN: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  O => V_TDFI_0_SQMUXA);
R_LST_RNO: LUT4 
generic map(
  INIT => X"AEEA"
)
port map (
  I0 => G0_0_0,
  I1 => G1_0_3,
  I2 => UN1_R_TFREECNT_1_AXB3,
  I3 => UN1_R_TFREECNT_1_P7,
  O => V_LST_1_SQMUXA_1_I);
R_TFREECNT_RNIG5GJ2q2z_Z2029: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => G1_0_1_1,
  I3 => R_TFREECNT(2),
  O => R_TFREECNT_RNIG5GJ2(2));
R_LST_RNO_0: LUT4 
generic map(
  INIT => X"D555"
)
port map (
  I0 => N_2120_0,
  I1 => apbi_paddr(3),
  I2 => G2_0_3,
  I3 => G2_5,
  O => G0_0_0);
COMB_UN40_CHANGE_RNI8VPE1: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN1_R_TFREECNT,
  I2 => COMB_UN27_CHANGE,
  I3 => COMB_UN40_CHANGE,
  O => COMB_UN1_R_TFREECNT_S0);
R_TD_OCC_RNIS2D22: LUT4 
generic map(
  INIT => X"0440"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => COMB_V_TFREECNT_P4,
  I3 => R_TD_OCC,
  O => G1_0_1_1);
R_LST_RNO_2: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(4),
  I2 => apbi_penable,
  I3 => apbi_psel,
  O => G2_0_3);
R_LST_RNO_6: LUT3 
generic map(
  INIT => X"C9"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TFREECNT_RNI919U1_0(0),
  I2 => V_TDFI_0_SQMUXA,
  O => G1_0);
R_TFREECNT_RNID3142q1z_Z2035: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => G1_0_1_0,
  I3 => R_TFREECNT(1),
  O => R_TFREECNT_RNID3142(1));
COMB_UN40_CHANGE_RNIQ0UI1: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => G1,
  O => G1_0_1_0);
R_LST_RNO_3: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => apbi_paddr(5),
  I1 => apbi_paddr(6),
  I2 => apbi_paddr(7),
  I3 => apbi_pwrite,
  O => G2_5);
R_TFREECNT_RNI97M34q3z: LUT4 
generic map(
  INIT => X"27D8"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0,
  I1 => COMB_V_TFREECNT_30(3),
  I2 => R_TFREECNT(3),
  I3 => COMB_UN40_CHANGE_RNIDTL41_0,
  O => UN1_R_TFREECNT_1_AXB3);
R_TFREECNT_RNIE8EA1q3z: LUT4 
generic map(
  INIT => X"DB24"
)
port map (
  I0 => COMB_V_TFREECNT_P4,
  I1 => R_TD_OCC,
  I2 => R_TFREECNT(2),
  I3 => R_TFREECNT(3),
  O => COMB_V_TFREECNT_30(3));
COMB_UN40_CHANGE_RNIDTL41_0_Z2040: LUT4 
generic map(
  INIT => X"7F00"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => COMB_V_TXFIFO_76,
  O => COMB_UN40_CHANGE_RNIDTL41_0);
R_TFREECNT_RNII80Nq3z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_TFREECNT(0),
  I1 => R_TFREECNT(1),
  I2 => R_TFREECNT(2),
  I3 => R_TFREECNT(3),
  O => COMB_UN1_R_TFREECNT);
R_TFREECNT_RNI547Lq1z: LUT3 
generic map(
  INIT => X"A8"
)
port map (
  I0 => R_TD_OCC,
  I1 => R_TFREECNT(0),
  I2 => R_TFREECNT(1),
  O => COMB_V_TFREECNT_P4);
R_TFREECNT_RNI12FFq0z: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TD_OCC,
  I1 => R_TFREECNT(0),
  O => G1);
COMB_V_TXFIFO_76_RNILNH621: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => COMB_V_EVENT_LT6_3_1,
  I1 => COMB_V_TXFIFO_76_RNI32075,
  I2 => R_TFREECNT_RNIABDRE(0),
  O => COMB_V_EVENT_LT6_3);
V_TD_OCC_1_SQMUXA_RNO: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(5),
  I1 => apbi_penable,
  I2 => apbi_psel,
  I3 => apbi_pwrite,
  O => V_LST_1_SQMUXA_0);
APBI_PWRITE_RNITG1R: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => apbi_penable,
  I1 => apbi_psel,
  I2 => apbi_pwrite,
  O => COMB_UN30_APBI_PSEL);
R_RXDONE2E: LUT3_L 
generic map(
  INIT => X"5C"
)
port map (
  I0 => COMB_UN1_R_RUNNING_1,
  I1 => R_RXDONE2,
  I2 => V_RXDONE2_1_SQMUXA_I,
  LO => R_RXDONE2E_0);
UN152_CHANGE_7_AMq2z_Z2048: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(2),
  I2 => R_TXFIFO_6(2),
  I3 => UN152_CHANGE_7_AM_1(2),
  O => UN152_CHANGE_7_AM(2));
UN152_CHANGE_7_AM_1q2z_Z2049: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(2),
  I3 => R_TXFIFO_4(2),
  LO => UN152_CHANGE_7_AM_1(2));
UN152_CHANGE_7_BMq2z_Z2050: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(2),
  I2 => R_TXFIFO_7(2),
  I3 => UN152_CHANGE_7_BM_1(2),
  O => UN152_CHANGE_7_BM(2));
UN152_CHANGE_7_BM_1q2z_Z2051: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(2),
  I3 => R_TXFIFO_5(2),
  LO => UN152_CHANGE_7_BM_1(2));
UN152_CHANGE_7_AMq4z_Z2052: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(4),
  I2 => R_TXFIFO_6(4),
  I3 => UN152_CHANGE_7_AM_1(4),
  O => UN152_CHANGE_7_AM(4));
UN152_CHANGE_7_AM_1q4z_Z2053: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(4),
  I3 => R_TXFIFO_4(4),
  LO => UN152_CHANGE_7_AM_1(4));
UN152_CHANGE_7_BMq4z_Z2054: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(4),
  I2 => R_TXFIFO_7(4),
  I3 => UN152_CHANGE_7_BM_1(4),
  O => UN152_CHANGE_7_BM(4));
UN152_CHANGE_7_BM_1q4z_Z2055: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(4),
  I3 => R_TXFIFO_5(4),
  LO => UN152_CHANGE_7_BM_1(4));
UN152_CHANGE_7_AMq6z_Z2056: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(6),
  I2 => R_TXFIFO_6(6),
  I3 => UN152_CHANGE_7_AM_1(6),
  O => UN152_CHANGE_7_AM(6));
UN152_CHANGE_7_AM_1q6z_Z2057: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(6),
  I3 => R_TXFIFO_4(6),
  LO => UN152_CHANGE_7_AM_1(6));
UN152_CHANGE_7_BMq6z_Z2058: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(6),
  I2 => R_TXFIFO_7(6),
  I3 => UN152_CHANGE_7_BM_1(6),
  O => UN152_CHANGE_7_BM(6));
UN152_CHANGE_7_BM_1q6z_Z2059: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(6),
  I3 => R_TXFIFO_5(6),
  LO => UN152_CHANGE_7_BM_1(6));
UN152_CHANGE_7_AMq8z_Z2060: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(8),
  I2 => R_TXFIFO_6(8),
  I3 => UN152_CHANGE_7_AM_1(8),
  O => UN152_CHANGE_7_AM(8));
UN152_CHANGE_7_AM_1q8z_Z2061: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(8),
  I3 => R_TXFIFO_4(8),
  LO => UN152_CHANGE_7_AM_1(8));
UN152_CHANGE_7_BMq8z_Z2062: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(8),
  I2 => R_TXFIFO_7(8),
  I3 => UN152_CHANGE_7_BM_1(8),
  O => UN152_CHANGE_7_BM(8));
UN152_CHANGE_7_BM_1q8z_Z2063: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(8),
  I3 => R_TXFIFO_5(8),
  LO => UN152_CHANGE_7_BM_1(8));
UN152_CHANGE_7_AMq12z_Z2064: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(12),
  I2 => R_TXFIFO_6(12),
  I3 => UN152_CHANGE_7_AM_1(12),
  O => UN152_CHANGE_7_AM(12));
UN152_CHANGE_7_AM_1q12z_Z2065: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(12),
  I3 => R_TXFIFO_4(12),
  LO => UN152_CHANGE_7_AM_1(12));
UN152_CHANGE_7_BMq12z_Z2066: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(12),
  I2 => R_TXFIFO_7(12),
  I3 => UN152_CHANGE_7_BM_1(12),
  O => UN152_CHANGE_7_BM(12));
UN152_CHANGE_7_BM_1q12z_Z2067: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(12),
  I3 => R_TXFIFO_5(12),
  LO => UN152_CHANGE_7_BM_1(12));
UN152_CHANGE_7_AMq16z_Z2068: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(16),
  I2 => R_TXFIFO_6(16),
  I3 => UN152_CHANGE_7_AM_1(16),
  O => UN152_CHANGE_7_AM(16));
UN152_CHANGE_7_AM_1q16z_Z2069: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(16),
  I3 => R_TXFIFO_4(16),
  LO => UN152_CHANGE_7_AM_1(16));
UN152_CHANGE_7_BMq16z_Z2070: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(16),
  I2 => R_TXFIFO_7(16),
  I3 => UN152_CHANGE_7_BM_1(16),
  O => UN152_CHANGE_7_BM(16));
UN152_CHANGE_7_BM_1q16z_Z2071: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(16),
  I3 => R_TXFIFO_5(16),
  LO => UN152_CHANGE_7_BM_1(16));
UN152_CHANGE_7_AMq18z_Z2072: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(18),
  I2 => R_TXFIFO_6(18),
  I3 => UN152_CHANGE_7_AM_1(18),
  O => UN152_CHANGE_7_AM(18));
UN152_CHANGE_7_AM_1q18z_Z2073: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(18),
  I3 => R_TXFIFO_4(18),
  LO => UN152_CHANGE_7_AM_1(18));
UN152_CHANGE_7_BMq18z_Z2074: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(18),
  I2 => R_TXFIFO_7(18),
  I3 => UN152_CHANGE_7_BM_1(18),
  O => UN152_CHANGE_7_BM(18));
UN152_CHANGE_7_BM_1q18z_Z2075: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(18),
  I3 => R_TXFIFO_5(18),
  LO => UN152_CHANGE_7_BM_1(18));
UN152_CHANGE_7_AMq20z_Z2076: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(20),
  I2 => R_TXFIFO_6(20),
  I3 => UN152_CHANGE_7_AM_1(20),
  O => UN152_CHANGE_7_AM(20));
UN152_CHANGE_7_AM_1q20z_Z2077: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(20),
  I3 => R_TXFIFO_4(20),
  LO => UN152_CHANGE_7_AM_1(20));
UN152_CHANGE_7_BMq20z_Z2078: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(20),
  I2 => R_TXFIFO_7(20),
  I3 => UN152_CHANGE_7_BM_1(20),
  O => UN152_CHANGE_7_BM(20));
UN152_CHANGE_7_BM_1q20z_Z2079: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(20),
  I3 => R_TXFIFO_5(20),
  LO => UN152_CHANGE_7_BM_1(20));
UN152_CHANGE_7_AMq22z_Z2080: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(22),
  I2 => R_TXFIFO_6(22),
  I3 => UN152_CHANGE_7_AM_1(22),
  O => UN152_CHANGE_7_AM(22));
UN152_CHANGE_7_AM_1q22z_Z2081: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(22),
  I3 => R_TXFIFO_4(22),
  LO => UN152_CHANGE_7_AM_1(22));
UN152_CHANGE_7_BMq22z_Z2082: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(22),
  I2 => R_TXFIFO_7(22),
  I3 => UN152_CHANGE_7_BM_1(22),
  O => UN152_CHANGE_7_BM(22));
UN152_CHANGE_7_BM_1q22z_Z2083: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(22),
  I3 => R_TXFIFO_5(22),
  LO => UN152_CHANGE_7_BM_1(22));
UN152_CHANGE_7_AMq24z_Z2084: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(24),
  I2 => R_TXFIFO_6(24),
  I3 => UN152_CHANGE_7_AM_1(24),
  O => UN152_CHANGE_7_AM(24));
UN152_CHANGE_7_AM_1q24z_Z2085: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(24),
  I3 => R_TXFIFO_4(24),
  LO => UN152_CHANGE_7_AM_1(24));
UN152_CHANGE_7_BMq24z_Z2086: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(24),
  I2 => R_TXFIFO_7(24),
  I3 => UN152_CHANGE_7_BM_1(24),
  O => UN152_CHANGE_7_BM(24));
UN152_CHANGE_7_BM_1q24z_Z2087: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(24),
  I3 => R_TXFIFO_5(24),
  LO => UN152_CHANGE_7_BM_1(24));
UN152_CHANGE_7_AMq28z_Z2088: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(28),
  I2 => R_TXFIFO_6(28),
  I3 => UN152_CHANGE_7_AM_1(28),
  O => UN152_CHANGE_7_AM(28));
UN152_CHANGE_7_AM_1q28z_Z2089: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(28),
  I3 => R_TXFIFO_4(28),
  LO => UN152_CHANGE_7_AM_1(28));
UN152_CHANGE_7_BMq28z_Z2090: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(28),
  I2 => R_TXFIFO_7(28),
  I3 => UN152_CHANGE_7_BM_1(28),
  O => UN152_CHANGE_7_BM(28));
UN152_CHANGE_7_BM_1q28z_Z2091: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(28),
  I3 => R_TXFIFO_5(28),
  LO => UN152_CHANGE_7_BM_1(28));
UN152_CHANGE_7_AMq0z_Z2092: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(0),
  I2 => R_TXFIFO_6(0),
  I3 => UN152_CHANGE_7_AM_1(0),
  O => UN152_CHANGE_7_AM(0));
UN152_CHANGE_7_AM_1q0z_Z2093: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(0),
  I3 => R_TXFIFO_4(0),
  LO => UN152_CHANGE_7_AM_1(0));
UN152_CHANGE_7_BMq0z_Z2094: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(0),
  I2 => R_TXFIFO_7(0),
  I3 => UN152_CHANGE_7_BM_1(0),
  O => UN152_CHANGE_7_BM(0));
UN152_CHANGE_7_BM_1q0z_Z2095: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(0),
  I3 => R_TXFIFO_5(0),
  LO => UN152_CHANGE_7_BM_1(0));
UN152_CHANGE_7_AMq26z_Z2096: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(26),
  I2 => R_TXFIFO_6(26),
  I3 => UN152_CHANGE_7_AM_1(26),
  O => UN152_CHANGE_7_AM(26));
UN152_CHANGE_7_AM_1q26z_Z2097: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(26),
  I3 => R_TXFIFO_4(26),
  LO => UN152_CHANGE_7_AM_1(26));
UN152_CHANGE_7_BMq26z_Z2098: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(26),
  I2 => R_TXFIFO_7(26),
  I3 => UN152_CHANGE_7_BM_1(26),
  O => UN152_CHANGE_7_BM(26));
UN152_CHANGE_7_BM_1q26z_Z2099: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(26),
  I3 => R_TXFIFO_5(26),
  LO => UN152_CHANGE_7_BM_1(26));
UN152_CHANGE_7_AMq10z_Z2100: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(10),
  I2 => R_TXFIFO_6(10),
  I3 => UN152_CHANGE_7_AM_1(10),
  O => UN152_CHANGE_7_AM(10));
UN152_CHANGE_7_AM_1q10z_Z2101: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(10),
  I3 => R_TXFIFO_4(10),
  LO => UN152_CHANGE_7_AM_1(10));
UN152_CHANGE_7_BMq10z_Z2102: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(10),
  I2 => R_TXFIFO_7(10),
  I3 => UN152_CHANGE_7_BM_1(10),
  O => UN152_CHANGE_7_BM(10));
UN152_CHANGE_7_BM_1q10z_Z2103: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(10),
  I3 => R_TXFIFO_5(10),
  LO => UN152_CHANGE_7_BM_1(10));
COMB_V_SPIO_MOSI_2_15: LUT4 
generic map(
  INIT => X"AA3A"
)
port map (
  I0 => N_838,
  I1 => COMB_V_SPIO_MOSI_2_15_1,
  I2 => R_TBITCNT(1),
  I3 => TINDEX_0_SQMUXA,
  O => N_846);
COMB_V_SPIO_MOSI_2_15_1_Z2105: LUT4_L 
generic map(
  INIT => X"5F30"
)
port map (
  I0 => N_840,
  I1 => N_843,
  I2 => COMB_TINDEX_1(3),
  I3 => COMB_V_SPIO_MOSI_2_14_1,
  LO => COMB_V_SPIO_MOSI_2_15_1);
R_TBITCNT_LM_0q0z: LUT4_L 
generic map(
  INIT => X"5702"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TBITCNT(0),
  I3 => R_TBITCNT_LM_0_1(0),
  LO => R_TBITCNT_LM(0));
R_TBITCNT_LM_0_1q0z_Z2107: LUT3 
generic map(
  INIT => X"07"
)
port map (
  I0 => R_MODE_CPHA,
  I1 => TINDEX_0_SQMUXA,
  I2 => TINDEX_1_SQMUXA,
  O => R_TBITCNT_LM_0_1(0));
R_RUNNINGC_1_Z2108: LUT3 
generic map(
  INIT => X"04"
)
port map (
  I0 => COMB_UN1_R_RUNNING_M,
  I1 => rstn,
  I2 => V_IRQ_0_SQMUXA_1_0,
  O => R_RUNNINGC_1);
COMB_V_SPIO_MOSIOEN_1_M2_Z2109: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSIOEN_1_M2_AM,
    I1 => COMB_V_SPIO_MOSIOEN_1_M2_BM,
    S => COMB_V_SPIO_MOSIOEN_1_SM0_0,
    O => COMB_V_SPIO_MOSIOEN_1_M2);
UN152_CHANGE_3q1z: MUXF5 port map (
    I0 => UN152_CHANGE_1(1),
    I1 => UN152_CHANGE_2(1),
    S => R_TDFI(1),
    O => N_1536);
UN152_CHANGE_3q5z: MUXF5 port map (
    I0 => UN152_CHANGE_1(5),
    I1 => UN152_CHANGE_2(5),
    S => R_TDFI(1),
    O => N_1540);
UN152_CHANGE_3q13z: MUXF5 port map (
    I0 => UN152_CHANGE_1(13),
    I1 => UN152_CHANGE_2(13),
    S => R_TDFI(1),
    O => N_1548);
UN152_CHANGE_3q17z: MUXF5 port map (
    I0 => UN152_CHANGE_1(17),
    I1 => UN152_CHANGE_2(17),
    S => R_TDFI(1),
    O => N_1552);
UN152_CHANGE_3q21z: MUXF5 port map (
    I0 => UN152_CHANGE_1(21),
    I1 => UN152_CHANGE_2(21),
    S => R_TDFI(1),
    O => N_1556);
UN152_CHANGE_3q25z: MUXF5 port map (
    I0 => N_1498,
    I1 => N_1529,
    S => R_TDFI(1),
    O => N_1560);
UN152_CHANGE_6q1z: MUXF5 port map (
    I0 => N_1567,
    I1 => N_1598,
    S => R_TDFI(1),
    O => N_1629);
UN152_CHANGE_6q5z: MUXF5 port map (
    I0 => N_1571,
    I1 => UN152_CHANGE_5(5),
    S => R_TDFI(1),
    O => N_1633);
UN152_CHANGE_6q25z: MUXF5 port map (
    I0 => UN152_CHANGE_4(25),
    I1 => UN152_CHANGE_5(25),
    S => R_TDFI(1),
    O => N_1653);
UN152_CHANGE_3q15z: MUXF5 port map (
    I0 => N_1488,
    I1 => N_1519,
    S => R_TDFI(1),
    O => N_1550);
UN152_CHANGE_3q31z: MUXF5 port map (
    I0 => N_1504,
    I1 => N_1535,
    S => R_TDFI(1),
    O => N_1566);
UN152_CHANGE_6q15z: MUXF5 port map (
    I0 => N_1581,
    I1 => N_1612,
    S => R_TDFI(1),
    O => N_1643);
UN152_CHANGE_6q31z: MUXF5 port map (
    I0 => N_1597,
    I1 => N_1628,
    S => R_TDFI(1),
    O => N_1659);
UN152_CHANGE_6q29z_Z2123: MUXF5 port map (
    I0 => UN152_CHANGE_4(29),
    I1 => UN152_CHANGE_5(29),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(29));
UN152_CHANGE_6q27z_Z2124: MUXF5 port map (
    I0 => UN152_CHANGE_4(27),
    I1 => UN152_CHANGE_5(27),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(27));
UN152_CHANGE_6q23z_Z2125: MUXF5 port map (
    I0 => UN152_CHANGE_4(23),
    I1 => UN152_CHANGE_5(23),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(23));
UN152_CHANGE_6q21z_Z2126: MUXF5 port map (
    I0 => UN152_CHANGE_4(21),
    I1 => UN152_CHANGE_5(21),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(21));
UN152_CHANGE_6q19z_Z2127: MUXF5 port map (
    I0 => UN152_CHANGE_4(19),
    I1 => UN152_CHANGE_5(19),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(19));
UN152_CHANGE_6q17z_Z2128: MUXF5 port map (
    I0 => UN152_CHANGE_4(17),
    I1 => UN152_CHANGE_5(17),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(17));
UN152_CHANGE_6q13z_Z2129: MUXF5 port map (
    I0 => UN152_CHANGE_4(13),
    I1 => UN152_CHANGE_5(13),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(13));
UN152_CHANGE_6q11z_Z2130: MUXF5 port map (
    I0 => UN152_CHANGE_4(11),
    I1 => UN152_CHANGE_5(11),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(11));
UN152_CHANGE_6q9z_Z2131: MUXF5 port map (
    I0 => UN152_CHANGE_4(9),
    I1 => UN152_CHANGE_5(9),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(9));
UN152_CHANGE_6q7z_Z2132: MUXF5 port map (
    I0 => UN152_CHANGE_4(7),
    I1 => UN152_CHANGE_5(7),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(7));
UN152_CHANGE_6q3z_Z2133: MUXF5 port map (
    I0 => UN152_CHANGE_4(3),
    I1 => UN152_CHANGE_5(3),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(3));
UN152_CHANGE_3q29z_Z2134: MUXF5 port map (
    I0 => UN152_CHANGE_1(29),
    I1 => UN152_CHANGE_2(29),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(29));
UN152_CHANGE_3q27z_Z2135: MUXF5 port map (
    I0 => UN152_CHANGE_1(27),
    I1 => UN152_CHANGE_2(27),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(27));
UN152_CHANGE_3q23z_Z2136: MUXF5 port map (
    I0 => UN152_CHANGE_1(23),
    I1 => UN152_CHANGE_2(23),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(23));
UN152_CHANGE_3q19z_Z2137: MUXF5 port map (
    I0 => UN152_CHANGE_1(19),
    I1 => UN152_CHANGE_2(19),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(19));
UN152_CHANGE_3q11z_Z2138: MUXF5 port map (
    I0 => UN152_CHANGE_1(11),
    I1 => UN152_CHANGE_2(11),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(11));
UN152_CHANGE_3q9z_Z2139: MUXF5 port map (
    I0 => UN152_CHANGE_1(9),
    I1 => UN152_CHANGE_2(9),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(9));
UN152_CHANGE_3q7z_Z2140: MUXF5 port map (
    I0 => UN152_CHANGE_1(7),
    I1 => UN152_CHANGE_2(7),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(7));
UN152_CHANGE_3q3z_Z2141: MUXF5 port map (
    I0 => UN152_CHANGE_1(3),
    I1 => UN152_CHANGE_2(3),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(3));
COMB_V_LST_1_Z2142: LUT4_L 
generic map(
  INIT => X"0888"
)
port map (
  I0 => N_2120_0,
  I1 => apbi_pwdata(22),
  I2 => COMB_V_EVENT_LT6_3,
  I3 => R_EVENT_LTD_1,
  LO => COMB_V_LST_1);
COMB_V_DIVCNT_1q7z_Z2143: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(7),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC7,
  LO => COMB_V_DIVCNT_1(7));
COMB_V_DIVCNT_1q9z_Z2144: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(9),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9,
  LO => COMB_V_DIVCNT_1(9));
R_SPIO_MOSIOEN_RNO: LUT4_L 
generic map(
  INIT => X"DF0F"
)
port map (
  I0 => N_1458,
  I1 => COMB_UN26_AM_EN_0,
  I2 => COMB_V_SPIO_MOSIOEN25,
  I3 => COMB_V_SPIO_MOSIOEN_1_M2,
  LO => COMB_V_SPIO_MOSIOEN_1_0_I);
COMB_V_DIVCNT_1q6z_Z2146: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(6),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC6,
  LO => COMB_V_DIVCNT_1(6));
COMB_V_DIVCNT_1q8z_Z2147: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(8),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8,
  LO => COMB_V_DIVCNT_1(8));
R_RXDONE2E_RNO: LUT4_L 
generic map(
  INIT => X"FEEE"
)
port map (
  I0 => COMB_UN1_R_RUNNING_1,
  I1 => COMB_UN1_SAMPLE,
  I2 => R_INCRDLI,
  I3 => R_SYNCSAMP(1),
  LO => V_RXDONE2_1_SQMUXA_I);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9_Z2149: LUT4_L 
generic map(
  INIT => X"AC53"
)
port map (
  I0 => N_630,
  I1 => N_874,
  I2 => N_875,
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_C9,
  LO => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC7_Z2150: LUT4_L 
generic map(
  INIT => X"F0E1"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_RELOAD(3),
  I2 => UN1_RELOAD(2),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  LO => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC7);
R_SPIO_MISO_RNO: LUT4_L 
generic map(
  INIT => X"FFCA"
)
port map (
  I0 => N_846,
  I1 => N_861,
  I2 => COMB_TINDEX_1(0),
  I3 => COMB_V_UF_7,
  LO => COMB_V_SPIO_MISO_3_0_I);
R_TXFIFO_1_RNOq0z: LUT4_L 
generic map(
  INIT => X"1F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1SR_0,
  I3 => V_TXFIFO_7_1_SQMUXA_1_4,
  LO => R_TXFIFO_1S_I);
R_TXFIFO_3_RNOq0z: LUT4_L 
generic map(
  INIT => X"2F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_3SR_0,
  I3 => V_TXFIFO_7_1_SQMUXA_1_4,
  LO => R_TXFIFO_3S_I);
R_TXFIFO_5_RNOq0z: LUT4_L 
generic map(
  INIT => X"4F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_5SR_0,
  I3 => V_TXFIFO_7_1_SQMUXA_1_4,
  LO => R_TXFIFO_5S_I);
R_TXFIFO_7_RNOq0z: LUT4_L 
generic map(
  INIT => X"8F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_7SR_0,
  I3 => V_TXFIFO_7_1_SQMUXA_1_4,
  LO => R_TXFIFO_7S_I);
COMB_V_INCRDLI_1_Z2156: LUT4_L 
generic map(
  INIT => X"0444"
)
port map (
  I0 => COMB_UN1_SAMPLE,
  I1 => COMB_V_INCRDLI_5,
  I2 => R_INCRDLI,
  I3 => R_SYNCSAMP(1),
  LO => COMB_V_INCRDLI_1);
R_RXDONE_RNO: LUT3_L 
generic map(
  INIT => X"EA"
)
port map (
  I0 => COMB_UN1_SAMPLE,
  I1 => R_INCRDLI,
  I2 => R_SYNCSAMP(1),
  LO => COMB_V_RXDONE_2_0_I);
R_CGCNT_LM_0q5z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2182_0,
  I1 => R_CGCNT_S(5),
  I2 => R_MODE_CG(4),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(5));
R_CGCNT_LM_0q4z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2182_0,
  I1 => R_CGCNT_S(4),
  I2 => R_MODE_CG(3),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(4));
R_CGCNT_LM_0q3z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2182_0,
  I1 => R_CGCNT_S(3),
  I2 => R_MODE_CG(2),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(3));
R_CGCNT_LM_0q2z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2182_0,
  I1 => R_CGCNT_S(2),
  I2 => R_MODE_CG(1),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(2));
R_CGCNT_LM_0q1z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2182_0,
  I1 => R_CGCNT_S(1),
  I2 => R_MODE_CG(0),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(1));
UN1_V_DIVCNT_0_SQMUXA_1_C9_Z2163: LUT4_L 
generic map(
  INIT => X"FFAC"
)
port map (
  I0 => N_629,
  I1 => N_873,
  I2 => N_875,
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P7,
  LO => UN1_V_DIVCNT_0_SQMUXA_1_C9);
UN1_R_TFREECNT_1_AXB0_Z2164: LUT4_L 
generic map(
  INIT => X"4BB4"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  I2 => R_TFREECNT(0),
  I3 => V_TDFI_0_SQMUXA,
  LO => UN1_R_TFREECNT_1_AXB0);
COMB_V_SPIO_MOSIOEN_1_M2_BM_Z2165: LUT4 
generic map(
  INIT => X"EC4C"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => R_MODE_TTO,
  I2 => R_MODE_TW,
  I3 => R_TWDIR,
  O => COMB_V_SPIO_MOSIOEN_1_M2_BM);
COMB_V_SPIO_MOSIOEN_1_M2_AM_Z2166: LUT4 
generic map(
  INIT => X"CCF7"
)
port map (
  I0 => R_MODE_TTO,
  I1 => R_MODE_TW,
  I2 => R_SPII_1_SPISEL,
  I3 => V_SPIO_MOSIOEN_2_SQMUXA,
  O => COMB_V_SPIO_MOSIOEN_1_M2_AM);
R_TXFIFO_2_RNOq0z: LUT4_L 
generic map(
  INIT => X"1F0F"
)
port map (
  I0 => R_TDFI(0),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_2SR_0,
  I3 => V_TXFIFO_6_1_SQMUXA_1_4,
  LO => R_TXFIFO_2S_I);
R_TXFIFO_6_RNOq0z: LUT4_L 
generic map(
  INIT => X"4F0F"
)
port map (
  I0 => R_TDFI(0),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_6SR_0,
  I3 => V_TXFIFO_6_1_SQMUXA_1_4,
  LO => R_TXFIFO_6S_I);
R_CGCNT_LM_0q0z: LUT4_L 
generic map(
  INIT => X"0004"
)
port map (
  I0 => R_CGCNT(0),
  I1 => R_RUNNING,
  I2 => V_CGCNT_0_SQMUXA_1,
  I3 => V_CGCNT_0_SQMUXA_2,
  LO => R_CGCNT_LM(0));
R_TDFI_RNOq2z_Z2170: LUT4_L 
generic map(
  INIT => X"78F0"
)
port map (
  I0 => R_TDFI(0),
  I1 => R_TDFI(1),
  I2 => R_TDFI(2),
  I3 => V_TDFI_0_SQMUXA,
  LO => R_TDFI_RNO(2));
R_CGCNTE_0_I_Z2171: LUT4 
generic map(
  INIT => X"FFFE"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => V_CGCNT_0_SQMUXA,
  I2 => V_CGCNT_0_SQMUXA_1,
  I3 => V_CGCNT_0_SQMUXA_2,
  O => R_CGCNTE_0_I);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8_Z2172: LUT4_L 
generic map(
  INIT => X"AC53"
)
port map (
  I0 => N_629,
  I1 => N_873,
  I2 => N_875,
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P7,
  LO => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC6_Z2173: LUT3_L 
generic map(
  INIT => X"C9"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_RELOAD(3),
  I2 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  LO => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC6);
R_RUNNING_RNI6NQP2: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => R_RUNNING,
  I1 => V_CGCNT_0_SQMUXA_1,
  I2 => V_CGCNT_0_SQMUXA_2,
  O => N_2182_0);
R_TXFIFO_4_RNOq0z: LUT4_L 
generic map(
  INIT => X"FBBB"
)
port map (
  I0 => COMB_V_TXFIFO_4_5(0),
  I1 => rstn,
  I2 => V_TDFI_0_SQMUXA_1,
  I3 => V_TXFIFO_4_1_SQMUXA_1_2,
  LO => R_TXFIFO_4S_I);
R_TXFIFO_0_RNOq0z: LUT4_L 
generic map(
  INIT => X"FBBB"
)
port map (
  I0 => COMB_V_TXFIFO_0_5(0),
  I1 => rstn,
  I2 => V_TDFI_0_SQMUXA_1,
  I3 => V_TXFIFO_0_1_SQMUXA_1_1,
  LO => R_TXFIFO_0S_I);
COMB_V_SPIO_MOSIOEN_1_M2S2: LUT4 
generic map(
  INIT => X"00F7"
)
port map (
  I0 => COMB_V_SPIO_MOSIOEN25,
  I1 => TINDEX_0_SQMUXA,
  I2 => V_SPIO_MOSIOEN_0_SQMUXA_1,
  I3 => V_SPIO_MOSIOEN_2_SQMUXA,
  O => COMB_V_SPIO_MOSIOEN_1_SM0_0);
R_TDFI_RNOq1z_Z2178: LUT3_L 
generic map(
  INIT => X"6C"
)
port map (
  I0 => R_TDFI(0),
  I1 => R_TDFI(1),
  I2 => V_TDFI_0_SQMUXA,
  LO => R_TDFI_RNO(1));
COMB_UN1_SAMPLE_Z2179: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => COMB_UN30_SAMPLE,
  I1 => COMB_V_INCRDLI_5,
  I2 => R_SYNCSAMPC_0,
  I3 => R_SYNCSAMPC_1,
  O => COMB_UN1_SAMPLE);
R_SPIO_MOSIOEN_RNO_0: LUT4 
generic map(
  INIT => X"B3FF"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_V_SPIO_MOSIOEN25,
  I2 => R_MODE_TW,
  I3 => R_RUNNING,
  O => V_SPIO_MOSIOEN_4_SQMUXA_I);
COMB_UN1_R_MODE_EN_2_Z2181: LUT4 
generic map(
  INIT => X"0080"
)
port map (
  I0 => N_2216,
  I1 => COMB_UN1_R_MODE_EN_2_0,
  I2 => R_MODE_EN,
  I3 => V_IRQ_0_SQMUXA_1_0,
  O => COMB_UN1_R_MODE_EN_2);
COMB_V_DIVCNT_1q1z_Z2182: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_786,
  I1 => N_795,
  I2 => R_MODE_PM(1),
  LO => COMB_V_DIVCNT_1(1));
COMB_V_DIVCNT_1q2z_Z2183: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_787,
  I1 => N_795,
  I2 => R_MODE_PM(2),
  LO => COMB_V_DIVCNT_1(2));
COMB_V_DIVCNT_1q3z_Z2184: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_788,
  I1 => N_795,
  I2 => R_MODE_PM(3),
  LO => COMB_V_DIVCNT_1(3));
UN1_RELOADq3z_Z2185: MUXF5 port map (
    I0 => UN1_RELOAD_AM(3),
    I1 => UN1_RELOAD_BM(3),
    S => N_875,
    O => UN1_RELOAD(3));
UN1_RELOAD_BMq3z_Z2186: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  O => UN1_RELOAD_BM(3));
UN1_RELOAD_AMq3z_Z2187: LUT3 
generic map(
  INIT => X"AC"
)
port map (
  I0 => N_628,
  I1 => COMB_V_DIVCNT_5(5),
  I2 => R_MODE_FACT,
  O => UN1_RELOAD_AM(3));
UN1_RELOADq2z_Z2188: MUXF5 port map (
    I0 => UN1_RELOAD_AM(2),
    I1 => UN1_RELOAD_BM(2),
    S => N_875,
    O => UN1_RELOAD(2));
UN1_RELOAD_BMq2z_Z2189: LUT3 
generic map(
  INIT => X"78"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  O => UN1_RELOAD_BM(2));
UN1_RELOAD_AMq2z_Z2190: LUT3 
generic map(
  INIT => X"AC"
)
port map (
  I0 => N_629,
  I1 => COMB_V_DIVCNT_5(6),
  I2 => R_MODE_FACT,
  O => UN1_RELOAD_AM(2));
V_EVENT_TIP_0_SQMUXA_1_Z2191: LUT3_L 
generic map(
  INIT => X"08"
)
port map (
  I0 => N_2120_0,
  I1 => N_2216,
  I2 => V_IRQ_0_SQMUXA_1_0,
  LO => V_EVENT_TIP_0_SQMUXA_1);
R_TWDIR_RNO: LUT4_L 
generic map(
  INIT => X"C355"
)
port map (
  I0 => COMB_V_TWDIR_1_IV_0_TZ,
  I1 => R_MODE_LOOPB,
  I2 => R_TWDIR,
  I3 => V_TWDIR_0_SQMUXA,
  LO => COMB_V_TWDIR_1_0_I);
R_EVENT_TIP_RNO: LUT4 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => N_2120_0,
  I1 => N_2216,
  I2 => COMB_UN1_R_RUNNING_1,
  I3 => V_IRQ_0_SQMUXA_1_0,
  O => V_EVENT_TIP_2_SQMUXA_I);
COMB_V_IRQ_1_IV_M6_2_Z2194: LUT4 
generic map(
  INIT => X"0222"
)
port map (
  I0 => COMB_V_IRQ_1_IV_M6_0,
  I1 => V_IRQ_0_SQMUXA_2,
  I2 => V_IRQ_0_SQMUXA_3_1,
  I3 => V_IRQ_0_SQMUXA_3_2,
  O => COMB_V_IRQ_1_IV_M6_2);
COMB_V_DIVCNT_1q0z_Z2195: LUT4_L 
generic map(
  INIT => X"FB51"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(0),
  I3 => R_MODE_PM(0),
  LO => COMB_V_DIVCNT_1(0));
COMB_V_DIVCNT_1q4z_Z2196: LUT4_L 
generic map(
  INIT => X"A8AA"
)
port map (
  I0 => N_789,
  I1 => COMB_RELOAD_1_0,
  I2 => R_MODE_DIV16,
  I3 => R_MODE_FACT,
  LO => COMB_V_DIVCNT_1(4));
COMB_V_DIVCNT_1q5z_Z2197: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(5),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC5,
  LO => COMB_V_DIVCNT_1(5));
COMB_V_SPIO_MOSI_2_30: MUXF8 port map (
    I0 => N_853,
    I1 => N_860,
    S => COMB_TINDEX_1(2),
    O => N_861);
COMB_V_INCRDLI_5_Z2199: LUT4 
generic map(
  INIT => X"8DCC"
)
port map (
  I0 => COMB_UN47_SAMPLE_0,
  I1 => R_INCRDLI,
  I2 => R_OV,
  I3 => V_TWDIR_0_SQMUXA,
  O => COMB_V_INCRDLI_5);
COMB_UN40_CHANGE_RNIJ2S11: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => R_TDFI(0),
  O => V_TXFIFO_7_1_SQMUXA_1_4);
R_TDFI_RNOq0z_Z2201: LUT4_L 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => R_TDFI(0),
  LO => R_TDFI_RNO(0));
UN1_V_CGCNT_0_SQMUXA_2: LUT4 
generic map(
  INIT => X"2E3F"
)
port map (
  I0 => COMB_UN65_SAMPLE_0,
  I1 => R_MODE_CPHA,
  I2 => V_TDFI_0_SQMUXA_1,
  I3 => V_TWDIR_0_SQMUXA,
  O => UN1_V_CGCNT_0_SQMUXA_2_0);
APBO_PRDATA_IV_1_RNINNQ21q11z: LUT4 
generic map(
  INIT => X"FFBF"
)
port map (
  I0 => N_141,
  I1 => APBO_PRDATA_IV_1(11),
  I2 => APBO_PRDATA_IV_2(11),
  I3 => R_MASK_UN_M,
  O => apbo_prdata(11));
APBO_PRDATA_0_IV_0_RNIRD4Rq10z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(10),
  I1 => APBO_PRDATA_0_IV_1(10),
  I2 => APBOUT_5_SQMUXA,
  I3 => R_RD(26),
  O => apbo_prdata(10));
APBO_PRDATA_0_IV_0_RNIAFLH1q9z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(9),
  I1 => APBO_PRDATA_0_IV_1(9),
  I2 => APBOUT_5_SQMUXA,
  I3 => R_RD(25),
  O => apbo_prdata(9));
APBO_PRDATA_0_IV_0_RNI7BLH1q8z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(8),
  I1 => APBO_PRDATA_0_IV_1(8),
  I2 => APBOUT_5_SQMUXA,
  I3 => R_RD(24),
  O => apbo_prdata(8));
UN1_V_OV10: LUT4 
generic map(
  INIT => X"F010"
)
port map (
  I0 => COMB_UN21_SAMPLE_0,
  I1 => COMB_UN30_SAMPLE,
  I2 => R_SYNCSAMPC_1,
  I3 => V_OV_0_SQMUXA_1,
  O => UN1_V_OV10_0);
COMB_V_UF_7_IV: LUT4 
generic map(
  INIT => X"54FC"
)
port map (
  I0 => R_SYNCSAMPC_1,
  I1 => R_UF,
  I2 => V_IRQ_0_SQMUXA_2_1,
  I3 => V_OV_0_SQMUXA_1,
  O => COMB_V_UF_7);
R_TWDIR_RNO_0: LUT3 
generic map(
  INIT => X"B3"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => R_RUNNING,
  I2 => R_SYNCSAMPC_1,
  O => V_TWDIR_2_SQMUXA_I);
V_TXFIFO_2_1_SQMUXA_1_4: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => R_TDFI(1),
  O => V_TXFIFO_6_1_SQMUXA_1_4);
R_TBITCNT_LM_0q4z: LUT3_L 
generic map(
  INIT => X"20"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TBITCNT_S(4),
  LO => R_TBITCNT_LM(4));
R_TBITCNT_LM_0q3z: LUT3_L 
generic map(
  INIT => X"20"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TBITCNT_S(3),
  LO => R_TBITCNT_LM(3));
R_TBITCNT_LM_0q2z: LUT3_L 
generic map(
  INIT => X"20"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TBITCNT_S(2),
  LO => R_TBITCNT_LM(2));
R_TBITCNT_LM_0q1z: LUT3_L 
generic map(
  INIT => X"20"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TBITCNT_S(1),
  LO => R_TBITCNT_LM(1));
COMB_V_DIVCNT_1_0q1z: LUT4_L 
generic map(
  INIT => X"80D5"
)
port map (
  I0 => COMB_RELOAD_1_0,
  I1 => COMB_V_SPIO_SCK20,
  I2 => UN1_R_DIVCNT_1_S_1,
  I3 => R_MODE_DIV16_RNIPI88,
  LO => N_786);
COMB_V_DIVCNT_1_0q2z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(2),
    I1 => COMB_V_DIVCNT_1_0_BM(2),
    S => COMB_RELOAD_1_0,
    O => N_787);
COMB_V_DIVCNT_1_0_BMq2z_Z2217: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_V_SPIO_SCK20,
  I1 => UN1_R_DIVCNT_1_S_2,
  O => COMB_V_DIVCNT_1_0_BM(2));
COMB_V_DIVCNT_1_0_AMq2z_Z2218: LUT3 
generic map(
  INIT => X"1E"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  I2 => R_MODE_DIV16_RNIOUDC,
  O => COMB_V_DIVCNT_1_0_AM(2));
COMB_V_DIVCNT_1_0q3z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(3),
    I1 => COMB_V_DIVCNT_1_0_BM(3),
    S => COMB_RELOAD_1_0,
    O => N_788);
COMB_V_DIVCNT_1_0_BMq3z_Z2220: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_V_SPIO_SCK20,
  I1 => UN1_R_DIVCNT_1_S_3,
  O => COMB_V_DIVCNT_1_0_BM(3));
COMB_V_DIVCNT_1_0_AMq3z_Z2221: LUT3 
generic map(
  INIT => X"A9"
)
port map (
  I0 => R_MODE_PM_RNIOEJG(2),
  I1 => R_MODE_DIV16_RNIOUDC,
  I2 => R_MODE_DIV16_RNIPI88,
  O => COMB_V_DIVCNT_1_0_AM(3));
UN1_RELOAD_0q1z: LUT3 
generic map(
  INIT => X"AC"
)
port map (
  I0 => N_630,
  I1 => COMB_V_DIVCNT_5(7),
  I2 => R_MODE_FACT,
  O => N_873);
UN1_RELOAD_0q0z: LUT3 
generic map(
  INIT => X"AC"
)
port map (
  I0 => COMB_V_DIVCNT_5(5),
  I1 => COMB_V_DIVCNT_5(8),
  I2 => R_MODE_FACT,
  O => N_874);
COMB_V_DIVCNT_1_0q4z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(4),
    I1 => COMB_V_DIVCNT_1_0_BM(4),
    S => COMB_RELOAD_1_0,
    O => N_789);
COMB_V_DIVCNT_1_0_BMq4z_Z2225: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_V_SPIO_SCK20,
  I1 => UN1_R_DIVCNT_1_S_4,
  O => COMB_V_DIVCNT_1_0_BM(4));
COMB_V_DIVCNT_1_0_AMq4z_Z2226: LUT4 
generic map(
  INIT => X"AAA9"
)
port map (
  I0 => UN1_RELOAD(5),
  I1 => R_MODE_PM_RNIOEJG(2),
  I2 => R_MODE_DIV16_RNIOUDC,
  I3 => R_MODE_DIV16_RNIPI88,
  O => COMB_V_DIVCNT_1_0_AM(4));
R_MODE_CPHA_RNIA3MN: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_MODE_CPHA,
  O => V_CGCNT_0_SQMUXA_2);
R_SPIO_MISO_RNO_0: LUT4 
generic map(
  INIT => X"ABAA"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_SLV_START_UN13_AM_EN,
  I2 => R_MODE_CPHA,
  I3 => TINDEX_0_SQMUXA,
  O => COMB_UN133_CHANGE_0_I);
R_TBITCNTE_0_I_Z2229: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN1_R_MODE_EN,
  O => R_TBITCNTE_0_I);
COMB_CHANGE_4_RNIBRGT1: LUT4 
generic map(
  INIT => X"3020"
)
port map (
  I0 => COMB_CHANGE_4,
  I1 => R_MODE_DIV16,
  I2 => R_MODE_FACT,
  I3 => V_DIVCNT_0_SQMUXA_1,
  O => N_795);
COMB_UN65_SAMPLE_RNI5JVN1: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => COMB_UN65_SAMPLE_0,
  I2 => R_MODE_CPHA,
  I3 => R_SYNCSAMPC_1,
  O => V_CGCNT_0_SQMUXA_1);
R_RUNNINGC_Z2232: LUT4_L 
generic map(
  INIT => X"7F00"
)
port map (
  I0 => COMB_UN40_SAMPLE_NE_1,
  I1 => COMB_V_RUNNING_9_IV_265_A0_5,
  I2 => COMB_V_RUNNING_9_IV_265_A0_6,
  I3 => R_RUNNINGC_1,
  LO => R_RUNNINGC);
APBO_PRDATA_0_IV_0_RNIBME01q31z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(31),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(31),
  I3 => R_RD_M_0(15),
  O => apbo_prdata(31));
APBO_PRDATA_0_IV_0_RNIU80Eq30z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(30),
  I2 => R_MODE_LOOPB,
  O => apbo_prdata(30));
APBO_PRDATA_0_IV_0_RNIA7HMq28z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(28),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(12),
  O => apbo_prdata(28));
APBO_PRDATA_0_IV_0_RNI65MDq27z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(27),
  I2 => R_MODE_DIV16,
  O => apbo_prdata(27));
APBO_PRDATA_0_IV_0_RNIO13Lq26z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(26),
  I2 => R_MODE_REV,
  O => apbo_prdata(26));
APBO_PRDATA_0_IV_0_RNITD7Lq25z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(25),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(9),
  O => apbo_prdata(25));
APBO_PRDATA_0_IV_0_RNIS5IIq24z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(24),
  I2 => R_MODE_EN,
  O => apbo_prdata(24));
APBO_PRDATA_0_IV_0_RNI8V4Gq23z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(23),
  I2 => R_MODE_LEN(3),
  O => apbo_prdata(23));
APBO_PRDATA_0_IV_0_RNIN17Lq22z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(22),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(6),
  O => apbo_prdata(22));
APBO_PRDATA_0_IV_0_RNI4N4Gq21z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(21),
  I2 => R_MODE_LEN(1),
  O => apbo_prdata(21));
APBO_PRDATA_0_IV_0_RNIJP6Lq20z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(20),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(4),
  O => apbo_prdata(20));
APBO_PRDATA_0_IV_0_RNI8D9Tq19z: LUT4 
generic map(
  INIT => X"FBBB"
)
port map (
  I0 => N_141,
  I1 => APBO_PRDATA_0_IV_0(19),
  I2 => APBOUT_5_SQMUXA,
  I3 => R_RD(3),
  O => apbo_prdata(19));
APBO_PRDATA_0_IV_0_RNIBEODq18z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(18),
  I2 => R_MODE_PM(2),
  O => apbo_prdata(18));
APBO_PRDATA_0_IV_0_RNIML7Lq17z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(17),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(1),
  O => apbo_prdata(17));
APBO_PRDATA_0_IV_0_RNI7UNDq16z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(16),
  I2 => R_MODE_PM(0),
  O => apbo_prdata(16));
APBO_PRDATA_0_IV_0_RNIKAIIq15z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(15),
  I2 => R_MODE_TW,
  O => apbo_prdata(15));
APBO_PRDATA_0_IV_0_RNIAQE01q14z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(14),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(30),
  I3 => R_RD_M(14),
  O => apbo_prdata(14));
APBO_PRDATA_0_IV_0_RNI5GRLq13z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(13),
  I2 => R_MODE_FACT,
  O => apbo_prdata(13));
APBO_PRDATA_0_IV_0_RNIF0FSq12z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(12),
  I1 => APBOUT_2_SQMUXA,
  I2 => R_EVENT_OV,
  I3 => R_MASK_OV_M,
  O => apbo_prdata(12));
APBO_PRDATA_0_IV_0_RNIONSOq7z: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => N_62,
  I1 => APBO_PRDATA_0_IV_0(7),
  I2 => R_MODE_CG(0),
  O => apbo_prdata(7));
APBO_PRDATA_0_IV_0_RNIQLP11q3z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(3),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(19),
  O => apbo_prdata(3));
R_RD_RNIH9J21q17z: LUT4 
generic map(
  INIT => X"FFEA"
)
port map (
  I0 => N_141,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(17),
  I3 => R_RD_M(1),
  O => apbo_prdata(1));
R_RD_RNIF5J21q16z: LUT4 
generic map(
  INIT => X"FFEA"
)
port map (
  I0 => N_141,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(16),
  I3 => R_RD_M(0),
  O => apbo_prdata(0));
COMB_V_SPIO_MOSI_2_7: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_7_AM,
    I1 => COMB_V_SPIO_MOSI_2_7_BM,
    S => COMB_TINDEX_1(2),
    O => N_838);
COMB_V_SPIO_MOSI_2_7_BM_Z2257: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_835,
  I1 => N_836,
  I2 => COMB_TINDEX_1(3),
  O => COMB_V_SPIO_MOSI_2_7_BM);
COMB_V_SPIO_MOSI_2_7_AM_Z2258: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_832,
  I1 => N_833,
  I2 => COMB_TINDEX_1(3),
  O => COMB_V_SPIO_MOSI_2_7_AM);
COMB_V_SPIO_MOSI_2_14_1_Z2259: LUT4_L 
generic map(
  INIT => X"0F35"
)
port map (
  I0 => N_839,
  I1 => N_842,
  I2 => COMB_TINDEX_1(2),
  I3 => COMB_TINDEX_1(3),
  LO => COMB_V_SPIO_MOSI_2_14_1);
R_OV_RNO: LUT2_L 
generic map(
  INIT => X"D"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => COMB_UN65_SAMPLE_0,
  LO => V_OV_0_SQMUXA_1_I);
COMB_V_SPIO_MOSI_2_29: MUXF7 port map (
    I0 => COMB_V_SPIO_MOSI_2_21,
    I1 => COMB_V_SPIO_MOSI_2_28,
    S => COMB_TINDEX_1(3),
    O => N_860);
COMB_V_SPIO_MOSI_2_22: MUXF7 port map (
    I0 => COMB_V_SPIO_MOSI_2_18,
    I1 => N_856,
    S => COMB_TINDEX_1(3),
    O => N_853);
V_IRQ_0_SQMUXA_2_Z2263: LUT3_L 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_V_EVENT_UN_3,
  I1 => R_MASK_UN,
  I2 => V_IRQ_0_SQMUXA_2_1,
  LO => V_IRQ_0_SQMUXA_2);
V_SPIO_MOSIOEN_0_SQMUXA_1_Z2264: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => R_MODE_TW,
  LO => V_SPIO_MOSIOEN_0_SQMUXA_1);
V_TDFI_0_SQMUXA_1_Z2265: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  O => V_TDFI_0_SQMUXA_1);
APBO_PRDATA_0_IV_Iq29z: LUT4 
generic map(
  INIT => X"FDFC"
)
port map (
  I0 => N_62,
  I1 => N_141,
  I2 => APBO_PRDATA_0_IV_I_0(29),
  I3 => R_MODE_CPOL,
  O => apbo_prdata(29));
R_RBITCNT_LM_0q4z: LUT4_L 
generic map(
  INIT => X"4000"
)
port map (
  I0 => N_2167,
  I1 => R_RBITCNT_S(4),
  I2 => UN1_R_MODE_EN_184_0,
  I3 => UN1_R_MODE_EN_184_1,
  LO => R_RBITCNT_LM(4));
R_RBITCNT_LM_0q3z: LUT4_L 
generic map(
  INIT => X"4000"
)
port map (
  I0 => N_2167,
  I1 => R_RBITCNT_S(3),
  I2 => UN1_R_MODE_EN_184_0,
  I3 => UN1_R_MODE_EN_184_1,
  LO => R_RBITCNT_LM(3));
R_RBITCNT_LM_0q2z: LUT4_L 
generic map(
  INIT => X"4000"
)
port map (
  I0 => N_2167,
  I1 => R_RBITCNT_S(2),
  I2 => UN1_R_MODE_EN_184_0,
  I3 => UN1_R_MODE_EN_184_1,
  LO => R_RBITCNT_LM(2));
R_RBITCNT_LM_0q1z: LUT4_L 
generic map(
  INIT => X"4000"
)
port map (
  I0 => N_2167,
  I1 => R_RBITCNT_S(1),
  I2 => UN1_R_MODE_EN_184_0,
  I3 => UN1_R_MODE_EN_184_1,
  LO => R_RBITCNT_LM(1));
R_RBITCNT_LM_0q0z: LUT4_L 
generic map(
  INIT => X"1000"
)
port map (
  I0 => N_2167,
  I1 => R_RBITCNT_QXU(0),
  I2 => UN1_R_MODE_EN_184_0,
  I3 => UN1_R_MODE_EN_184_1,
  LO => R_RBITCNT_LM(0));
R_RD_RNI46HQq6z: LUT4 
generic map(
  INIT => X"ECA0"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(6),
  I3 => R_RD(22),
  O => apbo_prdata(6));
R_RD_RNI22HQq5z: LUT4 
generic map(
  INIT => X"ECA0"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(5),
  I3 => R_RD(21),
  O => apbo_prdata(5));
R_RD_RNI0UGQq4z: LUT4 
generic map(
  INIT => X"ECA0"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(4),
  I3 => R_RD(20),
  O => apbo_prdata(4));
R_RD_RNI5UHQq2z: LUT4 
generic map(
  INIT => X"ECA0"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(2),
  I3 => R_RD(18),
  O => apbo_prdata(2));
COMB_RELOAD_1: LUT4 
generic map(
  INIT => X"1555"
)
port map (
  I0 => COMB_CHANGE_4,
  I1 => COMB_OP_EQ_V_SPIO_SCK2,
  I2 => R_MODE_MS,
  I3 => R_RUNNING,
  O => COMB_RELOAD_1_0);
UN1_R_DIVCNT_1_S_8_RNIEMIT: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => UN1_R_DIVCNT_1_S_8,
  O => COMB_V_DIVCNT_5(8));
UN1_R_DIVCNT_1_S_7_RNIDMIT: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => UN1_R_DIVCNT_1_S_7,
  O => COMB_V_DIVCNT_5(7));
UN1_R_DIVCNT_1_S_6_RNICMIT: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => UN1_R_DIVCNT_1_S_6,
  O => COMB_V_DIVCNT_5(6));
UN1_R_DIVCNT_1_S_5_RNIBMIT: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => UN1_R_DIVCNT_1_S_5,
  O => COMB_V_DIVCNT_5(5));
V_OV_0_SQMUXA_1_Z2281: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => COMB_UN65_SAMPLE_0,
  O => V_OV_0_SQMUXA_1);
V_INCRDLI_0_SQMUXA_1: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => R_SYNCSAMPC_1,
  O => V_TWDIR_0_SQMUXA);
V_CGCNT_0_SQMUXA_Z2283: LUT4 
generic map(
  INIT => X"4C00"
)
port map (
  I0 => COMB_OP_EQ_UN2_ASEL_EN_3,
  I1 => COMB_OP_EQ_V_SPIO_SCK2,
  I2 => COMB_UN4_ASEL_EN_MB_1_0,
  I3 => COMB_V_SPIO_SCK20,
  O => V_CGCNT_0_SQMUXA);
R_SYNCSAMP_RNIMFU61q1z: LUT4 
generic map(
  INIT => X"CECC"
)
port map (
  I0 => COMB_UN30_SAMPLE,
  I1 => R_SYNCSAMP(1),
  I2 => R_SYNCSAMPC_0,
  I3 => R_SYNCSAMPC_1,
  O => COMB_UN1_R_SYNCSAMP_0_I);
R_TD_OCC_RNO_0: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => V_TD_OCC_1_SQMUXA,
  O => V_TD_OCC_0_SQMUXA_I);
R_TXFIFO_5SR_0_Z2286: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_1(2),
  I2 => R_TXFIFO_5(0),
  I3 => rstn,
  O => R_TXFIFO_5SR_0);
R_TXFIFO_3SR_0_Z2287: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_3(2),
  I2 => R_TXFIFO_3(0),
  I3 => rstn,
  O => R_TXFIFO_3SR_0);
R_TXFIFO_2SR_0_Z2288: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_4(2),
  I2 => R_TXFIFO_2(0),
  I3 => rstn,
  O => R_TXFIFO_2SR_0);
R_TXFIFO_1SR_0_Z2289: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_5(2),
  I2 => R_TXFIFO_1(0),
  I3 => rstn,
  O => R_TXFIFO_1SR_0);
COMB_V_SPIO_MOSI_2_18_Z2290: MUXF6 port map (
    I0 => N_847,
    I1 => COMB_V_SPIO_MOSI_2_23,
    S => COMB_TINDEX_1(4),
    O => COMB_V_SPIO_MOSI_2_18);
COMB_CHANGE_1_1_Z2291: LUT4 
generic map(
  INIT => X"CCCA"
)
port map (
  I0 => COMB_CHANGE_4,
  I1 => R_CHNG,
  I2 => SAMPLE_0_SQMUXA_2,
  I3 => V_TOGGLE_0_SQMUXA,
  O => COMB_CHANGE_1_1);
COMB_V_SPIO_MOSI_2_28_Z2292: MUXF6 port map (
    I0 => N_851,
    I1 => N_858,
    S => COMB_TINDEX_1(4),
    O => COMB_V_SPIO_MOSI_2_28);
COMB_V_SPIO_MOSI_2_21_Z2293: MUXF6 port map (
    I0 => N_850,
    I1 => N_857,
    S => COMB_TINDEX_1(4),
    O => COMB_V_SPIO_MOSI_2_21);
COMB_V_SPIO_MOSI_2_25: MUXF6 port map (
    I0 => N_848,
    I1 => COMB_V_SPIO_MOSI_2_24,
    S => COMB_TINDEX_1(4),
    O => N_856);
COMB_V_IRQ_1_IV_M6_0_Z2295: LUT4 
generic map(
  INIT => X"4555"
)
port map (
  I0 => COMB_V_IRQ_1_IV_M5_E,
  I1 => R_EVENT_MME,
  I2 => R_MASK_MME,
  I3 => V_IRQ_0_SQMUXA_1_0,
  O => COMB_V_IRQ_1_IV_M6_0);
COMB_UN40_SAMPLE_NE_0_RNI7R8C4: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_UN40_SAMPLE_NE_0,
  I1 => COMB_UN65_SAMPLE_0,
  I2 => COMB_V_RUNNING_9_IV_265_A0_2,
  I3 => COMB_V_TFREECNT_30(3),
  O => COMB_V_RUNNING_9_IV_265_A0_6);
APBO_PRDATA_IV_2q11z_Z2297: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(11),
  I3 => R_RD(27),
  O => APBO_PRDATA_IV_2(11));
APBO_PRDATA_IV_1q11z_Z2298: LUT4 
generic map(
  INIT => X"2A3F"
)
port map (
  I0 => N_62,
  I1 => APBOUT_2_SQMUXA,
  I2 => R_EVENT_UN,
  I3 => R_MODE_CG(4),
  O => APBO_PRDATA_IV_1(11));
APBO_PRDATA_0_IV_0q30z_Z2299: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(14),
  I3 => R_RD(30),
  O => APBO_PRDATA_0_IV_0(30));
APBO_PRDATA_0_IV_0q31z_Z2300: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_TIP,
  I3 => R_MASK_TIP,
  O => APBO_PRDATA_0_IV_0(31));
APBO_PRDATA_0_IV_1q10z_Z2301: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_MME,
  I3 => R_MASK_MME,
  O => APBO_PRDATA_0_IV_1(10));
APBO_PRDATA_0_IV_0q10z_Z2302: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CG(3),
  I3 => R_RD(10),
  O => APBO_PRDATA_0_IV_0(10));
APBO_PRDATA_0_IV_0q24z_Z2303: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(8),
  I3 => R_RD(24),
  O => APBO_PRDATA_0_IV_0(24));
APBO_PRDATA_0_IV_0q27z_Z2304: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(11),
  I3 => R_RD(27),
  O => APBO_PRDATA_0_IV_0(27));
APBO_PRDATA_0_IV_0q13z_Z2305: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(13),
  I3 => R_RD(29),
  O => APBO_PRDATA_0_IV_0(13));
APBO_PRDATA_0_IV_0q28z_Z2306: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CPHA,
  I3 => R_RD(28),
  O => APBO_PRDATA_0_IV_0(28));
APBO_PRDATA_0_IV_I_0q29z_Z2307: LUT4 
generic map(
  INIT => X"EAC0"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(13),
  I3 => R_RD(29),
  O => APBO_PRDATA_0_IV_I_0(29));
APBO_PRDATA_0_IV_0q20z_Z2308: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_LEN(0),
  I3 => R_RD(20),
  O => APBO_PRDATA_0_IV_0(20));
APBO_PRDATA_0_IV_0q22z_Z2309: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_LEN(2),
  I3 => R_RD(22),
  O => APBO_PRDATA_0_IV_0(22));
APBO_PRDATA_0_IV_1q9z_Z2310: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CG(2),
  I3 => R_RD(9),
  O => APBO_PRDATA_0_IV_1(9));
APBO_PRDATA_0_IV_0q9z_Z2311: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_NE,
  I3 => R_MASK_NE,
  O => APBO_PRDATA_0_IV_0(9));
APBO_PRDATA_0_IV_0q25z_Z2312: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_MS,
  I3 => R_RD(25),
  O => APBO_PRDATA_0_IV_0(25));
APBO_PRDATA_0_IV_0q18z_Z2313: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(2),
  I3 => R_RD(18),
  O => APBO_PRDATA_0_IV_0(18));
APBO_PRDATA_0_IV_1q8z_Z2314: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_NF,
  I3 => R_MASK_NF,
  O => APBO_PRDATA_0_IV_1(8));
APBO_PRDATA_0_IV_0q8z_Z2315: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CG(1),
  I3 => R_RD(8),
  O => APBO_PRDATA_0_IV_0(8));
APBO_PRDATA_0_IV_0q21z_Z2316: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(5),
  I3 => R_RD(21),
  O => APBO_PRDATA_0_IV_0(21));
APBO_PRDATA_0_IV_0q23z_Z2317: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(7),
  I3 => R_RD(23),
  O => APBO_PRDATA_0_IV_0(23));
APBO_PRDATA_0_IV_0q14z_Z2318: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_LT,
  I3 => R_MASK_LT,
  O => APBO_PRDATA_0_IV_0(14));
APBO_PRDATA_0_IV_0q16z_Z2319: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(0),
  I3 => R_RD(16),
  O => APBO_PRDATA_0_IV_0(16));
APBO_PRDATA_0_IV_0q7z_Z2320: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(7),
  I3 => R_RD(23),
  O => APBO_PRDATA_0_IV_0(7));
APBO_PRDATA_0_IV_0q26z_Z2321: LUT4 
generic map(
  INIT => X"153F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(10),
  I3 => R_RD(26),
  O => APBO_PRDATA_0_IV_0(26));
APBO_PRDATA_0_IV_0q15z_Z2322: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(15),
  I3 => R_RD(31),
  O => APBO_PRDATA_0_IV_0(15));
APBO_PRDATA_0_IV_0q3z_Z2323: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_TTO,
  I3 => R_RD(3),
  O => APBO_PRDATA_0_IV_0(3));
APBO_PRDATA_0_IV_0q19z_Z2324: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_PM(3),
  I3 => R_RD(19),
  O => APBO_PRDATA_0_IV_0(19));
APBO_PRDATA_0_IV_0q17z_Z2325: LUT4 
generic map(
  INIT => X"23AF"
)
port map (
  I0 => N_62,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_PM(1),
  I3 => R_RD(17),
  O => APBO_PRDATA_0_IV_0(17));
APBO_PRDATA_0_IV_0q12z_Z2326: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(12),
  I3 => R_RD(28),
  O => APBO_PRDATA_0_IV_0(12));
COMB_UN40_SAMPLE_NE: LUT4 
generic map(
  INIT => X"0880"
)
port map (
  I0 => COMB_UN40_SAMPLE_NE_0,
  I1 => COMB_UN40_SAMPLE_NE_1,
  I2 => LEN_1_0(3),
  I3 => R_RBITCNT(3),
  O => COMB_UN40_SAMPLE);
COMB_UN27_CHANGE_NE: LUT4 
generic map(
  INIT => X"0880"
)
port map (
  I0 => COMB_UN27_CHANGE_NE_0,
  I1 => COMB_UN27_CHANGE_NE_1,
  I2 => LEN_1_0(3),
  I3 => R_TBITCNT(3),
  O => COMB_UN27_CHANGE);
V_EVENT_OV_0_SQMUXA_Z2329: LUT3 
generic map(
  INIT => X"10"
)
port map (
  I0 => COMB_UN21_SAMPLE_0,
  I1 => R_OV,
  I2 => V_IRQ_0_SQMUXA_3_1,
  O => V_EVENT_OV_0_SQMUXA);
R_RDFIC_1_Z2330: LUT4_L 
generic map(
  INIT => X"7800"
)
port map (
  I0 => CO0_0,
  I1 => R_RDFI(1),
  I2 => R_RDFI(2),
  I3 => rstn,
  LO => R_RDFIC_1);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC5_Z2331: LUT2 
generic map(
  INIT => X"9"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  O => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC5);
COMB_V_DIVCNT_1_RNOq0z: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => COMB_V_SPIO_SCK20,
  I1 => R_DIVCNT(0),
  O => COMB_V_DIVCNT_5(0));
COMB_V_DIVCNT_1_RNOq9z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_V_SPIO_SCK20,
  I1 => UN1_R_DIVCNT_1_S_9,
  O => COMB_V_DIVCNT_5(9));
COMB_OP_EQ_V_SPIO_SCK2_RNID2AV: LUT3_L 
generic map(
  INIT => X"80"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  LO => V_DIVCNT_0_SQMUXA_1);
V_IRQ_0_SQMUXA_1_0_RNIKMMA: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => V_IRQ_0_SQMUXA_1_0,
  I1 => V_MODE_CPHA_0_SQMUXA,
  O => V_MODE_EN_1_SQMUXA_I);
R_CHNG_RNO: LUT4 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => N_2120_0,
  I1 => SAMPLE_0_SQMUXA_2,
  I2 => V_CHNG_0_SQMUXA,
  I3 => V_TOGGLE_0_SQMUXA,
  O => V_CHNG_2_SQMUXA_I);
TINDEX_1_SQMUXA_RNI0ME71: LUT3 
generic map(
  INIT => X"F8"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => TINDEX_1_SQMUXA,
  I2 => V_TOGGLE_0_SQMUXA,
  O => V_SPIO_SCK_1_SQMUXA_I);
R_RBITCNTE_0_I_Z2338: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_SYNCSAMPC_1,
  O => R_RBITCNTE_0_I);
R_TXFIFO_7SR_0_Z2339: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1(2),
  I2 => R_TXFIFO_7(0),
  I3 => rstn,
  O => R_TXFIFO_7SR_0);
R_TXFIFO_6SR_0_Z2340: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_0(2),
  I2 => R_TXFIFO_6(0),
  I3 => rstn,
  O => R_TXFIFO_6SR_0);
COMB_V_RD_3q13z_Z2341: LUT4_L 
generic map(
  INIT => X"5C50"
)
port map (
  I0 => N_44,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(18),
  LO => COMB_V_RD_3(13));
COMB_V_RD_3q18z_Z2342: LUT4_L 
generic map(
  INIT => X"C505"
)
port map (
  I0 => N_44,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(18),
  LO => COMB_V_RD_3(18));
COMB_V_RD_3q7z_Z2343: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(24),
  I3 => RDATA(7),
  LO => COMB_V_RD_3(7));
COMB_V_RD_3q24z_Z2344: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(24),
  I3 => RDATA(7),
  LO => COMB_V_RD_3(24));
COMB_V_RD_3q2z_Z2345: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(29),
  I3 => RDATA(2),
  LO => COMB_V_RD_3(2));
COMB_V_RD_3q29z_Z2346: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(29),
  I3 => RDATA(2),
  LO => COMB_V_RD_3(29));
COMB_V_TXFIFO_4_5q0z_Z2347: LUT3 
generic map(
  INIT => X"B8"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_2(2),
  I2 => R_TXFIFO_4(0),
  O => COMB_V_TXFIFO_4_5(0));
COMB_V_TXFIFO_0_5q0z_Z2348: LUT3 
generic map(
  INIT => X"B8"
)
port map (
  I0 => N_885,
  I1 => R_TDLI_RNIJFCB1_6(2),
  I2 => R_TXFIFO_0(0),
  O => COMB_V_TXFIFO_0_5(0));
COMB_V_RD_3q21z_Z2349: LUT4_L 
generic map(
  INIT => X"C505"
)
port map (
  I0 => N_40,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(21),
  LO => COMB_V_RD_3(21));
COMB_V_RD_3q10z_Z2350: LUT4_L 
generic map(
  INIT => X"5C50"
)
port map (
  I0 => N_40,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(21),
  LO => COMB_V_RD_3(10));
COMB_V_EVENT_UN_3_Z2351: LUT3 
generic map(
  INIT => X"4C"
)
port map (
  I0 => apbi_pwdata(11),
  I1 => R_EVENT_UN,
  I2 => V_EVENT_LT_1_SQMUXA,
  O => COMB_V_EVENT_UN_3);
R_RD_RNOq8z: LUT4_L 
generic map(
  INIT => X"3101"
)
port map (
  I0 => N_93,
  I1 => LEN_1_0(3),
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(8),
  LO => N_12_I);
R_RD_RNOq26z: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(26),
  I3 => RDATA(5),
  LO => N_117_I);
R_RD_RNOq23z: LUT4_L 
generic map(
  INIT => X"1310"
)
port map (
  I0 => N_93,
  I1 => LEN_1_0(3),
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(8),
  LO => N_30_I);
R_RBITCNT_RNIF5B12q3z: LUT3 
generic map(
  INIT => X"60"
)
port map (
  I0 => LEN_1_0(3),
  I1 => R_RBITCNT(3),
  I2 => R_SYNCSAMPC_1,
  O => COMB_V_RUNNING_9_IV_265_A0_5);
V_TD_OCC_1_SQMUXA_Z2356: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => apbi_paddr(3),
  I1 => R_EVENT_NF,
  I2 => V_LST_1_SQMUXA_0,
  I3 => V_TD_OCC_1_SQMUXA_2,
  O => V_TD_OCC_1_SQMUXA);
R_SYNCSAMPC_Z2357: LUT3_L 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_UN16_SAMPLE,
  I1 => R_SYNCSAMPC_0,
  I2 => R_SYNCSAMPC_1,
  LO => R_SYNCSAMPC);
R_RDFIC_0_Z2358: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => CO0_0,
  I1 => R_RDFI(1),
  I2 => rstn,
  LO => R_RDFIC_0);
R_EVENT_UNCE_Z2359: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(11),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_UNCE);
COMB_V_IRQ_1_IV_M5_E_Z2360: LUT4_L 
generic map(
  INIT => X"F040"
)
port map (
  I0 => COMB_V_EVENT_NF3,
  I1 => COMB_V_IRQ_1_IV_M3_E_0,
  I2 => R_MODE_EN,
  I3 => V_IRQ_0_SQMUXA_1,
  LO => COMB_V_IRQ_1_IV_M5_E);
R_EVENT_OVCE_Z2361: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(12),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_OVCE);
R_EVENT_MMECE_Z2362: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(10),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_MMECE);
UN1_RELOADq4z_Z2363: LUT3 
generic map(
  INIT => X"2E"
)
port map (
  I0 => N_870,
  I1 => N_875,
  I2 => R_MODE_PM(0),
  O => UN1_RELOAD(4));
COMB_V_SPIO_MOSI_2_16: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_16_AM,
    I1 => COMB_V_SPIO_MOSI_2_16_BM,
    S => R_TBITCNT(1),
    O => N_847);
COMB_V_SPIO_MOSI_2_16_BM_Z2365: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(3),
  I1 => UN152_CHANGE_6(3),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_16_BM);
COMB_V_SPIO_MOSI_2_16_AM_Z2366: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1536,
  I1 => N_1629,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_16_AM);
COMB_V_SPIO_MOSI_2_17: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_17_AM,
    I1 => COMB_V_SPIO_MOSI_2_17_BM,
    S => R_TBITCNT(1),
    O => N_848);
COMB_V_SPIO_MOSI_2_17_BM_Z2368: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(11),
  I1 => UN152_CHANGE_6(11),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_17_BM);
COMB_V_SPIO_MOSI_2_17_AM_Z2369: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(9),
  I1 => UN152_CHANGE_6(9),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_17_AM);
COMB_V_SPIO_MOSI_2_20: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_20_AM,
    I1 => COMB_V_SPIO_MOSI_2_20_BM,
    S => R_TBITCNT(1),
    O => N_851);
COMB_V_SPIO_MOSI_2_20_BM_Z2371: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1550,
  I1 => N_1643,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_20_BM);
COMB_V_SPIO_MOSI_2_20_AM_Z2372: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1548,
  I1 => UN152_CHANGE_6(13),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_20_AM);
R_RD_RNIHLK8q1z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(1),
  O => R_RD_M(1));
COMB_V_SPIO_SCK20_Z2374: LUT3 
generic map(
  INIT => X"C4"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  O => COMB_V_SPIO_SCK20);
COMB_V_SPIO_MOSI_2_1: MUXF6 port map (
    I0 => UN152_CHANGE_7(0),
    I1 => UN152_CHANGE_7(16),
    S => COMB_TINDEX_1(4),
    O => N_832);
V_IRQ_0_SQMUXA_3_1_Z2376: LUT4 
generic map(
  INIT => X"3020"
)
port map (
  I0 => N_2121_0,
  I1 => COMB_UN30_SAMPLE,
  I2 => R_SAMP,
  I3 => SAMPLE_0_SQMUXA_2,
  O => V_IRQ_0_SQMUXA_3_1);
R_TDLI_RNOq2z_Z2377: LUT4_L 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  LO => R_TDLI_RNO(2));
R_RD_RNI5BU9q14z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(14),
  O => R_RD_M(14));
R_RD_RNIGLK8q0z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(0),
  O => R_RD_M(0));
R_RD_RNIGSSHq15z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => R_RD(15),
  O => R_RD_M_0(15));
COMB_V_SPIO_MOSI_2_27: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_27_AM,
    I1 => COMB_V_SPIO_MOSI_2_27_BM,
    S => R_TBITCNT(1),
    O => N_858);
COMB_V_SPIO_MOSI_2_27_BM_Z2382: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1566,
  I1 => N_1659,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_27_BM);
COMB_V_SPIO_MOSI_2_27_AM_Z2383: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(29),
  I1 => UN152_CHANGE_6(29),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_27_AM);
COMB_V_SPIO_MOSI_2_26: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_26_AM,
    I1 => COMB_V_SPIO_MOSI_2_26_BM,
    S => R_TBITCNT(1),
    O => N_857);
COMB_V_SPIO_MOSI_2_26_BM_Z2385: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(23),
  I1 => UN152_CHANGE_6(23),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_26_BM);
COMB_V_SPIO_MOSI_2_26_AM_Z2386: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1556,
  I1 => UN152_CHANGE_6(21),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_26_AM);
COMB_V_SPIO_MOSI_2_24_Z2387: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_24_AM,
    I1 => COMB_V_SPIO_MOSI_2_24_BM,
    S => R_TBITCNT(1),
    O => COMB_V_SPIO_MOSI_2_24);
COMB_V_SPIO_MOSI_2_24_BM_Z2388: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(27),
  I1 => UN152_CHANGE_6(27),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_24_BM);
COMB_V_SPIO_MOSI_2_24_AM_Z2389: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1560,
  I1 => N_1653,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_24_AM);
COMB_V_SPIO_MOSI_2_23_Z2390: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_23_AM,
    I1 => COMB_V_SPIO_MOSI_2_23_BM,
    S => R_TBITCNT(1),
    O => COMB_V_SPIO_MOSI_2_23);
COMB_V_SPIO_MOSI_2_23_BM_Z2391: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(19),
  I1 => UN152_CHANGE_6(19),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_23_BM);
COMB_V_SPIO_MOSI_2_23_AM_Z2392: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1552,
  I1 => UN152_CHANGE_6(17),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_23_AM);
COMB_V_SPIO_MOSI_2_19: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_19_AM,
    I1 => COMB_V_SPIO_MOSI_2_19_BM,
    S => R_TBITCNT(1),
    O => N_850);
COMB_V_SPIO_MOSI_2_19_BM_Z2394: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(7),
  I1 => UN152_CHANGE_6(7),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_19_BM);
COMB_V_SPIO_MOSI_2_19_AM_Z2395: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1540,
  I1 => N_1633,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_19_AM);
COMB_V_SPIO_MOSI_2_12: MUXF7 port map (
    I0 => UN152_CHANGE_7(14),
    I1 => UN152_CHANGE_7(30),
    S => COMB_TINDEX_1(4),
    O => N_843);
COMB_V_SPIO_MOSI_2_11: MUXF6 port map (
    I0 => UN152_CHANGE_7(6),
    I1 => UN152_CHANGE_7(22),
    S => COMB_TINDEX_1(4),
    O => N_842);
COMB_V_SPIO_MOSI_2_9: MUXF6 port map (
    I0 => UN152_CHANGE_7(10),
    I1 => UN152_CHANGE_7(26),
    S => COMB_TINDEX_1(4),
    O => N_840);
COMB_V_SPIO_MOSI_2_8: MUXF6 port map (
    I0 => UN152_CHANGE_7(2),
    I1 => UN152_CHANGE_7(18),
    S => COMB_TINDEX_1(4),
    O => N_839);
COMB_V_SPIO_MOSI_2_5: MUXF6 port map (
    I0 => UN152_CHANGE_7(12),
    I1 => UN152_CHANGE_7(28),
    S => COMB_TINDEX_1(4),
    O => N_836);
COMB_V_SPIO_MOSI_2_4: MUXF6 port map (
    I0 => UN152_CHANGE_7(4),
    I1 => UN152_CHANGE_7(20),
    S => COMB_TINDEX_1(4),
    O => N_835);
COMB_V_SPIO_MOSI_2_2: MUXF6 port map (
    I0 => UN152_CHANGE_7(8),
    I1 => UN152_CHANGE_7(24),
    S => COMB_TINDEX_1(4),
    O => N_833);
R_RD_RNOq11z: LUT4_L 
generic map(
  INIT => X"5111"
)
port map (
  I0 => COMB_V_RD_3_I_0(11),
  I1 => LEN_1_0(2),
  I2 => R_MODE_LEN(0),
  I3 => R_MODE_LEN(1),
  LO => N_16_I);
R_RD_RNOq9z: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_131,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(9),
  I3 => R_RXFIFO(22),
  LO => N_14_I);
R_RD_RNOq22z: LUT4_L 
generic map(
  INIT => X"5410"
)
port map (
  I0 => N_137,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(9),
  I3 => R_RXFIFO(22),
  LO => N_28_I);
R_RD_RNOq20z: LUT4_L 
generic map(
  INIT => X"5111"
)
port map (
  I0 => COMB_V_RD_3_I_0(20),
  I1 => LEN_1_0(2),
  I2 => R_MODE_LEN(0),
  I3 => R_MODE_LEN(1),
  LO => N_26_I);
R_RD_FREE_RNO_0: LUT3 
generic map(
  INIT => X"F8"
)
port map (
  I0 => COMB_UN1_APBI_PSEL,
  I1 => COMB_UN17_APBI_PSEL,
  I2 => COMB_V_RD4,
  O => V_RD_FREE_0_SQMUXA_I);
R_SAMP_RNO_0: LUT4 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => N_2120_0,
  I1 => N_2121_0,
  I2 => SAMPLE_0_SQMUXA_2,
  I3 => V_CHNG_0_SQMUXA,
  O => V_SAMP_2_SQMUXA_I);
R_SAMP_RNO: LUT4_L 
generic map(
  INIT => X"0D2F"
)
port map (
  I0 => N_2120_0,
  I1 => N_2122_0,
  I2 => R_MODE_CPHA,
  I3 => R_SAMP,
  LO => N_2109_0_I);
COMB_V_RD_3q12z_Z2410: LUT4_L 
generic map(
  INIT => X"7340"
)
port map (
  I0 => N_139,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(12),
  I3 => RDATA(19),
  LO => COMB_V_RD_3(12));
COMB_V_RD_3q19z_Z2411: LUT4_L 
generic map(
  INIT => X"DC10"
)
port map (
  I0 => N_139,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(12),
  I3 => RDATA(19),
  LO => COMB_V_RD_3(19));
COMB_V_RD_3q6z_Z2412: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(25),
  I3 => RDATA(6),
  LO => COMB_V_RD_3(6));
COMB_V_RD_3q25z_Z2413: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(25),
  I3 => RDATA(6),
  LO => COMB_V_RD_3(25));
COMB_V_RD_3_I_M2q5z: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(26),
  I3 => RDATA(5),
  LO => N_116);
R_RD_RNOq17z: LUT4_L 
generic map(
  INIT => X"1310"
)
port map (
  I0 => N_94,
  I1 => N_134,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(14),
  LO => N_24_I);
R_RD_RNOq16z: LUT4_L 
generic map(
  INIT => X"1310"
)
port map (
  I0 => N_95,
  I1 => N_135,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(15),
  LO => N_22_I);
R_RD_RNOq15z: LUT4_L 
generic map(
  INIT => X"3101"
)
port map (
  I0 => N_95,
  I1 => N_135,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(15),
  LO => N_20_I);
R_RD_RNOq14z: LUT4_L 
generic map(
  INIT => X"3101"
)
port map (
  I0 => N_94,
  I1 => N_134,
  I2 => R_MODE_REV,
  I3 => R_RXFIFO(14),
  LO => N_18_I);
R_RD_RNOq31z: LUT4_L 
generic map(
  INIT => X"B830"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(0),
  I3 => R_RXFIFO(31),
  LO => N_123_I);
R_RD_RNOq30z: LUT4_L 
generic map(
  INIT => X"B830"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(1),
  I3 => R_RXFIFO(30),
  LO => N_121_I);
R_RD_RNOq27z: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(27),
  I3 => RDATA(4),
  LO => N_119_I);
R_RBITCNT_RNIS4JN1q1z: LUT4 
generic map(
  INIT => X"0BBB"
)
port map (
  I0 => N_2159_0,
  I1 => UN1_R_MODE_EN_184_A6_0_2,
  I2 => UN1_R_MODE_EN_184_A6_1_5,
  I3 => UN1_R_MODE_EN_184_A6_1_6,
  O => UN1_R_MODE_EN_184_1);
COMB_UN27_CHANGE_NE_1_Z2423: LUT4 
generic map(
  INIT => X"1248"
)
port map (
  I0 => LEN_1_0(1),
  I1 => LEN_1_0(2),
  I2 => R_TBITCNT(1),
  I3 => R_TBITCNT(2),
  O => COMB_UN27_CHANGE_NE_1);
COMB_UN27_CHANGE_NE_0_Z2424: LUT4_L 
generic map(
  INIT => X"A041"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN(0),
  I2 => R_TBITCNT(0),
  I3 => R_TBITCNT(4),
  LO => COMB_UN27_CHANGE_NE_0);
R_RXFIFO_I_29_RNI3JGM2: LUT4 
generic map(
  INIT => X"AEFF"
)
port map (
  I0 => N_139,
  I1 => LEN_1_0(1),
  I2 => R_MODE_LEN(0),
  I3 => R_RXFIFO(13),
  O => N_44);
APBI_PADDR_RNIEF18q3z: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(4),
  I2 => apbi_paddr(7),
  I3 => APBOUT_0_SQMUXA_I_I_A2_3,
  O => N_141);
V_IRQ_0_SQMUXA_2_1_Z2427: LUT3 
generic map(
  INIT => X"20"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => COMB_UN26_AM_EN_0,
  I2 => COMB_UN30_AM_EN,
  O => V_IRQ_0_SQMUXA_2_1);
R_TDLI_RNIJFCB1_1q2z_Z2428: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_1(2));
R_TDLI_RNIJFCB1_2q2z_Z2429: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_2(2));
R_TDLI_RNIJFCB1_4q2z_Z2430: LUT4 
generic map(
  INIT => X"0020"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_4(2));
R_TDLI_RNIJFCB1_5q2z_Z2431: LUT4 
generic map(
  INIT => X"0008"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_5(2));
R_TDLI_RNIJFCB1_6q2z_Z2432: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_6(2));
APBOUT_4_SQMUXA_Z2433: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => COMB_UN1_APBI_PSEL,
  I2 => COMB_UN17_APBI_PSEL,
  O => APBOUT_4_SQMUXA);
R_RBITCNT_RNI42OTq1z: LUT4 
generic map(
  INIT => X"4100"
)
port map (
  I0 => N_2161_0,
  I1 => R_MODE_LEN(1),
  I2 => R_RBITCNT(1),
  I3 => UN1_R_MODE_EN_184_A6_0,
  O => N_2167);
R_RXFIFO_I_12_RNIRTTF2: LUT4 
generic map(
  INIT => X"F1FF"
)
port map (
  I0 => N_83,
  I1 => COMB_SPILEN_LEN,
  I2 => LEN_1_0(3),
  I3 => R_RXFIFO(10),
  O => N_40);
V_TOGGLE_0_SQMUXA_A0: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2_5,
  I1 => COMB_OP_EQ_V_SPIO_SCK2_6,
  I2 => COMB_UN4_ASEL_EN_0,
  I3 => V_TOGGLE_0_SQMUXA_A0_1,
  O => V_TOGGLE_0_SQMUXA);
R_RDFIC_Z2437: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => COMB_V_RD4,
  I1 => R_RDFI(0),
  I2 => rstn,
  LO => R_RDFIC);
COMB_UN40_SAMPLE_NE_0_Z2438: LUT4 
generic map(
  INIT => X"A041"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN(0),
  I2 => R_RBITCNT(0),
  I3 => R_RBITCNT(4),
  O => COMB_UN40_SAMPLE_NE_0);
R_RXFIFO_I_8_RNIFS0N: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => N_84,
  I1 => N_1746,
  I2 => R_MODE_LEN(3),
  I3 => R_RXFIFO(7),
  O => RDATA(7));
R_RXFIFO_I_24_RNIKQ7M: LUT4 
generic map(
  INIT => X"E0F0"
)
port map (
  I0 => N_1752_0,
  I1 => R_MODE_LEN(1),
  I2 => R_RXFIFO(2),
  I3 => RDATA_2_0_1,
  O => RDATA(2));
V_EVENT_LT_1_SQMUXA_Z2441: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  I2 => COMB_UN9_APBI_PSEL_0,
  I3 => COMB_UN30_APBI_PSEL,
  O => V_EVENT_LT_1_SQMUXA);
V_MODE_CPHA_0_SQMUXA_Z2442: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  I2 => COMB_UN9_APBI_PSEL_0,
  I3 => COMB_UN30_APBI_PSEL,
  O => V_MODE_CPHA_0_SQMUXA);
APBOUT_2_SQMUXA_Z2443: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  I2 => COMB_UN1_APBI_PSEL,
  I3 => COMB_UN9_APBI_PSEL_0,
  O => APBOUT_2_SQMUXA);
APBOUT_1_SQMUXA_I: LUT4 
generic map(
  INIT => X"BFFF"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  I2 => COMB_UN1_APBI_PSEL,
  I3 => COMB_UN9_APBI_PSEL_0,
  O => N_62);
R_MASK_OV_RNISVP9: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_3_SQMUXA,
  I1 => R_MASK_OV,
  O => R_MASK_OV_M);
R_TDLI_RNIJFCB1_3q2z_Z2446: LUT4 
generic map(
  INIT => X"0080"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_3(2));
R_TDLI_RNOq1z_Z2447: LUT3_L 
generic map(
  INIT => X"78"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  LO => R_TDLI_RNO(1));
APBOUT_5_SQMUXA_0_A2: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => COMB_UN1_APBI_PSEL,
  I2 => COMB_UN17_APBI_PSEL,
  O => APBOUT_5_SQMUXA);
R_MASK_UN_RNIQVP9: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_3_SQMUXA,
  I1 => R_MASK_UN,
  O => R_MASK_UN_M);
R_SPIO_MISOOEN_RNO: LUT4_L 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => COMB_V_SPIO_MOSIOEN25,
  I1 => R_MODE_TW,
  I2 => R_SPII_1_SPISEL,
  I3 => TINDEX_1_SQMUXA,
  LO => UN1_V_SPIO_MOSIOEN24_0_I);
R_PSCK_RNO_0: LUT3 
generic map(
  INIT => X"FD"
)
port map (
  I0 => N_2120_0,
  I1 => V_CHNG_0_SQMUXA,
  I2 => V_PSCK_0_SQMUXA,
  O => V_PSCK_1_SQMUXA_I);
SAMPLE_0_SQMUXA_1_RNIFPPS: LUT4 
generic map(
  INIT => X"C480"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_SAMP,
  I2 => R_TOGGLE,
  I3 => SAMPLE_0_SQMUXA_1,
  O => UN1_R_MODE_EN_184_0);
UN1_RELOAD_0q4z: LUT4_L 
generic map(
  INIT => X"2EE2"
)
port map (
  I0 => N_630,
  I1 => R_MODE_FACT,
  I2 => R_MODE_PM(0),
  I3 => R_MODE_PM(1),
  LO => N_870);
COMB_V_RD_3_I_M2q4z: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(27),
  I3 => RDATA(4),
  LO => N_118);
COMB_V_RD_3_I_M2q0z: LUT4_L 
generic map(
  INIT => X"E2C0"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(0),
  I3 => R_RXFIFO(31),
  LO => N_122);
UN152_CHANGE_7q14z_Z2456: MUXF6 port map (
    I0 => N_1549,
    I1 => UN152_CHANGE_6(14),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(14));
UN152_CHANGE_7q30z_Z2457: MUXF6 port map (
    I0 => UN152_CHANGE_3(30),
    I1 => UN152_CHANGE_6(30),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(30));
COMB_INDATA_1_U: LUT4_L 
generic map(
  INIT => X"B111"
)
port map (
  I0 => COMB_INDATA_1_SN_N_6_0,
  I1 => COMB_INDATA_1_U_1,
  I2 => R_MODE_MS,
  I3 => SPIO_MOSI_5,
  LO => COMB_INDATA_1);
COMB_INDATA_1_U_1_Z2459: LUT3 
generic map(
  INIT => X"27"
)
port map (
  I0 => N_1458,
  I1 => R_SPII_1_MISO,
  I2 => R_SPII_1_MOSI,
  O => COMB_INDATA_1_U_1);
UN152_CHANGE_7q10z_Z2460: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(10),
    I1 => UN152_CHANGE_7_BM(10),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(10));
UN152_CHANGE_7q26z_Z2461: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(26),
    I1 => UN152_CHANGE_7_BM(26),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(26));
COMB_V_RD_3_I_M2q1z: LUT4_L 
generic map(
  INIT => X"E2C0"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(1),
  I3 => R_RXFIFO(30),
  LO => N_120);
COMB_V_CHNG_1_Z2463: LUT4_L 
generic map(
  INIT => X"F072"
)
port map (
  I0 => N_2120_0,
  I1 => R_CHNG,
  I2 => R_MODE_CPHA,
  I3 => V_CHNG_0_SQMUXA,
  LO => COMB_V_CHNG_1);
UN152_CHANGE_7q0z_Z2464: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(0),
    I1 => UN152_CHANGE_7_BM(0),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(0));
COMB_V_RD_3q28z_Z2465: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(28),
  I3 => RDATA(3),
  LO => COMB_V_RD_3(28));
COMB_V_RD_3q3z_Z2466: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(28),
  I3 => RDATA(3),
  LO => COMB_V_RD_3(3));
UN152_CHANGE_7q28z_Z2467: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(28),
    I1 => UN152_CHANGE_7_BM(28),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(28));
UN152_CHANGE_7q24z_Z2468: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(24),
    I1 => UN152_CHANGE_7_BM(24),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(24));
UN152_CHANGE_7q22z_Z2469: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(22),
    I1 => UN152_CHANGE_7_BM(22),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(22));
UN152_CHANGE_7q20z_Z2470: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(20),
    I1 => UN152_CHANGE_7_BM(20),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(20));
UN152_CHANGE_7q18z_Z2471: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(18),
    I1 => UN152_CHANGE_7_BM(18),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(18));
UN152_CHANGE_7q16z_Z2472: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(16),
    I1 => UN152_CHANGE_7_BM(16),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(16));
UN152_CHANGE_7q12z_Z2473: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(12),
    I1 => UN152_CHANGE_7_BM(12),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(12));
UN152_CHANGE_7q8z_Z2474: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(8),
    I1 => UN152_CHANGE_7_BM(8),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(8));
UN152_CHANGE_7q6z_Z2475: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(6),
    I1 => UN152_CHANGE_7_BM(6),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(6));
UN152_CHANGE_7q4z_Z2476: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(4),
    I1 => UN152_CHANGE_7_BM(4),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(4));
UN152_CHANGE_7q2z_Z2477: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(2),
    I1 => UN152_CHANGE_7_BM(2),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(2));
V_TXFIFO_4_1_SQMUXA_1_2_Z2478: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_UN40_CHANGE,
  I1 => R_TDFI(0),
  I2 => R_TDFI(1),
  I3 => R_TDFI(2),
  O => V_TXFIFO_4_1_SQMUXA_1_2);
V_TXFIFO_0_1_SQMUXA_1_1_Z2479: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => COMB_UN40_CHANGE,
  I1 => R_TDFI(0),
  I2 => R_TDFI(1),
  I3 => R_TDFI(2),
  O => V_TXFIFO_0_1_SQMUXA_1_1);
R_TFREECNT_RNIVITG2q1z: LUT4_L 
generic map(
  INIT => X"0082"
)
port map (
  I0 => COMB_V_RUNNING_9_IV_265_A0_1,
  I1 => R_TD_OCC,
  I2 => R_TFREECNT(0),
  I3 => R_TFREECNT(1),
  LO => COMB_V_RUNNING_9_IV_265_A0_2);
COMB_V_RD_3_I_0q11z_Z2481: LUT4_L 
generic map(
  INIT => X"AEBF"
)
port map (
  I0 => N_132,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(11),
  I3 => R_RXFIFO(20),
  LO => COMB_V_RD_3_I_0(11));
COMB_V_RD_3_I_0q20z_Z2482: LUT4_L 
generic map(
  INIT => X"ABEF"
)
port map (
  I0 => N_136,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(11),
  I3 => R_RXFIFO(20),
  LO => COMB_V_RD_3_I_0(20));
APBI_PADDR_RNI2KF4q6z: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  I2 => apbi_paddr(6),
  I3 => COMB_UN1_APBI_PSEL,
  O => APBOUT_0_SQMUXA_I_I_A2_3);
COMB_UN65_SAMPLE: LUT4 
generic map(
  INIT => X"1020"
)
port map (
  I0 => COMB_UN54_SAMPLE,
  I1 => R_MODE_LOOPB,
  I2 => R_MODE_TW,
  I3 => R_TWDIR,
  O => COMB_UN65_SAMPLE_0);
COMB_OP_EQ_V_SPIO_SCK2_Z2485: LUT4 
generic map(
  INIT => X"0008"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2_5,
  I1 => COMB_OP_EQ_V_SPIO_SCK2_6,
  I2 => R_DIVCNT(1),
  I3 => R_DIVCNT(8),
  O => COMB_OP_EQ_V_SPIO_SCK2);
V_IRQ_0_SQMUXA_1_Z2486: LUT4 
generic map(
  INIT => X"1030"
)
port map (
  I0 => COMB_UN1_AM_EN,
  I1 => R_EVENT_NE,
  I2 => R_MASK_NE,
  I3 => R_RD_FREE,
  O => V_IRQ_0_SQMUXA_1);
R_TDLI_RNIJFCB1q2z_Z2487: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1(2));
R_TDLI_RNIJFCB1_0q2z_Z2488: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_0(2));
R_RDLIC_Z2489: LUT4_L 
generic map(
  INIT => X"7800"
)
port map (
  I0 => CO0_3,
  I1 => R_RDLI(1),
  I2 => R_RDLI(2),
  I3 => rstn,
  LO => R_RDLIC);
COMB_V_TWDIR_1_IV_0_TZ_Z2490: LUT3 
generic map(
  INIT => X"7D"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_MODE_TTO,
  O => COMB_V_TWDIR_1_IV_0_TZ);
R_RXFIFO_I_23_RNIIG4P: LUT4 
generic map(
  INIT => X"F600"
)
port map (
  I0 => N_1752_0,
  I1 => R_MODE_LEN(2),
  I2 => R_MODE_LEN(3),
  I3 => R_RXFIFO(5),
  O => RDATA(5));
R_RXFIFO_I_11_RNIGVGP: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => N_84,
  I1 => N_1746_1,
  I2 => R_MODE_LEN(3),
  I3 => R_RXFIFO(6),
  O => RDATA(6));
V_MASK_LT_1_SQMUXA_Z2493: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => COMB_UN13_APBI_PSEL_2,
  I2 => COMB_UN30_APBI_PSEL,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => V_MASK_LT_1_SQMUXA);
APBOUT_3_SQMUXA_Z2494: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => COMB_UN1_APBI_PSEL,
  I2 => COMB_UN13_APBI_PSEL_2,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => APBOUT_3_SQMUXA);
V_EVENT_NF_0_SQMUXA_Z2495: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_2120_0,
  I1 => COMB_V_EVENT_NF3,
  O => V_EVENT_NF_0_SQMUXA);
COMB_UN26_AM_EN: LUT4 
generic map(
  INIT => X"45CF"
)
port map (
  I0 => COMB_SLV_START_UN13_AM_EN,
  I1 => COMB_UN30_AM_EN,
  I2 => R_MODE_MS_REP1,
  I3 => SAMPLE_0_SQMUXA_1,
  O => COMB_UN26_AM_EN_0);
V_EVENT_NE_0_SQMUXA_1_Z2497: LUT3 
generic map(
  INIT => X"2A"
)
port map (
  I0 => N_2120_0,
  I1 => COMB_UN1_AM_EN,
  I2 => R_RD_FREE,
  O => V_EVENT_NE_0_SQMUXA_1);
COMB_UN18_SAMPLE: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => COMB_UN16_SAMPLE,
  I1 => R_OV,
  O => COMB_UN30_SAMPLE);
R_TD_OCC_RNO: LUT2_L 
generic map(
  INIT => X"B"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  LO => COMB_V_TXFIFO_76_I);
R_TDLI_RNOq0z_Z2500: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  LO => R_TDLI_RNO(0));
R_RBITCNT_RNIU6HEq2z: LUT4 
generic map(
  INIT => X"7BDF"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN(3),
  I2 => R_RBITCNT(2),
  I3 => R_RBITCNT(3),
  O => N_2161_0);
COMB_V_RD_3_I_A2q22z: LUT4_L 
generic map(
  INIT => X"3313"
)
port map (
  I0 => N_84,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_LEN(3),
  I3 => R_MODE_REV,
  LO => N_137);
COMB_V_RD_3_I_A2q9z: LUT4_L 
generic map(
  INIT => X"1333"
)
port map (
  I0 => N_84,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_LEN(3),
  I3 => R_MODE_REV,
  LO => N_131);
R_RDFI_RNII02Lq0z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_V_RD4,
  I1 => R_RDFI(0),
  O => CO0_0);
R_RD_FREE_RNO: LUT1_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => COMB_V_RD4,
  LO => COMB_V_RD4_I);
R_SPIO_MISOOEN_RNO_0: LUT2 
generic map(
  INIT => X"B"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => COMB_V_SPIO_MOSIOEN25,
  O => V_SPIO_MISOOEN_2_SQMUXA_I);
R_PSCK_RNO: LUT4_L 
generic map(
  INIT => X"EC4C"
)
port map (
  I0 => COMB_V_PSCK_1_0_159_I_O4_0,
  I1 => R_MODE_CPOL,
  I2 => R_MODE_EN,
  I3 => R_SPII_1_SCK,
  LO => N_2137);
R_TFREECNT_RNIQEMR1q2z: LUT4_L 
generic map(
  INIT => X"1441"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_V_TFREECNT_P4,
  I2 => R_TD_OCC,
  I3 => R_TFREECNT(2),
  LO => COMB_V_RUNNING_9_IV_265_A0_1);
V_IRQ_0_SQMUXA_3_2_Z2509: LUT4 
generic map(
  INIT => X"0010"
)
port map (
  I0 => COMB_UN21_SAMPLE_0,
  I1 => R_EVENT_OV,
  I2 => R_MASK_OV,
  I3 => R_OV,
  O => V_IRQ_0_SQMUXA_3_2);
R_RBITCNT_RNIEB7Fq4z: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => N_2178,
  I1 => R_MODE_LEN(3),
  I2 => R_RBITCNT(3),
  I3 => R_RBITCNT(4),
  O => UN1_R_MODE_EN_184_A6_0_2);
COMB_SPILEN_LEN_1_RNIFS6H: LUT4_L 
generic map(
  INIT => X"2000"
)
port map (
  I0 => N_1752_0,
  I1 => R_MODE_LEN(3),
  I2 => R_RBITCNT(1),
  I3 => R_RBITCNT(4),
  LO => UN1_R_MODE_EN_184_A6_1_6);
COMB_UN17_APBI_PSEL_Z2512: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(3),
  I2 => apbi_paddr(4),
  I3 => COMB_UN17_APBI_PSEL_1,
  O => COMB_UN17_APBI_PSEL);
COMB_UN16_SAMPLE_Z2513: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => COMB_UN16_SAMPLE_1,
  I1 => R_RD_FREE,
  I2 => R_RFREECNT(0),
  I3 => R_RFREECNT(2),
  O => COMB_UN16_SAMPLE);
R_RDLIC_1_Z2514: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => CO0_3,
  I1 => R_RDLI(1),
  I2 => rstn,
  LO => R_RDLIC_1);
R_MODE_PM_RNIUNLGq3z: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  I3 => R_MODE_PM(3),
  O => N_630);
R_MODE_PM_RNIOEJGq2z_Z2516: LUT4 
generic map(
  INIT => X"1540"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  I2 => R_MODE_PM(1),
  I3 => R_MODE_PM(2),
  O => R_MODE_PM_RNIOEJG(2));
R_MODE_PM_RNIUNLG_0q3z: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  I3 => R_MODE_PM(3),
  O => N_629);
R_RXFIFO_I_2_RNIE33D: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_RXFIFO(19),
  O => RDATA(19));
COMB_SPILEN_LEN_RNIQK1Q: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_81,
  I1 => COMB_SPILEN_LEN,
  O => N_139);
R_RXFIFO_I_22_RNIJ5LF: LUT3 
generic map(
  INIT => X"8C"
)
port map (
  I0 => N_1752_0,
  I1 => R_RXFIFO(4),
  I2 => RDATA_2_0_1,
  O => RDATA(4));
COMB_V_RD_3_I_A2q15z: LUT4 
generic map(
  INIT => X"2333"
)
port map (
  I0 => N_81,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_LEN(0),
  I3 => R_MODE_LEN(1),
  O => N_135);
COMB_V_RD_3_I_A2q14z: LUT3 
generic map(
  INIT => X"23"
)
port map (
  I0 => N_81,
  I1 => COMB_SPILEN_LEN,
  I2 => R_MODE_LEN(1),
  O => N_134);
R_MODE_LEN_FAST_RNI5D5J1_1q0z: LUT4 
generic map(
  INIT => X"00FE"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN_FAST(0),
  I2 => R_MODE_LEN_FAST(1),
  I3 => R_MODE_LEN_FAST(3),
  O => LEN_1_0(3));
UN152_CHANGE_3q14z: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(14),
    I1 => UN152_CHANGE_3_BM(14),
    S => R_TDFI(1),
    O => N_1549);
UN152_CHANGE_3_BMq14z_Z2525: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(14),
  I2 => R_TXFIFO_6(14),
  O => UN152_CHANGE_3_BM(14));
UN152_CHANGE_3_AMq14z_Z2526: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(14),
  I2 => R_TXFIFO_4(14),
  O => UN152_CHANGE_3_AM(14));
COMB_TINDEX_1q2z_Z2527: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(2),
  I1 => TINDEX_0_SQMUXA,
  O => COMB_TINDEX_1(2));
COMB_TINDEX_1q3z_Z2528: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(3),
  I1 => TINDEX_0_SQMUXA,
  O => COMB_TINDEX_1(3));
COMB_TINDEX_1q4z_Z2529: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  I3 => R_TBITCNT(4),
  O => COMB_TINDEX_1(4));
R_RXFIFO_I_19_RNI55IJ: LUT4 
generic map(
  INIT => X"90F0"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_RXFIFO(3),
  I3 => RDATA_2_0_1,
  O => RDATA(3));
COMB_V_RD_3_I_A2q20z: LUT3_L 
generic map(
  INIT => X"51"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN(3),
  I2 => R_MODE_REV,
  LO => N_136);
COMB_UN1_R_RUNNING_1_Z2532: LUT4 
generic map(
  INIT => X"0F0E"
)
port map (
  I0 => COMB_UN1_R_MODE_TW,
  I1 => R_OV2,
  I2 => R_RUNNING,
  I3 => R_RXDONE2,
  O => COMB_UN1_R_RUNNING_1);
COMB_V_TXFIFO_76_Z2533: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  O => COMB_V_TXFIFO_76);
COMB_V_EVENT_NF2: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  O => COMB_V_EVENT_NF3);
COMB_INDATA_1_U_RNO: LUT2_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_SYNCSAMPC_0,
  I1 => V_PSCK_0_SQMUXA,
  LO => COMB_INDATA_1_SN_N_6_0);
COMB_UN40_CHANGE_Z2536: LUT4 
generic map(
  INIT => X"00BF"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_TW,
  I2 => R_TWDIR,
  I3 => R_UF,
  O => COMB_UN40_CHANGE);
COMB_TINDEX_1q0z_Z2537: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(0),
  I1 => TINDEX_0_SQMUXA,
  O => COMB_TINDEX_1(0));
COMB_V_RD4_Z2538: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => COMB_UN1_AM_EN,
  I1 => R_RD_FREE,
  O => COMB_V_RD4);
R_RBITCNT_RNIMMGEq1z: LUT4 
generic map(
  INIT => X"7BDF"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_RBITCNT(0),
  I3 => R_RBITCNT(1),
  O => N_2159_0);
COMB_V_RD_3_I_O2q23z: LUT2 
generic map(
  INIT => X"7"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_RXFIFO(23),
  O => N_93);
COMB_V_RD_3_I_A2q11z: LUT3_L 
generic map(
  INIT => X"15"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN(3),
  I2 => R_MODE_REV,
  LO => N_132);
UN152_CHANGE_6q30z_Z2542: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(30),
    I1 => UN152_CHANGE_6_BM(30),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(30));
UN152_CHANGE_6_BMq30z_Z2543: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(30),
  I2 => R_TXFIFO_7(30),
  O => UN152_CHANGE_6_BM(30));
UN152_CHANGE_6_AMq30z_Z2544: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(30),
  I2 => R_TXFIFO_5(30),
  O => UN152_CHANGE_6_AM(30));
UN152_CHANGE_6q14z_Z2545: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(14),
    I1 => UN152_CHANGE_6_BM(14),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(14));
UN152_CHANGE_6_BMq14z_Z2546: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(14),
  I2 => R_TXFIFO_7(14),
  O => UN152_CHANGE_6_BM(14));
UN152_CHANGE_6_AMq14z_Z2547: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(14),
  I2 => R_TXFIFO_5(14),
  O => UN152_CHANGE_6_AM(14));
UN152_CHANGE_3q30z_Z2548: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(30),
    I1 => UN152_CHANGE_3_BM(30),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(30));
UN152_CHANGE_3_BMq30z_Z2549: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(30),
  I2 => R_TXFIFO_6(30),
  O => UN152_CHANGE_3_BM(30));
UN152_CHANGE_3_AMq30z_Z2550: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(30),
  I2 => R_TXFIFO_4(30),
  O => UN152_CHANGE_3_AM(30));
R_SPIO_SCKOEN_RNO_0: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_MODE_LOOPB,
  O => V_SPIO_SCKOEN_1_SQMUXA_I);
V_TOGGLE_0_SQMUXA_A0_1_Z2552: LUT4 
generic map(
  INIT => X"1000"
)
port map (
  I0 => R_DIVCNT(1),
  I1 => R_DIVCNT(8),
  I2 => R_MODE_MS_FAST,
  I3 => R_RUNNING_FAST,
  O => V_TOGGLE_0_SQMUXA_A0_1);
COMB_CHANGE_4_1_Z2553: LUT4 
generic map(
  INIT => X"0040"
)
port map (
  I0 => R_MODE_CPHA,
  I1 => R_MODE_EN_FAST,
  I2 => R_MODE_MS_FAST,
  I3 => R_RUNNING_FAST,
  O => COMB_CHANGE_4_1);
R_RBITCNT_RNIQDU7q4z: LUT3 
generic map(
  INIT => X"09"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_RBITCNT(0),
  I2 => R_RBITCNT(4),
  O => UN1_R_MODE_EN_184_A6_0);
R_RBITCNT_RNI96K8q2z: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_RBITCNT(0),
  I2 => R_RBITCNT(2),
  I3 => R_RBITCNT(3),
  O => UN1_R_MODE_EN_184_A6_1_5);
COMB_OP_EQ_UN2_ASEL_EN_3_Z2556: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_CGCNT(0),
  I1 => R_CGCNT(1),
  I2 => R_CGCNT(4),
  I3 => R_CGCNT(5),
  O => COMB_OP_EQ_UN2_ASEL_EN_3);
COMB_UN13_APBI_PSEL_2_Z2557: LUT3 
generic map(
  INIT => X"20"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(4),
  I2 => apbi_paddr(5),
  O => COMB_UN13_APBI_PSEL_2);
COMB_UN30_AM_EN_Z2558: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => R_TFREECNT_FAST(0),
  I1 => R_TFREECNT_FAST(1),
  I2 => R_TFREECNT_FAST(2),
  I3 => R_TFREECNT_FAST(3),
  O => COMB_UN30_AM_EN);
COMB_UN1_AM_EN_Z2559: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => R_RFREECNT(0),
  I1 => R_RFREECNT(1),
  I2 => R_RFREECNT(2),
  I3 => R_RFREECNT(3),
  O => COMB_UN1_AM_EN);
COMB_OP_EQ_V_SPIO_SCK2_5_Z2560: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(0),
  I1 => R_DIVCNT(6),
  I2 => R_DIVCNT(7),
  I3 => R_DIVCNT(9),
  O => COMB_OP_EQ_V_SPIO_SCK2_5);
COMB_OP_EQ_V_SPIO_SCK2_6_Z2561: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(2),
  I1 => R_DIVCNT(3),
  I2 => R_DIVCNT(4),
  I3 => R_DIVCNT(5),
  O => COMB_OP_EQ_V_SPIO_SCK2_6);
R_RDLIC_0_Z2562: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => R_RDLI(0),
  I1 => R_RXDONE,
  I2 => rstn,
  LO => R_RDLIC_0);
R_SPIO_SCKOEN_RNO: LUT1_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_SYNCSAMPC_0,
  LO => COMB_SAMPLE_6_0_I);
R_MODE_DIV16_RNIOUDC_Z2564: LUT3 
generic map(
  INIT => X"14"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  I2 => R_MODE_PM(1),
  O => R_MODE_DIV16_RNIOUDC);
COMB_SPILEN_LEN_Z2565: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN_FAST(0),
  I2 => R_MODE_LEN_FAST(1),
  I3 => R_MODE_LEN_FAST(3),
  O => COMB_SPILEN_LEN);
COMB_V_RD_3_I_O2q17z: LUT2 
generic map(
  INIT => X"7"
)
port map (
  I0 => N_81,
  I1 => R_RXFIFO(17),
  O => N_94);
COMB_V_RD_3_I_O2q16z: LUT2 
generic map(
  INIT => X"7"
)
port map (
  I0 => N_81,
  I1 => R_RXFIFO(16),
  O => N_95);
RDATA_0_A4q7z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => N_1746_1,
  I1 => R_MODE_LEN(0),
  O => N_1746);
SAMPLE_0_SQMUXA_1_Z2569: LUT3 
generic map(
  INIT => X"06"
)
port map (
  I0 => R_PSCK,
  I1 => R_SPII_1_SCK,
  I2 => R_SPII_1_SPISEL_FAST,
  O => SAMPLE_0_SQMUXA_1);
TINDEX_0_SQMUXA_Z2570: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  O => TINDEX_0_SQMUXA);
V_PSCK_0_SQMUXA_Z2571: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_SPII_1_SPISEL,
  O => V_PSCK_0_SQMUXA);
COMB_V_MODE_MS_1_Z2572: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(25),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_MS_1);
COMB_V_MODE_EN_1_Z2573: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(24),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_EN_1);
V_CHNG_0_SQMUXA_Z2574: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_SPII_1_SPISEL,
  O => V_CHNG_0_SQMUXA);
COMB_UN47_SAMPLE: LUT3 
generic map(
  INIT => X"04"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_TW,
  I2 => R_TWDIR,
  O => COMB_UN47_SAMPLE_0);
COMB_V_SPIO_MOSIOEN24: LUT3 
generic map(
  INIT => X"15"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_TW,
  I2 => R_TWDIR,
  O => COMB_V_SPIO_MOSIOEN25);
COMB_V_RD_3_I_O2q8z: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => N_83,
  I1 => R_MODE_LEN(0),
  O => N_84);
R_SAMP_RNO_1: LUT2_L 
generic map(
  INIT => X"4"
)
port map (
  I0 => N_2121_0,
  I1 => R_SPII_1_SPISEL,
  LO => N_2122_0);
UN1_RELOAD_AM_RNOq3z: LUT3 
generic map(
  INIT => X"78"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  O => N_628);
COMB_UN1_APBI_PSEL_Z2580: LUT3 
generic map(
  INIT => X"08"
)
port map (
  I0 => apbi_penable,
  I1 => apbi_psel,
  I2 => apbi_pwrite,
  O => COMB_UN1_APBI_PSEL);
UN152_CHANGE_1q25z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(25),
  I2 => R_TXFIFO_4(25),
  O => N_1498);
UN152_CHANGE_2q25z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(25),
  I2 => R_TXFIFO_6(25),
  O => N_1529);
UN152_CHANGE_4q1z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(1),
  I2 => R_TXFIFO_5(1),
  O => N_1567);
UN152_CHANGE_4q5z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(5),
  I2 => R_TXFIFO_5(5),
  O => N_1571);
UN152_CHANGE_5q1z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(1),
  I2 => R_TXFIFO_7(1),
  O => N_1598);
REG_R_SPIO_SCK_3_Z2586: LUT3_L 
generic map(
  INIT => X"2E"
)
port map (
  I0 => R_MODE_CPOL,
  I1 => R_RUNNING,
  I2 => SPIO_SCK_6,
  LO => REG_R_SPIO_SCK_3);
UN152_CHANGE_1q11z_Z2587: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(11),
  I2 => R_TXFIFO_4(11),
  O => UN152_CHANGE_1(11));
UN152_CHANGE_1q15z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(15),
  I2 => R_TXFIFO_4(15),
  O => N_1488);
UN152_CHANGE_1q31z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(31),
  I2 => R_TXFIFO_4(31),
  O => N_1504);
UN152_CHANGE_2q11z_Z2590: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(11),
  I2 => R_TXFIFO_6(11),
  O => UN152_CHANGE_2(11));
UN152_CHANGE_2q15z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(15),
  I2 => R_TXFIFO_6(15),
  O => N_1519);
UN152_CHANGE_2q31z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(31),
  I2 => R_TXFIFO_6(31),
  O => N_1535);
UN152_CHANGE_4q11z_Z2593: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(11),
  I2 => R_TXFIFO_5(11),
  O => UN152_CHANGE_4(11));
UN152_CHANGE_4q15z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(15),
  I2 => R_TXFIFO_5(15),
  O => N_1581);
UN152_CHANGE_4q31z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(31),
  I2 => R_TXFIFO_5(31),
  O => N_1597);
UN152_CHANGE_5q11z_Z2596: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(11),
  I2 => R_TXFIFO_7(11),
  O => UN152_CHANGE_5(11));
UN152_CHANGE_5q15z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(15),
  I2 => R_TXFIFO_7(15),
  O => N_1612);
UN152_CHANGE_5q31z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(31),
  I2 => R_TXFIFO_7(31),
  O => N_1628);
COMB_V_TXFIFO_0_5_0q18z_Z2599: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(13),
  I2 => R_TD(18),
  O => COMB_V_TXFIFO_0_5_0(18));
COMB_V_TXFIFO_0_5_0q13z_Z2600: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(13),
  I2 => R_TD(18),
  O => COMB_V_TXFIFO_0_5_0(13));
COMB_V_TXFIFO_0_5_0_I_M2q29z: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(2),
  I2 => R_TD(29),
  O => N_109);
COMB_V_TXFIFO_0_5_0_I_M2q20z: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(11),
  I2 => R_TD(20),
  O => N_108);
COMB_V_TXFIFO_0_5_0_I_M2q19z: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(12),
  I2 => R_TD(19),
  O => N_107);
COMB_V_TXFIFO_0_5_0_I_M2q16z: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(15),
  I2 => R_TD(16),
  O => N_106);
COMB_V_TXFIFO_0_5_0_I_M2q15z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(15),
  I2 => R_TD(16),
  O => N_105);
COMB_V_TXFIFO_0_5_0_I_M2q12z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(12),
  I2 => R_TD(19),
  O => N_104);
COMB_V_TXFIFO_0_5_0_I_M2q11z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(11),
  I2 => R_TD(20),
  O => N_103);
COMB_V_TXFIFO_0_5_0_I_M2q2z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(2),
  I2 => R_TD(29),
  O => N_102);
COMB_V_TXFIFO_0_5_0q31z_Z2609: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(0),
  I2 => R_TD(31),
  O => COMB_V_TXFIFO_0_5_0(31));
COMB_V_TXFIFO_0_5_0q0z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(0),
  I2 => R_TD(31),
  O => N_885);
COMB_V_TXFIFO_0_5_0q30z_Z2611: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(1),
  I2 => R_TD(30),
  O => COMB_V_TXFIFO_0_5_0(30));
COMB_V_TXFIFO_0_5_0q28z_Z2612: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(3),
  I2 => R_TD(28),
  O => COMB_V_TXFIFO_0_5_0(28));
COMB_V_TXFIFO_0_5_0q27z_Z2613: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(4),
  I2 => R_TD(27),
  O => COMB_V_TXFIFO_0_5_0(27));
COMB_V_TXFIFO_0_5_0q26z_Z2614: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(5),
  I2 => R_TD(26),
  O => COMB_V_TXFIFO_0_5_0(26));
COMB_V_TXFIFO_0_5_0q25z_Z2615: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(6),
  I2 => R_TD(25),
  O => COMB_V_TXFIFO_0_5_0(25));
COMB_V_TXFIFO_0_5_0q24z_Z2616: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(7),
  I2 => R_TD(24),
  O => COMB_V_TXFIFO_0_5_0(24));
COMB_V_TXFIFO_0_5_0q23z_Z2617: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(8),
  I2 => R_TD(23),
  O => COMB_V_TXFIFO_0_5_0(23));
COMB_V_TXFIFO_0_5_0q22z_Z2618: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(9),
  I2 => R_TD(22),
  O => COMB_V_TXFIFO_0_5_0(22));
COMB_V_TXFIFO_0_5_0q21z_Z2619: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(10),
  I2 => R_TD(21),
  O => COMB_V_TXFIFO_0_5_0(21));
COMB_V_TXFIFO_0_5_0q17z_Z2620: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(14),
  I2 => R_TD(17),
  O => COMB_V_TXFIFO_0_5_0(17));
COMB_V_TXFIFO_0_5_0q14z_Z2621: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(14),
  I2 => R_TD(17),
  O => COMB_V_TXFIFO_0_5_0(14));
COMB_V_TXFIFO_0_5_0q10z_Z2622: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(10),
  I2 => R_TD(21),
  O => COMB_V_TXFIFO_0_5_0(10));
COMB_V_TXFIFO_0_5_0q9z_Z2623: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(9),
  I2 => R_TD(22),
  O => COMB_V_TXFIFO_0_5_0(9));
COMB_V_TXFIFO_0_5_0q8z_Z2624: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(8),
  I2 => R_TD(23),
  O => COMB_V_TXFIFO_0_5_0(8));
COMB_V_TXFIFO_0_5_0q7z_Z2625: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(7),
  I2 => R_TD(24),
  O => COMB_V_TXFIFO_0_5_0(7));
COMB_V_TXFIFO_0_5_0q6z_Z2626: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(6),
  I2 => R_TD(25),
  O => COMB_V_TXFIFO_0_5_0(6));
COMB_V_TXFIFO_0_5_0q5z_Z2627: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(5),
  I2 => R_TD(26),
  O => COMB_V_TXFIFO_0_5_0(5));
COMB_V_TXFIFO_0_5_0q4z_Z2628: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(4),
  I2 => R_TD(27),
  O => COMB_V_TXFIFO_0_5_0(4));
COMB_V_TXFIFO_0_5_0q3z_Z2629: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(3),
  I2 => R_TD(28),
  O => COMB_V_TXFIFO_0_5_0(3));
COMB_V_TXFIFO_0_5_0q1z_Z2630: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(1),
  I2 => R_TD(30),
  O => COMB_V_TXFIFO_0_5_0(1));
UN152_CHANGE_5q29z_Z2631: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(29),
  I2 => R_TXFIFO_7(29),
  O => UN152_CHANGE_5(29));
UN152_CHANGE_5q27z_Z2632: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(27),
  I2 => R_TXFIFO_7(27),
  O => UN152_CHANGE_5(27));
UN152_CHANGE_5q25z_Z2633: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(25),
  I2 => R_TXFIFO_7(25),
  O => UN152_CHANGE_5(25));
UN152_CHANGE_5q23z_Z2634: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(23),
  I2 => R_TXFIFO_7(23),
  O => UN152_CHANGE_5(23));
UN152_CHANGE_5q21z_Z2635: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(21),
  I2 => R_TXFIFO_7(21),
  O => UN152_CHANGE_5(21));
UN152_CHANGE_5q19z_Z2636: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(19),
  I2 => R_TXFIFO_7(19),
  O => UN152_CHANGE_5(19));
UN152_CHANGE_5q17z_Z2637: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(17),
  I2 => R_TXFIFO_7(17),
  O => UN152_CHANGE_5(17));
UN152_CHANGE_5q13z_Z2638: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(13),
  I2 => R_TXFIFO_7(13),
  O => UN152_CHANGE_5(13));
UN152_CHANGE_5q9z_Z2639: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(9),
  I2 => R_TXFIFO_7(9),
  O => UN152_CHANGE_5(9));
UN152_CHANGE_5q7z_Z2640: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(7),
  I2 => R_TXFIFO_7(7),
  O => UN152_CHANGE_5(7));
UN152_CHANGE_5q5z_Z2641: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(5),
  I2 => R_TXFIFO_7(5),
  O => UN152_CHANGE_5(5));
UN152_CHANGE_5q3z_Z2642: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(3),
  I2 => R_TXFIFO_7(3),
  O => UN152_CHANGE_5(3));
UN152_CHANGE_4q29z_Z2643: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(29),
  I2 => R_TXFIFO_5(29),
  O => UN152_CHANGE_4(29));
UN152_CHANGE_4q27z_Z2644: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(27),
  I2 => R_TXFIFO_5(27),
  O => UN152_CHANGE_4(27));
UN152_CHANGE_4q25z_Z2645: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(25),
  I2 => R_TXFIFO_5(25),
  O => UN152_CHANGE_4(25));
UN152_CHANGE_4q23z_Z2646: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(23),
  I2 => R_TXFIFO_5(23),
  O => UN152_CHANGE_4(23));
UN152_CHANGE_4q21z_Z2647: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(21),
  I2 => R_TXFIFO_5(21),
  O => UN152_CHANGE_4(21));
UN152_CHANGE_4q19z_Z2648: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(19),
  I2 => R_TXFIFO_5(19),
  O => UN152_CHANGE_4(19));
UN152_CHANGE_4q17z_Z2649: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(17),
  I2 => R_TXFIFO_5(17),
  O => UN152_CHANGE_4(17));
UN152_CHANGE_4q13z_Z2650: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(13),
  I2 => R_TXFIFO_5(13),
  O => UN152_CHANGE_4(13));
UN152_CHANGE_4q9z_Z2651: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(9),
  I2 => R_TXFIFO_5(9),
  O => UN152_CHANGE_4(9));
UN152_CHANGE_4q7z_Z2652: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(7),
  I2 => R_TXFIFO_5(7),
  O => UN152_CHANGE_4(7));
UN152_CHANGE_4q3z_Z2653: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(3),
  I2 => R_TXFIFO_5(3),
  O => UN152_CHANGE_4(3));
UN152_CHANGE_2q29z_Z2654: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(29),
  I2 => R_TXFIFO_6(29),
  O => UN152_CHANGE_2(29));
UN152_CHANGE_2q27z_Z2655: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(27),
  I2 => R_TXFIFO_6(27),
  O => UN152_CHANGE_2(27));
UN152_CHANGE_2q23z_Z2656: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(23),
  I2 => R_TXFIFO_6(23),
  O => UN152_CHANGE_2(23));
UN152_CHANGE_2q21z_Z2657: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(21),
  I2 => R_TXFIFO_6(21),
  O => UN152_CHANGE_2(21));
UN152_CHANGE_2q19z_Z2658: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(19),
  I2 => R_TXFIFO_6(19),
  O => UN152_CHANGE_2(19));
UN152_CHANGE_2q17z_Z2659: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(17),
  I2 => R_TXFIFO_6(17),
  O => UN152_CHANGE_2(17));
UN152_CHANGE_2q13z_Z2660: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(13),
  I2 => R_TXFIFO_6(13),
  O => UN152_CHANGE_2(13));
UN152_CHANGE_2q9z_Z2661: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(9),
  I2 => R_TXFIFO_6(9),
  O => UN152_CHANGE_2(9));
UN152_CHANGE_2q7z_Z2662: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(7),
  I2 => R_TXFIFO_6(7),
  O => UN152_CHANGE_2(7));
UN152_CHANGE_2q5z_Z2663: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(5),
  I2 => R_TXFIFO_6(5),
  O => UN152_CHANGE_2(5));
UN152_CHANGE_2q3z_Z2664: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(3),
  I2 => R_TXFIFO_6(3),
  O => UN152_CHANGE_2(3));
UN152_CHANGE_2q1z_Z2665: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(1),
  I2 => R_TXFIFO_6(1),
  O => UN152_CHANGE_2(1));
UN152_CHANGE_1q29z_Z2666: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(29),
  I2 => R_TXFIFO_4(29),
  O => UN152_CHANGE_1(29));
UN152_CHANGE_1q27z_Z2667: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(27),
  I2 => R_TXFIFO_4(27),
  O => UN152_CHANGE_1(27));
UN152_CHANGE_1q23z_Z2668: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(23),
  I2 => R_TXFIFO_4(23),
  O => UN152_CHANGE_1(23));
UN152_CHANGE_1q21z_Z2669: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(21),
  I2 => R_TXFIFO_4(21),
  O => UN152_CHANGE_1(21));
UN152_CHANGE_1q19z_Z2670: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(19),
  I2 => R_TXFIFO_4(19),
  O => UN152_CHANGE_1(19));
UN152_CHANGE_1q17z_Z2671: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(17),
  I2 => R_TXFIFO_4(17),
  O => UN152_CHANGE_1(17));
UN152_CHANGE_1q13z_Z2672: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(13),
  I2 => R_TXFIFO_4(13),
  O => UN152_CHANGE_1(13));
UN152_CHANGE_1q9z_Z2673: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(9),
  I2 => R_TXFIFO_4(9),
  O => UN152_CHANGE_1(9));
UN152_CHANGE_1q7z_Z2674: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(7),
  I2 => R_TXFIFO_4(7),
  O => UN152_CHANGE_1(7));
UN152_CHANGE_1q5z_Z2675: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(5),
  I2 => R_TXFIFO_4(5),
  O => UN152_CHANGE_1(5));
UN152_CHANGE_1q3z_Z2676: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(3),
  I2 => R_TXFIFO_4(3),
  O => UN152_CHANGE_1(3));
UN152_CHANGE_1q1z_Z2677: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(1),
  I2 => R_TXFIFO_4(1),
  O => UN152_CHANGE_1(1));
UN1_R_DIVCNT_1_S_9_RNO: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(9),
  O => UN1_R_DIVCNT_1_S_9_SF);
COMB_UN1_R_MODE_EN_2_0_Z2679: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_EVENT_TIP,
  I1 => R_MASK_TIP,
  O => COMB_UN1_R_MODE_EN_2_0);
R_SYNCSAMPC_0_Z2680: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_MS,
  O => R_SYNCSAMPC_0);
COMB_V_IRQ_1_IV_M3_E_0_Z2681: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_EVENT_NF,
  I1 => R_MASK_NF,
  O => COMB_V_IRQ_1_IV_M3_E_0);
COMB_UN16_SAMPLE_1_Z2682: LUT2_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_RFREECNT(1),
  I1 => R_RFREECNT(3),
  LO => COMB_UN16_SAMPLE_1);
COMB_OP_EQ_UN2_ASEL_EN_2: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(2),
  I1 => R_CGCNT(3),
  O => COMB_UN4_ASEL_EN_MB_1_0);
R_PSCK_RNO_1: LUT2_L 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_SPII_1_SPISEL,
  I1 => rstn,
  LO => COMB_V_PSCK_1_0_159_I_O4_0);
V_IRQ_0_SQMUXA_1_0_Z2685: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_SPII_1_SPISEL,
  O => V_IRQ_0_SQMUXA_1_0);
RDATA_0_0q3z: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN(3),
  O => RDATA_2_0_1);
UN1_R_RFREECNT_AXB_3_Z2687: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_RFREECNT(3),
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_3);
UN1_R_RFREECNT_AXB_2_Z2688: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_RFREECNT(2),
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_2);
UN1_R_RFREECNT_AXB_1_Z2689: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_RFREECNT(1),
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_1);
UN1_R_RFREECNT_AXB_0_Z2690: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => COMB_V_RD4,
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_0);
R_MODE_DIV16_RNIPI88_Z2691: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  O => R_MODE_DIV16_RNIPI88);
R_MODE_DIV16_RNIQGCG: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_FACT,
  O => N_875);
R_MODE_LEN_RNI1A5Dq2z: LUT2 
generic map(
  INIT => X"7"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN(3),
  O => N_81);
RDATA_0_A4q6z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_MODE_LEN(1),
  I1 => R_MODE_LEN(2),
  O => N_1746_1);
COMB_SPILEN_LEN_1: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  O => N_1752_0);
COMB_SLV_START_UN13_AM_EN_0: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_CPOL_FAST,
  I1 => R_SPII_1_SCK,
  O => COMB_SLV_START_UN13_AM_EN);
COMB_UN13_APBI_PSEL_3: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => apbi_paddr(6),
  I1 => apbi_paddr(7),
  O => V_TD_OCC_1_SQMUXA_4);
R_RDLI_RNIPOPJq0z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_RDLI(0),
  I1 => R_RXDONE,
  O => CO0_3);
COMB_UN1_R_MODE_TW_Z2699: LUT2_L 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_MODE_TW,
  LO => COMB_UN1_R_MODE_TW);
COMB_UN21_SAMPLE: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_TW,
  I1 => R_TWDIR,
  O => COMB_UN21_SAMPLE_0);
COMB_UN1_R_MODE_EN_Z2701: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_RUNNING,
  O => COMB_UN1_R_MODE_EN);
R_MODE_EN_RNIVS7B: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_MODE_EN,
  I1 => rstn,
  O => N_2120_0);
R_MODE_TW_RNIDGVH: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_MODE_TW,
  O => N_1458);
R_TOGGLE_RNIGVLP: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_MODE_MS_REP1,
  I1 => R_TOGGLE,
  O => N_2121_0);
R_RBITCNT_RNIEH87q2z: LUT2_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_RBITCNT(2),
  LO => N_2178);
R_MODE_LEN_RNIV95Dq1z: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => R_MODE_LEN(1),
  I1 => R_MODE_LEN(2),
  O => N_83);
COMB_UN54_SAMPLE_0: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_MS_REP1,
  I1 => R_MODE_TTO,
  LO => COMB_UN54_SAMPLE);
R_RUNNING_Z2708: FDR port map (
    Q => R_RUNNING,
    D => R_RUNNINGC,
    C => clk,
    R => R_MODE_EN_I);
R_RDLIq2z_Z2709: FDR port map (
    Q => R_RDLI(2),
    D => R_RDLIC,
    C => clk,
    R => R_MODE_EN_I);
R_RDLIq0z_Z2710: FDR port map (
    Q => R_RDLI(0),
    D => R_RDLIC_0,
    C => clk,
    R => R_MODE_EN_I);
R_RDLIq1z_Z2711: FDR port map (
    Q => R_RDLI(1),
    D => R_RDLIC_1,
    C => clk,
    R => R_MODE_EN_I);
R_TXFIFO_1q0z_Z2712: FDS port map (
    Q => R_TXFIFO_1(0),
    D => R_TXFIFO_1S_I,
    C => clk,
    S => R_MODE_EN_I);
R_RDFIq0z_Z2713: FDR port map (
    Q => R_RDFI(0),
    D => R_RDFIC,
    C => clk,
    R => R_MODE_EN_I);
R_RDFIq1z_Z2714: FDR port map (
    Q => R_RDFI(1),
    D => R_RDFIC_0,
    C => clk,
    R => R_MODE_EN_I);
R_RDFIq2z_Z2715: FDR port map (
    Q => R_RDFI(2),
    D => R_RDFIC_1,
    C => clk,
    R => R_MODE_EN_I);
R_TXFIFO_2q0z_Z2716: FDS port map (
    Q => R_TXFIFO_2(0),
    D => R_TXFIFO_2S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_3q0z_Z2717: FDS port map (
    Q => R_TXFIFO_3(0),
    D => R_TXFIFO_3S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_4q0z_Z2718: FDS port map (
    Q => R_TXFIFO_4(0),
    D => R_TXFIFO_4S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_5q0z_Z2719: FDS port map (
    Q => R_TXFIFO_5(0),
    D => R_TXFIFO_5S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_6q0z_Z2720: FDS port map (
    Q => R_TXFIFO_6(0),
    D => R_TXFIFO_6S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_7q0z_Z2721: FDS port map (
    Q => R_TXFIFO_7(0),
    D => R_TXFIFO_7S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_0q0z_Z2722: FDS port map (
    Q => R_TXFIFO_0(0),
    D => R_TXFIFO_0S_I,
    C => clk,
    S => R_MODE_EN_I);
R_SYNCSAMPq0z_Z2723: FDR port map (
    Q => R_SYNCSAMP(0),
    D => R_SYNCSAMPC,
    C => clk,
    R => R_OV);
R_RBITCNTq4z_Z2724: FDRE port map (
    Q => R_RBITCNT(4),
    D => R_RBITCNT_LM(4),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq4z_Z2725: XORCY port map (
    LI => R_RBITCNT(4),
    CI => R_RBITCNT_CRY(3),
    O => R_RBITCNT_S(4));
R_RBITCNTq3z_Z2726: FDRE port map (
    Q => R_RBITCNT(3),
    D => R_RBITCNT_LM(3),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq3z_Z2727: XORCY port map (
    LI => R_RBITCNT_QXU(3),
    CI => R_RBITCNT_CRY(2),
    O => R_RBITCNT_S(3));
R_RBITCNT_CRYq3z_Z2728: MUXCY_L port map (
    DI => NN_1,
    CI => R_RBITCNT_CRY(2),
    S => R_RBITCNT_QXU(3),
    LO => R_RBITCNT_CRY(3));
R_RBITCNTq2z_Z2729: FDRE port map (
    Q => R_RBITCNT(2),
    D => R_RBITCNT_LM(2),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq2z_Z2730: XORCY port map (
    LI => R_RBITCNT_QXU(2),
    CI => R_RBITCNT_CRY(1),
    O => R_RBITCNT_S(2));
R_RBITCNT_CRYq2z_Z2731: MUXCY_L port map (
    DI => NN_1,
    CI => R_RBITCNT_CRY(1),
    S => R_RBITCNT_QXU(2),
    LO => R_RBITCNT_CRY(2));
R_RBITCNTq1z_Z2732: FDRE port map (
    Q => R_RBITCNT(1),
    D => R_RBITCNT_LM(1),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq1z_Z2733: XORCY port map (
    LI => R_RBITCNT_QXU(1),
    CI => R_RBITCNT(0),
    O => R_RBITCNT_S(1));
R_RBITCNT_CRYq1z_Z2734: MUXCY_L port map (
    DI => NN_1,
    CI => R_RBITCNT(0),
    S => R_RBITCNT_QXU(1),
    LO => R_RBITCNT_CRY(1));
R_RBITCNTq0z_Z2735: FDRE port map (
    Q => R_RBITCNT(0),
    D => R_RBITCNT_LM(0),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_QXUq0z_Z2736: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(0),
  O => R_RBITCNT_QXU(0));
R_CGCNTq5z_Z2737: FDRE port map (
    Q => R_CGCNT(5),
    D => R_CGCNT_LM(5),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq5z_Z2738: XORCY port map (
    LI => R_CGCNT_QXU(5),
    CI => R_CGCNT_CRY(4),
    O => R_CGCNT_S(5));
R_CGCNT_QXUq5z_Z2739: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(5),
  O => R_CGCNT_QXU(5));
R_CGCNTq4z_Z2740: FDRE port map (
    Q => R_CGCNT(4),
    D => R_CGCNT_LM(4),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq4z_Z2741: XORCY port map (
    LI => R_CGCNT_QXU(4),
    CI => R_CGCNT_CRY(3),
    O => R_CGCNT_S(4));
R_CGCNT_CRYq4z_Z2742: MUXCY_L port map (
    DI => NN_2,
    CI => R_CGCNT_CRY(3),
    S => R_CGCNT_QXU(4),
    LO => R_CGCNT_CRY(4));
R_CGCNTq3z_Z2743: FDRE port map (
    Q => R_CGCNT(3),
    D => R_CGCNT_LM(3),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq3z_Z2744: XORCY port map (
    LI => R_CGCNT_QXU(3),
    CI => R_CGCNT_CRY(2),
    O => R_CGCNT_S(3));
R_CGCNT_CRYq3z_Z2745: MUXCY_L port map (
    DI => NN_2,
    CI => R_CGCNT_CRY(2),
    S => R_CGCNT_QXU(3),
    LO => R_CGCNT_CRY(3));
R_CGCNTq2z_Z2746: FDRE port map (
    Q => R_CGCNT(2),
    D => R_CGCNT_LM(2),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq2z_Z2747: XORCY port map (
    LI => R_CGCNT_QXU(2),
    CI => R_CGCNT_CRY(1),
    O => R_CGCNT_S(2));
R_CGCNT_CRYq2z_Z2748: MUXCY_L port map (
    DI => NN_2,
    CI => R_CGCNT_CRY(1),
    S => R_CGCNT_QXU(2),
    LO => R_CGCNT_CRY(2));
R_CGCNTq1z_Z2749: FDRE port map (
    Q => R_CGCNT(1),
    D => R_CGCNT_LM(1),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq1z_Z2750: XORCY port map (
    LI => R_CGCNT_QXU(1),
    CI => R_CGCNT_CRY(0),
    O => R_CGCNT_S(1));
R_CGCNT_CRYq1z_Z2751: MUXCY_L port map (
    DI => NN_2,
    CI => R_CGCNT_CRY(0),
    S => R_CGCNT_QXU(1),
    LO => R_CGCNT_CRY(1));
R_CGCNTq0z_Z2752: FDRE port map (
    Q => R_CGCNT(0),
    D => R_CGCNT_LM(0),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_CRYq0z_Z2753: MUXCY_L port map (
    DI => NN_2,
    CI => NN_1,
    S => R_CGCNT_S(0),
    LO => R_CGCNT_CRY(0));
R_TBITCNTq4z_Z2754: FDRE port map (
    Q => R_TBITCNT(4),
    D => R_TBITCNT_LM(4),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq4z_Z2755: XORCY port map (
    LI => R_TBITCNT(4),
    CI => R_TBITCNT_CRY(3),
    O => R_TBITCNT_S(4));
R_TBITCNTq3z_Z2756: FDRE port map (
    Q => R_TBITCNT(3),
    D => R_TBITCNT_LM(3),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq3z_Z2757: XORCY port map (
    LI => R_TBITCNT_QXU(3),
    CI => R_TBITCNT_CRY(2),
    O => R_TBITCNT_S(3));
R_TBITCNT_CRYq3z_Z2758: MUXCY_L port map (
    DI => NN_1,
    CI => R_TBITCNT_CRY(2),
    S => R_TBITCNT_QXU(3),
    LO => R_TBITCNT_CRY(3));
R_TBITCNTq2z_Z2759: FDRE port map (
    Q => R_TBITCNT(2),
    D => R_TBITCNT_LM(2),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq2z_Z2760: XORCY port map (
    LI => R_TBITCNT_QXU(2),
    CI => R_TBITCNT_CRY(1),
    O => R_TBITCNT_S(2));
R_TBITCNT_CRYq2z_Z2761: MUXCY_L port map (
    DI => NN_1,
    CI => R_TBITCNT_CRY(1),
    S => R_TBITCNT_QXU(2),
    LO => R_TBITCNT_CRY(2));
R_TBITCNTq1z_Z2762: FDRE port map (
    Q => R_TBITCNT(1),
    D => R_TBITCNT_LM(1),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq1z_Z2763: XORCY port map (
    LI => R_TBITCNT_QXU(1),
    CI => R_TBITCNT(0),
    O => R_TBITCNT_S(1));
R_TBITCNT_CRYq1z_Z2764: MUXCY_L port map (
    DI => NN_1,
    CI => R_TBITCNT(0),
    S => R_TBITCNT_QXU(1),
    LO => R_TBITCNT_CRY(1));
R_TBITCNTq0z_Z2765: FDRE port map (
    Q => R_TBITCNT(0),
    D => R_TBITCNT_LM(0),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
UN1_V_DIVCNT_0_SQMUXA_1_P7_Z2766: LUT4 
generic map(
  INIT => X"FFFE"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_RELOAD(3),
  I2 => UN1_RELOAD(2),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  O => UN1_V_DIVCNT_0_SQMUXA_1_P7);
UN1_V_DIVCNT_0_SQMUXA_1_P4_Z2767: LUT4 
generic map(
  INIT => X"FFFE"
)
port map (
  I0 => UN1_RELOAD(5),
  I1 => R_MODE_PM_RNIOEJG(2),
  I2 => R_MODE_DIV16_RNIOUDC,
  I3 => R_MODE_DIV16_RNIPI88,
  O => UN1_V_DIVCNT_0_SQMUXA_1_P4);
UN1_R_DIVCNT_1_S_9_Z2768: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_9_SF,
    CI => UN1_R_DIVCNT_1_CRY_8,
    O => UN1_R_DIVCNT_1_S_9);
UN1_R_DIVCNT_1_S_8_Z2769: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_8_SF,
    CI => UN1_R_DIVCNT_1_CRY_7,
    O => UN1_R_DIVCNT_1_S_8);
UN1_R_DIVCNT_1_CRY_8_Z2770: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_7,
    S => UN1_R_DIVCNT_1_S_8_SF,
    LO => UN1_R_DIVCNT_1_CRY_8);
UN1_R_DIVCNT_1_S_7_Z2771: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_7_SF,
    CI => UN1_R_DIVCNT_1_CRY_6,
    O => UN1_R_DIVCNT_1_S_7);
UN1_R_DIVCNT_1_CRY_7_Z2772: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_6,
    S => UN1_R_DIVCNT_1_S_7_SF,
    LO => UN1_R_DIVCNT_1_CRY_7);
UN1_R_DIVCNT_1_S_6_Z2773: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_6_SF,
    CI => UN1_R_DIVCNT_1_CRY_5,
    O => UN1_R_DIVCNT_1_S_6);
UN1_R_DIVCNT_1_CRY_6_Z2774: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_5,
    S => UN1_R_DIVCNT_1_S_6_SF,
    LO => UN1_R_DIVCNT_1_CRY_6);
UN1_R_DIVCNT_1_S_5_Z2775: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_5_SF,
    CI => UN1_R_DIVCNT_1_CRY_4,
    O => UN1_R_DIVCNT_1_S_5);
UN1_R_DIVCNT_1_CRY_5_Z2776: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_4,
    S => UN1_R_DIVCNT_1_S_5_SF,
    LO => UN1_R_DIVCNT_1_CRY_5);
UN1_R_DIVCNT_1_S_4_Z2777: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_4_SF,
    CI => UN1_R_DIVCNT_1_CRY_3,
    O => UN1_R_DIVCNT_1_S_4);
UN1_R_DIVCNT_1_CRY_4_Z2778: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_3,
    S => UN1_R_DIVCNT_1_S_4_SF,
    LO => UN1_R_DIVCNT_1_CRY_4);
UN1_R_DIVCNT_1_S_3_Z2779: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_3_SF,
    CI => UN1_R_DIVCNT_1_CRY_2,
    O => UN1_R_DIVCNT_1_S_3);
UN1_R_DIVCNT_1_CRY_3_Z2780: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_2,
    S => UN1_R_DIVCNT_1_S_3_SF,
    LO => UN1_R_DIVCNT_1_CRY_3);
UN1_R_DIVCNT_1_S_2_Z2781: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_2_SF,
    CI => UN1_R_DIVCNT_1_CRY_1,
    O => UN1_R_DIVCNT_1_S_2);
UN1_R_DIVCNT_1_CRY_2_Z2782: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_1,
    S => UN1_R_DIVCNT_1_S_2_SF,
    LO => UN1_R_DIVCNT_1_CRY_2);
UN1_R_DIVCNT_1_S_1_Z2783: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_1_SF,
    CI => UN1_R_DIVCNT_1_CRY_0,
    O => UN1_R_DIVCNT_1_S_1);
UN1_R_DIVCNT_1_CRY_1_Z2784: MUXCY_L port map (
    DI => NN_2,
    CI => UN1_R_DIVCNT_1_CRY_0,
    S => UN1_R_DIVCNT_1_S_1_SF,
    LO => UN1_R_DIVCNT_1_CRY_1);
UN1_R_DIVCNT_1_CRY_0_Z2785: MUXCY_L port map (
    DI => NN_2,
    CI => NN_1,
    S => UN1_R_DIVCNT_1_I,
    LO => UN1_R_DIVCNT_1_CRY_0);
UN1_R_RFREECNT_S_3: XORCY port map (
    LI => UN1_R_RFREECNT_AXB_3,
    CI => UN1_R_RFREECNT_CRY_2,
    O => UN1_R_RFREECNT_0(3));
UN1_R_RFREECNT_S_2: XORCY port map (
    LI => UN1_R_RFREECNT_AXB_2,
    CI => UN1_R_RFREECNT_CRY_1,
    O => UN1_R_RFREECNT_0(2));
UN1_R_RFREECNT_CRY_2_Z2788: MUXCY_L port map (
    DI => R_RXDONE,
    CI => UN1_R_RFREECNT_CRY_1,
    S => UN1_R_RFREECNT_AXB_2,
    LO => UN1_R_RFREECNT_CRY_2);
UN1_R_RFREECNT_S_1: XORCY port map (
    LI => UN1_R_RFREECNT_AXB_1,
    CI => UN1_R_RFREECNT_CRY_0,
    O => UN1_R_RFREECNT_0(1));
UN1_R_RFREECNT_CRY_1_Z2790: MUXCY_L port map (
    DI => R_RXDONE,
    CI => UN1_R_RFREECNT_CRY_0,
    S => UN1_R_RFREECNT_AXB_1,
    LO => UN1_R_RFREECNT_CRY_1);
UN1_R_RFREECNT_S_0: XORCY port map (
    LI => UN1_R_RFREECNT_AXB_0,
    CI => R_RFREECNT(0),
    O => UN1_R_RFREECNT_0(0));
UN1_R_RFREECNT_CRY_0_Z2792: MUXCY_L port map (
    DI => COMB_V_RD4,
    CI => R_RFREECNT(0),
    S => UN1_R_RFREECNT_AXB_0,
    LO => UN1_R_RFREECNT_CRY_0);
R_EVENT_UN_Z2793: FDRSE port map (
    Q => R_EVENT_UN,
    D => NN_1,
    C => clk,
    R => RSTN_I,
    S => V_IRQ_0_SQMUXA_2_1,
    CE => R_EVENT_UNCE);
R_RXFIFO_I_32: RAM16X1D port map (
  DPO => R_RXFIFO(16),
  SPO => R_RXFIFO_N_35,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(16),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_31: RAM16X1D port map (
  DPO => R_RXFIFO(8),
  SPO => R_RXFIFO_N_34,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(8),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_30: RAM16X1D port map (
  DPO => R_RXFIFO(17),
  SPO => R_RXFIFO_N_33,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(17),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_29: RAM16X1D port map (
  DPO => R_RXFIFO(13),
  SPO => R_RXFIFO_N_32,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(13),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_28: RAM16X1D port map (
  DPO => R_RXFIFO(9),
  SPO => R_RXFIFO_N_31,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(9),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_27: RAM16X1D port map (
  DPO => R_RXFIFO(18),
  SPO => R_RXFIFO_N_30,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(18),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_26: RAM16X1D port map (
  DPO => R_RXFIFO(14),
  SPO => R_RXFIFO_N_29,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(14),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_25: RAM16X1D port map (
  DPO => R_RXFIFO(1),
  SPO => R_RXFIFO_N_28,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(1),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_24: RAM16X1D port map (
  DPO => R_RXFIFO(2),
  SPO => R_RXFIFO_N_27,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(2),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_23: RAM16X1D port map (
  DPO => R_RXFIFO(5),
  SPO => R_RXFIFO_N_26,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(5),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_22: RAM16X1D port map (
  DPO => R_RXFIFO(4),
  SPO => R_RXFIFO_N_25,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(4),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_21: RAM16X1D port map (
  DPO => R_RXFIFO(0),
  SPO => R_RXFIFO_N_24,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(0),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_20: RAM16X1D port map (
  DPO => R_RXFIFO(29),
  SPO => R_RXFIFO_N_23,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(29),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_19: RAM16X1D port map (
  DPO => R_RXFIFO(3),
  SPO => R_RXFIFO_N_22,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(3),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_18: RAM16X1D port map (
  DPO => R_RXFIFO(21),
  SPO => R_RXFIFO_N_21,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(21),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_17: RAM16X1D port map (
  DPO => R_RXFIFO(30),
  SPO => R_RXFIFO_N_20,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(30),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_16: RAM16X1D port map (
  DPO => R_RXFIFO(26),
  SPO => R_RXFIFO_N_19,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(26),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_15: RAM16X1D port map (
  DPO => R_RXFIFO(22),
  SPO => R_RXFIFO_N_18,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(22),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_14: RAM16X1D port map (
  DPO => R_RXFIFO(31),
  SPO => R_RXFIFO_N_17,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(31),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_13: RAM16X1D port map (
  DPO => R_RXFIFO(27),
  SPO => R_RXFIFO_N_16,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(27),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_12: RAM16X1D port map (
  DPO => R_RXFIFO(10),
  SPO => R_RXFIFO_N_15,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(10),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_11: RAM16X1D port map (
  DPO => R_RXFIFO(6),
  SPO => R_RXFIFO_N_14,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(6),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_10: RAM16X1D port map (
  DPO => R_RXFIFO(15),
  SPO => R_RXFIFO_N_13,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(15),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_9: RAM16X1D port map (
  DPO => R_RXFIFO(11),
  SPO => R_RXFIFO_N_12,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(11),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_8: RAM16X1D port map (
  DPO => R_RXFIFO(7),
  SPO => R_RXFIFO_N_11,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(7),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_7: RAM16X1D port map (
  DPO => R_RXFIFO(25),
  SPO => R_RXFIFO_N_10,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(25),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_6: RAM16X1D port map (
  DPO => R_RXFIFO(12),
  SPO => R_RXFIFO_N_9,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(12),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_5: RAM16X1D port map (
  DPO => R_RXFIFO(28),
  SPO => R_RXFIFO_N_8,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(28),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_4: RAM16X1D port map (
  DPO => R_RXFIFO(24),
  SPO => R_RXFIFO_N_7,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(24),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_3: RAM16X1D port map (
  DPO => R_RXFIFO(23),
  SPO => R_RXFIFO_N_6,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(23),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_2: RAM16X1D port map (
  DPO => R_RXFIFO(19),
  SPO => R_RXFIFO_N_5,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(19),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_1: RAM16X1D port map (
  DPO => R_RXFIFO(20),
  SPO => R_RXFIFO_N_4,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_1,
  D => R_RXD(20),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_1,
  WCLK => clk,
  WE => R_RXDONE);
R_SPIO_SCKOEN: FDSE port map (
    Q => spio_sckoen,
    D => COMB_SAMPLE_6_0_I,
    C => clk,
    S => N_2120_0_I,
    CE => V_SPIO_SCKOEN_1_SQMUXA_I);
R_MASK_LT_Z2827: FDRE port map (
    Q => R_MASK_LT,
    D => apbi_pwdata(14),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_MME_Z2828: FDRE port map (
    Q => R_MASK_MME,
    D => apbi_pwdata(10),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_NE_Z2829: FDRE port map (
    Q => R_MASK_NE,
    D => apbi_pwdata(9),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_NF_Z2830: FDRE port map (
    Q => R_MASK_NF,
    D => apbi_pwdata(8),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_OV_Z2831: FDRE port map (
    Q => R_MASK_OV,
    D => apbi_pwdata(12),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_TIP_Z2832: FDRE port map (
    Q => R_MASK_TIP,
    D => apbi_pwdata(31),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_UN_Z2833: FDRE port map (
    Q => R_MASK_UN,
    D => apbi_pwdata(11),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MODE_CPHA_Z2834: FDRE port map (
    Q => R_MODE_CPHA,
    D => apbi_pwdata(28),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CPOL_Z2835: FDRE port map (
    Q => R_MODE_CPOL,
    D => apbi_pwdata(29),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_DIV16_Z2836: FDRE port map (
    Q => R_MODE_DIV16,
    D => apbi_pwdata(27),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_FACT_Z2837: FDRE port map (
    Q => R_MODE_FACT,
    D => apbi_pwdata(13),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LOOPB_Z2838: FDRE port map (
    Q => R_MODE_LOOPB,
    D => apbi_pwdata(30),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_REV_Z2839: FDRE port map (
    Q => R_MODE_REV,
    D => apbi_pwdata(26),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_TTO_Z2840: FDRE port map (
    Q => R_MODE_TTO,
    D => apbi_pwdata(3),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_TW_Z2841: FDRE port map (
    Q => R_MODE_TW,
    D => apbi_pwdata(15),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_EVENT_MME_Z2842: FDRSE port map (
    Q => R_EVENT_MME,
    D => NN_1,
    C => clk,
    R => RSTN_I,
    S => V_IRQ_0_SQMUXA_1_0,
    CE => R_EVENT_MMECE);
R_MODE_LENq3z_Z2843: FDRE port map (
    Q => R_MODE_LEN(3),
    D => apbi_pwdata(23),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LENq2z_Z2844: FDRE port map (
    Q => R_MODE_LEN(2),
    D => apbi_pwdata(22),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LENq1z_Z2845: FDRE port map (
    Q => R_MODE_LEN(1),
    D => apbi_pwdata(21),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LENq0z_Z2846: FDRE port map (
    Q => R_MODE_LEN(0),
    D => apbi_pwdata(20),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq3z_Z2847: FDRE port map (
    Q => R_MODE_PM(3),
    D => apbi_pwdata(19),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq2z_Z2848: FDRE port map (
    Q => R_MODE_PM(2),
    D => apbi_pwdata(18),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq1z_Z2849: FDRE port map (
    Q => R_MODE_PM(1),
    D => apbi_pwdata(17),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq0z_Z2850: FDRE port map (
    Q => R_MODE_PM(0),
    D => apbi_pwdata(16),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq4z_Z2851: FDRE port map (
    Q => R_MODE_CG(4),
    D => apbi_pwdata(11),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq3z_Z2852: FDRE port map (
    Q => R_MODE_CG(3),
    D => apbi_pwdata(10),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq2z_Z2853: FDRE port map (
    Q => R_MODE_CG(2),
    D => apbi_pwdata(9),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq1z_Z2854: FDRE port map (
    Q => R_MODE_CG(1),
    D => apbi_pwdata(8),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq0z_Z2855: FDRE port map (
    Q => R_MODE_CG(0),
    D => apbi_pwdata(7),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_SPIO_MISOOEN: FDSE port map (
    Q => spio_misooen,
    D => UN1_V_SPIO_MOSIOEN24_0_I,
    C => clk,
    S => N_2120_0_I,
    CE => V_SPIO_MISOOEN_2_SQMUXA_I);
R_EVENT_NE_Z2857: FDRSE port map (
    Q => R_EVENT_NE,
    D => NN_1,
    C => clk,
    R => RSTN_I,
    S => V_EVENT_NE_0_SQMUXA_1,
    CE => R_MODE_EN);
R_EVENT_NF_Z2858: FDRSE port map (
    Q => R_EVENT_NF,
    D => NN_1,
    C => clk,
    R => RSTN_I,
    S => V_EVENT_NF_0_SQMUXA,
    CE => R_MODE_EN);
R_MODE_EN_Z2859: FDRE port map (
    Q => R_MODE_EN,
    D => COMB_V_MODE_EN_1,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
R_MODE_MS_Z2860: FDRE port map (
    Q => R_MODE_MS,
    D => COMB_V_MODE_MS_1,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
R_RD_FREE_Z2861: FDSE port map (
    Q => R_RD_FREE,
    D => COMB_V_RD4_I,
    C => clk,
    S => N_2120_0_I,
    CE => V_RD_FREE_0_SQMUXA_I);
R_TDLIq2z_Z2862: FDR port map (
    Q => R_TDLI(2),
    D => R_TDLI_RNO(2),
    C => clk,
    R => N_2120_0_I);
R_TDLIq1z_Z2863: FDR port map (
    Q => R_TDLI(1),
    D => R_TDLI_RNO(1),
    C => clk,
    R => N_2120_0_I);
R_TDLIq0z_Z2864: FDR port map (
    Q => R_TDLI(0),
    D => R_TDLI_RNO(0),
    C => clk,
    R => N_2120_0_I);
R_TD_OCC_Z2865: FDRE port map (
    Q => R_TD_OCC,
    D => COMB_V_TXFIFO_76_I,
    C => clk,
    R => N_2120_0_I,
    CE => V_TD_OCC_0_SQMUXA_I);
R_RFREECNTq3z_Z2866: FDS port map (
    Q => R_RFREECNT(3),
    D => UN1_R_RFREECNT_0(3),
    C => clk,
    S => N_2120_0_I);
R_RFREECNTq2z_Z2867: FDR port map (
    Q => R_RFREECNT(2),
    D => UN1_R_RFREECNT_0(2),
    C => clk,
    R => N_2120_0_I);
R_RFREECNTq1z_Z2868: FDR port map (
    Q => R_RFREECNT(1),
    D => UN1_R_RFREECNT_0(1),
    C => clk,
    R => N_2120_0_I);
R_RFREECNTq0z_Z2869: FDR port map (
    Q => R_RFREECNT(0),
    D => UN1_R_RFREECNT_0(0),
    C => clk,
    R => N_2120_0_I);
R_EVENT_OV_Z2870: FDRSE port map (
    Q => R_EVENT_OV,
    D => NN_1,
    C => clk,
    R => RSTN_I,
    S => V_EVENT_OV_0_SQMUXA,
    CE => R_EVENT_OVCE);
R_SPIO_SCK: FDRE port map (
    Q => SPIO_SCK_6,
    D => REG_R_SPIO_SCK_3,
    C => clk,
    R => RSTN_I,
    CE => V_SPIO_SCK_1_SQMUXA_I);
R_OV_Z2872: FDRE port map (
    Q => R_OV,
    D => V_OV_0_SQMUXA_1_I,
    C => clk,
    R => N_2120_0_I,
    CE => UN1_V_OV10_0);
R_TWDIR_Z2873: FDSE port map (
    Q => R_TWDIR,
    D => COMB_V_TWDIR_1_0_I,
    C => clk,
    S => N_2120_0_I,
    CE => V_TWDIR_2_SQMUXA_I);
R_UF_Z2874: FDR port map (
    Q => R_UF,
    D => COMB_V_UF_7,
    C => clk,
    R => N_2120_0_I);
R_TDFIq2z_Z2875: FDR port map (
    Q => R_TDFI(2),
    D => R_TDFI_RNO(2),
    C => clk,
    R => N_2120_0_I);
R_TDFIq1z_Z2876: FDR port map (
    Q => R_TDFI(1),
    D => R_TDFI_RNO(1),
    C => clk,
    R => N_2120_0_I);
R_TDFIq0z_Z2877: FDR port map (
    Q => R_TDFI(0),
    D => R_TDFI_RNO(0),
    C => clk,
    R => N_2120_0_I);
R_INCRDLI_Z2878: FDR port map (
    Q => R_INCRDLI,
    D => COMB_V_INCRDLI_1,
    C => clk,
    R => N_2120_0_I);
R_SPIO_MISO: FDSE port map (
    Q => SPIO_MOSI_5,
    D => COMB_V_SPIO_MISO_3_0_I,
    C => clk,
    S => N_2120_0_I,
    CE => COMB_UN133_CHANGE_0_I);
R_TFREECNTq3z_Z2880: FDS port map (
    Q => R_TFREECNT(3),
    D => R_EVENT_LTD_1,
    C => clk,
    S => N_2120_0_I);
R_TFREECNTq2z_Z2881: FDR port map (
    Q => R_TFREECNT(2),
    D => R_TFREECNT_RNIABDRE(0),
    C => clk,
    R => N_2120_0_I);
R_TFREECNTq1z_Z2882: FDR port map (
    Q => R_TFREECNT(1),
    D => COMB_V_TXFIFO_76_RNI32075,
    C => clk,
    R => N_2120_0_I);
R_TFREECNTq0z_Z2883: FDR port map (
    Q => R_TFREECNT(0),
    D => UN1_R_TFREECNT_1_AXB0,
    C => clk,
    R => N_2120_0_I);
R_SPIO_MOSIOEN: FDSE port map (
    Q => spio_mosioen,
    D => COMB_V_SPIO_MOSIOEN_1_0_I,
    C => clk,
    S => N_2120_0_I,
    CE => V_SPIO_MOSIOEN_4_SQMUXA_I);
R_EVENT_TIP_Z2885: FDRE port map (
    Q => R_EVENT_TIP,
    D => V_EVENT_TIP_0_SQMUXA_1,
    C => clk,
    R => RSTN_I,
    CE => V_EVENT_TIP_2_SQMUXA_I);
R_DIVCNTq9z_Z2886: FDR port map (
    Q => R_DIVCNT(9),
    D => COMB_V_DIVCNT_1(9),
    C => clk,
    R => RSTN_I);
R_DIVCNTq8z_Z2887: FDR port map (
    Q => R_DIVCNT(8),
    D => COMB_V_DIVCNT_1(8),
    C => clk,
    R => RSTN_I);
R_DIVCNTq7z_Z2888: FDR port map (
    Q => R_DIVCNT(7),
    D => COMB_V_DIVCNT_1(7),
    C => clk,
    R => RSTN_I);
R_DIVCNTq6z_Z2889: FDR port map (
    Q => R_DIVCNT(6),
    D => COMB_V_DIVCNT_1(6),
    C => clk,
    R => RSTN_I);
R_DIVCNTq5z_Z2890: FDR port map (
    Q => R_DIVCNT(5),
    D => COMB_V_DIVCNT_1(5),
    C => clk,
    R => RSTN_I);
R_DIVCNTq4z_Z2891: FDR port map (
    Q => R_DIVCNT(4),
    D => COMB_V_DIVCNT_1(4),
    C => clk,
    R => RSTN_I);
R_DIVCNTq3z_Z2892: FDR port map (
    Q => R_DIVCNT(3),
    D => COMB_V_DIVCNT_1(3),
    C => clk,
    R => RSTN_I);
R_DIVCNTq2z_Z2893: FDR port map (
    Q => R_DIVCNT(2),
    D => COMB_V_DIVCNT_1(2),
    C => clk,
    R => RSTN_I);
R_DIVCNTq1z_Z2894: FDR port map (
    Q => R_DIVCNT(1),
    D => COMB_V_DIVCNT_1(1),
    C => clk,
    R => RSTN_I);
R_DIVCNTq0z_Z2895: FDR port map (
    Q => R_DIVCNT(0),
    D => COMB_V_DIVCNT_1(0),
    C => clk,
    R => RSTN_I);
R_LST_Z2896: FDRE port map (
    Q => R_LST,
    D => COMB_V_LST_1,
    C => clk,
    R => RSTN_I,
    CE => V_LST_1_SQMUXA_1_I);
II_GND: GND port map (
    G => NN_1);
II_VCC: VCC port map (
    P => NN_2);
spio_miso <= SPIO_MOSI_5;
spio_mosi <= SPIO_MOSI_5;
spio_sck <= SPIO_SCK_6;
spio_astart <= NN_1;
slvsel(0) <= NN_2;
slvsel(1) <= NN_2;
slvsel(2) <= NN_2;
slvsel(3) <= NN_2;
slvsel(4) <= NN_2;
slvsel(5) <= NN_2;
slvsel(6) <= NN_2;
slvsel(7) <= NN_2;
slvsel(8) <= NN_2;
slvsel(9) <= NN_2;
slvsel(10) <= NN_2;
slvsel(11) <= NN_2;
slvsel(12) <= NN_2;
slvsel(13) <= NN_2;
slvsel(14) <= NN_2;
slvsel(15) <= NN_2;
slvsel(16) <= NN_2;
slvsel(17) <= NN_2;
slvsel(18) <= NN_2;
slvsel(19) <= NN_2;
slvsel(20) <= NN_2;
slvsel(21) <= NN_2;
slvsel(22) <= NN_2;
slvsel(23) <= NN_2;
slvsel(24) <= NN_2;
slvsel(25) <= NN_2;
slvsel(26) <= NN_2;
slvsel(27) <= NN_2;
slvsel(28) <= NN_2;
slvsel(29) <= NN_2;
slvsel(30) <= NN_2;
slvsel(31) <= NN_2;
end beh;

