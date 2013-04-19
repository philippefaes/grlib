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
-- Mon May 16 13:55:49 2011
--
--
--
-- Written by Synplify Pro version Build 312R
-- Mon May 16 13:55:49 2011
--
-- @N: Setting default value for generic rev to 3;
-- @N: Setting default value for generic fdepth to 3;
-- @N: Setting default value for generic slvselen to 1;
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
-- FD              16 uses
-- FDE             347 uses
-- FDR             49 uses
-- FDRE            63 uses
-- FDRSE           5 uses
-- FDS             11 uses
-- FDSE            38 uses
-- GND             1 use
-- MUXCY_L         23 uses
-- MUXF5           69 uses
-- MUXF6           25 uses
-- MUXF7           4 uses
-- MUXF8           1 use
-- VCC             1 use
-- XORCY           26 uses
-- LUT1            24 uses
-- LUT2            112 uses
-- LUT3            225 uses
-- LUT4            381 uses
--
-- I/O Register bits:                  0
-- Register bits not including I/Os:   529 (1%)
--
-- RAM/ROM usage summary
-- Dual Port Rams (RAM16X1D): 32
--
-- Total load per clock:
--    spictrlx|clk: 561
--
-- Mapping Summary:
-- Total  LUTs: 806 (3%)
--
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--library synplify;
--use synplify_components_all;
library UNISIM;
use UNISIM.VCOMPONENTS.all;

entity spictrl_unisim_comb0 is
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
end spictrl_unisim_comb0;

architecture beh of spictrl_unisim_comb0 is
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
  signal UN152_CHANGE_7 : std_logic_vector(31 downto 0);
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
  signal COMB_V_RD_3 : std_logic_vector(31 downto 0);
  signal R_TFREECNT_RNIJEI2D : std_logic_vector(0 to 0);
  signal R_TFREECNT_RNI78IID : std_logic_vector(1 to 1);
  signal R_TFREECNT_RNI26HMD : std_logic_vector(2 to 2);
  signal R_MODE_PM_RNIOUDC : std_logic_vector(1 to 1);
  signal R_MODE_PM_RNIOEJG : std_logic_vector(2 to 2);
  signal R_TDFI_RNO : std_logic_vector(2 downto 0);
  signal R_TDLI_RNO : std_logic_vector(2 downto 0);
  signal COMB_V_TFREECNT_30 : std_logic_vector(3 downto 1);
  signal COMB_V_DIVCNT_1 : std_logic_vector(9 downto 0);
  signal UN1_RELOAD : std_logic_vector(5 downto 2);
  signal UN1_RELOAD_MB : std_logic_vector(3 to 3);
  signal COMB_V_TXFIFO_0_5_0 : std_logic_vector(31 downto 0);
  signal R_TDLI_RNIJFCB1_6 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_5 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_4 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_3 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_2 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_1 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1_0 : std_logic_vector(2 to 2);
  signal R_TDLI_RNIJFCB1 : std_logic_vector(2 to 2);
  signal R_RD_M : std_logic_vector(31 downto 7);
  signal R_RD_M_0 : std_logic_vector(28 downto 18);
  signal UN152_CHANGE_1 : std_logic_vector(29 downto 13);
  signal UN152_CHANGE_2 : std_logic_vector(29 downto 13);
  signal UN152_CHANGE_3 : std_logic_vector(31 downto 1);
  signal UN152_CHANGE_4 : std_logic_vector(21 downto 13);
  signal UN152_CHANGE_5 : std_logic_vector(29 downto 13);
  signal UN152_CHANGE_6 : std_logic_vector(31 downto 1);
  signal UN1_V_TXFIFO_76_0 : std_logic_vector(3 to 3);
  signal RDATA : std_logic_vector(28 downto 2);
  signal COMB_V_DIVCNT_5 : std_logic_vector(9 downto 0);
  signal LEN_1_0 : std_logic_vector(3 downto 0);
  signal R_SLVSEL_M : std_logic_vector(30 downto 17);
  signal UN152_CHANGE : std_logic_vector(26 downto 15);
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
  signal R_RBITCNT_LM : std_logic_vector(4 downto 0);
  signal R_RBITCNT_QXU : std_logic_vector(3 downto 1);
  signal R_RBITCNT_CRY : std_logic_vector(3 downto 1);
  signal R_RBITCNT_S : std_logic_vector(4 downto 1);
  signal APBO_PRDATA_0_IV_0 : std_logic_vector(31 downto 2);
  signal APBO_PRDATA_0_IV_1 : std_logic_vector(31 downto 0);
  signal APBO_PRDATA_IV_0 : std_logic_vector(11 to 11);
  signal APBO_PRDATA_IV_1 : std_logic_vector(11 to 11);
  signal APBO_PRDATA_IV_2 : std_logic_vector(11 to 11);
  signal APBO_PRDATA_0_IV_2 : std_logic_vector(10 downto 8);
  signal RDATA_0 : std_logic_vector(9 to 9);
  signal UN152_CHANGE_3_AM : std_logic_vector(31 downto 1);
  signal UN152_CHANGE_3_BM : std_logic_vector(31 downto 1);
  signal UN152_CHANGE_6_AM : std_logic_vector(31 downto 1);
  signal UN152_CHANGE_6_BM : std_logic_vector(31 downto 1);
  signal UN152_CHANGE_7_AM : std_logic_vector(26 downto 0);
  signal UN152_CHANGE_7_BM : std_logic_vector(26 downto 0);
  signal COMB_V_DIVCNT_1_0_AM : std_logic_vector(7 downto 2);
  signal COMB_V_DIVCNT_1_0_BM : std_logic_vector(7 downto 2);
  signal UN1_RELOAD_BM : std_logic_vector(3 downto 2);
  signal UN1_RELOAD_AM : std_logic_vector(2 to 2);
  signal R_TBITCNT_LM_0_1 : std_logic_vector(0 to 0);
  signal UN152_CHANGE_7_BM_1 : std_logic_vector(26 downto 0);
  signal UN152_CHANGE_7_AM_1 : std_logic_vector(26 downto 0);
  signal R_TFREECNT_FAST : std_logic_vector(3 downto 0);
  signal R_MODE_LEN_FAST : std_logic_vector(3 downto 0);
  signal R_DIVCNT_FAST : std_logic_vector(9 downto 0);
  signal COMB_V_DIVCNT_1_FAST : std_logic_vector(9 downto 0);
  signal R_TFREECNT_RNIET94S : std_logic_vector(2 to 2);
  signal R_TFREECNT_RNI1CS691 : std_logic_vector(0 to 0);
  signal R_TFREECNT_RNIET94S_0 : std_logic_vector(2 to 2);
  signal R_TFREECNT_RNI1CS691_0 : std_logic_vector(0 to 0);
  signal R_DIVCNT_FAST_RNIFJP41 : std_logic_vector(6 to 6);
  signal R_DIVCNT_FAST_RNI5BO41 : std_logic_vector(3 to 3);
  signal UN1_RELOAD_RN_0 : std_logic_vector(3 to 3);
  signal UN1_RELOAD_SN : std_logic_vector(3 to 3);
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
  signal NN_1 : std_logic ;
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
  signal COMB_SPILEN_LEN : std_logic ;
  signal R_MASK_MME : std_logic ;
  signal COMB_OP_EQ_V_SPIO_SCK2 : std_logic ;
  signal TINDEX_0_SQMUXA : std_logic ;
  signal R_OV2 : std_logic ;
  signal R_RXDONE2 : std_logic ;
  signal COMB_V_MODE_EN_1 : std_logic ;
  signal COMB_V_MODE_MS_1 : std_logic ;
  signal V_EVENT_LT_1_SQMUXA : std_logic ;
  signal V_MASK_LT_1_SQMUXA : std_logic ;
  signal V_MODE_CPHA_0_SQMUXA : std_logic ;
  signal V_SLVSEL_1_SQMUXA : std_logic ;
  signal COMB_V_TXFIFO_76 : std_logic ;
  signal COMB_V_RD4 : std_logic ;
  signal APBOUT_1_SQMUXA : std_logic ;
  signal APBOUT_2_SQMUXA : std_logic ;
  signal APBOUT_3_SQMUXA : std_logic ;
  signal APBOUT_4_SQMUXA : std_logic ;
  signal APBOUT_5_SQMUXA : std_logic ;
  signal APBOUT_6_SQMUXA : std_logic ;
  signal COMB_UN40_CHANGE : std_logic ;
  signal R_MASK_LT : std_logic ;
  signal R_MASK_NE : std_logic ;
  signal R_MASK_OV : std_logic ;
  signal R_MASK_TIP : std_logic ;
  signal R_MASK_UN : std_logic ;
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
  signal R_SYNCSAMPC_1 : std_logic ;
  signal V_OV_0_SQMUXA_1 : std_logic ;
  signal V_EVENT_OV_0_SQMUXA : std_logic ;
  signal UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R : std_logic ;
  signal R_MODE_DIV16_RNIPI88 : std_logic ;
  signal COMB_V_INCRDLI_1 : std_logic ;
  signal V_EVENT_TIP_0_SQMUXA_1 : std_logic ;
  signal UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81 : std_logic ;
  signal UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2 : std_logic ;
  signal R_EVENT_LTD_1 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8 : std_logic ;
  signal UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9 : std_logic ;
  signal R_LST : std_logic ;
  signal COMB_V_LST_1 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_26 : std_logic ;
  signal COMB_INDATA_1 : std_logic ;
  signal N_2126_0 : std_logic ;
  signal COMB_UN27_CHANGE : std_logic ;
  signal COMB_UN40_SAMPLE : std_logic ;
  signal COMB_V_UF_7 : std_logic ;
  signal UN1_V_OV10_0 : std_logic ;
  signal V_TXFIFO_5_1_SQMUXA_1_4 : std_logic ;
  signal V_IRQ_0_SQMUXA_2_1 : std_logic ;
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
  signal COMB_UN54_SAMPLE : std_logic ;
  signal N_838 : std_logic ;
  signal N_841 : std_logic ;
  signal N_845 : std_logic ;
  signal N_849 : std_logic ;
  signal N_856 : std_logic ;
  signal N_862 : std_logic ;
  signal V_CGCNT_0_SQMUXA_1 : std_logic ;
  signal V_TXFIFO_6_1_SQMUXA_1_4 : std_logic ;
  signal COMB_UN1_APBI_PSEL : std_logic ;
  signal COMB_UN30_APBI_PSEL : std_logic ;
  signal COMB_UN30_SAMPLE : std_logic ;
  signal COMB_UN9_APBI_PSEL : std_logic ;
  signal COMB_UN21_APBI_PSEL : std_logic ;
  signal COMB_UN1_AM_EN : std_logic ;
  signal COMB_V_RUNNING_9 : std_logic ;
  signal APBOUT_0_SQMUXA : std_logic ;
  signal APBOUT_0_SQMUXA_2 : std_logic ;
  signal V_TD_OCC_1_SQMUXA_4 : std_logic ;
  signal COMB_UN5_APBI_PSEL_1 : std_logic ;
  signal CO0_0 : std_logic ;
  signal RDATA_3_0 : std_logic ;
  signal SAMPLE_0_SQMUXA_1 : std_logic ;
  signal COMB_UN21_SAMPLE_0 : std_logic ;
  signal COMB_UN30_AM_EN : std_logic ;
  signal COMB_CHANGE_1_1 : std_logic ;
  signal N_2128_0 : std_logic ;
  signal COMB_SLV_START_UN13_AM_EN : std_logic ;
  signal COMB_UN1_R_RUNNING_1 : std_logic ;
  signal COMB_UN26_AM_EN_0 : std_logic ;
  signal V_CHNG_0_SQMUXA : std_logic ;
  signal V_PSCK_0_SQMUXA : std_logic ;
  signal V_DIVCNT_1_SQMUXA : std_logic ;
  signal COMB_V_SPIO_SCK20 : std_logic ;
  signal COMB_RELOAD_1_0 : std_logic ;
  signal N_636 : std_logic ;
  signal N_634 : std_logic ;
  signal N_792 : std_logic ;
  signal N_793 : std_logic ;
  signal N_794 : std_logic ;
  signal N_796 : std_logic ;
  signal N_797 : std_logic ;
  signal N_798 : std_logic ;
  signal N_801 : std_logic ;
  signal N_635 : std_logic ;
  signal N_876 : std_logic ;
  signal N_879 : std_logic ;
  signal N_880 : std_logic ;
  signal N_881 : std_logic ;
  signal COMB_INDATA_1_SN_N_6_0 : std_logic ;
  signal RDATA_2_0 : std_logic ;
  signal RDATA_0_0 : std_logic ;
  signal RDATA_4 : std_logic ;
  signal N_1759_I : std_logic ;
  signal N_822_0_3 : std_logic ;
  signal N_826_0_4 : std_logic ;
  signal N_795 : std_logic ;
  signal COMB_UN40_SAMPLE_2 : std_logic ;
  signal COMB_UN16_SAMPLE : std_logic ;
  signal COMB_SAMPLE_1 : std_logic ;
  signal COMB_SELECT_DATA_RDATA118 : std_logic ;
  signal COMB_SELECT_DATA_RDATA116_1 : std_logic ;
  signal N_832_0_1 : std_logic ;
  signal CO0_3 : std_logic ;
  signal N_2174 : std_logic ;
  signal N_2165_0 : std_logic ;
  signal V_IRQ_0_SQMUXA_3 : std_logic ;
  signal COMB_UN1_R_MODE_EN_2 : std_logic ;
  signal V_IRQ_0_SQMUXA_1 : std_logic ;
  signal N_846 : std_logic ;
  signal N_1546 : std_logic ;
  signal N_1639 : std_logic ;
  signal N_1577 : std_logic ;
  signal N_1608 : std_logic ;
  signal N_1500 : std_logic ;
  signal N_1531 : std_logic ;
  signal N_1484 : std_logic ;
  signal N_1515 : std_logic ;
  signal COMB_UN1_R_TFREECNT : std_logic ;
  signal COMB_UN1_R_TFREECNT_S0 : std_logic ;
  signal N_1663 : std_logic ;
  signal N_839 : std_logic ;
  signal N_844 : std_logic ;
  signal N_851 : std_logic ;
  signal N_852 : std_logic ;
  signal N_855 : std_logic ;
  signal N_857 : std_logic ;
  signal N_858 : std_logic ;
  signal N_859 : std_logic ;
  signal N_867 : std_logic ;
  signal N_866 : std_logic ;
  signal COMB_SELECT_DATA_RDATA116 : std_logic ;
  signal COMB_UN27_CHANGE_2 : std_logic ;
  signal N_864 : std_logic ;
  signal N_865 : std_logic ;
  signal N_848 : std_logic ;
  signal N_842 : std_logic ;
  signal N_1601 : std_logic ;
  signal COMB_V_SPIO_MOSIOEN25 : std_logic ;
  signal V_SPIO_MOSIOEN_0_SQMUXA_1 : std_logic ;
  signal V_SPIO_MOSIOEN_3_SQMUXA : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_SM0_0 : std_logic ;
  signal TINDEX_1_SQMUXA : std_logic ;
  signal COMB_UN1_R_MODE_TW : std_logic ;
  signal COMB_OP_EQ_UN2_ASEL_EN : std_logic ;
  signal V_CGCNT_0_SQMUXA : std_logic ;
  signal V_CGCNT_0_SQMUXA_2 : std_logic ;
  signal COMB_UN6_ASEL_EN : std_logic ;
  signal N_2127_0 : std_logic ;
  signal SAMPLE_0_SQMUXA_2 : std_logic ;
  signal N_2143 : std_logic ;
  signal CHANGE_1_SQMUXA : std_logic ;
  signal COMB_V_CHNG_1 : std_logic ;
  signal N_2188_0 : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_M2 : std_logic ;
  signal UN1_V_CGCNT_0_SQMUXA_2_0 : std_logic ;
  signal COMB_V_INCRDLI_5 : std_logic ;
  signal V_RUNNING_0_SQMUXA_1 : std_logic ;
  signal COMB_UN65_SAMPLE_0 : std_logic ;
  signal V_TWDIR_0_SQMUXA : std_logic ;
  signal N_2146_0 : std_logic ;
  signal N_2167_0 : std_logic ;
  signal N_2173 : std_logic ;
  signal N_2175 : std_logic ;
  signal COMB_UN1_R_INCRDLI : std_logic ;
  signal COMB_UN47_SAMPLE_0 : std_logic ;
  signal R_MASK_UN_M : std_logic ;
  signal R_EVENT_MMECE : std_logic ;
  signal R_EVENT_OVCE : std_logic ;
  signal R_EVENT_LTCE : std_logic ;
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
  signal COMB_V_LST_1_1 : std_logic ;
  signal COMB_V_IRQ_1_IV_M3_E : std_logic ;
  signal COMB_V_IRQ_1_IV_M5_E : std_logic ;
  signal COMB_UN1_R_TFREECNT_S0_N_11 : std_logic ;
  signal COMB_UN1_R_TFREECNT_S0_N_13 : std_logic ;
  signal COMB_UN40_SAMPLE_NE_2_N_8_I : std_logic ;
  signal COMB_UN40_SAMPLE_NE_2_N_12_I : std_logic ;
  signal COMB_V_TWDIR_1_IV_0_TZ : std_logic ;
  signal V_TOGGLE_0_SQMUXA_A0_1 : std_logic ;
  signal UN1_V_TXFIFO_76_2_B0_0_O5 : std_logic ;
  signal UN1_V_TXFIFO_76_2_N_11 : std_logic ;
  signal UN1_V_TXFIFO_76_3_N_13 : std_logic ;
  signal UN1_V_TXFIFO_76_3_N_14 : std_logic ;
  signal V_TOGGLE_0_SQMUXA : std_logic ;
  signal V_IRQ_0_SQMUXA_1_0 : std_logic ;
  signal COMB_UN1_R_RUNNING_1_I : std_logic ;
  signal COMB_V_TXFIFO_76_I : std_logic ;
  signal COMB_SAMPLE_6_0_I : std_logic ;
  signal UN1_R_DIVCNT_1_I : std_logic ;
  signal RSTN_I : std_logic ;
  signal V_OV_0_SQMUXA_1_I : std_logic ;
  signal COMB_V_RD4_I : std_logic ;
  signal COMB_V_RXDONE_2_0_I : std_logic ;
  signal COMB_UN1_R_SYNCSAMP_0_I : std_logic ;
  signal N_2126_0_I : std_logic ;
  signal V_SPIO_SCKOEN_1_SQMUXA_I : std_logic ;
  signal UN1_V_SPIO_MOSIOEN24_0_I : std_logic ;
  signal V_SPIO_MISOOEN_2_SQMUXA_I : std_logic ;
  signal V_PSCK_1_SQMUXA_I : std_logic ;
  signal V_MODE_EN_1_SQMUXA_I : std_logic ;
  signal V_RD_FREE_0_SQMUXA_I : std_logic ;
  signal N_2115_0_I : std_logic ;
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
  signal COMB_V_IRQ_1_IV_N_7_I : std_logic ;
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
  signal N_2229 : std_logic ;
  signal COMB_UN13_APBI_PSEL_2 : std_logic ;
  signal APBOUT_0_SQMUXA_3 : std_logic ;
  signal COMB_UN17_APBI_PSEL_2 : std_logic ;
  signal APBOUT_5_SQMUXA_1 : std_logic ;
  signal COMB_V_PSCK_1_0_159_I_O4_0 : std_logic ;
  signal V_TD_OCC_1_SQMUXA_3 : std_logic ;
  signal COMB_UN16_SAMPLE_1 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_1_4 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_1_5 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_0_1 : std_logic ;
  signal UN1_R_MODE_EN_184_A6_0 : std_logic ;
  signal UN1_V_TXFIFO_76_3_M9_I_O5_0 : std_logic ;
  signal V_TOGGLE_0_SQMUXA_A0_0 : std_logic ;
  signal V_SPIO_MOSIOEN_0_SQMUXA_0 : std_logic ;
  signal COMB_CHANGE_4_1 : std_logic ;
  signal V_IRQ_0_SQMUXA_2_0 : std_logic ;
  signal COMB_UN40_SAMPLE_NE_1 : std_logic ;
  signal COMB_UN27_CHANGE_NE_0 : std_logic ;
  signal UN1_R_MODE_EN_184_0 : std_logic ;
  signal V_IRQ_0_SQMUXA_3_1_0 : std_logic ;
  signal UN1_V_TXFIFO_76_3_M9_I_0 : std_logic ;
  signal UN1_V_TXFIFO_76_3_M9_I_2 : std_logic ;
  signal V_RUNNING_0_SQMUXA_1_0 : std_logic ;
  signal V_RUNNING_0_SQMUXA_1_4 : std_logic ;
  signal UN1_V_TXFIFO_76_2_B0_0_0 : std_logic ;
  signal UN1_V_TXFIFO_76_2_B0_0_2 : std_logic ;
  signal V_TXFIFO_0_1_SQMUXA_1_1 : std_logic ;
  signal COMB_V_RUNNING_9_IV_0 : std_logic ;
  signal V_TXFIFO_4_1_SQMUXA_1_2 : std_logic ;
  signal R_TXFIFO_0SR_0 : std_logic ;
  signal R_TXFIFO_4SR_0 : std_logic ;
  signal R_TXFIFO_1SR_0 : std_logic ;
  signal R_TXFIFO_2SR_0 : std_logic ;
  signal R_TXFIFO_6SR_0 : std_logic ;
  signal R_TXFIFO_5SR_0 : std_logic ;
  signal R_TXFIFO_7SR_0 : std_logic ;
  signal R_TXFIFO_3SR_0 : std_logic ;
  signal COMB_V_EVENT_LT6_3_1 : std_logic ;
  signal COMB_V_IRQ_1_IV_M1_E_0 : std_logic ;
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
  signal COMB_V_SPIO_MOSI_2_19_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_19_BM : std_logic ;
  signal COMB_INDATA_1_U_1 : std_logic ;
  signal COMB_V_SPIO_MOSI_2_20_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_20_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_25_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_25_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_18_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_18_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_7_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_7_BM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_14_AM : std_logic ;
  signal COMB_V_SPIO_MOSI_2_14_BM : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_M2_AM : std_logic ;
  signal COMB_V_SPIO_MOSIOEN_1_M2_BM : std_logic ;
  signal V_RUNNING_0_SQMUXA_1_4_1 : std_logic ;
  signal R_IRQD_0 : std_logic ;
  signal R_EVENT_LTD_0 : std_logic ;
  signal R_EVENT_TIPE_0 : std_logic ;
  signal G0_5_5 : std_logic ;
  signal G0_0_A3_0_0 : std_logic ;
  signal G1_0_1_0 : std_logic ;
  signal G2 : std_logic ;
  signal G2_1_3 : std_logic ;
  signal G0_0_0 : std_logic ;
  signal G0_1_0 : std_logic ;
  signal G0_4_6 : std_logic ;
  signal G0_4_7 : std_logic ;
  signal G0_4_8 : std_logic ;
  signal G2_0 : std_logic ;
  signal G0_5_3 : std_logic ;
  signal G1_6_0 : std_logic ;
  signal G1_7_0 : std_logic ;
  signal G1_8_0 : std_logic ;
  signal G1_9 : std_logic ;
  signal G1_0_0 : std_logic ;
  signal G1_0_1_1 : std_logic ;
  signal COMB_UN1_R_TFREECNT_S0_N_13_0_0_0 : std_logic ;
  signal G1_1_1_0 : std_logic ;
  signal G0_2_6_0 : std_logic ;
  signal G0_2_7_0 : std_logic ;
  signal G0_2_8_0 : std_logic ;
  signal G1_1 : std_logic ;
  signal R_SPII_1_SPISEL_FAST : std_logic ;
  signal UN1_R_TFREECNT_1_AXB0_FAST : std_logic ;
  signal R_MODE_CPOL_FAST : std_logic ;
  signal R_MODE_LEN_2_REP1 : std_logic ;
  signal R_MODE_LEN_0_REP1 : std_logic ;
  signal R_SPII_1_SCK_FAST : std_logic ;
  signal R_MODE_EN_FAST : std_logic ;
  signal COMB_V_MODE_EN_1_FAST : std_logic ;
  signal R_MODE_MS_FAST : std_logic ;
  signal COMB_V_MODE_MS_1_FAST : std_logic ;
  signal R_MODE_MS_REP1 : std_logic ;
  signal COMB_V_MODE_MS_1_REP1 : std_logic ;
  signal R_TD_OCC_FAST : std_logic ;
  signal COMB_V_TXFIFO_76_I_FAST : std_logic ;
  signal R_RUNNING_FAST : std_logic ;
  signal R_RUNNINGC_FAST : std_logic ;
  signal R_RUNNING_REP1 : std_logic ;
  signal R_RUNNINGC_REP1 : std_logic ;
  signal COMB_UN27_CHANGE_NE_1_0 : std_logic ;
  signal G0_I_M2_0_1 : std_logic ;
  signal R_IRQD_1 : std_logic ;
  signal COMB_V_RUNNING_9_IV_1 : std_logic ;
  signal COMB_V_TFREECNT_AXBXC3_1 : std_logic ;
  signal G2_1_0 : std_logic ;
  signal G2_0_1 : std_logic ;
  signal G0_21_1 : std_logic ;
  signal R_SPIO_SCK_FAST : std_logic ;
  signal REG_R_SPIO_SCK_3_FAST : std_logic ;
  signal UN1_V_TXFIFO_76_2_B0_0_O5_RNO : std_logic ;
  signal G0_9_SX : std_logic ;
  signal UN1_V_TXFIFO_76_2_B0_0_O5_RNO_2 : std_logic ;
  signal G0_21_SX : std_logic ;
  signal COMB_V_IRQ_1_IV_N_7_I_MB_1 : std_logic ;
  signal V_RUNNING_0_SQMUXA_1_0_1 : std_logic ;
  signal R_LST_RNO_0 : std_logic ;
  signal R_LST_RNO_1 : std_logic ;
  signal R_SPII_1_SPISEL_FAST_RNI8IOA1 : std_logic ;
  signal G3_SX : std_logic ;
  signal SPIO_MOSI_5 : std_logic ;
  signal SPIO_SCK_6 : std_logic ;
  signal NN_2 : std_logic ;
  signal NN_3 : std_logic ;
  signal SLVSEL_9 : std_logic ;
  signal SLVSEL_10 : std_logic ;
  signal SLVSEL_11 : std_logic ;
  signal SLVSEL_12 : std_logic ;
  signal SLVSEL_13 : std_logic ;
  signal SLVSEL_14 : std_logic ;
  signal SLVSEL_15 : std_logic ;
  signal SLVSEL_16 : std_logic ;
  signal SLVSEL_17 : std_logic ;
  signal SLVSEL_18 : std_logic ;
  signal SLVSEL_19 : std_logic ;
  signal SLVSEL_20 : std_logic ;
  signal SLVSEL_21 : std_logic ;
  signal SLVSEL_22 : std_logic ;
  signal SLVSEL_23 : std_logic ;
  signal SLVSEL_24 : std_logic ;
  signal SLVSEL_25 : std_logic ;
  signal SLVSEL_26 : std_logic ;
  signal SLVSEL_27 : std_logic ;
  signal SLVSEL_28 : std_logic ;
  signal SLVSEL_29 : std_logic ;
  signal SLVSEL_30 : std_logic ;
  signal SLVSEL_31 : std_logic ;
  signal SLVSEL_32 : std_logic ;
  signal SLVSEL_33 : std_logic ;
  signal SLVSEL_34 : std_logic ;
  signal SLVSEL_35 : std_logic ;
  signal SLVSEL_36 : std_logic ;
  signal SLVSEL_37 : std_logic ;
  signal SLVSEL_38 : std_logic ;
  signal SLVSEL_39 : std_logic ;
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
UN1_R_DIVCNT_1_I_Z1715: LUT1 
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
R_TBITCNT_QXUq1z_Z1724: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(1),
  O => R_TBITCNT_QXU(1));
R_TBITCNT_QXUq2z_Z1725: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(2),
  O => R_TBITCNT_QXU(2));
R_TBITCNT_QXUq3z_Z1726: LUT1 
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
R_CGCNT_QXUq1z_Z1728: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(1),
  O => R_CGCNT_QXU(1));
R_CGCNT_QXUq2z_Z1729: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(2),
  O => R_CGCNT_QXU(2));
R_CGCNT_QXUq3z_Z1730: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(3),
  O => R_CGCNT_QXU(3));
R_CGCNT_QXUq4z_Z1731: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(4),
  O => R_CGCNT_QXU(4));
R_RBITCNT_QXUq1z_Z1732: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(1),
  O => R_RBITCNT_QXU(1));
R_RBITCNT_QXUq2z_Z1733: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(2),
  O => R_RBITCNT_QXU(2));
R_RBITCNT_QXUq3z_Z1734: LUT1 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RBITCNT(3),
  O => R_RBITCNT_QXU(3));
R_MODE_EN_RNIVS7B_0: INV port map (
    I => N_2126_0,
    O => N_2126_0_I);
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
R_EVENT_LT_Z1739: FDR port map (
    Q => R_EVENT_LT,
    D => R_EVENT_LTD_0,
    C => clk,
    R => RSTN_I);
R_EVENT_TIP_Z1740: FDR port map (
    Q => R_EVENT_TIP,
    D => R_EVENT_TIPE_0,
    C => clk,
    R => RSTN_I);
R_CHNG_Z1741: FDE port map (
    Q => R_CHNG,
    D => COMB_V_CHNG_1,
    C => clk,
    CE => V_CHNG_2_SQMUXA_I);
R_SAMP_Z1742: FDE port map (
    Q => R_SAMP,
    D => N_2115_0_I,
    C => clk,
    CE => V_SAMP_2_SQMUXA_I);
R_PSCK_Z1743: FDE port map (
    Q => R_PSCK,
    D => N_2143,
    C => clk,
    CE => V_PSCK_1_SQMUXA_I);
R_TDq0z_Z1744: FDE port map (
    Q => R_TD(0),
    D => apbi_pwdata(0),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq1z_Z1745: FDE port map (
    Q => R_TD(1),
    D => apbi_pwdata(1),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq2z_Z1746: FDE port map (
    Q => R_TD(2),
    D => apbi_pwdata(2),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq3z_Z1747: FDE port map (
    Q => R_TD(3),
    D => apbi_pwdata(3),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq4z_Z1748: FDE port map (
    Q => R_TD(4),
    D => apbi_pwdata(4),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq5z_Z1749: FDE port map (
    Q => R_TD(5),
    D => apbi_pwdata(5),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq6z_Z1750: FDE port map (
    Q => R_TD(6),
    D => apbi_pwdata(6),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq7z_Z1751: FDE port map (
    Q => R_TD(7),
    D => apbi_pwdata(7),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq8z_Z1752: FDE port map (
    Q => R_TD(8),
    D => apbi_pwdata(8),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq9z_Z1753: FDE port map (
    Q => R_TD(9),
    D => apbi_pwdata(9),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq10z_Z1754: FDE port map (
    Q => R_TD(10),
    D => apbi_pwdata(10),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq11z_Z1755: FDE port map (
    Q => R_TD(11),
    D => apbi_pwdata(11),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq12z_Z1756: FDE port map (
    Q => R_TD(12),
    D => apbi_pwdata(12),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq13z_Z1757: FDE port map (
    Q => R_TD(13),
    D => apbi_pwdata(13),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq14z_Z1758: FDE port map (
    Q => R_TD(14),
    D => apbi_pwdata(14),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq15z_Z1759: FDE port map (
    Q => R_TD(15),
    D => apbi_pwdata(15),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq16z_Z1760: FDE port map (
    Q => R_TD(16),
    D => apbi_pwdata(16),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq17z_Z1761: FDE port map (
    Q => R_TD(17),
    D => apbi_pwdata(17),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq18z_Z1762: FDE port map (
    Q => R_TD(18),
    D => apbi_pwdata(18),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq19z_Z1763: FDE port map (
    Q => R_TD(19),
    D => apbi_pwdata(19),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq20z_Z1764: FDE port map (
    Q => R_TD(20),
    D => apbi_pwdata(20),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq21z_Z1765: FDE port map (
    Q => R_TD(21),
    D => apbi_pwdata(21),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq22z_Z1766: FDE port map (
    Q => R_TD(22),
    D => apbi_pwdata(22),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq23z_Z1767: FDE port map (
    Q => R_TD(23),
    D => apbi_pwdata(23),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq24z_Z1768: FDE port map (
    Q => R_TD(24),
    D => apbi_pwdata(24),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq25z_Z1769: FDE port map (
    Q => R_TD(25),
    D => apbi_pwdata(25),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq26z_Z1770: FDE port map (
    Q => R_TD(26),
    D => apbi_pwdata(26),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq27z_Z1771: FDE port map (
    Q => R_TD(27),
    D => apbi_pwdata(27),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq28z_Z1772: FDE port map (
    Q => R_TD(28),
    D => apbi_pwdata(28),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq29z_Z1773: FDE port map (
    Q => R_TD(29),
    D => apbi_pwdata(29),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq30z_Z1774: FDE port map (
    Q => R_TD(30),
    D => apbi_pwdata(30),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TDq31z_Z1775: FDE port map (
    Q => R_TD(31),
    D => apbi_pwdata(31),
    C => clk,
    CE => V_TD_OCC_1_SQMUXA);
R_TXFIFO_0q27z_Z1776: FDE port map (
    Q => R_TXFIFO_0(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q28z_Z1777: FDE port map (
    Q => R_TXFIFO_0(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q29z_Z1778: FDE port map (
    Q => R_TXFIFO_0(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q30z_Z1779: FDE port map (
    Q => R_TXFIFO_0(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q31z_Z1780: FDE port map (
    Q => R_TXFIFO_0(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_SYNCSAMPq1z_Z1781: FD port map (
    Q => R_SYNCSAMP(1),
    D => R_SYNCSAMP(0),
    C => clk);
R_TXFIFO_0q12z_Z1782: FDE port map (
    Q => R_TXFIFO_0(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q13z_Z1783: FDE port map (
    Q => R_TXFIFO_0(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q14z_Z1784: FDE port map (
    Q => R_TXFIFO_0(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q15z_Z1785: FDE port map (
    Q => R_TXFIFO_0(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q16z_Z1786: FDE port map (
    Q => R_TXFIFO_0(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q17z_Z1787: FDE port map (
    Q => R_TXFIFO_0(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q18z_Z1788: FDE port map (
    Q => R_TXFIFO_0(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q19z_Z1789: FDE port map (
    Q => R_TXFIFO_0(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q20z_Z1790: FDE port map (
    Q => R_TXFIFO_0(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q21z_Z1791: FDE port map (
    Q => R_TXFIFO_0(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q22z_Z1792: FDE port map (
    Q => R_TXFIFO_0(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q23z_Z1793: FDE port map (
    Q => R_TXFIFO_0(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q24z_Z1794: FDE port map (
    Q => R_TXFIFO_0(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q25z_Z1795: FDE port map (
    Q => R_TXFIFO_0(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q26z_Z1796: FDE port map (
    Q => R_TXFIFO_0(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q1z_Z1797: FDE port map (
    Q => R_TXFIFO_0(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q2z_Z1798: FDE port map (
    Q => R_TXFIFO_0(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q3z_Z1799: FDE port map (
    Q => R_TXFIFO_0(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q4z_Z1800: FDE port map (
    Q => R_TXFIFO_0(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q5z_Z1801: FDE port map (
    Q => R_TXFIFO_0(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q6z_Z1802: FDE port map (
    Q => R_TXFIFO_0(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q7z_Z1803: FDE port map (
    Q => R_TXFIFO_0(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q8z_Z1804: FDE port map (
    Q => R_TXFIFO_0(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q9z_Z1805: FDE port map (
    Q => R_TXFIFO_0(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q10z_Z1806: FDE port map (
    Q => R_TXFIFO_0(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_0q11z_Z1807: FDE port map (
    Q => R_TXFIFO_0(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_6(2));
R_TXFIFO_7q31z_Z1808: FDE port map (
    Q => R_TXFIFO_7(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q16z_Z1809: FDE port map (
    Q => R_TXFIFO_7(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q17z_Z1810: FDE port map (
    Q => R_TXFIFO_7(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q18z_Z1811: FDE port map (
    Q => R_TXFIFO_7(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q19z_Z1812: FDE port map (
    Q => R_TXFIFO_7(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q20z_Z1813: FDE port map (
    Q => R_TXFIFO_7(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q21z_Z1814: FDE port map (
    Q => R_TXFIFO_7(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q22z_Z1815: FDE port map (
    Q => R_TXFIFO_7(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q23z_Z1816: FDE port map (
    Q => R_TXFIFO_7(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q24z_Z1817: FDE port map (
    Q => R_TXFIFO_7(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q25z_Z1818: FDE port map (
    Q => R_TXFIFO_7(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q26z_Z1819: FDE port map (
    Q => R_TXFIFO_7(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q27z_Z1820: FDE port map (
    Q => R_TXFIFO_7(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q28z_Z1821: FDE port map (
    Q => R_TXFIFO_7(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q29z_Z1822: FDE port map (
    Q => R_TXFIFO_7(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q30z_Z1823: FDE port map (
    Q => R_TXFIFO_7(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q1z_Z1824: FDE port map (
    Q => R_TXFIFO_7(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q2z_Z1825: FDE port map (
    Q => R_TXFIFO_7(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q3z_Z1826: FDE port map (
    Q => R_TXFIFO_7(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q4z_Z1827: FDE port map (
    Q => R_TXFIFO_7(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q5z_Z1828: FDE port map (
    Q => R_TXFIFO_7(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q6z_Z1829: FDE port map (
    Q => R_TXFIFO_7(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q7z_Z1830: FDE port map (
    Q => R_TXFIFO_7(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q8z_Z1831: FDE port map (
    Q => R_TXFIFO_7(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q9z_Z1832: FDE port map (
    Q => R_TXFIFO_7(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q10z_Z1833: FDE port map (
    Q => R_TXFIFO_7(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q11z_Z1834: FDE port map (
    Q => R_TXFIFO_7(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q12z_Z1835: FDE port map (
    Q => R_TXFIFO_7(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q13z_Z1836: FDE port map (
    Q => R_TXFIFO_7(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q14z_Z1837: FDE port map (
    Q => R_TXFIFO_7(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_7q15z_Z1838: FDE port map (
    Q => R_TXFIFO_7(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1(2));
R_TXFIFO_6q18z_Z1839: FDE port map (
    Q => R_TXFIFO_6(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q19z_Z1840: FDE port map (
    Q => R_TXFIFO_6(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q20z_Z1841: FDE port map (
    Q => R_TXFIFO_6(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q21z_Z1842: FDE port map (
    Q => R_TXFIFO_6(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q22z_Z1843: FDE port map (
    Q => R_TXFIFO_6(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q23z_Z1844: FDE port map (
    Q => R_TXFIFO_6(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q24z_Z1845: FDE port map (
    Q => R_TXFIFO_6(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q25z_Z1846: FDE port map (
    Q => R_TXFIFO_6(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q26z_Z1847: FDE port map (
    Q => R_TXFIFO_6(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q27z_Z1848: FDE port map (
    Q => R_TXFIFO_6(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q28z_Z1849: FDE port map (
    Q => R_TXFIFO_6(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q29z_Z1850: FDE port map (
    Q => R_TXFIFO_6(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q30z_Z1851: FDE port map (
    Q => R_TXFIFO_6(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q31z_Z1852: FDE port map (
    Q => R_TXFIFO_6(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q3z_Z1853: FDE port map (
    Q => R_TXFIFO_6(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q4z_Z1854: FDE port map (
    Q => R_TXFIFO_6(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q5z_Z1855: FDE port map (
    Q => R_TXFIFO_6(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q6z_Z1856: FDE port map (
    Q => R_TXFIFO_6(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q7z_Z1857: FDE port map (
    Q => R_TXFIFO_6(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q8z_Z1858: FDE port map (
    Q => R_TXFIFO_6(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q9z_Z1859: FDE port map (
    Q => R_TXFIFO_6(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q10z_Z1860: FDE port map (
    Q => R_TXFIFO_6(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q11z_Z1861: FDE port map (
    Q => R_TXFIFO_6(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q12z_Z1862: FDE port map (
    Q => R_TXFIFO_6(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q13z_Z1863: FDE port map (
    Q => R_TXFIFO_6(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q14z_Z1864: FDE port map (
    Q => R_TXFIFO_6(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q15z_Z1865: FDE port map (
    Q => R_TXFIFO_6(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q16z_Z1866: FDE port map (
    Q => R_TXFIFO_6(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q17z_Z1867: FDE port map (
    Q => R_TXFIFO_6(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_5q20z_Z1868: FDE port map (
    Q => R_TXFIFO_5(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q21z_Z1869: FDE port map (
    Q => R_TXFIFO_5(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q22z_Z1870: FDE port map (
    Q => R_TXFIFO_5(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q23z_Z1871: FDE port map (
    Q => R_TXFIFO_5(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q24z_Z1872: FDE port map (
    Q => R_TXFIFO_5(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q25z_Z1873: FDE port map (
    Q => R_TXFIFO_5(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q26z_Z1874: FDE port map (
    Q => R_TXFIFO_5(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q27z_Z1875: FDE port map (
    Q => R_TXFIFO_5(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q28z_Z1876: FDE port map (
    Q => R_TXFIFO_5(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q29z_Z1877: FDE port map (
    Q => R_TXFIFO_5(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q30z_Z1878: FDE port map (
    Q => R_TXFIFO_5(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q31z_Z1879: FDE port map (
    Q => R_TXFIFO_5(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_6q1z_Z1880: FDE port map (
    Q => R_TXFIFO_6(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_6q2z_Z1881: FDE port map (
    Q => R_TXFIFO_6(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_0(2));
R_TXFIFO_5q5z_Z1882: FDE port map (
    Q => R_TXFIFO_5(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q6z_Z1883: FDE port map (
    Q => R_TXFIFO_5(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q7z_Z1884: FDE port map (
    Q => R_TXFIFO_5(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q8z_Z1885: FDE port map (
    Q => R_TXFIFO_5(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q9z_Z1886: FDE port map (
    Q => R_TXFIFO_5(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q10z_Z1887: FDE port map (
    Q => R_TXFIFO_5(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q11z_Z1888: FDE port map (
    Q => R_TXFIFO_5(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q12z_Z1889: FDE port map (
    Q => R_TXFIFO_5(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q13z_Z1890: FDE port map (
    Q => R_TXFIFO_5(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q14z_Z1891: FDE port map (
    Q => R_TXFIFO_5(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q15z_Z1892: FDE port map (
    Q => R_TXFIFO_5(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q16z_Z1893: FDE port map (
    Q => R_TXFIFO_5(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q17z_Z1894: FDE port map (
    Q => R_TXFIFO_5(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q18z_Z1895: FDE port map (
    Q => R_TXFIFO_5(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q19z_Z1896: FDE port map (
    Q => R_TXFIFO_5(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_4q22z_Z1897: FDE port map (
    Q => R_TXFIFO_4(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q23z_Z1898: FDE port map (
    Q => R_TXFIFO_4(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q24z_Z1899: FDE port map (
    Q => R_TXFIFO_4(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q25z_Z1900: FDE port map (
    Q => R_TXFIFO_4(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q26z_Z1901: FDE port map (
    Q => R_TXFIFO_4(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q27z_Z1902: FDE port map (
    Q => R_TXFIFO_4(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q28z_Z1903: FDE port map (
    Q => R_TXFIFO_4(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q29z_Z1904: FDE port map (
    Q => R_TXFIFO_4(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q30z_Z1905: FDE port map (
    Q => R_TXFIFO_4(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q31z_Z1906: FDE port map (
    Q => R_TXFIFO_4(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_5q1z_Z1907: FDE port map (
    Q => R_TXFIFO_5(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q2z_Z1908: FDE port map (
    Q => R_TXFIFO_5(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q3z_Z1909: FDE port map (
    Q => R_TXFIFO_5(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_5q4z_Z1910: FDE port map (
    Q => R_TXFIFO_5(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_1(2));
R_TXFIFO_4q7z_Z1911: FDE port map (
    Q => R_TXFIFO_4(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q8z_Z1912: FDE port map (
    Q => R_TXFIFO_4(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q9z_Z1913: FDE port map (
    Q => R_TXFIFO_4(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q10z_Z1914: FDE port map (
    Q => R_TXFIFO_4(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q11z_Z1915: FDE port map (
    Q => R_TXFIFO_4(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q12z_Z1916: FDE port map (
    Q => R_TXFIFO_4(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q13z_Z1917: FDE port map (
    Q => R_TXFIFO_4(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q14z_Z1918: FDE port map (
    Q => R_TXFIFO_4(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q15z_Z1919: FDE port map (
    Q => R_TXFIFO_4(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q16z_Z1920: FDE port map (
    Q => R_TXFIFO_4(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q17z_Z1921: FDE port map (
    Q => R_TXFIFO_4(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q18z_Z1922: FDE port map (
    Q => R_TXFIFO_4(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q19z_Z1923: FDE port map (
    Q => R_TXFIFO_4(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q20z_Z1924: FDE port map (
    Q => R_TXFIFO_4(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q21z_Z1925: FDE port map (
    Q => R_TXFIFO_4(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_3q24z_Z1926: FDE port map (
    Q => R_TXFIFO_3(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q25z_Z1927: FDE port map (
    Q => R_TXFIFO_3(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q26z_Z1928: FDE port map (
    Q => R_TXFIFO_3(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q27z_Z1929: FDE port map (
    Q => R_TXFIFO_3(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q28z_Z1930: FDE port map (
    Q => R_TXFIFO_3(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q29z_Z1931: FDE port map (
    Q => R_TXFIFO_3(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q30z_Z1932: FDE port map (
    Q => R_TXFIFO_3(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q31z_Z1933: FDE port map (
    Q => R_TXFIFO_3(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_4q1z_Z1934: FDE port map (
    Q => R_TXFIFO_4(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q2z_Z1935: FDE port map (
    Q => R_TXFIFO_4(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q3z_Z1936: FDE port map (
    Q => R_TXFIFO_4(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q4z_Z1937: FDE port map (
    Q => R_TXFIFO_4(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q5z_Z1938: FDE port map (
    Q => R_TXFIFO_4(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_4q6z_Z1939: FDE port map (
    Q => R_TXFIFO_4(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_2(2));
R_TXFIFO_3q9z_Z1940: FDE port map (
    Q => R_TXFIFO_3(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q10z_Z1941: FDE port map (
    Q => R_TXFIFO_3(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q11z_Z1942: FDE port map (
    Q => R_TXFIFO_3(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q12z_Z1943: FDE port map (
    Q => R_TXFIFO_3(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q13z_Z1944: FDE port map (
    Q => R_TXFIFO_3(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q14z_Z1945: FDE port map (
    Q => R_TXFIFO_3(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q15z_Z1946: FDE port map (
    Q => R_TXFIFO_3(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q16z_Z1947: FDE port map (
    Q => R_TXFIFO_3(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q17z_Z1948: FDE port map (
    Q => R_TXFIFO_3(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q18z_Z1949: FDE port map (
    Q => R_TXFIFO_3(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q19z_Z1950: FDE port map (
    Q => R_TXFIFO_3(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q20z_Z1951: FDE port map (
    Q => R_TXFIFO_3(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q21z_Z1952: FDE port map (
    Q => R_TXFIFO_3(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q22z_Z1953: FDE port map (
    Q => R_TXFIFO_3(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q23z_Z1954: FDE port map (
    Q => R_TXFIFO_3(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_2q26z_Z1955: FDE port map (
    Q => R_TXFIFO_2(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q27z_Z1956: FDE port map (
    Q => R_TXFIFO_2(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q28z_Z1957: FDE port map (
    Q => R_TXFIFO_2(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q29z_Z1958: FDE port map (
    Q => R_TXFIFO_2(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q30z_Z1959: FDE port map (
    Q => R_TXFIFO_2(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q31z_Z1960: FDE port map (
    Q => R_TXFIFO_2(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_3q1z_Z1961: FDE port map (
    Q => R_TXFIFO_3(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q2z_Z1962: FDE port map (
    Q => R_TXFIFO_3(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q3z_Z1963: FDE port map (
    Q => R_TXFIFO_3(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q4z_Z1964: FDE port map (
    Q => R_TXFIFO_3(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q5z_Z1965: FDE port map (
    Q => R_TXFIFO_3(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q6z_Z1966: FDE port map (
    Q => R_TXFIFO_3(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q7z_Z1967: FDE port map (
    Q => R_TXFIFO_3(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_3q8z_Z1968: FDE port map (
    Q => R_TXFIFO_3(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_3(2));
R_TXFIFO_2q11z_Z1969: FDE port map (
    Q => R_TXFIFO_2(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q12z_Z1970: FDE port map (
    Q => R_TXFIFO_2(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q13z_Z1971: FDE port map (
    Q => R_TXFIFO_2(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q14z_Z1972: FDE port map (
    Q => R_TXFIFO_2(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q15z_Z1973: FDE port map (
    Q => R_TXFIFO_2(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q16z_Z1974: FDE port map (
    Q => R_TXFIFO_2(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q17z_Z1975: FDE port map (
    Q => R_TXFIFO_2(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q18z_Z1976: FDE port map (
    Q => R_TXFIFO_2(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q19z_Z1977: FDE port map (
    Q => R_TXFIFO_2(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q20z_Z1978: FDE port map (
    Q => R_TXFIFO_2(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q21z_Z1979: FDE port map (
    Q => R_TXFIFO_2(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q22z_Z1980: FDE port map (
    Q => R_TXFIFO_2(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q23z_Z1981: FDE port map (
    Q => R_TXFIFO_2(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q24z_Z1982: FDE port map (
    Q => R_TXFIFO_2(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q25z_Z1983: FDE port map (
    Q => R_TXFIFO_2(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_1q28z_Z1984: FDE port map (
    Q => R_TXFIFO_1(28),
    D => COMB_V_TXFIFO_0_5_0(28),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q29z_Z1985: FDE port map (
    Q => R_TXFIFO_1(29),
    D => COMB_V_TXFIFO_0_5_0(29),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q30z_Z1986: FDE port map (
    Q => R_TXFIFO_1(30),
    D => COMB_V_TXFIFO_0_5_0(30),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q31z_Z1987: FDE port map (
    Q => R_TXFIFO_1(31),
    D => COMB_V_TXFIFO_0_5_0(31),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_2q1z_Z1988: FDE port map (
    Q => R_TXFIFO_2(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q2z_Z1989: FDE port map (
    Q => R_TXFIFO_2(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q3z_Z1990: FDE port map (
    Q => R_TXFIFO_2(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q4z_Z1991: FDE port map (
    Q => R_TXFIFO_2(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q5z_Z1992: FDE port map (
    Q => R_TXFIFO_2(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q6z_Z1993: FDE port map (
    Q => R_TXFIFO_2(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q7z_Z1994: FDE port map (
    Q => R_TXFIFO_2(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q8z_Z1995: FDE port map (
    Q => R_TXFIFO_2(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q9z_Z1996: FDE port map (
    Q => R_TXFIFO_2(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_2q10z_Z1997: FDE port map (
    Q => R_TXFIFO_2(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_4(2));
R_TXFIFO_1q13z_Z1998: FDE port map (
    Q => R_TXFIFO_1(13),
    D => COMB_V_TXFIFO_0_5_0(13),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q14z_Z1999: FDE port map (
    Q => R_TXFIFO_1(14),
    D => COMB_V_TXFIFO_0_5_0(14),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q15z_Z2000: FDE port map (
    Q => R_TXFIFO_1(15),
    D => COMB_V_TXFIFO_0_5_0(15),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q16z_Z2001: FDE port map (
    Q => R_TXFIFO_1(16),
    D => COMB_V_TXFIFO_0_5_0(16),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q17z_Z2002: FDE port map (
    Q => R_TXFIFO_1(17),
    D => COMB_V_TXFIFO_0_5_0(17),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q18z_Z2003: FDE port map (
    Q => R_TXFIFO_1(18),
    D => COMB_V_TXFIFO_0_5_0(18),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q19z_Z2004: FDE port map (
    Q => R_TXFIFO_1(19),
    D => COMB_V_TXFIFO_0_5_0(19),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q20z_Z2005: FDE port map (
    Q => R_TXFIFO_1(20),
    D => COMB_V_TXFIFO_0_5_0(20),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q21z_Z2006: FDE port map (
    Q => R_TXFIFO_1(21),
    D => COMB_V_TXFIFO_0_5_0(21),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q22z_Z2007: FDE port map (
    Q => R_TXFIFO_1(22),
    D => COMB_V_TXFIFO_0_5_0(22),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q23z_Z2008: FDE port map (
    Q => R_TXFIFO_1(23),
    D => COMB_V_TXFIFO_0_5_0(23),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q24z_Z2009: FDE port map (
    Q => R_TXFIFO_1(24),
    D => COMB_V_TXFIFO_0_5_0(24),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q25z_Z2010: FDE port map (
    Q => R_TXFIFO_1(25),
    D => COMB_V_TXFIFO_0_5_0(25),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q26z_Z2011: FDE port map (
    Q => R_TXFIFO_1(26),
    D => COMB_V_TXFIFO_0_5_0(26),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q27z_Z2012: FDE port map (
    Q => R_TXFIFO_1(27),
    D => COMB_V_TXFIFO_0_5_0(27),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q1z_Z2013: FDE port map (
    Q => R_TXFIFO_1(1),
    D => COMB_V_TXFIFO_0_5_0(1),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q2z_Z2014: FDE port map (
    Q => R_TXFIFO_1(2),
    D => COMB_V_TXFIFO_0_5_0(2),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q3z_Z2015: FDE port map (
    Q => R_TXFIFO_1(3),
    D => COMB_V_TXFIFO_0_5_0(3),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q4z_Z2016: FDE port map (
    Q => R_TXFIFO_1(4),
    D => COMB_V_TXFIFO_0_5_0(4),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q5z_Z2017: FDE port map (
    Q => R_TXFIFO_1(5),
    D => COMB_V_TXFIFO_0_5_0(5),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q6z_Z2018: FDE port map (
    Q => R_TXFIFO_1(6),
    D => COMB_V_TXFIFO_0_5_0(6),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q7z_Z2019: FDE port map (
    Q => R_TXFIFO_1(7),
    D => COMB_V_TXFIFO_0_5_0(7),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q8z_Z2020: FDE port map (
    Q => R_TXFIFO_1(8),
    D => COMB_V_TXFIFO_0_5_0(8),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q9z_Z2021: FDE port map (
    Q => R_TXFIFO_1(9),
    D => COMB_V_TXFIFO_0_5_0(9),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q10z_Z2022: FDE port map (
    Q => R_TXFIFO_1(10),
    D => COMB_V_TXFIFO_0_5_0(10),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q11z_Z2023: FDE port map (
    Q => R_TXFIFO_1(11),
    D => COMB_V_TXFIFO_0_5_0(11),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_TXFIFO_1q12z_Z2024: FDE port map (
    Q => R_TXFIFO_1(12),
    D => COMB_V_TXFIFO_0_5_0(12),
    C => clk,
    CE => R_TDLI_RNIJFCB1_5(2));
R_RXDq19z_Z2025: FDE port map (
    Q => R_RXD(19),
    D => R_RXD(18),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq20z_Z2026: FDE port map (
    Q => R_RXD(20),
    D => R_RXD(19),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq21z_Z2027: FDE port map (
    Q => R_RXD(21),
    D => R_RXD(20),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq22z_Z2028: FDE port map (
    Q => R_RXD(22),
    D => R_RXD(21),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq23z_Z2029: FDE port map (
    Q => R_RXD(23),
    D => R_RXD(22),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq24z_Z2030: FDE port map (
    Q => R_RXD(24),
    D => R_RXD(23),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq25z_Z2031: FDE port map (
    Q => R_RXD(25),
    D => R_RXD(24),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq26z_Z2032: FDE port map (
    Q => R_RXD(26),
    D => R_RXD(25),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq27z_Z2033: FDE port map (
    Q => R_RXD(27),
    D => R_RXD(26),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq28z_Z2034: FDE port map (
    Q => R_RXD(28),
    D => R_RXD(27),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq29z_Z2035: FDE port map (
    Q => R_RXD(29),
    D => R_RXD(28),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq30z_Z2036: FDE port map (
    Q => R_RXD(30),
    D => R_RXD(29),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq31z_Z2037: FDE port map (
    Q => R_RXD(31),
    D => R_RXD(30),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq4z_Z2038: FDE port map (
    Q => R_RXD(4),
    D => R_RXD(3),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq5z_Z2039: FDE port map (
    Q => R_RXD(5),
    D => R_RXD(4),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq6z_Z2040: FDE port map (
    Q => R_RXD(6),
    D => R_RXD(5),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq7z_Z2041: FDE port map (
    Q => R_RXD(7),
    D => R_RXD(6),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq8z_Z2042: FDE port map (
    Q => R_RXD(8),
    D => R_RXD(7),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq9z_Z2043: FDE port map (
    Q => R_RXD(9),
    D => R_RXD(8),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq10z_Z2044: FDE port map (
    Q => R_RXD(10),
    D => R_RXD(9),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq11z_Z2045: FDE port map (
    Q => R_RXD(11),
    D => R_RXD(10),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq12z_Z2046: FDE port map (
    Q => R_RXD(12),
    D => R_RXD(11),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq13z_Z2047: FDE port map (
    Q => R_RXD(13),
    D => R_RXD(12),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq14z_Z2048: FDE port map (
    Q => R_RXD(14),
    D => R_RXD(13),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq15z_Z2049: FDE port map (
    Q => R_RXD(15),
    D => R_RXD(14),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq16z_Z2050: FDE port map (
    Q => R_RXD(16),
    D => R_RXD(15),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq17z_Z2051: FDE port map (
    Q => R_RXD(17),
    D => R_RXD(16),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq18z_Z2052: FDE port map (
    Q => R_RXD(18),
    D => R_RXD(17),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RDq27z_Z2053: FDE port map (
    Q => R_RD(27),
    D => COMB_V_RD_3(27),
    C => clk,
    CE => COMB_V_RD4);
R_RDq28z_Z2054: FDE port map (
    Q => R_RD(28),
    D => COMB_V_RD_3(28),
    C => clk,
    CE => COMB_V_RD4);
R_RDq29z_Z2055: FDE port map (
    Q => R_RD(29),
    D => COMB_V_RD_3(29),
    C => clk,
    CE => COMB_V_RD4);
R_RDq30z_Z2056: FDE port map (
    Q => R_RD(30),
    D => COMB_V_RD_3(30),
    C => clk,
    CE => COMB_V_RD4);
R_RDq31z_Z2057: FDE port map (
    Q => R_RD(31),
    D => COMB_V_RD_3(31),
    C => clk,
    CE => COMB_V_RD4);
R_RXDq0z_Z2058: FDE port map (
    Q => R_RXD(0),
    D => COMB_INDATA_1,
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq1z_Z2059: FDE port map (
    Q => R_RXD(1),
    D => R_RXD(0),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq2z_Z2060: FDE port map (
    Q => R_RXD(2),
    D => R_RXD(1),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RXDq3z_Z2061: FDE port map (
    Q => R_RXD(3),
    D => R_RXD(2),
    C => clk,
    CE => COMB_UN1_R_SYNCSAMP_0_I);
R_RDq12z_Z2062: FDE port map (
    Q => R_RD(12),
    D => COMB_V_RD_3(12),
    C => clk,
    CE => COMB_V_RD4);
R_RDq13z_Z2063: FDE port map (
    Q => R_RD(13),
    D => COMB_V_RD_3(13),
    C => clk,
    CE => COMB_V_RD4);
R_RDq14z_Z2064: FDE port map (
    Q => R_RD(14),
    D => COMB_V_RD_3(14),
    C => clk,
    CE => COMB_V_RD4);
R_RDq15z_Z2065: FDE port map (
    Q => R_RD(15),
    D => COMB_V_RD_3(15),
    C => clk,
    CE => COMB_V_RD4);
R_RDq16z_Z2066: FDE port map (
    Q => R_RD(16),
    D => COMB_V_RD_3(16),
    C => clk,
    CE => COMB_V_RD4);
R_RDq17z_Z2067: FDE port map (
    Q => R_RD(17),
    D => COMB_V_RD_3(17),
    C => clk,
    CE => COMB_V_RD4);
R_RDq18z_Z2068: FDE port map (
    Q => R_RD(18),
    D => COMB_V_RD_3(18),
    C => clk,
    CE => COMB_V_RD4);
R_RDq19z_Z2069: FDE port map (
    Q => R_RD(19),
    D => COMB_V_RD_3(19),
    C => clk,
    CE => COMB_V_RD4);
R_RDq20z_Z2070: FDE port map (
    Q => R_RD(20),
    D => COMB_V_RD_3(20),
    C => clk,
    CE => COMB_V_RD4);
R_RDq21z_Z2071: FDE port map (
    Q => R_RD(21),
    D => COMB_V_RD_3(21),
    C => clk,
    CE => COMB_V_RD4);
R_RDq22z_Z2072: FDE port map (
    Q => R_RD(22),
    D => COMB_V_RD_3(22),
    C => clk,
    CE => COMB_V_RD4);
R_RDq23z_Z2073: FDE port map (
    Q => R_RD(23),
    D => COMB_V_RD_3(23),
    C => clk,
    CE => COMB_V_RD4);
R_RDq24z_Z2074: FDE port map (
    Q => R_RD(24),
    D => COMB_V_RD_3(24),
    C => clk,
    CE => COMB_V_RD4);
R_RDq25z_Z2075: FDE port map (
    Q => R_RD(25),
    D => COMB_V_RD_3(25),
    C => clk,
    CE => COMB_V_RD4);
R_RDq26z_Z2076: FDE port map (
    Q => R_RD(26),
    D => COMB_V_RD_3(26),
    C => clk,
    CE => COMB_V_RD4);
R_RDq0z_Z2077: FDE port map (
    Q => R_RD(0),
    D => COMB_V_RD_3(0),
    C => clk,
    CE => COMB_V_RD4);
R_RDq1z_Z2078: FDE port map (
    Q => R_RD(1),
    D => COMB_V_RD_3(1),
    C => clk,
    CE => COMB_V_RD4);
R_RDq2z_Z2079: FDE port map (
    Q => R_RD(2),
    D => COMB_V_RD_3(2),
    C => clk,
    CE => COMB_V_RD4);
R_RDq3z_Z2080: FDE port map (
    Q => R_RD(3),
    D => COMB_V_RD_3(3),
    C => clk,
    CE => COMB_V_RD4);
R_RDq4z_Z2081: FDE port map (
    Q => R_RD(4),
    D => COMB_V_RD_3(4),
    C => clk,
    CE => COMB_V_RD4);
R_RDq5z_Z2082: FDE port map (
    Q => R_RD(5),
    D => COMB_V_RD_3(5),
    C => clk,
    CE => COMB_V_RD4);
R_RDq6z_Z2083: FDE port map (
    Q => R_RD(6),
    D => COMB_V_RD_3(6),
    C => clk,
    CE => COMB_V_RD4);
R_RDq7z_Z2084: FDE port map (
    Q => R_RD(7),
    D => COMB_V_RD_3(7),
    C => clk,
    CE => COMB_V_RD4);
R_RDq8z_Z2085: FDE port map (
    Q => R_RD(8),
    D => COMB_V_RD_3(8),
    C => clk,
    CE => COMB_V_RD4);
R_RDq9z_Z2086: FDE port map (
    Q => R_RD(9),
    D => COMB_V_RD_3(9),
    C => clk,
    CE => COMB_V_RD4);
R_RDq10z_Z2087: FDE port map (
    Q => R_RD(10),
    D => COMB_V_RD_3(10),
    C => clk,
    CE => COMB_V_RD4);
R_RDq11z_Z2088: FDE port map (
    Q => R_RD(11),
    D => COMB_V_RD_3(11),
    C => clk,
    CE => COMB_V_RD4);
R_OV2_Z2089: FD port map (
    Q => R_OV2,
    D => R_OV,
    C => clk);
R_RXDONE_Z2090: FD port map (
    Q => R_RXDONE,
    D => COMB_V_RXDONE_2_0_I,
    C => clk);
R_SPIO_ENABLE: FD port map (
    Q => spio_enable,
    D => R_MODE_EN,
    C => clk);
R_TOGGLE_Z2092: FD port map (
    Q => R_TOGGLE,
    D => V_TOGGLE_0_SQMUXA,
    C => clk);
R_SPII_0_SPISEL_Z2093: FD port map (
    Q => R_SPII_0_SPISEL,
    D => spii_spisel,
    C => clk);
R_SPII_1_MISO_Z2094: FD port map (
    Q => R_SPII_1_MISO,
    D => R_SPII_0_MISO,
    C => clk);
R_SPII_1_MOSI_Z2095: FD port map (
    Q => R_SPII_1_MOSI,
    D => R_SPII_0_MOSI,
    C => clk);
R_SPII_1_SCK_Z2096: FD port map (
    Q => R_SPII_1_SCK,
    D => R_SPII_0_SCK,
    C => clk);
R_SPII_1_SPISEL_Z2097: FD port map (
    Q => R_SPII_1_SPISEL,
    D => R_SPII_0_SPISEL,
    C => clk);
R_SPII_0_MISO_Z2098: FD port map (
    Q => R_SPII_0_MISO,
    D => spii_miso,
    C => clk);
R_SPII_0_MOSI_Z2099: FD port map (
    Q => R_SPII_0_MOSI,
    D => spii_mosi,
    C => clk);
R_SPII_0_SCK_Z2100: FD port map (
    Q => R_SPII_0_SCK,
    D => spii_sck,
    C => clk);
R_SPII_1_SPISEL_FAST_Z2101: FD port map (
    Q => R_SPII_1_SPISEL_FAST,
    D => R_SPII_0_SPISEL,
    C => clk);
R_SPII_1_SCK_FAST_Z2102: FD port map (
    Q => R_SPII_1_SCK_FAST,
    D => R_SPII_0_SCK,
    C => clk);
SAMPLE_0_SQMUXA_1_RNIKIJBC: LUT4 
generic map(
  INIT => X"2022"
)
port map (
  I0 => UN1_V_TXFIFO_76_3_N_13,
  I1 => SAMPLE_0_SQMUXA_2,
  I2 => G3_SX,
  I3 => COMB_CHANGE_4_1,
  O => UN1_V_TXFIFO_76_3_N_14);
R_LST_RNO_0_Z2104: LUT4 
generic map(
  INIT => X"80FF"
)
port map (
  I0 => G2_1_3,
  I1 => apbi_pwrite,
  I2 => apbi_paddr(2),
  I3 => N_2126_0,
  O => R_LST_RNO_0);
V_SLVSEL_1_SQMUXA_Z2105: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_UN21_APBI_PSEL,
  I1 => apbi_pwrite,
  I2 => apbi_psel,
  I3 => apbi_penable,
  O => V_SLVSEL_1_SQMUXA);
V_EVENT_LT_1_SQMUXA_Z2106: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_UN9_APBI_PSEL,
  I1 => apbi_pwrite,
  I2 => apbi_psel,
  I3 => apbi_penable,
  O => V_EVENT_LT_1_SQMUXA);
APBOUT_6_SQMUXA_Z2107: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_UN21_APBI_PSEL,
  I1 => apbi_pwrite,
  I2 => apbi_psel,
  I3 => apbi_penable,
  O => APBOUT_6_SQMUXA);
APBOUT_2_SQMUXA_Z2108: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_UN9_APBI_PSEL,
  I1 => apbi_pwrite,
  I2 => apbi_psel,
  I3 => apbi_penable,
  O => APBOUT_2_SQMUXA);
UN1_RELOAD_SNq3z_Z2109: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_FACT,
  I1 => R_MODE_DIV16,
  O => UN1_RELOAD_SN(3));
UN1_RELOAD_RNq3z: LUT4 
generic map(
  INIT => X"CACC"
)
port map (
  I0 => UN1_RELOAD_BM(3),
  I1 => N_634,
  I2 => R_MODE_FACT,
  I3 => R_MODE_DIV16,
  O => UN1_RELOAD_RN_0(3));
COMB_UN17_APBI_PSEL_2_Z2111: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => apbi_paddr(5),
  I1 => apbi_paddr(3),
  I2 => apbi_paddr(7),
  I3 => apbi_paddr(6),
  O => COMB_UN17_APBI_PSEL_2);
COMB_UN13_APBI_PSEL_2_Z2112: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => apbi_paddr(4),
  I1 => apbi_paddr(2),
  I2 => apbi_paddr(7),
  I3 => apbi_paddr(6),
  O => COMB_UN13_APBI_PSEL_2);
V_RUNNING_0_SQMUXA_1_0_1_Z2113: LUT4 
generic map(
  INIT => X"56AA"
)
port map (
  I0 => R_TD_OCC,
  I1 => R_TFREECNT(1),
  I2 => R_TFREECNT(0),
  I3 => R_TD_OCC_FAST,
  O => V_RUNNING_0_SQMUXA_1_0_1);
UN1_RELOAD_MBq3z_Z2114: LUT4 
generic map(
  INIT => X"AC0C"
)
port map (
  I0 => UN1_R_DIVCNT_1_S_5,
  I1 => UN1_RELOAD_RN_0(3),
  I2 => UN1_RELOAD_SN(3),
  I3 => V_DIVCNT_1_SQMUXA,
  O => UN1_RELOAD_MB(3));
R_MODE_MS_REP1_RNIKCIQ1: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_SPII_1_SPISEL_FAST_RNI8IOA1,
  I1 => R_MODE_MS_REP1,
  O => SAMPLE_0_SQMUXA_2);
R_DIVCNT_FAST_RNISD123q0z: LUT4 
generic map(
  INIT => X"FFF7"
)
port map (
  I0 => R_DIVCNT_FAST_RNIFJP41(6),
  I1 => R_DIVCNT_FAST_RNI5BO41(3),
  I2 => R_DIVCNT_FAST(0),
  I3 => R_DIVCNT_FAST(2),
  O => G0_1_0);
R_DIVCNT_FAST_RNI5BO41q3z_Z2117: LUT3 
generic map(
  INIT => X"01"
)
port map (
  I0 => R_DIVCNT_FAST(3),
  I1 => R_DIVCNT_FAST(4),
  I2 => R_DIVCNT_FAST(5),
  O => R_DIVCNT_FAST_RNI5BO41(3));
SAMPLE_0_SQMUXA_1_RNIRR151: LUT4 
generic map(
  INIT => X"45CF"
)
port map (
  I0 => COMB_SLV_START_UN13_AM_EN,
  I1 => COMB_UN30_AM_EN,
  I2 => R_MODE_MS_FAST,
  I3 => SAMPLE_0_SQMUXA_1,
  O => G3_SX);
R_SPII_1_SPISEL_FAST_RNI8IOA1_Z2119: LUT4_L 
generic map(
  INIT => X"0028"
)
port map (
  I0 => R_MODE_EN_FAST,
  I1 => R_PSCK,
  I2 => R_SPII_1_SCK,
  I3 => R_SPII_1_SPISEL_FAST,
  LO => R_SPII_1_SPISEL_FAST_RNI8IOA1);
R_CGCNT_RNIDPPC2q2z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => G0_21_SX,
  I1 => R_CGCNT(0),
  I2 => R_CGCNT(2),
  I3 => R_CGCNT(3),
  O => COMB_OP_EQ_UN2_ASEL_EN);
R_LST_RNO: MUXF5 port map (
    I0 => R_LST_RNO_0,
    I1 => R_LST_RNO_1,
    S => G2,
    O => V_LST_1_SQMUXA_1_I);
R_LST_RNO_1_Z2122: LUT4 
generic map(
  INIT => X"CCCE"
)
port map (
  I0 => COMB_V_EVENT_LT6_3_1,
  I1 => G0_0_0,
  I2 => UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81,
  I3 => UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2,
  O => R_LST_RNO_1);
R_RBITCNT_LM_0q0z: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_2146_0,
  I1 => R_RBITCNT(0),
  LO => R_RBITCNT_LM(0));
R_TBITCNT_LM_0_1q0z_Z2124: LUT3 
generic map(
  INIT => X"07"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_MODE_CPHA,
  I2 => TINDEX_1_SQMUXA,
  O => R_TBITCNT_LM_0_1(0));
V_RUNNING_0_SQMUXA_1_0_Z2125: LUT4 
generic map(
  INIT => X"100B"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_V_TFREECNT_30(1),
  I2 => R_TFREECNT(2),
  I3 => V_RUNNING_0_SQMUXA_1_0_1,
  O => V_RUNNING_0_SQMUXA_1_0);
R_IRQD_RNO: LUT4_L 
generic map(
  INIT => X"EAFF"
)
port map (
  I0 => COMB_UN1_R_MODE_EN_2,
  I1 => COMB_V_IRQ_1_IV_N_7_I_MB_1,
  I2 => COMB_V_IRQ_1_IV_M1_E_0,
  I3 => COMB_V_IRQ_1_IV_M6_2,
  LO => COMB_V_IRQ_1_IV_N_7_I);
R_IRQD_RNO_0: LUT3_L 
generic map(
  INIT => X"02"
)
port map (
  I0 => COMB_V_EVENT_LT6_3_1,
  I1 => UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81,
  I2 => UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2,
  LO => COMB_V_IRQ_1_IV_N_7_I_MB_1);
R_DIVCNT_FAST_RNIFJP41q6z_Z2128: LUT3 
generic map(
  INIT => X"01"
)
port map (
  I0 => R_DIVCNT_FAST(6),
  I1 => R_DIVCNT_FAST(7),
  I2 => R_DIVCNT_FAST(9),
  O => R_DIVCNT_FAST_RNIFJP41(6));
R_CGCNT_RNIP6D61q1z: LUT3_L 
generic map(
  INIT => X"FE"
)
port map (
  I0 => R_CGCNT(1),
  I1 => R_CGCNT(4),
  I2 => R_CGCNT(5),
  LO => G0_21_SX);
UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2_Z2130: MUXF5 port map (
    I0 => R_TFREECNT_RNIET94S_0(2),
    I1 => R_TFREECNT_RNI1CS691_0(0),
    S => UN1_V_TXFIFO_76_0_I(3),
    O => UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2);
R_TFREECNT_RNI1CS691_0q0z_Z2131: LUT4 
generic map(
  INIT => X"A96A"
)
port map (
  I0 => R_TFREECNT_RNI26HMD(2),
  I1 => R_TFREECNT_RNI78IID(1),
  I2 => R_TFREECNT_RNIJEI2D(0),
  I3 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  O => R_TFREECNT_RNI1CS691_0(0));
R_TFREECNT_RNIET94S_0q2z_Z2132: LUT3 
generic map(
  INIT => X"9A"
)
port map (
  I0 => R_TFREECNT_RNI26HMD(2),
  I1 => R_TFREECNT_RNI78IID(1),
  I2 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  O => R_TFREECNT_RNIET94S_0(2));
UN1_V_TXFIFO_76_2_B0_0_O5_RNO_1: LUT4_L 
generic map(
  INIT => X"7FFF"
)
port map (
  I0 => UN1_V_TXFIFO_76_2_B0_0_O5_RNO_2,
  I1 => COMB_OP_EQ_V_SPIO_SCK2_5,
  I2 => COMB_OP_EQ_V_SPIO_SCK2_6,
  I3 => R_MODE_MS_FAST,
  LO => UN1_V_TXFIFO_76_3_M9_I_O5_0);
UN1_V_TXFIFO_76_2_B0_0_O5_RNO_2_Z2134: LUT3 
generic map(
  INIT => X"10"
)
port map (
  I0 => R_DIVCNT_FAST(1),
  I1 => R_DIVCNT_FAST(8),
  I2 => R_RUNNING_FAST,
  O => UN1_V_TXFIFO_76_2_B0_0_O5_RNO_2);
COMB_V_EVENT_LT6_3_1_RNIR4SMU2: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => COMB_V_EVENT_LT6_3_1,
  I1 => G0_9_SX,
  I2 => UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81,
  O => COMB_V_LST_1_1);
R_TFREECNT_RNI53B6M1q2z: LUT4_L 
generic map(
  INIT => X"C96C"
)
port map (
  I0 => G0_0_A3_0_0,
  I1 => R_TFREECNT_RNI26HMD(2),
  I2 => R_TFREECNT_RNI78IID(1),
  I3 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  LO => G0_9_SX);
UN1_V_TXFIFO_76_2_B0_0_O5_Z2137: LUT4 
generic map(
  INIT => X"FF13"
)
port map (
  I0 => UN1_V_TXFIFO_76_2_B0_0_O5_RNO,
  I1 => COMB_UN6_ASEL_EN,
  I2 => G0_21_1,
  I3 => UN1_V_TXFIFO_76_3_M9_I_O5_0,
  O => UN1_V_TXFIFO_76_2_B0_0_O5);
UN1_V_TXFIFO_76_2_B0_0_O5_RNO_Z2138: LUT3 
generic map(
  INIT => X"01"
)
port map (
  I0 => R_CGCNT(0),
  I1 => R_CGCNT(2),
  I2 => R_CGCNT(3),
  O => UN1_V_TXFIFO_76_2_B0_0_O5_RNO);
UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2_0: MUXF5 port map (
    I0 => R_TFREECNT_RNIET94S(2),
    I1 => R_TFREECNT_RNI1CS691(0),
    S => UN1_V_TXFIFO_76_0_I(3),
    O => UN1_R_TFREECNT_1_P7);
R_TFREECNT_RNI1CS691q0z_Z2140: LUT4 
generic map(
  INIT => X"FE80"
)
port map (
  I0 => R_TFREECNT_RNI26HMD(2),
  I1 => R_TFREECNT_RNI78IID(1),
  I2 => R_TFREECNT_RNIJEI2D(0),
  I3 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  O => R_TFREECNT_RNI1CS691(0));
R_TFREECNT_RNIET94Sq2z_Z2141: LUT3 
generic map(
  INIT => X"E0"
)
port map (
  I0 => R_TFREECNT_RNI26HMD(2),
  I1 => R_TFREECNT_RNI78IID(1),
  I2 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  O => R_TFREECNT_RNIET94S(2));
R_DIVCNT_FASTq8z_Z2142: FDR port map (
    Q => R_DIVCNT_FAST(8),
    D => COMB_V_DIVCNT_1_FAST(8),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq8z_Z2143: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_801,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(8),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8,
  LO => COMB_V_DIVCNT_1_FAST(8));
R_DIVCNT_FASTq1z_Z2144: FDR port map (
    Q => R_DIVCNT_FAST(1),
    D => COMB_V_DIVCNT_1_FAST(1),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq1z_Z2145: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_792,
  I1 => N_801,
  I2 => R_MODE_PM(1),
  LO => COMB_V_DIVCNT_1_FAST(1));
R_SPIO_SCK_FAST_Z2146: FDRE port map (
    Q => R_SPIO_SCK_FAST,
    D => REG_R_SPIO_SCK_3_FAST,
    C => clk,
    R => RSTN_I,
    CE => V_SPIO_SCK_1_SQMUXA_I);
REG_R_SPIO_SCK_3_FAST_Z2147: LUT3_L 
generic map(
  INIT => X"2E"
)
port map (
  I0 => R_MODE_CPOL,
  I1 => R_RUNNING,
  I2 => R_SPIO_SCK_FAST,
  LO => REG_R_SPIO_SCK_3_FAST);
UN1_V_TXFIFO_76_2_B0_0_O5_RNO_0: LUT3 
generic map(
  INIT => X"01"
)
port map (
  I0 => R_CGCNT(1),
  I1 => R_CGCNT(4),
  I2 => R_CGCNT(5),
  O => G0_21_1);
R_CGCNT_RNINEVP2q5z: LUT4 
generic map(
  INIT => X"CCCE"
)
port map (
  I0 => G0_5_3,
  I1 => G2_0_1,
  I2 => R_CGCNT(0),
  I3 => R_CGCNT(5),
  O => G2_0);
R_SPIO_SCK_FAST_RNIAL5D: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_CPOL,
  I1 => R_SPIO_SCK_FAST,
  LO => G2_0_1);
R_LST_RNO_2: LUT4 
generic map(
  INIT => X"2DB4"
)
port map (
  I0 => G2_1_0,
  I1 => R_TFREECNT_RNI78IID(1),
  I2 => UN1_R_TFREECNT_1_AXB3,
  I3 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  O => G2);
R_LST_RNO_4: LUT4 
generic map(
  INIT => X"4DDD"
)
port map (
  I0 => R_TFREECNT_RNI26HMD(2),
  I1 => R_TFREECNT_RNI78IID(1),
  I2 => R_TFREECNT_RNIJEI2D(0),
  I3 => UN1_V_TXFIFO_76_0_I(3),
  O => G2_1_0);
R_TFREECNT_RNI27I51q2z: LUT4 
generic map(
  INIT => X"566A"
)
port map (
  I0 => COMB_V_TFREECNT_AXBXC3_1,
  I1 => COMB_V_TFREECNT_P4,
  I2 => R_TD_OCC_FAST,
  I3 => R_TFREECNT(2),
  O => COMB_V_TFREECNT_30(3));
R_TFREECNT_RNI42FFq3z: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_TD_OCC,
  I1 => R_TFREECNT(3),
  O => COMB_V_TFREECNT_AXBXC3_1);
COMB_V_RUNNING_9_IV: LUT4 
generic map(
  INIT => X"C4CC"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => COMB_V_RUNNING_9_IV_0,
  I2 => COMB_V_RUNNING_9_IV_1,
  I3 => R_SYNCSAMPC_1,
  O => COMB_V_RUNNING_9);
COMB_V_RUNNING_9_IV_1_Z2156: LUT3_L 
generic map(
  INIT => X"7F"
)
port map (
  I0 => COMB_V_TFREECNT_30(3),
  I1 => V_RUNNING_0_SQMUXA_1_0,
  I2 => V_RUNNING_0_SQMUXA_1_4_1,
  LO => COMB_V_RUNNING_9_IV_1);
R_IRQD: LUT4_L 
generic map(
  INIT => X"EAAA"
)
port map (
  I0 => COMB_V_IRQ_1_IV_N_7_I,
  I1 => COMB_V_LST_1_1,
  I2 => R_EVENT_LTD_1,
  I3 => R_IRQD_1,
  LO => R_IRQD_0);
R_IRQD_1_Z2158: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_EVENT_LT,
  I1 => R_MASK_LT,
  O => R_IRQD_1);
R_EVENT_LTD: LUT4_L 
generic map(
  INIT => X"DC50"
)
port map (
  I0 => R_EVENT_LTCE,
  I1 => COMB_V_LST_1_1,
  I2 => R_EVENT_LT,
  I3 => R_EVENT_LTD_1,
  LO => R_EVENT_LTD_0);
R_TFREECNT_RNI78IIDq1z_Z2160: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0_N_13,
  I1 => COMB_UN27_CHANGE,
  I2 => G0_I_M2_0_1,
  I3 => R_TFREECNT(1),
  O => R_TFREECNT_RNI78IID(1));
R_TFREECNT_RNIIER61q1z: LUT4 
generic map(
  INIT => X"0440"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => COMB_V_TFREECNT_30(1),
  I3 => R_TFREECNT(1),
  O => G0_I_M2_0_1);
COMB_UN27_CHANGE_NE: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_UN27_CHANGE_2,
  I1 => COMB_UN27_CHANGE_NE_0,
  I2 => COMB_UN27_CHANGE_NE_1_0,
  O => COMB_UN27_CHANGE);
COMB_UN27_CHANGE_NE_1_0_Z2163: LUT4 
generic map(
  INIT => X"1248"
)
port map (
  I0 => LEN_1_0(1),
  I1 => LEN_1_0(3),
  I2 => R_TBITCNT(1),
  I3 => R_TBITCNT(3),
  O => COMB_UN27_CHANGE_NE_1_0);
R_RUNNING_REP1_Z2164: FDR port map (
    Q => R_RUNNING_REP1,
    D => R_RUNNINGC_REP1,
    C => clk,
    R => R_MODE_EN_I);
R_RUNNINGC_REP1_Z2165: LUT3_L 
generic map(
  INIT => X"08"
)
port map (
  I0 => N_2229,
  I1 => rstn,
  I2 => V_IRQ_0_SQMUXA_1_0,
  LO => R_RUNNINGC_REP1);
R_RUNNING_FAST_Z2166: FDR port map (
    Q => R_RUNNING_FAST,
    D => R_RUNNINGC_FAST,
    C => clk,
    R => R_MODE_EN_I);
R_RUNNINGC_FAST_Z2167: LUT3_L 
generic map(
  INIT => X"08"
)
port map (
  I0 => N_2229,
  I1 => rstn,
  I2 => V_IRQ_0_SQMUXA_1_0,
  LO => R_RUNNINGC_FAST);
R_TD_OCC_FAST_Z2168: FDRE port map (
    Q => R_TD_OCC_FAST,
    D => COMB_V_TXFIFO_76_I_FAST,
    C => clk,
    R => N_2126_0_I,
    CE => V_TD_OCC_0_SQMUXA_I);
R_TD_OCC_FAST_RNO: LUT2_L 
generic map(
  INIT => X"B"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC_FAST,
  LO => COMB_V_TXFIFO_76_I_FAST);
R_MODE_MS_REP1_Z2170: FDRE port map (
    Q => R_MODE_MS_REP1,
    D => COMB_V_MODE_MS_1_REP1,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
COMB_V_MODE_MS_1_REP1_Z2171: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(25),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_MS_1_REP1);
R_MODE_MS_FAST_Z2172: FDRE port map (
    Q => R_MODE_MS_FAST,
    D => COMB_V_MODE_MS_1_FAST,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
COMB_V_MODE_MS_1_FAST_Z2173: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(25),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_MS_1_FAST);
R_MODE_EN_FAST_Z2174: FDRE port map (
    Q => R_MODE_EN_FAST,
    D => COMB_V_MODE_EN_1_FAST,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
COMB_V_MODE_EN_1_FAST_Z2175: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(24),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_EN_1_FAST);
R_DIVCNT_FASTq2z_Z2176: FDR port map (
    Q => R_DIVCNT_FAST(2),
    D => COMB_V_DIVCNT_1_FAST(2),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq2z_Z2177: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_793,
  I1 => N_801,
  I2 => R_MODE_PM(2),
  LO => COMB_V_DIVCNT_1_FAST(2));
R_DIVCNT_FASTq6z_Z2178: FDR port map (
    Q => R_DIVCNT_FAST(6),
    D => COMB_V_DIVCNT_1_FAST(6),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq6z_Z2179: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_797,
  I1 => N_801,
  LO => COMB_V_DIVCNT_1_FAST(6));
R_DIVCNT_FASTq3z_Z2180: FDR port map (
    Q => R_DIVCNT_FAST(3),
    D => COMB_V_DIVCNT_1_FAST(3),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq3z_Z2181: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_794,
  I1 => N_801,
  I2 => R_MODE_PM(3),
  LO => COMB_V_DIVCNT_1_FAST(3));
R_DIVCNT_FASTq9z_Z2182: FDR port map (
    Q => R_DIVCNT_FAST(9),
    D => COMB_V_DIVCNT_1_FAST(9),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq9z_Z2183: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_801,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(9),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9,
  LO => COMB_V_DIVCNT_1_FAST(9));
R_DIVCNT_FASTq4z_Z2184: FDR port map (
    Q => R_DIVCNT_FAST(4),
    D => COMB_V_DIVCNT_1_FAST(4),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq4z_Z2185: LUT4_L 
generic map(
  INIT => X"A8AA"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => R_MODE_DIV16,
  I3 => R_MODE_FACT,
  LO => COMB_V_DIVCNT_1_FAST(4));
R_DIVCNT_FASTq5z_Z2186: FDR port map (
    Q => R_DIVCNT_FAST(5),
    D => COMB_V_DIVCNT_1_FAST(5),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq5z_Z2187: LUT4_L 
generic map(
  INIT => X"A8AA"
)
port map (
  I0 => N_796,
  I1 => COMB_RELOAD_1_0,
  I2 => R_MODE_DIV16,
  I3 => R_MODE_FACT,
  LO => COMB_V_DIVCNT_1_FAST(5));
R_DIVCNT_FASTq7z_Z2188: FDR port map (
    Q => R_DIVCNT_FAST(7),
    D => COMB_V_DIVCNT_1_FAST(7),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq7z_Z2189: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_798,
  I1 => N_801,
  LO => COMB_V_DIVCNT_1_FAST(7));
R_DIVCNT_FASTq0z_Z2190: FDR port map (
    Q => R_DIVCNT_FAST(0),
    D => COMB_V_DIVCNT_1_FAST(0),
    C => clk,
    R => RSTN_I);
COMB_V_DIVCNT_1_FASTq0z_Z2191: LUT4_L 
generic map(
  INIT => X"FB51"
)
port map (
  I0 => N_801,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(0),
  I3 => R_MODE_PM(0),
  LO => COMB_V_DIVCNT_1_FAST(0));
R_TFREECNT_FASTq3z_Z2192: FDS port map (
    Q => R_TFREECNT_FAST(3),
    D => R_EVENT_LTD_1,
    C => clk,
    S => N_2126_0_I);
R_TFREECNT_FASTq1z_Z2193: FDR port map (
    Q => R_TFREECNT_FAST(1),
    D => UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81,
    C => clk,
    R => N_2126_0_I);
R_MODE_LEN_FASTq1z_Z2194: FDRE port map (
    Q => R_MODE_LEN_FAST(1),
    D => apbi_pwdata(21),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_0_REP1_Z2195: FDRE port map (
    Q => R_MODE_LEN_0_REP1,
    D => apbi_pwdata(20),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_FASTq0z_Z2196: FDRE port map (
    Q => R_MODE_LEN_FAST(0),
    D => apbi_pwdata(20),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_FASTq3z_Z2197: FDRE port map (
    Q => R_MODE_LEN_FAST(3),
    D => apbi_pwdata(23),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_2_REP1_Z2198: FDRE port map (
    Q => R_MODE_LEN_2_REP1,
    D => apbi_pwdata(22),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LEN_FASTq2z_Z2199: FDRE port map (
    Q => R_MODE_LEN_FAST(2),
    D => apbi_pwdata(22),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_TFREECNT_FASTq2z_Z2200: FDR port map (
    Q => R_TFREECNT_FAST(2),
    D => UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2,
    C => clk,
    R => N_2126_0_I);
R_MODE_CPOL_FAST_Z2201: FDRE port map (
    Q => R_MODE_CPOL_FAST,
    D => apbi_pwdata(29),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_TFREECNT_FASTq0z_Z2202: FDR port map (
    Q => R_TFREECNT_FAST(0),
    D => UN1_R_TFREECNT_1_AXB0_FAST,
    C => clk,
    R => N_2126_0_I);
UN1_R_TFREECNT_1_AXB0_FAST_Z2203: LUT4_L 
generic map(
  INIT => X"7887"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0,
  I1 => R_TD_OCC,
  I2 => R_TFREECNT_FAST(0),
  I3 => UN1_V_TXFIFO_76_0(3),
  LO => UN1_R_TFREECNT_1_AXB0_FAST);
R_TFREECNT_RNIJEI2Dq0z_Z2204: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0_N_13_0_0_0,
  I1 => COMB_UN27_CHANGE,
  I2 => G1_1,
  I3 => R_TFREECNT(0),
  O => R_TFREECNT_RNIJEI2D(0));
R_CHNG_RNI2ITVB: LUT4_L 
generic map(
  INIT => X"F0E2"
)
port map (
  I0 => G1_0_0,
  I1 => G1_1_1_0,
  I2 => R_CHNG,
  I3 => SAMPLE_0_SQMUXA_2,
  LO => COMB_UN1_R_TFREECNT_S0_N_13_0_0_0);
R_RUNNING_REP1_RNIUNC68: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => G0_2_6_0,
  I1 => G0_2_7_0,
  I2 => G0_2_8_0,
  I3 => G2_0,
  O => G1_1_1_0);
COMB_UN40_CHANGE_RNISOSS: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => R_TD_OCC,
  O => G1_1);
R_RUNNING_REP1_RNIBQSL1: LUT4 
generic map(
  INIT => X"1000"
)
port map (
  I0 => R_DIVCNT(0),
  I1 => R_DIVCNT(1),
  I2 => R_MODE_MS_REP1,
  I3 => R_RUNNING_REP1,
  O => G0_2_8_0);
R_DIVCNT_RNID78R1q3z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(3),
  I1 => R_DIVCNT(4),
  I2 => R_DIVCNT(6),
  I3 => R_DIVCNT(8),
  O => G0_2_7_0);
R_DIVCNT_RNIF78R1q2z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(2),
  I1 => R_DIVCNT(5),
  I2 => R_DIVCNT(7),
  I3 => R_DIVCNT(9),
  O => G0_2_6_0);
R_DIVCNT_RNI278R1q2z: LUT4_L 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(0),
  I1 => R_DIVCNT(2),
  I2 => R_DIVCNT(3),
  I3 => R_DIVCNT(5),
  LO => G1_7_0);
COMB_UN26_AM_EN_RNIQC4N1: LUT4_L 
generic map(
  INIT => X"0400"
)
port map (
  I0 => COMB_UN26_AM_EN_0,
  I1 => G1_0_1_1,
  I2 => R_MODE_CPHA,
  I3 => R_MODE_EN,
  LO => G1_0_0);
R_RUNNING_REP1_RNIUM8O: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_MS_REP1,
  I1 => R_RUNNING_REP1,
  O => G1_0_1_1);
R_RUNNING_REP1_RNII4V0A: LUT4_L 
generic map(
  INIT => X"FF80"
)
port map (
  I0 => G1_8_0,
  I1 => G1_9,
  I2 => G2_0,
  I3 => SAMPLE_0_SQMUXA_2,
  LO => COMB_UN1_R_TFREECNT_S0_N_11);
R_DIVCNT_RNIKEGM3q2z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => G1_6_0,
  I1 => G1_7_0,
  O => G1_9);
R_RUNNING_REP1_RNIJQSL1_0: LUT4 
generic map(
  INIT => X"1000"
)
port map (
  I0 => R_DIVCNT(1),
  I1 => R_DIVCNT(8),
  I2 => R_MODE_MS_REP1,
  I3 => R_RUNNING_REP1,
  O => G1_8_0);
R_DIVCNT_RNII78R1_0q4z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(4),
  I1 => R_DIVCNT(6),
  I2 => R_DIVCNT(7),
  I3 => R_DIVCNT(9),
  O => G1_6_0);
R_CGCNT_RNIUG6J1q1z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_CGCNT(1),
  I1 => R_CGCNT(2),
  I2 => R_CGCNT(3),
  I3 => R_CGCNT(4),
  O => G0_5_3);
R_RUNNING_REP1_RNI79DC5: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => G0_4_6,
  I1 => G0_4_7,
  I2 => G0_4_8,
  O => V_TOGGLE_0_SQMUXA_A0_0);
R_RUNNING_REP1_RNIJQSL1: LUT4_L 
generic map(
  INIT => X"1000"
)
port map (
  I0 => R_DIVCNT(1),
  I1 => R_DIVCNT(8),
  I2 => R_MODE_MS_REP1,
  I3 => R_RUNNING_REP1,
  LO => G0_4_8);
R_DIVCNT_RNI278R1_0q2z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(0),
  I1 => R_DIVCNT(2),
  I2 => R_DIVCNT(3),
  I3 => R_DIVCNT(5),
  O => G0_4_7);
R_DIVCNT_RNII78R1q4z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT(4),
  I1 => R_DIVCNT(6),
  I2 => R_DIVCNT(7),
  I3 => R_DIVCNT(9),
  O => G0_4_6);
R_DIVCNT_FAST_RNI9SDG1q1z: LUT4 
generic map(
  INIT => X"1000"
)
port map (
  I0 => R_DIVCNT_FAST(1),
  I1 => R_DIVCNT_FAST(8),
  I2 => R_MODE_MS_FAST,
  I3 => R_RUNNING_FAST,
  O => V_TOGGLE_0_SQMUXA_A0_1);
R_DIVCNT_FAST_RNI271H1q0z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT_FAST(0),
  I1 => R_DIVCNT_FAST(6),
  I2 => R_DIVCNT_FAST(7),
  I3 => R_DIVCNT_FAST(9),
  O => COMB_OP_EQ_V_SPIO_SCK2_5);
R_DIVCNT_FAST_RNIQ60H1q2z: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_DIVCNT_FAST(2),
  I1 => R_DIVCNT_FAST(3),
  I2 => R_DIVCNT_FAST(4),
  I3 => R_DIVCNT_FAST(5),
  O => COMB_OP_EQ_V_SPIO_SCK2_6);
R_SPIO_SCK_RNI9H1P: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_CPOL,
  I1 => SPIO_SCK_6,
  O => COMB_UN6_ASEL_EN);
UN1_V_TXFIFO_76_3_M9_I_2_RNI4NEVC: LUT4 
generic map(
  INIT => X"CCCA"
)
port map (
  I0 => COMB_UN27_CHANGE,
  I1 => COMB_V_TXFIFO_76,
  I2 => UN1_V_TXFIFO_76_3_N_14,
  I3 => UN1_V_TXFIFO_76_3_M9_I_2,
  O => UN1_V_TXFIFO_76_0_I(3));
R_DIVCNT_FAST_RNIRKAO7q0z: LUT4 
generic map(
  INIT => X"F1FF"
)
port map (
  I0 => COMB_OP_EQ_UN2_ASEL_EN,
  I1 => COMB_UN6_ASEL_EN,
  I2 => G0_1_0,
  I3 => V_TOGGLE_0_SQMUXA_A0_1,
  O => UN1_V_TXFIFO_76_3_N_13);
R_MODE_EN_FAST_RNIALKJ1: LUT4 
generic map(
  INIT => X"0040"
)
port map (
  I0 => R_MODE_CPHA,
  I1 => R_MODE_EN_FAST,
  I2 => R_MODE_MS_FAST,
  I3 => R_RUNNING_FAST,
  O => COMB_CHANGE_4_1);
UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81_Z2230: LUT4 
generic map(
  INIT => X"5A96"
)
port map (
  I0 => R_TFREECNT_RNI78IID(1),
  I1 => R_TFREECNT_RNIJEI2D(0),
  I2 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  I3 => UN1_V_TXFIFO_76_0(3),
  O => UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81);
R_LST_RNO_3: LUT4 
generic map(
  INIT => X"D555"
)
port map (
  I0 => N_2126_0,
  I1 => apbi_paddr(2),
  I2 => apbi_pwrite,
  I3 => G2_1_3,
  O => G0_0_0);
APBI_PADDR_RNIGSJRq6z: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(5),
  I2 => apbi_paddr(6),
  I3 => G0_5_5,
  O => G2_1_3);
UN1_R_TFREECNT_1_AXB3_RNI8QSBI2: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => UN1_R_TFREECNT_1_AXB3,
  I1 => UN1_R_TFREECNT_1_P7,
  O => R_EVENT_LTD_1);
R_TFREECNT_RNI26HMDq2z_Z2234: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0_N_13,
  I1 => COMB_UN27_CHANGE,
  I2 => G1_0_1_0,
  I3 => R_TFREECNT(2),
  O => R_TFREECNT_RNI26HMD(2));
COMB_UN40_CHANGE_RNIFG4PC: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN1_R_TFREECNT_S0_N_13,
  I2 => COMB_UN27_CHANGE,
  I3 => COMB_UN40_CHANGE,
  O => COMB_UN1_R_TFREECNT_S0);
COMB_UN40_CHANGE_RNICCQA1: LUT4 
generic map(
  INIT => X"0440"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => COMB_V_TFREECNT_P4,
  I3 => R_TD_OCC,
  O => G1_0_1_0);
UN1_V_TXFIFO_76_3_M9_I_2_RNIN512Q: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_TFREECNT_RNIJEI2D(0),
  I1 => UN1_V_TXFIFO_76_0_I(3),
  LO => G0_0_A3_0_0);
APBI_PADDR_RNI412Oq7z: LUT4 
generic map(
  INIT => X"1000"
)
port map (
  I0 => apbi_paddr(4),
  I1 => apbi_paddr(7),
  I2 => apbi_penable,
  I3 => apbi_psel,
  O => G0_5_5);
APBI_PSEL_RNITG1R: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => apbi_penable,
  I1 => apbi_psel,
  I2 => apbi_pwrite,
  O => COMB_UN30_APBI_PSEL);
R_EVENT_TIPE: LUT3_L 
generic map(
  INIT => X"CA"
)
port map (
  I0 => R_EVENT_TIP,
  I1 => V_EVENT_TIP_0_SQMUXA_1,
  I2 => V_EVENT_TIP_2_SQMUXA_I,
  LO => R_EVENT_TIPE_0);
UN152_CHANGE_7_AMq2z_Z2241: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(2),
  I2 => R_TXFIFO_6(2),
  I3 => UN152_CHANGE_7_AM_1(2),
  O => UN152_CHANGE_7_AM(2));
UN152_CHANGE_7_AM_1q2z_Z2242: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(2),
  I3 => R_TXFIFO_4(2),
  LO => UN152_CHANGE_7_AM_1(2));
UN152_CHANGE_7_BMq2z_Z2243: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(2),
  I2 => R_TXFIFO_7(2),
  I3 => UN152_CHANGE_7_BM_1(2),
  O => UN152_CHANGE_7_BM(2));
UN152_CHANGE_7_BM_1q2z_Z2244: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(2),
  I3 => R_TXFIFO_5(2),
  LO => UN152_CHANGE_7_BM_1(2));
UN152_CHANGE_7_AMq4z_Z2245: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(4),
  I2 => R_TXFIFO_6(4),
  I3 => UN152_CHANGE_7_AM_1(4),
  O => UN152_CHANGE_7_AM(4));
UN152_CHANGE_7_AM_1q4z_Z2246: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(4),
  I3 => R_TXFIFO_4(4),
  LO => UN152_CHANGE_7_AM_1(4));
UN152_CHANGE_7_BMq4z_Z2247: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(4),
  I2 => R_TXFIFO_7(4),
  I3 => UN152_CHANGE_7_BM_1(4),
  O => UN152_CHANGE_7_BM(4));
UN152_CHANGE_7_BM_1q4z_Z2248: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(4),
  I3 => R_TXFIFO_5(4),
  LO => UN152_CHANGE_7_BM_1(4));
UN152_CHANGE_7_AMq6z_Z2249: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(6),
  I2 => R_TXFIFO_6(6),
  I3 => UN152_CHANGE_7_AM_1(6),
  O => UN152_CHANGE_7_AM(6));
UN152_CHANGE_7_AM_1q6z_Z2250: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(6),
  I3 => R_TXFIFO_4(6),
  LO => UN152_CHANGE_7_AM_1(6));
UN152_CHANGE_7_BMq6z_Z2251: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(6),
  I2 => R_TXFIFO_7(6),
  I3 => UN152_CHANGE_7_BM_1(6),
  O => UN152_CHANGE_7_BM(6));
UN152_CHANGE_7_BM_1q6z_Z2252: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(6),
  I3 => R_TXFIFO_5(6),
  LO => UN152_CHANGE_7_BM_1(6));
UN152_CHANGE_7_AMq8z_Z2253: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(8),
  I2 => R_TXFIFO_6(8),
  I3 => UN152_CHANGE_7_AM_1(8),
  O => UN152_CHANGE_7_AM(8));
UN152_CHANGE_7_AM_1q8z_Z2254: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(8),
  I3 => R_TXFIFO_4(8),
  LO => UN152_CHANGE_7_AM_1(8));
UN152_CHANGE_7_BMq8z_Z2255: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(8),
  I2 => R_TXFIFO_7(8),
  I3 => UN152_CHANGE_7_BM_1(8),
  O => UN152_CHANGE_7_BM(8));
UN152_CHANGE_7_BM_1q8z_Z2256: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(8),
  I3 => R_TXFIFO_5(8),
  LO => UN152_CHANGE_7_BM_1(8));
UN152_CHANGE_7_AMq10z_Z2257: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(10),
  I2 => R_TXFIFO_6(10),
  I3 => UN152_CHANGE_7_AM_1(10),
  O => UN152_CHANGE_7_AM(10));
UN152_CHANGE_7_AM_1q10z_Z2258: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(10),
  I3 => R_TXFIFO_4(10),
  LO => UN152_CHANGE_7_AM_1(10));
UN152_CHANGE_7_BMq10z_Z2259: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(10),
  I2 => R_TXFIFO_7(10),
  I3 => UN152_CHANGE_7_BM_1(10),
  O => UN152_CHANGE_7_BM(10));
UN152_CHANGE_7_BM_1q10z_Z2260: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(10),
  I3 => R_TXFIFO_5(10),
  LO => UN152_CHANGE_7_BM_1(10));
UN152_CHANGE_7_AMq16z_Z2261: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(16),
  I2 => R_TXFIFO_6(16),
  I3 => UN152_CHANGE_7_AM_1(16),
  O => UN152_CHANGE_7_AM(16));
UN152_CHANGE_7_AM_1q16z_Z2262: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(16),
  I3 => R_TXFIFO_4(16),
  LO => UN152_CHANGE_7_AM_1(16));
UN152_CHANGE_7_BMq16z_Z2263: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(16),
  I2 => R_TXFIFO_7(16),
  I3 => UN152_CHANGE_7_BM_1(16),
  O => UN152_CHANGE_7_BM(16));
UN152_CHANGE_7_BM_1q16z_Z2264: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(16),
  I3 => R_TXFIFO_5(16),
  LO => UN152_CHANGE_7_BM_1(16));
UN152_CHANGE_7_AMq18z_Z2265: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(18),
  I2 => R_TXFIFO_6(18),
  I3 => UN152_CHANGE_7_AM_1(18),
  O => UN152_CHANGE_7_AM(18));
UN152_CHANGE_7_AM_1q18z_Z2266: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(18),
  I3 => R_TXFIFO_4(18),
  LO => UN152_CHANGE_7_AM_1(18));
UN152_CHANGE_7_BMq18z_Z2267: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(18),
  I2 => R_TXFIFO_7(18),
  I3 => UN152_CHANGE_7_BM_1(18),
  O => UN152_CHANGE_7_BM(18));
UN152_CHANGE_7_BM_1q18z_Z2268: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(18),
  I3 => R_TXFIFO_5(18),
  LO => UN152_CHANGE_7_BM_1(18));
UN152_CHANGE_7_AMq20z_Z2269: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(20),
  I2 => R_TXFIFO_6(20),
  I3 => UN152_CHANGE_7_AM_1(20),
  O => UN152_CHANGE_7_AM(20));
UN152_CHANGE_7_AM_1q20z_Z2270: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(20),
  I3 => R_TXFIFO_4(20),
  LO => UN152_CHANGE_7_AM_1(20));
UN152_CHANGE_7_BMq20z_Z2271: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(20),
  I2 => R_TXFIFO_7(20),
  I3 => UN152_CHANGE_7_BM_1(20),
  O => UN152_CHANGE_7_BM(20));
UN152_CHANGE_7_BM_1q20z_Z2272: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(20),
  I3 => R_TXFIFO_5(20),
  LO => UN152_CHANGE_7_BM_1(20));
UN152_CHANGE_7_AMq22z_Z2273: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(22),
  I2 => R_TXFIFO_6(22),
  I3 => UN152_CHANGE_7_AM_1(22),
  O => UN152_CHANGE_7_AM(22));
UN152_CHANGE_7_AM_1q22z_Z2274: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(22),
  I3 => R_TXFIFO_4(22),
  LO => UN152_CHANGE_7_AM_1(22));
UN152_CHANGE_7_BMq22z_Z2275: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(22),
  I2 => R_TXFIFO_7(22),
  I3 => UN152_CHANGE_7_BM_1(22),
  O => UN152_CHANGE_7_BM(22));
UN152_CHANGE_7_BM_1q22z_Z2276: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(22),
  I3 => R_TXFIFO_5(22),
  LO => UN152_CHANGE_7_BM_1(22));
UN152_CHANGE_7_AMq24z_Z2277: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(24),
  I2 => R_TXFIFO_6(24),
  I3 => UN152_CHANGE_7_AM_1(24),
  O => UN152_CHANGE_7_AM(24));
UN152_CHANGE_7_AM_1q24z_Z2278: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(24),
  I3 => R_TXFIFO_4(24),
  LO => UN152_CHANGE_7_AM_1(24));
UN152_CHANGE_7_BMq24z_Z2279: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(24),
  I2 => R_TXFIFO_7(24),
  I3 => UN152_CHANGE_7_BM_1(24),
  O => UN152_CHANGE_7_BM(24));
UN152_CHANGE_7_BM_1q24z_Z2280: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(24),
  I3 => R_TXFIFO_5(24),
  LO => UN152_CHANGE_7_BM_1(24));
UN152_CHANGE_7_AMq0z_Z2281: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(0),
  I2 => R_TXFIFO_6(0),
  I3 => UN152_CHANGE_7_AM_1(0),
  O => UN152_CHANGE_7_AM(0));
UN152_CHANGE_7_AM_1q0z_Z2282: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(0),
  I3 => R_TXFIFO_4(0),
  LO => UN152_CHANGE_7_AM_1(0));
UN152_CHANGE_7_BMq0z_Z2283: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(0),
  I2 => R_TXFIFO_7(0),
  I3 => UN152_CHANGE_7_BM_1(0),
  O => UN152_CHANGE_7_BM(0));
UN152_CHANGE_7_BM_1q0z_Z2284: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(0),
  I3 => R_TXFIFO_5(0),
  LO => UN152_CHANGE_7_BM_1(0));
UN152_CHANGE_7_AMq26z_Z2285: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_2(26),
  I2 => R_TXFIFO_6(26),
  I3 => UN152_CHANGE_7_AM_1(26),
  O => UN152_CHANGE_7_AM(26));
UN152_CHANGE_7_AM_1q26z_Z2286: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_0(26),
  I3 => R_TXFIFO_4(26),
  LO => UN152_CHANGE_7_AM_1(26));
UN152_CHANGE_7_BMq26z_Z2287: LUT4 
generic map(
  INIT => X"88F5"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TXFIFO_3(26),
  I2 => R_TXFIFO_7(26),
  I3 => UN152_CHANGE_7_BM_1(26),
  O => UN152_CHANGE_7_BM(26));
UN152_CHANGE_7_BM_1q26z_Z2288: LUT4_L 
generic map(
  INIT => X"2367"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1(26),
  I3 => R_TXFIFO_5(26),
  LO => UN152_CHANGE_7_BM_1(26));
V_RUNNING_0_SQMUXA_1_4_Z2289: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_V_TFREECNT_30(3),
  I1 => R_SYNCSAMPC_1,
  I2 => V_RUNNING_0_SQMUXA_1_0,
  I3 => V_RUNNING_0_SQMUXA_1_4_1,
  O => V_RUNNING_0_SQMUXA_1_4);
V_RUNNING_0_SQMUXA_1_4_1_Z2290: LUT4 
generic map(
  INIT => X"1001"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN65_SAMPLE_0,
  I2 => R_TD_OCC,
  I3 => R_TFREECNT(0),
  O => V_RUNNING_0_SQMUXA_1_4_1);
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
COMB_V_SPIO_MOSIOEN_1_M2_Z2292: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSIOEN_1_M2_AM,
    I1 => COMB_V_SPIO_MOSIOEN_1_M2_BM,
    S => COMB_V_SPIO_MOSIOEN_1_SM0_0,
    O => COMB_V_SPIO_MOSIOEN_1_M2);
UN152_CHANGE_6q29z: MUXF5 port map (
    I0 => N_1601,
    I1 => UN152_CHANGE_5(29),
    S => R_TDFI(1),
    O => N_1663);
UN152_CHANGE_3q5z: MUXF5 port map (
    I0 => N_1484,
    I1 => N_1515,
    S => R_TDFI(1),
    O => N_1546);
UN152_CHANGE_3q21z_Z2295: MUXF5 port map (
    I0 => N_1500,
    I1 => N_1531,
    S => R_TDFI(1),
    O => UN152_CHANGE_3(21));
UN152_CHANGE_6q5z: MUXF5 port map (
    I0 => N_1577,
    I1 => N_1608,
    S => R_TDFI(1),
    O => N_1639);
UN152_CHANGE_6q21z_Z2297: MUXF5 port map (
    I0 => UN152_CHANGE_4(21),
    I1 => UN152_CHANGE_5(21),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(21));
UN152_CHANGE_6q13z_Z2298: MUXF5 port map (
    I0 => UN152_CHANGE_4(13),
    I1 => UN152_CHANGE_5(13),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(13));
UN152_CHANGE_3q29z_Z2299: MUXF5 port map (
    I0 => UN152_CHANGE_1(29),
    I1 => UN152_CHANGE_2(29),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(29));
UN152_CHANGE_3q13z_Z2300: MUXF5 port map (
    I0 => UN152_CHANGE_1(13),
    I1 => UN152_CHANGE_2(13),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(13));
COMB_V_LST_1_Z2301: LUT4_L 
generic map(
  INIT => X"0888"
)
port map (
  I0 => N_2126_0,
  I1 => apbi_pwdata(22),
  I2 => COMB_V_LST_1_1,
  I3 => R_EVENT_LTD_1,
  LO => COMB_V_LST_1);
COMB_V_DIVCNT_1q9z_Z2302: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_801,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(9),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9,
  LO => COMB_V_DIVCNT_1(9));
COMB_V_DIVCNT_1q7z_Z2303: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_798,
  I1 => N_801,
  LO => COMB_V_DIVCNT_1(7));
COMB_V_DIVCNT_1_0q7z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(7),
    I1 => COMB_V_DIVCNT_1_0_BM(7),
    S => COMB_RELOAD_1_0,
    O => N_798);
COMB_V_DIVCNT_1_0_BMq7z_Z2305: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => UN1_R_DIVCNT_1_S_7,
  I1 => V_DIVCNT_1_SQMUXA,
  O => COMB_V_DIVCNT_1_0_BM(7));
COMB_V_DIVCNT_1_0_AMq7z_Z2306: LUT4 
generic map(
  INIT => X"F0E1"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_RELOAD_MB(3),
  I2 => UN1_RELOAD(2),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  O => COMB_V_DIVCNT_1_0_AM(7));
R_SPIO_MOSIOEN_RNO: LUT4_L 
generic map(
  INIT => X"B3F3"
)
port map (
  I0 => COMB_UN26_AM_EN_0,
  I1 => COMB_V_SPIO_MOSIOEN25,
  I2 => COMB_V_SPIO_MOSIOEN_1_M2,
  I3 => V_SPIO_MOSIOEN_0_SQMUXA_0,
  LO => COMB_V_SPIO_MOSIOEN_1_0_I);
COMB_V_DIVCNT_1q8z_Z2308: LUT4_L 
generic map(
  INIT => X"5140"
)
port map (
  I0 => N_801,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(8),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8,
  LO => COMB_V_DIVCNT_1(8));
COMB_V_DIVCNT_1q6z_Z2309: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => N_797,
  I1 => N_801,
  LO => COMB_V_DIVCNT_1(6));
COMB_V_IRQ_1_IV_M1_E_0_Z2310: LUT4 
generic map(
  INIT => X"0440"
)
port map (
  I0 => R_EVENT_LT,
  I1 => R_MASK_LT,
  I2 => UN1_R_TFREECNT_1_AXB3,
  I3 => UN1_R_TFREECNT_1_P7,
  O => COMB_V_IRQ_1_IV_M1_E_0);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9_Z2311: LUT4 
generic map(
  INIT => X"AC53"
)
port map (
  I0 => N_636,
  I1 => N_880,
  I2 => N_881,
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_C9,
  O => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC9);
R_SPIO_MISO_RNO: LUT4_L 
generic map(
  INIT => X"FFCA"
)
port map (
  I0 => N_852,
  I1 => N_867,
  I2 => COMB_TINDEX_1(0),
  I3 => COMB_V_UF_7,
  LO => COMB_V_SPIO_MISO_3_0_I);
COMB_V_DIVCNT_1_0q6z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(6),
    I1 => COMB_V_DIVCNT_1_0_BM(6),
    S => COMB_RELOAD_1_0,
    O => N_797);
COMB_V_DIVCNT_1_0_BMq6z_Z2314: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => UN1_R_DIVCNT_1_S_6,
  I1 => V_DIVCNT_1_SQMUXA,
  O => COMB_V_DIVCNT_1_0_BM(6));
COMB_V_DIVCNT_1_0_AMq6z_Z2315: LUT3 
generic map(
  INIT => X"C9"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_RELOAD_MB(3),
  I2 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  O => COMB_V_DIVCNT_1_0_AM(6));
R_RXDONE2_RNO_0: LUT4 
generic map(
  INIT => X"FEFC"
)
port map (
  I0 => COMB_SAMPLE_1,
  I1 => COMB_UN1_R_INCRDLI,
  I2 => COMB_UN1_R_RUNNING_1,
  I3 => COMB_V_INCRDLI_5,
  O => V_RXDONE2_1_SQMUXA_I);
COMB_V_EVENT_LT6_3_1_Z2317: LUT4 
generic map(
  INIT => X"0440"
)
port map (
  I0 => COMB_V_RUNNING_9,
  I1 => R_LST,
  I2 => R_TFREECNT_RNIJEI2D(0),
  I3 => UN1_V_TXFIFO_76_0(3),
  O => COMB_V_EVENT_LT6_3_1);
R_CGCNT_LM_0q5z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2188_0,
  I1 => R_CGCNT_S(5),
  I2 => R_MODE_CG(4),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(5));
R_CGCNT_LM_0q4z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2188_0,
  I1 => R_CGCNT_S(4),
  I2 => R_MODE_CG(3),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(4));
R_CGCNT_LM_0q3z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2188_0,
  I1 => R_CGCNT_S(3),
  I2 => R_MODE_CG(2),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(3));
R_CGCNT_LM_0q2z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2188_0,
  I1 => R_CGCNT_S(2),
  I2 => R_MODE_CG(1),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(2));
R_CGCNT_LM_0q1z: LUT4_L 
generic map(
  INIT => X"88D8"
)
port map (
  I0 => N_2188_0,
  I1 => R_CGCNT_S(1),
  I2 => R_MODE_CG(0),
  I3 => UN1_V_CGCNT_0_SQMUXA_2_0,
  LO => R_CGCNT_LM(1));
UN1_V_DIVCNT_0_SQMUXA_1_C9_Z2323: LUT4_L 
generic map(
  INIT => X"FFAC"
)
port map (
  I0 => N_635,
  I1 => N_879,
  I2 => N_881,
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P7,
  LO => UN1_V_DIVCNT_0_SQMUXA_1_C9);
R_TXFIFO_1_RNOq0z: LUT4_L 
generic map(
  INIT => X"1F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_1SR_0,
  I3 => V_TXFIFO_5_1_SQMUXA_1_4,
  LO => R_TXFIFO_1S_I);
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
R_TXFIFO_3_RNOq0z: LUT4_L 
generic map(
  INIT => X"2F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_3SR_0,
  I3 => V_TXFIFO_5_1_SQMUXA_1_4,
  LO => R_TXFIFO_3S_I);
R_TXFIFO_5_RNOq0z: LUT4_L 
generic map(
  INIT => X"4F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_5SR_0,
  I3 => V_TXFIFO_5_1_SQMUXA_1_4,
  LO => R_TXFIFO_5S_I);
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
R_TXFIFO_7_RNOq0z: LUT4_L 
generic map(
  INIT => X"8F0F"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => R_TXFIFO_7SR_0,
  I3 => V_TXFIFO_5_1_SQMUXA_1_4,
  LO => R_TXFIFO_7S_I);
COMB_V_INCRDLI_1_Z2330: LUT3_L 
generic map(
  INIT => X"10"
)
port map (
  I0 => COMB_SAMPLE_1,
  I1 => COMB_UN1_R_INCRDLI,
  I2 => COMB_V_INCRDLI_5,
  LO => COMB_V_INCRDLI_1);
COMB_V_SPIO_MOSIOEN_1_M2_BM_Z2331: LUT4 
generic map(
  INIT => X"F0D8"
)
port map (
  I0 => COMB_V_SPIO_MOSIOEN25,
  I1 => R_MODE_TTO,
  I2 => R_TWDIR,
  I3 => V_SPIO_MOSIOEN_0_SQMUXA_1,
  O => COMB_V_SPIO_MOSIOEN_1_M2_BM);
COMB_V_SPIO_MOSIOEN_1_M2_AM_Z2332: LUT4 
generic map(
  INIT => X"F7CC"
)
port map (
  I0 => R_MODE_TTO,
  I1 => R_MODE_TW,
  I2 => R_SPII_1_SPISEL,
  I3 => V_SPIO_MOSIOEN_3_SQMUXA,
  O => COMB_V_SPIO_MOSIOEN_1_M2_AM);
R_RXDONE_RNO: LUT3_L 
generic map(
  INIT => X"EC"
)
port map (
  I0 => COMB_SAMPLE_1,
  I1 => COMB_UN1_R_INCRDLI,
  I2 => COMB_V_INCRDLI_5,
  LO => COMB_V_RXDONE_2_0_I);
UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8_Z2334: LUT4 
generic map(
  INIT => X"AC53"
)
port map (
  I0 => N_635,
  I1 => N_879,
  I2 => N_881,
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P7,
  O => UN1_V_DIVCNT_0_SQMUXA_1_AXBXC8);
UN1_R_TFREECNT_1_AXB3_Z2335: LUT4 
generic map(
  INIT => X"27D8"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0,
  I1 => COMB_V_TFREECNT_30(3),
  I2 => R_TFREECNT(3),
  I3 => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R,
  O => UN1_R_TFREECNT_1_AXB3);
UN1_R_TFREECNT_1_AXB0_Z2336: LUT4_L 
generic map(
  INIT => X"7887"
)
port map (
  I0 => COMB_UN1_R_TFREECNT_S0,
  I1 => R_TD_OCC,
  I2 => R_TFREECNT(0),
  I3 => UN1_V_TXFIFO_76_0(3),
  LO => UN1_R_TFREECNT_1_AXB0);
R_CGCNTE_0_I_Z2337: LUT4 
generic map(
  INIT => X"FFFE"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => V_CGCNT_0_SQMUXA,
  I2 => V_CGCNT_0_SQMUXA_1,
  I3 => V_CGCNT_0_SQMUXA_2,
  O => R_CGCNTE_0_I);
R_TXFIFO_4_RNOq0z: LUT4_L 
generic map(
  INIT => X"8F0F"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TXFIFO_4SR_0,
  I3 => V_TXFIFO_4_1_SQMUXA_1_2,
  LO => R_TXFIFO_4S_I);
R_TXFIFO_0_RNOq0z: LUT4_L 
generic map(
  INIT => X"8F0F"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_TXFIFO_0SR_0,
  I3 => V_TXFIFO_0_1_SQMUXA_1_1,
  LO => R_TXFIFO_0S_I);
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
COMB_V_RD_3q10z_Z2341: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(21),
  I3 => RDATA(10),
  LO => COMB_V_RD_3(10));
COMB_V_RD_3q11z_Z2342: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(20),
  I3 => RDATA(11),
  LO => COMB_V_RD_3(11));
COMB_V_RD_3q20z_Z2343: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(20),
  I3 => RDATA(11),
  LO => COMB_V_RD_3(20));
COMB_V_RD_3q21z_Z2344: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(21),
  I3 => RDATA(10),
  LO => COMB_V_RD_3(21));
COMB_V_RD_3q22z_Z2345: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(22),
  I3 => RDATA(9),
  LO => COMB_V_RD_3(22));
COMB_V_RD_3q9z_Z2346: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(22),
  I3 => RDATA(9),
  LO => COMB_V_RD_3(9));
R_TDFI_RNOq2z_Z2347: LUT3_L 
generic map(
  INIT => X"6C"
)
port map (
  I0 => R_TDFI(1),
  I1 => R_TDFI(2),
  I2 => V_TXFIFO_5_1_SQMUXA_1_4,
  LO => R_TDFI_RNO(2));
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
UN1_RELOADq2z_Z2349: MUXF5 port map (
    I0 => UN1_RELOAD_AM(2),
    I1 => UN1_RELOAD_BM(2),
    S => N_881,
    O => UN1_RELOAD(2));
UN1_RELOAD_BMq2z_Z2350: LUT3 
generic map(
  INIT => X"78"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  O => UN1_RELOAD_BM(2));
UN1_RELOAD_AMq2z_Z2351: LUT4 
generic map(
  INIT => X"B888"
)
port map (
  I0 => N_635,
  I1 => R_MODE_FACT,
  I2 => UN1_R_DIVCNT_1_S_6,
  I3 => V_DIVCNT_1_SQMUXA,
  O => UN1_RELOAD_AM(2));
UN1_RELOAD_BMq3z_Z2352: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  O => UN1_RELOAD_BM(3));
COMB_V_DIVCNT_1q3z_Z2353: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_794,
  I1 => N_801,
  I2 => R_MODE_PM(3),
  LO => COMB_V_DIVCNT_1(3));
COMB_V_DIVCNT_1q2z_Z2354: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_793,
  I1 => N_801,
  I2 => R_MODE_PM(2),
  LO => COMB_V_DIVCNT_1(2));
COMB_V_DIVCNT_1q1z_Z2355: LUT3_L 
generic map(
  INIT => X"E2"
)
port map (
  I0 => N_792,
  I1 => N_801,
  I2 => R_MODE_PM(1),
  LO => COMB_V_DIVCNT_1(1));
R_EVENT_TIPE_RNO: LUT4_L 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => N_2126_0,
  I1 => N_2229,
  I2 => COMB_UN1_R_RUNNING_1,
  I3 => V_IRQ_0_SQMUXA_1_0,
  LO => V_EVENT_TIP_2_SQMUXA_I);
R_RUNNING_RNI6NQP2: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => R_RUNNING,
  I1 => V_CGCNT_0_SQMUXA_1,
  I2 => V_CGCNT_0_SQMUXA_2,
  O => N_2188_0);
UN1_V_CGCNT_0_SQMUXA_2: LUT4 
generic map(
  INIT => X"007F"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_MODE_CPHA,
  I3 => V_CGCNT_0_SQMUXA_1,
  O => UN1_V_CGCNT_0_SQMUXA_2_0);
COMB_V_SPIO_MOSIOEN_1_M2S2: LUT4 
generic map(
  INIT => X"7F75"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => COMB_UN26_AM_EN_0,
  I2 => R_MODE_MS,
  I3 => V_SPIO_MOSIOEN_0_SQMUXA_1,
  O => COMB_V_SPIO_MOSIOEN_1_SM0_0);
COMB_V_RD_3q13z_Z2360: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(18),
  I3 => RDATA(13),
  LO => COMB_V_RD_3(13));
COMB_V_RD_3q18z_Z2361: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(18),
  I3 => RDATA(13),
  LO => COMB_V_RD_3(18));
COMB_V_SPIO_MOSI_2_30: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_859,
  I1 => N_866,
  I2 => COMB_TINDEX_1(2),
  O => N_867);
COMB_V_SPIO_MOSI_2_15: MUXF6 port map (
    I0 => N_844,
    I1 => N_851,
    S => COMB_TINDEX_1(1),
    O => N_852);
COMB_V_DIVCNT_1q4z_Z2364: LUT4_L 
generic map(
  INIT => X"A8AA"
)
port map (
  I0 => N_795,
  I1 => COMB_RELOAD_1_0,
  I2 => R_MODE_DIV16,
  I3 => R_MODE_FACT,
  LO => COMB_V_DIVCNT_1(4));
COMB_V_RD_3q17z_Z2365: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(17),
  I3 => RDATA(14),
  LO => COMB_V_RD_3(17));
COMB_V_RD_3q14z_Z2366: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(17),
  I3 => RDATA(14),
  LO => COMB_V_RD_3(14));
COMB_V_DIVCNT_1q5z_Z2367: LUT4_L 
generic map(
  INIT => X"A8AA"
)
port map (
  I0 => N_796,
  I1 => COMB_RELOAD_1_0,
  I2 => R_MODE_DIV16,
  I3 => R_MODE_FACT,
  LO => COMB_V_DIVCNT_1(5));
COMB_V_DIVCNT_1q0z_Z2368: LUT4_L 
generic map(
  INIT => X"FB51"
)
port map (
  I0 => N_801,
  I1 => COMB_RELOAD_1_0,
  I2 => COMB_V_DIVCNT_5(0),
  I3 => R_MODE_PM(0),
  LO => COMB_V_DIVCNT_1(0));
R_TDFI_RNOq1z_Z2369: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_TDFI(1),
  I1 => V_TXFIFO_5_1_SQMUXA_1_4,
  LO => R_TDFI_RNO(1));
COMB_UN1_R_MODE_EN_2_Z2370: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_V_RUNNING_9,
  I1 => R_EVENT_TIP,
  I2 => R_MASK_TIP,
  I3 => R_MODE_EN,
  O => COMB_UN1_R_MODE_EN_2);
R_RUNNINGC_Z2371: LUT3_L 
generic map(
  INIT => X"08"
)
port map (
  I0 => N_2229,
  I1 => rstn,
  I2 => V_IRQ_0_SQMUXA_1_0,
  LO => R_RUNNINGC);
APBO_PRDATA_0_IV_0_RNIC8NCq31z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(31),
  I1 => APBO_PRDATA_0_IV_1(31),
  I2 => APBOUT_6_SQMUXA,
  I3 => SLVSEL_39,
  O => apbo_prdata(31));
APBO_PRDATA_0_IV_0_RNI8L8Jq29z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(29),
  I1 => APBO_PRDATA_0_IV_1(29),
  I2 => APBOUT_4_SQMUXA,
  I3 => R_RD(29),
  O => apbo_prdata(29));
APBO_PRDATA_0_IV_0_RNI5L8Jq19z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(19),
  I1 => APBO_PRDATA_0_IV_1(19),
  I2 => APBOUT_4_SQMUXA,
  I3 => R_RD(19),
  O => apbo_prdata(19));
APBO_PRDATA_0_IV_0_RNISG7Jq16z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(16),
  I1 => APBO_PRDATA_0_IV_1(16),
  I2 => APBOUT_4_SQMUXA,
  I3 => R_RD(16),
  O => apbo_prdata(16));
APBO_PRDATA_0_IV_0_RNIFCOCq14z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(14),
  I1 => APBO_PRDATA_0_IV_1(14),
  I2 => APBOUT_6_SQMUXA,
  I3 => SLVSEL_22,
  O => apbo_prdata(14));
APBO_PRDATA_IV_0_RNIFS831q11z: LUT4 
generic map(
  INIT => X"FF7F"
)
port map (
  I0 => APBO_PRDATA_IV_0(11),
  I1 => APBO_PRDATA_IV_1(11),
  I2 => APBO_PRDATA_IV_2(11),
  I3 => R_MASK_UN_M,
  O => apbo_prdata(11));
APBO_PRDATA_0_IV_0_RNIV3RDq10z: LUT3 
generic map(
  INIT => X"7F"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(10),
  I1 => APBO_PRDATA_0_IV_1(10),
  I2 => APBO_PRDATA_0_IV_2(10),
  O => apbo_prdata(10));
APBO_PRDATA_0_IV_0_RNI7SKF1q9z: LUT3 
generic map(
  INIT => X"7F"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(9),
  I1 => APBO_PRDATA_0_IV_1(9),
  I2 => APBO_PRDATA_0_IV_2(9),
  O => apbo_prdata(9));
APBO_PRDATA_0_IV_0_RNI4SKF1q8z: LUT3 
generic map(
  INIT => X"7F"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(8),
  I1 => APBO_PRDATA_0_IV_1(8),
  I2 => APBO_PRDATA_0_IV_2(8),
  O => apbo_prdata(8));
V_EVENT_TIP_0_SQMUXA_1_Z2381: LUT4_L 
generic map(
  INIT => X"20A0"
)
port map (
  I0 => N_2126_0,
  I1 => COMB_UN40_SAMPLE,
  I2 => COMB_V_RUNNING_9_IV_0,
  I3 => V_RUNNING_0_SQMUXA_1_4,
  LO => V_EVENT_TIP_0_SQMUXA_1);
R_RXFIFO_I_9_RNI3V611: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => N_826_0_4,
  I1 => COMB_SELECT_DATA_RDATA118,
  I2 => COMB_SPILEN_LEN,
  I3 => R_RXFIFO(11),
  O => RDATA(11));
R_RXFIFO_I_12_RNIIJ571: LUT4 
generic map(
  INIT => X"F700"
)
port map (
  I0 => N_822_0_3,
  I1 => N_826_0_4,
  I2 => COMB_SPILEN_LEN,
  I3 => R_RXFIFO(10),
  O => RDATA(10));
R_RXFIFO_I_28_RNIECK51: LUT4 
generic map(
  INIT => X"70F0"
)
port map (
  I0 => N_822_0_3,
  I1 => N_826_0_4,
  I2 => R_RXFIFO(9),
  I3 => RDATA_0(9),
  O => RDATA(9));
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
COMB_V_IRQ_1_IV_M6_2_Z2386: LUT4 
generic map(
  INIT => X"002A"
)
port map (
  I0 => COMB_V_IRQ_1_IV_M6_0,
  I1 => V_IRQ_0_SQMUXA_2_0,
  I2 => V_IRQ_0_SQMUXA_2_1,
  I3 => V_IRQ_0_SQMUXA_3,
  O => COMB_V_IRQ_1_IV_M6_2);
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
UN1_V_TXFIFO_76_3_M9_I_2_RNI4NEVC_0: LUT4 
generic map(
  INIT => X"3335"
)
port map (
  I0 => COMB_UN27_CHANGE,
  I1 => COMB_V_TXFIFO_76,
  I2 => UN1_V_TXFIFO_76_3_N_14,
  I3 => UN1_V_TXFIFO_76_3_M9_I_2,
  O => UN1_V_TXFIFO_76_0(3));
UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R_Z2393: LUT4 
generic map(
  INIT => X"CCC5"
)
port map (
  I0 => COMB_UN27_CHANGE,
  I1 => COMB_V_TXFIFO_76,
  I2 => UN1_V_TXFIFO_76_2_N_11,
  I3 => UN1_V_TXFIFO_76_2_B0_0_2,
  O => UN1_V_TXFIFO_76_2_B0_0_2_RNI5F6R);
COMB_V_INCRDLI_5_Z2394: LUT4 
generic map(
  INIT => X"8DCC"
)
port map (
  I0 => COMB_UN47_SAMPLE_0,
  I1 => R_INCRDLI,
  I2 => R_OV,
  I3 => V_TWDIR_0_SQMUXA,
  O => COMB_V_INCRDLI_5);
R_MODE_CPHA_RNIA3MN: LUT3 
generic map(
  INIT => X"80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => R_MODE_CPHA,
  O => V_CGCNT_0_SQMUXA_2);
V_SPIO_MOSIOEN_3_SQMUXA_Z2396: LUT3_L 
generic map(
  INIT => X"70"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => R_MODE_TW,
  I2 => TINDEX_0_SQMUXA,
  LO => V_SPIO_MOSIOEN_3_SQMUXA);
R_TDFI_RNOq0z_Z2397: LUT4_L 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => R_TDFI(0),
  LO => R_TDFI_RNO(0));
COMB_V_DIVCNT_1_0q4z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(4),
    I1 => COMB_V_DIVCNT_1_0_BM(4),
    S => COMB_RELOAD_1_0,
    O => N_795);
COMB_V_DIVCNT_1_0_BMq4z_Z2399: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_V_SPIO_SCK20,
  I1 => UN1_R_DIVCNT_1_S_4,
  O => COMB_V_DIVCNT_1_0_BM(4));
COMB_V_DIVCNT_1_0_AMq4z_Z2400: LUT4 
generic map(
  INIT => X"AAA9"
)
port map (
  I0 => UN1_RELOAD(5),
  I1 => R_MODE_PM_RNIOEJG(2),
  I2 => R_MODE_PM_RNIOUDC(1),
  I3 => R_MODE_DIV16_RNIPI88,
  O => COMB_V_DIVCNT_1_0_AM(4));
UN1_RELOAD_0q0z: LUT4 
generic map(
  INIT => X"E400"
)
port map (
  I0 => R_MODE_FACT,
  I1 => UN1_R_DIVCNT_1_S_8,
  I2 => UN1_R_DIVCNT_1_S_5,
  I3 => V_DIVCNT_1_SQMUXA,
  O => N_880);
UN1_RELOAD_0q1z: LUT4 
generic map(
  INIT => X"B888"
)
port map (
  I0 => N_636,
  I1 => R_MODE_FACT,
  I2 => UN1_R_DIVCNT_1_S_7,
  I3 => V_DIVCNT_1_SQMUXA,
  O => N_879);
COMB_V_DIVCNT_1_0q5z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(5),
    I1 => COMB_V_DIVCNT_1_0_BM(5),
    S => COMB_RELOAD_1_0,
    O => N_796);
COMB_V_DIVCNT_1_0_BMq5z_Z2404: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => COMB_V_SPIO_SCK20,
  I2 => UN1_R_DIVCNT_1_S_5,
  O => COMB_V_DIVCNT_1_0_BM(5));
COMB_V_DIVCNT_1_0_AMq5z_Z2405: LUT2 
generic map(
  INIT => X"9"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  O => COMB_V_DIVCNT_1_0_AM(5));
COMB_V_DIVCNT_1_0q3z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(3),
    I1 => COMB_V_DIVCNT_1_0_BM(3),
    S => COMB_RELOAD_1_0,
    O => N_794);
COMB_V_DIVCNT_1_0_BMq3z_Z2407: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => UN1_R_DIVCNT_1_S_3,
  I1 => V_DIVCNT_1_SQMUXA,
  O => COMB_V_DIVCNT_1_0_BM(3));
COMB_V_DIVCNT_1_0_AMq3z_Z2408: LUT3 
generic map(
  INIT => X"A9"
)
port map (
  I0 => R_MODE_PM_RNIOEJG(2),
  I1 => R_MODE_PM_RNIOUDC(1),
  I2 => R_MODE_DIV16_RNIPI88,
  O => COMB_V_DIVCNT_1_0_AM(3));
COMB_V_DIVCNT_1_0q2z: MUXF5 port map (
    I0 => COMB_V_DIVCNT_1_0_AM(2),
    I1 => COMB_V_DIVCNT_1_0_BM(2),
    S => COMB_RELOAD_1_0,
    O => N_793);
COMB_V_DIVCNT_1_0_BMq2z_Z2410: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => UN1_R_DIVCNT_1_S_2,
  I1 => V_DIVCNT_1_SQMUXA,
  O => COMB_V_DIVCNT_1_0_BM(2));
COMB_V_DIVCNT_1_0_AMq2z_Z2411: LUT3 
generic map(
  INIT => X"1E"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  I2 => R_MODE_PM_RNIOUDC(1),
  O => COMB_V_DIVCNT_1_0_AM(2));
COMB_V_DIVCNT_1_0q1z: LUT4 
generic map(
  INIT => X"8D05"
)
port map (
  I0 => COMB_RELOAD_1_0,
  I1 => UN1_R_DIVCNT_1_S_1,
  I2 => R_MODE_DIV16_RNIPI88,
  I3 => V_DIVCNT_1_SQMUXA,
  O => N_792);
COMB_UN40_CHANGE_RNIJ2S11: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN27_CHANGE,
  I2 => COMB_UN40_CHANGE,
  I3 => R_TDFI(0),
  O => V_TXFIFO_5_1_SQMUXA_1_4);
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
R_TBITCNTE_0_I_Z2415: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => COMB_UN1_R_MODE_EN,
  O => R_TBITCNTE_0_I);
R_MODE_DIV16_RNI472U: LUT3 
generic map(
  INIT => X"10"
)
port map (
  I0 => COMB_RELOAD_1_0,
  I1 => R_MODE_DIV16,
  I2 => R_MODE_FACT,
  O => N_801);
R_RUNNINGC_1: LUT4 
generic map(
  INIT => X"00F4"
)
port map (
  I0 => COMB_UN26_AM_EN_0,
  I1 => R_MODE_EN,
  I2 => R_RUNNING,
  I3 => V_RUNNING_0_SQMUXA_1,
  O => N_2229);
APBO_PRDATA_0_IV_0_RNIL01Iq30z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(30),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(30),
  I3 => R_SLVSEL_M(30),
  O => apbo_prdata(30));
APBO_PRDATA_0_IV_0_RNIA14Iq28z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(28),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(28),
  I3 => SLVSEL_36,
  O => apbo_prdata(28));
APBO_PRDATA_0_IV_0_RNI7L3Iq27z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(27),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(27),
  I3 => SLVSEL_35,
  O => apbo_prdata(27));
APBO_PRDATA_0_IV_0_RNI493Iq26z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(26),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(26),
  I3 => SLVSEL_34,
  O => apbo_prdata(26));
APBO_PRDATA_0_IV_0_RNI1T2Iq25z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(25),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(25),
  I3 => SLVSEL_33,
  O => apbo_prdata(25));
APBO_PRDATA_0_IV_0_RNIUG2Iq24z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(24),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(24),
  I3 => R_SLVSEL_M(24),
  O => apbo_prdata(24));
APBO_PRDATA_0_IV_0_RNIR42Iq23z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(23),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(23),
  I3 => SLVSEL_31,
  O => apbo_prdata(23));
APBO_PRDATA_0_IV_0_RNIOO1Iq22z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(22),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(22),
  I3 => SLVSEL_30,
  O => apbo_prdata(22));
APBO_PRDATA_0_IV_0_RNILC1Iq21z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(21),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(21),
  I3 => SLVSEL_29,
  O => apbo_prdata(21));
APBO_PRDATA_0_IV_0_RNII01Iq20z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(20),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(20),
  I3 => SLVSEL_28,
  O => apbo_prdata(20));
APBO_PRDATA_0_IV_0_RNI714Iq18z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(18),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M_0(18),
  I3 => SLVSEL_26,
  O => apbo_prdata(18));
APBO_PRDATA_0_IV_0_RNI4L3Iq17z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(17),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(17),
  I3 => R_SLVSEL_M(17),
  O => apbo_prdata(17));
APBO_PRDATA_0_IV_0_RNITC2Iq15z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(15),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M(31),
  I3 => SLVSEL_23,
  O => apbo_prdata(15));
APBO_PRDATA_0_IV_0_RNI0T2Iq13z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(13),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M(29),
  I3 => SLVSEL_21,
  O => apbo_prdata(13));
APBO_PRDATA_0_IV_0_RNI9KNCq12z: LUT4 
generic map(
  INIT => X"F777"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(12),
  I1 => APBO_PRDATA_0_IV_1(12),
  I2 => APBOUT_6_SQMUXA,
  I3 => SLVSEL_20,
  O => apbo_prdata(12));
APBO_PRDATA_0_IV_0_RNILP5Tq7z: LUT4 
generic map(
  INIT => X"FFD5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(7),
  I1 => APBOUT_1_SQMUXA,
  I2 => R_MODE_CG(0),
  I3 => R_RD_M(7),
  O => apbo_prdata(7));
APBO_PRDATA_0_IV_0_RNIECQPq6z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(6),
  I1 => APBOUT_5_SQMUXA,
  I2 => R_RD(22),
  O => apbo_prdata(6));
APBO_PRDATA_0_IV_0_RNITUGOq5z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(5),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(5),
  O => apbo_prdata(5));
APBO_PRDATA_0_IV_0_RNIRUGOq4z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(4),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(4),
  O => apbo_prdata(4));
APBO_PRDATA_0_IV_0_RNITHFRq3z: LUT4 
generic map(
  INIT => X"FDF5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(3),
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD_M(19),
  I3 => SLVSEL_11,
  O => apbo_prdata(3));
APBO_PRDATA_0_IV_0_RNINUGOq2z: LUT3 
generic map(
  INIT => X"D5"
)
port map (
  I0 => APBO_PRDATA_0_IV_0(2),
  I1 => APBOUT_4_SQMUXA,
  I2 => R_RD(2),
  O => apbo_prdata(2));
APBO_PRDATA_0_IV_1_RNI363Iq1z: LUT4 
generic map(
  INIT => X"FDDD"
)
port map (
  I0 => APBO_PRDATA_0_IV_1(1),
  I1 => APBOUT_0_SQMUXA,
  I2 => APBOUT_6_SQMUXA,
  I3 => SLVSEL_9,
  O => apbo_prdata(1));
APBO_PRDATA_0_IV_1_RNI163Iq0z: LUT4 
generic map(
  INIT => X"FDDD"
)
port map (
  I0 => APBO_PRDATA_0_IV_1(0),
  I1 => APBOUT_0_SQMUXA,
  I2 => APBOUT_6_SQMUXA,
  I3 => NN_3,
  O => apbo_prdata(0));
COMB_V_SPIO_MOSI_2_29: LUT3_L 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_858,
  I1 => N_865,
  I2 => R_TBITCNT(1),
  LO => N_866);
R_RXFIFO_I_29_RNISED41: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => N_832_0_1,
  I1 => COMB_SELECT_DATA_RDATA116,
  I2 => COMB_SPILEN_LEN,
  I3 => R_RXFIFO(13),
  O => RDATA(13));
COMB_V_SPIO_MOSI_2_22: MUXF6 port map (
    I0 => N_855,
    I1 => N_862,
    S => R_TBITCNT(1),
    O => N_859);
COMB_V_SPIO_MOSI_2_14: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_14_AM,
    I1 => COMB_V_SPIO_MOSI_2_14_BM,
    S => R_TBITCNT(2),
    O => N_851);
COMB_V_SPIO_MOSI_2_14_BM_Z2445: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_848,
  I1 => N_849,
  I2 => R_TBITCNT(3),
  O => COMB_V_SPIO_MOSI_2_14_BM);
COMB_V_SPIO_MOSI_2_14_AM_Z2446: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_845,
  I1 => N_846,
  I2 => R_TBITCNT(3),
  O => COMB_V_SPIO_MOSI_2_14_AM);
COMB_V_SPIO_MOSI_2_7: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_7_AM,
    I1 => COMB_V_SPIO_MOSI_2_7_BM,
    S => COMB_TINDEX_1(2),
    O => N_844);
COMB_V_SPIO_MOSI_2_7_BM_Z2448: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_841,
  I1 => N_842,
  I2 => R_TBITCNT(3),
  O => COMB_V_SPIO_MOSI_2_7_BM);
COMB_V_SPIO_MOSI_2_7_AM_Z2449: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_838,
  I1 => N_839,
  I2 => COMB_TINDEX_1(3),
  O => COMB_V_SPIO_MOSI_2_7_AM);
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
R_RXFIFO_I_26_RNI93NR: LUT3 
generic map(
  INIT => X"D0"
)
port map (
  I0 => N_832_0_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RXFIFO(14),
  O => RDATA(14));
R_TWDIR_RNO_0: LUT3 
generic map(
  INIT => X"B3"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => R_RUNNING,
  I2 => R_SYNCSAMPC_1,
  O => V_TWDIR_2_SQMUXA_I);
V_SPIO_MOSIOEN_0_SQMUXA_1_Z2454: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_CHANGE_1_1,
  I1 => R_MODE_TW,
  O => V_SPIO_MOSIOEN_0_SQMUXA_1);
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
V_RUNNING_0_SQMUXA_1_Z2456: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => V_RUNNING_0_SQMUXA_1_4,
  LO => V_RUNNING_0_SQMUXA_1);
RDATA_5q8z: LUT2 
generic map(
  INIT => X"7"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN(3),
  O => N_826_0_4);
R_RBITCNT_LM_0q4z: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => N_2146_0,
  I1 => R_RBITCNT_S(4),
  LO => R_RBITCNT_LM(4));
R_RBITCNT_LM_0q3z: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => N_2146_0,
  I1 => R_RBITCNT_S(3),
  LO => R_RBITCNT_LM(3));
R_RBITCNT_LM_0q2z: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => N_2146_0,
  I1 => R_RBITCNT_S(2),
  LO => R_RBITCNT_LM(2));
R_RBITCNT_LM_0q1z: LUT2_L 
generic map(
  INIT => X"8"
)
port map (
  I0 => N_2146_0,
  I1 => R_RBITCNT_S(1),
  LO => R_RBITCNT_LM(1));
COMB_RELOAD_1: LUT4 
generic map(
  INIT => X"31F5"
)
port map (
  I0 => COMB_CHANGE_4_1,
  I1 => COMB_OP_EQ_V_SPIO_SCK2,
  I2 => COMB_UN26_AM_EN_0,
  I3 => COMB_V_SPIO_SCK20,
  O => COMB_RELOAD_1_0);
V_CGCNT_0_SQMUXA_Z2463: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => COMB_OP_EQ_UN2_ASEL_EN,
  I1 => COMB_OP_EQ_V_SPIO_SCK2,
  I2 => R_MODE_MS,
  I3 => R_RUNNING,
  O => V_CGCNT_0_SQMUXA);
R_OV_RNO: LUT2_L 
generic map(
  INIT => X"D"
)
port map (
  I0 => COMB_UN40_SAMPLE,
  I1 => COMB_UN65_SAMPLE_0,
  LO => V_OV_0_SQMUXA_1_I);
UN1_R_DIVCNT_1_S_8_RNIEMIT: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => UN1_R_DIVCNT_1_S_8,
  O => COMB_V_DIVCNT_5(8));
R_DIVCNT_RNIC3V31q0z: LUT3 
generic map(
  INIT => X"10"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_DIVCNT(0),
  I2 => R_MODE_MS,
  O => COMB_V_DIVCNT_5(0));
UN1_R_DIVCNT_1_S_9_RNIFMIT: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => UN1_R_DIVCNT_1_S_9,
  O => COMB_V_DIVCNT_5(9));
R_SYNCSAMP_RNIAQLFq1z: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_SAMPLE_1,
  I1 => R_SYNCSAMP(1),
  O => COMB_UN1_R_SYNCSAMP_0_I);
COMB_V_TXFIFO_76_RNI32CI: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => V_TD_OCC_1_SQMUXA,
  O => V_TD_OCC_0_SQMUXA_I);
R_TXFIFO_3SR_0_Z2470: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_3(2),
  I2 => R_TXFIFO_3(0),
  I3 => rstn,
  O => R_TXFIFO_3SR_0);
R_TXFIFO_5SR_0_Z2471: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_1(2),
  I2 => R_TXFIFO_5(0),
  I3 => rstn,
  O => R_TXFIFO_5SR_0);
R_TXFIFO_2SR_0_Z2472: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_4(2),
  I2 => R_TXFIFO_2(0),
  I3 => rstn,
  O => R_TXFIFO_2SR_0);
R_TXFIFO_1SR_0_Z2473: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_5(2),
  I2 => R_TXFIFO_1(0),
  I3 => rstn,
  O => R_TXFIFO_1SR_0);
R_TXFIFO_4SR_0_Z2474: LUT4_L 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_2(2),
  I2 => R_TXFIFO_4(0),
  I3 => rstn,
  LO => R_TXFIFO_4SR_0);
R_TXFIFO_0SR_0_Z2475: LUT4_L 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_6(2),
  I2 => R_TXFIFO_0(0),
  I3 => rstn,
  LO => R_TXFIFO_0SR_0);
R_CHNG_RNIVLU5C: LUT4 
generic map(
  INIT => X"CE02"
)
port map (
  I0 => COMB_CHANGE_4_1,
  I1 => COMB_UN1_R_TFREECNT_S0_N_11,
  I2 => COMB_UN26_AM_EN_0,
  I3 => R_CHNG,
  O => COMB_UN1_R_TFREECNT_S0_N_13);
COMB_CHANGE_1_1_Z2477: LUT4 
generic map(
  INIT => X"5D08"
)
port map (
  I0 => CHANGE_1_SQMUXA,
  I1 => COMB_CHANGE_4_1,
  I2 => COMB_UN26_AM_EN_0,
  I3 => R_CHNG,
  O => COMB_CHANGE_1_1);
COMB_V_SPIO_MOSI_2_28: MUXF8 port map (
    I0 => COMB_V_SPIO_MOSI_2_26,
    I1 => N_864,
    S => R_TBITCNT(3),
    O => N_865);
COMB_V_RD_3q15z_Z2479: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(16),
  I3 => RDATA(15),
  LO => COMB_V_RD_3(15));
COMB_V_RD_3q16z_Z2480: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(16),
  I3 => RDATA(15),
  LO => COMB_V_RD_3(16));
COMB_V_SPIO_MOSI_2_21: MUXF6 port map (
    I0 => N_856,
    I1 => N_857,
    S => R_TBITCNT(3),
    O => N_858);
COMB_V_SPIO_MOSI_2_18: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_18_AM,
    I1 => COMB_V_SPIO_MOSI_2_18_BM,
    S => COMB_TINDEX_1(3),
    O => N_855);
COMB_V_SPIO_MOSI_2_18_BM_Z2483: LUT4 
generic map(
  INIT => X"F2D0"
)
port map (
  I0 => R_TBITCNT(4),
  I1 => TINDEX_0_SQMUXA,
  I2 => UN152_CHANGE_7(9),
  I3 => UN152_CHANGE_7(25),
  O => COMB_V_SPIO_MOSI_2_18_BM);
COMB_V_SPIO_MOSI_2_18_AM_Z2484: LUT4 
generic map(
  INIT => X"F2D0"
)
port map (
  I0 => R_TBITCNT(4),
  I1 => TINDEX_0_SQMUXA,
  I2 => UN152_CHANGE_7(1),
  I3 => UN152_CHANGE_7(17),
  O => COMB_V_SPIO_MOSI_2_18_AM);
COMB_V_SPIO_MOSI_2_25: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_25_AM,
    I1 => COMB_V_SPIO_MOSI_2_25_BM,
    S => COMB_TINDEX_1(3),
    O => N_862);
COMB_V_SPIO_MOSI_2_25_BM_Z2486: LUT4 
generic map(
  INIT => X"F2D0"
)
port map (
  I0 => R_TBITCNT(4),
  I1 => TINDEX_0_SQMUXA,
  I2 => UN152_CHANGE_7(11),
  I3 => UN152_CHANGE_7(27),
  O => COMB_V_SPIO_MOSI_2_25_BM);
COMB_V_SPIO_MOSI_2_25_AM_Z2487: LUT4 
generic map(
  INIT => X"F2D0"
)
port map (
  I0 => R_TBITCNT(4),
  I1 => TINDEX_0_SQMUXA,
  I2 => UN152_CHANGE_7(3),
  I3 => UN152_CHANGE_7(19),
  O => COMB_V_SPIO_MOSI_2_25_AM);
COMB_V_IRQ_1_IV_M6_0_Z2488: LUT4 
generic map(
  INIT => X"4555"
)
port map (
  I0 => COMB_V_IRQ_1_IV_M5_E,
  I1 => R_EVENT_MME,
  I2 => R_MASK_MME,
  I3 => V_IRQ_0_SQMUXA_1_0,
  O => COMB_V_IRQ_1_IV_M6_0);
COMB_V_RUNNING_9_IV_0_Z2489: LUT4 
generic map(
  INIT => X"00F4"
)
port map (
  I0 => COMB_UN26_AM_EN_0,
  I1 => R_MODE_EN,
  I2 => R_RUNNING,
  I3 => V_IRQ_0_SQMUXA_1_0,
  O => COMB_V_RUNNING_9_IV_0);
UN1_V_TXFIFO_76_2_B0_0_2_Z2490: LUT4 
generic map(
  INIT => X"FF45"
)
port map (
  I0 => R_CHNG,
  I1 => SAMPLE_0_SQMUXA_2,
  I2 => UN1_V_TXFIFO_76_2_B0_0_O5,
  I3 => UN1_V_TXFIFO_76_2_B0_0_0,
  O => UN1_V_TXFIFO_76_2_B0_0_2);
UN1_V_TXFIFO_76_3_M9_I_2_Z2491: LUT4 
generic map(
  INIT => X"FF45"
)
port map (
  I0 => R_CHNG,
  I1 => SAMPLE_0_SQMUXA_2,
  I2 => UN1_V_TXFIFO_76_3_N_13,
  I3 => UN1_V_TXFIFO_76_3_M9_I_0,
  O => UN1_V_TXFIFO_76_3_M9_I_2);
APBO_PRDATA_0_IV_1q12z_Z2492: LUT4 
generic map(
  INIT => X"5D7F"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RD(12),
  I3 => R_RD(28),
  O => APBO_PRDATA_0_IV_1(12));
APBO_PRDATA_0_IV_0q20z_Z2493: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_LEN(0),
  I3 => R_RD(4),
  O => APBO_PRDATA_0_IV_0(20));
APBO_PRDATA_0_IV_0q18z_Z2494: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_PM(2),
  I3 => R_RD(2),
  O => APBO_PRDATA_0_IV_0(18));
APBO_PRDATA_0_IV_0q15z_Z2495: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_TW,
  I3 => R_RD(15),
  O => APBO_PRDATA_0_IV_0(15));
APBO_PRDATA_0_IV_0q16z_Z2496: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(0),
  I3 => SLVSEL_24,
  O => APBO_PRDATA_0_IV_0(16));
APBO_PRDATA_0_IV_0q5z_Z2497: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(21),
  I3 => SLVSEL_13,
  O => APBO_PRDATA_0_IV_0(5));
APBO_PRDATA_0_IV_0q19z_Z2498: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(3),
  I3 => SLVSEL_27,
  O => APBO_PRDATA_0_IV_0(19));
APBO_PRDATA_0_IV_0q23z_Z2499: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_LEN(3),
  I3 => R_RD(7),
  O => APBO_PRDATA_0_IV_0(23));
APBO_PRDATA_0_IV_0q22z_Z2500: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_LEN(2),
  I3 => R_RD(6),
  O => APBO_PRDATA_0_IV_0(22));
APBO_PRDATA_0_IV_0q21z_Z2501: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_LEN(1),
  I3 => R_RD(5),
  O => APBO_PRDATA_0_IV_0(21));
APBO_PRDATA_0_IV_1q0z_Z2502: LUT4 
generic map(
  INIT => X"5D7F"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RD(0),
  I3 => R_RD(16),
  O => APBO_PRDATA_0_IV_1(0));
APBO_PRDATA_0_IV_1q1z_Z2503: LUT4 
generic map(
  INIT => X"5D7F"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RD(1),
  I3 => R_RD(17),
  O => APBO_PRDATA_0_IV_1(1));
APBO_PRDATA_0_IV_0q30z_Z2504: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_LOOPB,
  I3 => R_RD(14),
  O => APBO_PRDATA_0_IV_0(30));
APBO_PRDATA_0_IV_0q14z_Z2505: LUT4 
generic map(
  INIT => X"5D7F"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RD(14),
  I3 => R_RD(30),
  O => APBO_PRDATA_0_IV_0(14));
APBO_PRDATA_0_IV_0q13z_Z2506: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_FACT,
  I3 => R_RD(13),
  O => APBO_PRDATA_0_IV_0(13));
APBO_PRDATA_0_IV_1q10z_Z2507: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CG(3),
  I3 => R_RD(10),
  O => APBO_PRDATA_0_IV_1(10));
APBO_PRDATA_0_IV_0q10z_Z2508: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(26),
  I3 => SLVSEL_18,
  O => APBO_PRDATA_0_IV_0(10));
APBO_PRDATA_0_IV_1q9z_Z2509: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CG(2),
  I3 => R_RD(9),
  O => APBO_PRDATA_0_IV_1(9));
APBO_PRDATA_0_IV_0q9z_Z2510: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(25),
  I3 => SLVSEL_17,
  O => APBO_PRDATA_0_IV_0(9));
APBO_PRDATA_0_IV_0q17z_Z2511: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_PM(1),
  I3 => R_RD(1),
  O => APBO_PRDATA_0_IV_0(17));
APBO_PRDATA_0_IV_0q4z_Z2512: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(20),
  I3 => SLVSEL_12,
  O => APBO_PRDATA_0_IV_0(4));
APBO_PRDATA_0_IV_0q3z_Z2513: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_TTO,
  I3 => R_RD(3),
  O => APBO_PRDATA_0_IV_0(3));
APBO_PRDATA_0_IV_0q2z_Z2514: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(18),
  I3 => SLVSEL_10,
  O => APBO_PRDATA_0_IV_0(2));
APBO_PRDATA_0_IV_0q6z_Z2515: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(6),
  I3 => SLVSEL_14,
  O => APBO_PRDATA_0_IV_0(6));
APBO_PRDATA_0_IV_0q7z_Z2516: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(23),
  I3 => SLVSEL_15,
  O => APBO_PRDATA_0_IV_0(7));
APBO_PRDATA_0_IV_2q8z_Z2517: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(24),
  I3 => SLVSEL_16,
  O => APBO_PRDATA_0_IV_2(8));
APBO_PRDATA_0_IV_1q8z_Z2518: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_4_SQMUXA,
  I2 => R_MODE_CG(1),
  I3 => R_RD(8),
  O => APBO_PRDATA_0_IV_1(8));
APBO_PRDATA_IV_1q11z_Z2519: LUT4 
generic map(
  INIT => X"5D7F"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RD(11),
  I3 => R_RD(27),
  O => APBO_PRDATA_IV_1(11));
APBO_PRDATA_0_IV_0q24z_Z2520: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_EN,
  I3 => R_RD(8),
  O => APBO_PRDATA_0_IV_0(24));
APBO_PRDATA_0_IV_0q31z_Z2521: LUT4 
generic map(
  INIT => X"57DF"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  I2 => R_RD(15),
  I3 => R_RD(31),
  O => APBO_PRDATA_0_IV_0(31));
APBO_PRDATA_0_IV_0q29z_Z2522: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_RD(13),
  I3 => SLVSEL_37,
  O => APBO_PRDATA_0_IV_0(29));
APBO_PRDATA_0_IV_0q28z_Z2523: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_CPHA,
  I3 => R_RD(12),
  O => APBO_PRDATA_0_IV_0(28));
APBO_PRDATA_0_IV_0q27z_Z2524: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_DIV16,
  I3 => R_RD(11),
  O => APBO_PRDATA_0_IV_0(27));
APBO_PRDATA_0_IV_0q26z_Z2525: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_REV,
  I3 => R_RD(10),
  O => APBO_PRDATA_0_IV_0(26));
APBO_PRDATA_0_IV_0q25z_Z2526: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_5_SQMUXA,
  I2 => R_MODE_MS,
  I3 => R_RD(9),
  O => APBO_PRDATA_0_IV_0(25));
R_RBITCNT_RNIRV1M3q1z: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => N_2173,
  I1 => N_2174,
  I2 => N_2175,
  I3 => UN1_R_MODE_EN_184_0,
  O => N_2146_0);
V_IRQ_0_SQMUXA_3_Z2528: LUT4_L 
generic map(
  INIT => X"1000"
)
port map (
  I0 => COMB_UN21_SAMPLE_0,
  I1 => COMB_UN30_SAMPLE,
  I2 => R_SYNCSAMPC_1,
  I3 => V_IRQ_0_SQMUXA_3_1_0,
  LO => V_IRQ_0_SQMUXA_3);
V_EVENT_OV_0_SQMUXA_Z2529: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_UN16_SAMPLE,
  I1 => COMB_UN21_SAMPLE_0,
  I2 => R_OV,
  I3 => R_SYNCSAMPC_1,
  O => V_EVENT_OV_0_SQMUXA);
UN1_V_TXFIFO_76_2_B0_0_A5: LUT4 
generic map(
  INIT => X"0D00"
)
port map (
  I0 => COMB_CHANGE_4_1,
  I1 => COMB_UN26_AM_EN_0,
  I2 => SAMPLE_0_SQMUXA_2,
  I3 => UN1_V_TXFIFO_76_2_B0_0_O5,
  O => UN1_V_TXFIFO_76_2_N_11);
R_RDFIC_1_Z2531: LUT4_L 
generic map(
  INIT => X"7800"
)
port map (
  I0 => CO0_0,
  I1 => R_RDFI(1),
  I2 => R_RDFI(2),
  I3 => rstn,
  LO => R_RDFIC_1);
V_OV_0_SQMUXA_1_Z2532: LUT2 
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
V_DIVCNT_1_SQMUXA_Z2534: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  O => V_DIVCNT_1_SQMUXA);
RDATA_1q10z: LUT3 
generic map(
  INIT => X"7F"
)
port map (
  I0 => R_MODE_LEN(1),
  I1 => R_MODE_LEN(2),
  I2 => R_MODE_LEN(3),
  O => N_832_0_1);
R_CHNG_RNO: LUT4 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => N_2126_0,
  I1 => SAMPLE_0_SQMUXA_2,
  I2 => V_CHNG_0_SQMUXA,
  I3 => V_TOGGLE_0_SQMUXA,
  O => V_CHNG_2_SQMUXA_I);
TINDEX_1_SQMUXA_RNI6N1B9: LUT3 
generic map(
  INIT => X"F8"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => TINDEX_1_SQMUXA,
  I2 => V_TOGGLE_0_SQMUXA,
  O => V_SPIO_SCK_1_SQMUXA_I);
R_RBITCNTE_0_I_Z2538: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_SYNCSAMPC_1,
  O => R_RBITCNTE_0_I);
R_TXFIFO_7SR_0_Z2539: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1(2),
  I2 => R_TXFIFO_7(0),
  I3 => rstn,
  O => R_TXFIFO_7SR_0);
R_TXFIFO_6SR_0_Z2540: LUT4 
generic map(
  INIT => X"4700"
)
port map (
  I0 => COMB_V_TXFIFO_0_5_0(0),
  I1 => R_TDLI_RNIJFCB1_0(2),
  I2 => R_TXFIFO_6(0),
  I3 => rstn,
  O => R_TXFIFO_6SR_0);
V_IRQ_0_SQMUXA_2_0_Z2541: LUT4 
generic map(
  INIT => X"B030"
)
port map (
  I0 => apbi_pwdata(11),
  I1 => R_EVENT_UN,
  I2 => R_MASK_UN,
  I3 => V_EVENT_LT_1_SQMUXA,
  O => V_IRQ_0_SQMUXA_2_0);
COMB_V_RD_3q2z_Z2542: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(29),
  I3 => RDATA(2),
  LO => COMB_V_RD_3(2));
COMB_V_RD_3q29z_Z2543: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(29),
  I3 => RDATA(2),
  LO => COMB_V_RD_3(29));
COMB_V_RD_3q12z_Z2544: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SELECT_DATA_RDATA116_1,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(12),
  I3 => RDATA(19),
  LO => COMB_V_RD_3(12));
COMB_V_RD_3q19z_Z2545: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SELECT_DATA_RDATA116_1,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(12),
  I3 => RDATA(19),
  LO => COMB_V_RD_3(19));
COMB_V_RD_3q24z_Z2546: LUT4_L 
generic map(
  INIT => X"A0E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_RXFIFO(7),
  I2 => RDATA(24),
  I3 => RDATA_4,
  LO => COMB_V_RD_3(24));
COMB_V_RD_3q7z_Z2547: LUT4_L 
generic map(
  INIT => X"50D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_RXFIFO(7),
  I2 => RDATA(24),
  I3 => RDATA_4,
  LO => COMB_V_RD_3(7));
RDATA_0q9z_Z2548: LUT4 
generic map(
  INIT => X"FDFE"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => RDATA_0(9));
APBO_PRDATA_0_IV_0q12z_Z2549: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_OV,
  I3 => R_MASK_OV,
  O => APBO_PRDATA_0_IV_0(12));
APBO_PRDATA_0_IV_1q16z_Z2550: LUT3 
generic map(
  INIT => X"15"
)
port map (
  I0 => APBOUT_0_SQMUXA,
  I1 => APBOUT_1_SQMUXA,
  I2 => R_MODE_PM(0),
  O => APBO_PRDATA_0_IV_1(16));
APBO_PRDATA_0_IV_1q19z_Z2551: LUT3 
generic map(
  INIT => X"15"
)
port map (
  I0 => APBOUT_0_SQMUXA,
  I1 => APBOUT_1_SQMUXA,
  I2 => R_MODE_PM(3),
  O => APBO_PRDATA_0_IV_1(19));
APBO_PRDATA_0_IV_1q14z_Z2552: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_LT,
  I3 => R_MASK_LT,
  O => APBO_PRDATA_0_IV_1(14));
APBO_PRDATA_0_IV_2q10z_Z2553: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_MME,
  I3 => R_MASK_MME,
  O => APBO_PRDATA_0_IV_2(10));
APBO_PRDATA_0_IV_2q9z_Z2554: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_NE,
  I3 => R_MASK_NE,
  O => APBO_PRDATA_0_IV_2(9));
APBO_PRDATA_0_IV_0q8z_Z2555: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_NF,
  I3 => R_MASK_NF,
  O => APBO_PRDATA_0_IV_0(8));
APBO_PRDATA_IV_2q11z_Z2556: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_1_SQMUXA,
  I1 => APBOUT_6_SQMUXA,
  I2 => R_MODE_CG(4),
  I3 => SLVSEL_19,
  O => APBO_PRDATA_IV_2(11));
APBO_PRDATA_IV_0q11z_Z2557: LUT3 
generic map(
  INIT => X"15"
)
port map (
  I0 => APBOUT_0_SQMUXA,
  I1 => APBOUT_2_SQMUXA,
  I2 => R_EVENT_UN,
  O => APBO_PRDATA_IV_0(11));
APBO_PRDATA_0_IV_1q31z_Z2558: LUT4 
generic map(
  INIT => X"135F"
)
port map (
  I0 => APBOUT_2_SQMUXA,
  I1 => APBOUT_3_SQMUXA,
  I2 => R_EVENT_TIP,
  I3 => R_MASK_TIP,
  O => APBO_PRDATA_0_IV_1(31));
APBO_PRDATA_0_IV_1q29z_Z2559: LUT3 
generic map(
  INIT => X"15"
)
port map (
  I0 => APBOUT_0_SQMUXA,
  I1 => APBOUT_1_SQMUXA,
  I2 => R_MODE_CPOL,
  O => APBO_PRDATA_0_IV_1(29));
COMB_SAMPLE_1_U: LUT4 
generic map(
  INIT => X"8A00"
)
port map (
  I0 => COMB_UN30_SAMPLE,
  I1 => R_MODE_LOOPB,
  I2 => R_MODE_MS,
  I3 => R_SYNCSAMPC_1,
  O => COMB_SAMPLE_1);
COMB_UN40_SAMPLE_NE: LUT4 
generic map(
  INIT => X"0440"
)
port map (
  I0 => COMB_UN40_SAMPLE_2,
  I1 => COMB_UN40_SAMPLE_NE_1,
  I2 => LEN_1_0(1),
  I3 => R_RBITCNT(1),
  O => COMB_UN40_SAMPLE);
V_TD_OCC_1_SQMUXA_Z2562: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => apbi_paddr(3),
  I1 => R_EVENT_NF,
  I2 => V_TD_OCC_1_SQMUXA_3,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => V_TD_OCC_1_SQMUXA);
R_SYNCSAMPC_Z2563: LUT4_L 
generic map(
  INIT => X"1000"
)
port map (
  I0 => COMB_UN16_SAMPLE,
  I1 => R_MODE_LOOPB,
  I2 => R_MODE_MS,
  I3 => R_SYNCSAMPC_1,
  LO => R_SYNCSAMPC);
R_RDFIC_0_Z2564: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => CO0_0,
  I1 => R_RDFI(1),
  I2 => rstn,
  LO => R_RDFIC_0);
COMB_V_IRQ_1_IV_M5_E_Z2565: LUT3_L 
generic map(
  INIT => X"C8"
)
port map (
  I0 => COMB_V_IRQ_1_IV_M3_E,
  I1 => R_MODE_EN,
  I2 => V_IRQ_0_SQMUXA_1,
  LO => COMB_V_IRQ_1_IV_M5_E);
R_RD_RNINLK8q7z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(7),
  O => R_RD_M(7));
COMB_V_SPIO_SCK20_Z2567: LUT3 
generic map(
  INIT => X"C4"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  O => COMB_V_SPIO_SCK20);
CHANGE_1_SQMUXA_Z2568: LUT4_L 
generic map(
  INIT => X"010F"
)
port map (
  I0 => COMB_OP_EQ_UN2_ASEL_EN,
  I1 => COMB_UN6_ASEL_EN,
  I2 => SAMPLE_0_SQMUXA_2,
  I3 => V_TOGGLE_0_SQMUXA_A0_0,
  LO => CHANGE_1_SQMUXA);
COMB_V_SPIO_MOSI_2_2: MUXF6 port map (
    I0 => UN152_CHANGE_7(8),
    I1 => UN152_CHANGE_7(24),
    S => R_TBITCNT(4),
    O => N_839);
COMB_V_SPIO_MOSI_2_5: MUXF7 port map (
    I0 => UN152_CHANGE_7(12),
    I1 => UN152_CHANGE_7(28),
    S => R_TBITCNT(4),
    O => N_842);
COMB_V_SPIO_MOSI_2_11: MUXF6 port map (
    I0 => UN152_CHANGE_7(6),
    I1 => UN152_CHANGE_7(22),
    S => R_TBITCNT(4),
    O => N_848);
COMB_V_SPIO_MOSI_2_27: MUXF7 port map (
    I0 => UN152_CHANGE(15),
    I1 => UN152_CHANGE_7(31),
    S => R_TBITCNT(4),
    O => N_864);
R_RXFIFO_I_10_RNI81BV: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_SELECT_DATA_RDATA116_1,
  I1 => LEN_1_0(0),
  I2 => LEN_1_0(1),
  I3 => R_RXFIFO(15),
  O => RDATA(15));
COMB_V_SPIO_MOSI_2_20: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_20_AM,
    I1 => COMB_V_SPIO_MOSI_2_20_BM,
    S => R_TBITCNT(4),
    O => N_857);
COMB_V_SPIO_MOSI_2_20_BM_Z2575: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(29),
  I1 => N_1663,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_20_BM);
COMB_V_SPIO_MOSI_2_20_AM_Z2576: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(13),
  I1 => UN152_CHANGE_6(13),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_20_AM);
R_TDLI_RNOq2z_Z2577: LUT4_L 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  LO => R_TDLI_RNO(2));
COMB_V_SPIO_MOSI_2_9: MUXF6 port map (
    I0 => UN152_CHANGE_7(10),
    I1 => UN152_CHANGE(26),
    S => R_TBITCNT(4),
    O => N_846);
RDATA_3q10z: LUT3 
generic map(
  INIT => X"DF"
)
port map (
  I0 => R_MODE_LEN(1),
  I1 => R_MODE_LEN(2),
  I2 => R_MODE_LEN(3),
  O => N_822_0_3);
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
COMB_INDATA_1_U_1_Z2581: LUT4 
generic map(
  INIT => X"0F1B"
)
port map (
  I0 => R_MODE_TW,
  I1 => R_SPII_1_MISO,
  I2 => R_SPII_1_MOSI,
  I3 => V_PSCK_0_SQMUXA,
  O => COMB_INDATA_1_U_1);
UN1_RELOADq4z_Z2582: LUT3 
generic map(
  INIT => X"2E"
)
port map (
  I0 => N_876,
  I1 => N_881,
  I2 => R_MODE_PM(0),
  O => UN1_RELOAD(4));
COMB_V_SPIO_MOSI_2_26_Z2583: MUXF7 port map (
    I0 => UN152_CHANGE_7(7),
    I1 => UN152_CHANGE_7(23),
    S => COMB_TINDEX_1(4),
    O => COMB_V_SPIO_MOSI_2_26);
COMB_V_SPIO_MOSI_2_19: MUXF5 port map (
    I0 => COMB_V_SPIO_MOSI_2_19_AM,
    I1 => COMB_V_SPIO_MOSI_2_19_BM,
    S => COMB_TINDEX_1(4),
    O => N_856);
COMB_V_SPIO_MOSI_2_19_BM_Z2585: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => UN152_CHANGE_3(21),
  I1 => UN152_CHANGE_6(21),
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_19_BM);
COMB_V_SPIO_MOSI_2_19_AM_Z2586: LUT3 
generic map(
  INIT => X"CA"
)
port map (
  I0 => N_1546,
  I1 => N_1639,
  I2 => R_TDFI(0),
  O => COMB_V_SPIO_MOSI_2_19_AM);
COMB_V_SPIO_MOSI_2_12: MUXF7 port map (
    I0 => UN152_CHANGE_7(14),
    I1 => UN152_CHANGE_7(30),
    S => COMB_TINDEX_1(4),
    O => N_849);
COMB_V_SPIO_MOSI_2_8: MUXF6 port map (
    I0 => UN152_CHANGE_7(2),
    I1 => UN152_CHANGE_7(18),
    S => COMB_TINDEX_1(4),
    O => N_845);
COMB_V_SPIO_MOSI_2_4: MUXF6 port map (
    I0 => UN152_CHANGE_7(4),
    I1 => UN152_CHANGE_7(20),
    S => COMB_TINDEX_1(4),
    O => N_841);
COMB_V_SPIO_MOSI_2_1: MUXF6 port map (
    I0 => UN152_CHANGE_7(0),
    I1 => UN152_CHANGE_7(16),
    S => COMB_TINDEX_1(4),
    O => N_838);
R_RD_RNIARU9q28z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(28),
  O => R_RD_M_0(28));
R_RD_RNI9NU9q27z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(27),
  O => R_RD_M_0(27));
R_RD_RNI8JU9q26z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(26),
  O => R_RD_M_0(26));
R_RD_RNI7FU9q25z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(25),
  O => R_RD_M_0(25));
R_RD_RNI57U9q23z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(23),
  O => R_RD_M_0(23));
R_RD_RNI43U9q22z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(22),
  O => R_RD_M_0(22));
R_RD_RNI3VT9q21z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(21),
  O => R_RD_M_0(21));
R_RD_RNI2RT9q20z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(20),
  O => R_RD_M_0(20));
R_RD_RNI9RU9q18z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_4_SQMUXA,
  I1 => R_RD(18),
  O => R_RD_M_0(18));
R_RD_RNI5VT9q31z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => R_RD(31),
  O => R_RD_M(31));
R_RD_RNICVU9q29z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => R_RD(29),
  O => R_RD_M(29));
R_RD_RNIBVU9q19z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_5_SQMUXA,
  I1 => R_RD(19),
  O => R_RD_M(19));
V_IRQ_0_SQMUXA_1_0_RNIKMMA: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => V_IRQ_0_SQMUXA_1_0,
  I1 => V_MODE_CPHA_0_SQMUXA,
  O => V_MODE_EN_1_SQMUXA_I);
R_RD_FREE_RNO_0: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_V_RD4,
  O => V_RD_FREE_0_SQMUXA_I);
R_SAMP_RNO_0: LUT4 
generic map(
  INIT => X"FFFD"
)
port map (
  I0 => N_2126_0,
  I1 => N_2127_0,
  I2 => SAMPLE_0_SQMUXA_2,
  I3 => V_CHNG_0_SQMUXA,
  O => V_SAMP_2_SQMUXA_I);
R_SAMP_RNO: LUT4_L 
generic map(
  INIT => X"0D2F"
)
port map (
  I0 => N_2126_0,
  I1 => N_2128_0,
  I2 => R_MODE_CPHA,
  I3 => R_SAMP,
  LO => N_2115_0_I);
COMB_V_RD_3q8z_Z2607: LUT4_L 
generic map(
  INIT => X"7340"
)
port map (
  I0 => LEN_1_0(3),
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(8),
  I3 => RDATA(23),
  LO => COMB_V_RD_3(8));
COMB_V_RD_3q23z_Z2608: LUT4_L 
generic map(
  INIT => X"DC10"
)
port map (
  I0 => LEN_1_0(3),
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(8),
  I3 => RDATA(23),
  LO => COMB_V_RD_3(23));
COMB_V_RD_3q26z_Z2609: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(26),
  I3 => RDATA(5),
  LO => COMB_V_RD_3(26));
COMB_V_RD_3q25z_Z2610: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(25),
  I3 => RDATA(6),
  LO => COMB_V_RD_3(25));
COMB_V_RD_3q6z_Z2611: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(25),
  I3 => RDATA(6),
  LO => COMB_V_RD_3(6));
COMB_V_RD_3q5z_Z2612: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(26),
  I3 => RDATA(5),
  LO => COMB_V_RD_3(5));
UN1_RELOADq5z_Z2613: LUT4 
generic map(
  INIT => X"02F2"
)
port map (
  I0 => N_635,
  I1 => R_MODE_DIV16,
  I2 => R_MODE_FACT,
  I3 => R_MODE_PM(0),
  O => UN1_RELOAD(5));
R_RBITCNT_RNI42OTq1z: LUT4 
generic map(
  INIT => X"4100"
)
port map (
  I0 => N_2167_0,
  I1 => R_MODE_LEN(1),
  I2 => R_RBITCNT(1),
  I3 => UN1_R_MODE_EN_184_A6_0,
  O => N_2173);
COMB_SELECT_DATA_RDATA118_Z2615: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => COMB_SELECT_DATA_RDATA118);
COMB_SELECT_DATA_RDATA116_Z2616: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => COMB_SELECT_DATA_RDATA116);
R_TDLI_RNIJFCB1_5q2z_Z2617: LUT4 
generic map(
  INIT => X"0008"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_5(2));
R_TDLI_RNIJFCB1_6q2z_Z2618: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_6(2));
R_TDLI_RNIJFCB1_1q2z_Z2619: LUT4 
generic map(
  INIT => X"0800"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_1(2));
R_TDLI_RNIJFCB1_2q2z_Z2620: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_2(2));
R_TDLI_RNIJFCB1_4q2z_Z2621: LUT4 
generic map(
  INIT => X"0020"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_4(2));
V_IRQ_0_SQMUXA_2_1_Z2622: LUT3 
generic map(
  INIT => X"20"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => COMB_UN26_AM_EN_0,
  I2 => COMB_UN30_AM_EN,
  O => V_IRQ_0_SQMUXA_2_1);
APBOUT_4_SQMUXA_Z2623: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  O => APBOUT_4_SQMUXA);
R_SPIO_SCK_RNITJ8I8: LUT3 
generic map(
  INIT => X"E0"
)
port map (
  I0 => COMB_OP_EQ_UN2_ASEL_EN,
  I1 => COMB_UN6_ASEL_EN,
  I2 => V_TOGGLE_0_SQMUXA_A0_0,
  O => V_TOGGLE_0_SQMUXA);
R_RDFIC_Z2625: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => COMB_V_RD4,
  I1 => R_RDFI(0),
  I2 => rstn,
  LO => R_RDFIC);
R_EVENT_UNCE_Z2626: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(11),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_UNCE);
R_EVENT_LTCE_Z2627: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(14),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_LTCE);
R_EVENT_OVCE_Z2628: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(12),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_OVCE);
R_EVENT_MMECE_Z2629: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => apbi_pwdata(10),
  I1 => V_EVENT_LT_1_SQMUXA,
  O => R_EVENT_MMECE);
R_MASK_UN_RNIQVP9: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_3_SQMUXA,
  I1 => R_MASK_UN,
  O => R_MASK_UN_M);
R_SLVSEL_RNIVUF3q24z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_6_SQMUXA,
  I1 => SLVSEL_32,
  O => R_SLVSEL_M(24));
COMB_SAMPLE_5: LUT3 
generic map(
  INIT => X"C8"
)
port map (
  I0 => N_2127_0,
  I1 => R_SAMP,
  I2 => SAMPLE_0_SQMUXA_2,
  O => R_SYNCSAMPC_1);
R_SLVSEL_RNI1BG3q17z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_6_SQMUXA,
  I1 => SLVSEL_25,
  O => R_SLVSEL_M(17));
R_RXFIFO_I_24_RNIC3JL: LUT3 
generic map(
  INIT => X"4C"
)
port map (
  I0 => LEN_1_0(1),
  I1 => R_RXFIFO(2),
  I2 => RDATA_2_0,
  O => RDATA(2));
R_TDLI_RNIJFCB1_3q2z_Z2635: LUT4 
generic map(
  INIT => X"0080"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_3(2));
R_TDLI_RNOq1z_Z2636: LUT3_L 
generic map(
  INIT => X"78"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  LO => R_TDLI_RNO(1));
R_SLVSEL_RNISEF3q30z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => APBOUT_6_SQMUXA,
  I1 => SLVSEL_38,
  O => R_SLVSEL_M(30));
APBOUT_5_SQMUXA_Z2638: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => APBOUT_5_SQMUXA_1,
  I1 => COMB_SPILEN_LEN,
  O => APBOUT_5_SQMUXA);
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
  I0 => N_2126_0,
  I1 => V_CHNG_0_SQMUXA,
  I2 => V_PSCK_0_SQMUXA,
  O => V_PSCK_1_SQMUXA_I);
R_TOGGLE_RNIFPPS: LUT4_L 
generic map(
  INIT => X"C480"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_SAMP,
  I2 => R_TOGGLE,
  I3 => SAMPLE_0_SQMUXA_1,
  LO => UN1_R_MODE_EN_184_0);
COMB_V_CHNG_1_Z2642: LUT4_L 
generic map(
  INIT => X"F072"
)
port map (
  I0 => N_2126_0,
  I1 => R_CHNG,
  I2 => R_MODE_CPHA,
  I3 => V_CHNG_0_SQMUXA,
  LO => COMB_V_CHNG_1);
UN152_CHANGE_7q15z: MUXF6 port map (
    I0 => UN152_CHANGE_3(15),
    I1 => UN152_CHANGE_6(15),
    S => R_TDFI(0),
    O => UN152_CHANGE(15));
COMB_V_RD_3q4z_Z2644: LUT4_L 
generic map(
  INIT => X"EC20"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(27),
  I3 => RDATA(4),
  LO => COMB_V_RD_3(4));
COMB_V_RD_3q27z_Z2645: LUT4_L 
generic map(
  INIT => X"B380"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(27),
  I3 => RDATA(4),
  LO => COMB_V_RD_3(27));
UN152_CHANGE_7q26z: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(26),
    I1 => UN152_CHANGE_7_BM(26),
    S => R_TDFI(0),
    O => UN152_CHANGE(26));
COMB_V_RD_3q31z_Z2647: LUT4_L 
generic map(
  INIT => X"B830"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(0),
  I3 => R_RXFIFO(31),
  LO => COMB_V_RD_3(31));
COMB_V_RD_3q0z_Z2648: LUT4_L 
generic map(
  INIT => X"E2C0"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(0),
  I3 => R_RXFIFO(31),
  LO => COMB_V_RD_3(0));
COMB_V_RD_3q30z_Z2649: LUT4_L 
generic map(
  INIT => X"B830"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(1),
  I3 => R_RXFIFO(30),
  LO => COMB_V_RD_3(30));
COMB_V_RD_3q1z_Z2650: LUT4_L 
generic map(
  INIT => X"E2C0"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_REV,
  I2 => R_RXFIFO(1),
  I3 => R_RXFIFO(30),
  LO => COMB_V_RD_3(1));
UN1_RELOAD_0q4z: LUT4_L 
generic map(
  INIT => X"2EE2"
)
port map (
  I0 => N_636,
  I1 => R_MODE_FACT,
  I2 => R_MODE_PM(0),
  I3 => R_MODE_PM(1),
  LO => N_876);
UN152_CHANGE_7q0z_Z2652: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(0),
    I1 => UN152_CHANGE_7_BM(0),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(0));
COMB_V_RD_3q28z_Z2653: LUT4_L 
generic map(
  INIT => X"A0E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_RXFIFO(3),
  I2 => RDATA(28),
  I3 => RDATA_3_0,
  LO => COMB_V_RD_3(28));
COMB_V_RD_3q3z_Z2654: LUT4_L 
generic map(
  INIT => X"50D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_RXFIFO(3),
  I2 => RDATA(28),
  I3 => RDATA_3_0,
  LO => COMB_V_RD_3(3));
UN152_CHANGE_7q31z_Z2655: MUXF6 port map (
    I0 => UN152_CHANGE_3(31),
    I1 => UN152_CHANGE_6(31),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(31));
UN152_CHANGE_7q30z_Z2656: MUXF6 port map (
    I0 => UN152_CHANGE_3(30),
    I1 => UN152_CHANGE_6(30),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(30));
UN152_CHANGE_7q28z_Z2657: MUXF6 port map (
    I0 => UN152_CHANGE_3(28),
    I1 => UN152_CHANGE_6(28),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(28));
UN152_CHANGE_7q27z_Z2658: MUXF6 port map (
    I0 => UN152_CHANGE_3(27),
    I1 => UN152_CHANGE_6(27),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(27));
UN152_CHANGE_7q25z_Z2659: MUXF6 port map (
    I0 => UN152_CHANGE_3(25),
    I1 => UN152_CHANGE_6(25),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(25));
UN152_CHANGE_7q24z_Z2660: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(24),
    I1 => UN152_CHANGE_7_BM(24),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(24));
UN152_CHANGE_7q23z_Z2661: MUXF6 port map (
    I0 => UN152_CHANGE_3(23),
    I1 => UN152_CHANGE_6(23),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(23));
UN152_CHANGE_7q22z_Z2662: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(22),
    I1 => UN152_CHANGE_7_BM(22),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(22));
UN152_CHANGE_7q20z_Z2663: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(20),
    I1 => UN152_CHANGE_7_BM(20),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(20));
UN152_CHANGE_7q19z_Z2664: MUXF6 port map (
    I0 => UN152_CHANGE_3(19),
    I1 => UN152_CHANGE_6(19),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(19));
UN152_CHANGE_7q18z_Z2665: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(18),
    I1 => UN152_CHANGE_7_BM(18),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(18));
UN152_CHANGE_7q17z_Z2666: MUXF6 port map (
    I0 => UN152_CHANGE_3(17),
    I1 => UN152_CHANGE_6(17),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(17));
UN152_CHANGE_7q16z_Z2667: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(16),
    I1 => UN152_CHANGE_7_BM(16),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(16));
UN152_CHANGE_7q14z_Z2668: MUXF6 port map (
    I0 => UN152_CHANGE_3(14),
    I1 => UN152_CHANGE_6(14),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(14));
UN152_CHANGE_7q12z_Z2669: MUXF6 port map (
    I0 => UN152_CHANGE_3(12),
    I1 => UN152_CHANGE_6(12),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(12));
UN152_CHANGE_7q11z_Z2670: MUXF6 port map (
    I0 => UN152_CHANGE_3(11),
    I1 => UN152_CHANGE_6(11),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(11));
UN152_CHANGE_7q10z_Z2671: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(10),
    I1 => UN152_CHANGE_7_BM(10),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(10));
UN152_CHANGE_7q9z_Z2672: MUXF6 port map (
    I0 => UN152_CHANGE_3(9),
    I1 => UN152_CHANGE_6(9),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(9));
UN152_CHANGE_7q8z_Z2673: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(8),
    I1 => UN152_CHANGE_7_BM(8),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(8));
UN152_CHANGE_7q7z_Z2674: MUXF6 port map (
    I0 => UN152_CHANGE_3(7),
    I1 => UN152_CHANGE_6(7),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(7));
UN152_CHANGE_7q6z_Z2675: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(6),
    I1 => UN152_CHANGE_7_BM(6),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(6));
UN152_CHANGE_7q4z_Z2676: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(4),
    I1 => UN152_CHANGE_7_BM(4),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(4));
UN152_CHANGE_7q3z_Z2677: MUXF6 port map (
    I0 => UN152_CHANGE_3(3),
    I1 => UN152_CHANGE_6(3),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(3));
UN152_CHANGE_7q2z_Z2678: MUXF5 port map (
    I0 => UN152_CHANGE_7_AM(2),
    I1 => UN152_CHANGE_7_BM(2),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(2));
UN152_CHANGE_7q1z_Z2679: MUXF6 port map (
    I0 => UN152_CHANGE_3(1),
    I1 => UN152_CHANGE_6(1),
    S => R_TDFI(0),
    O => UN152_CHANGE_7(1));
V_TXFIFO_4_1_SQMUXA_1_2_Z2680: LUT4 
generic map(
  INIT => X"0200"
)
port map (
  I0 => COMB_UN40_CHANGE,
  I1 => R_TDFI(0),
  I2 => R_TDFI(1),
  I3 => R_TDFI(2),
  O => V_TXFIFO_4_1_SQMUXA_1_2);
V_TXFIFO_0_1_SQMUXA_1_1_Z2681: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => COMB_UN40_CHANGE,
  I1 => R_TDFI(0),
  I2 => R_TDFI(1),
  I3 => R_TDFI(2),
  O => V_TXFIFO_0_1_SQMUXA_1_1);
UN1_V_TXFIFO_76_2_B0_0_0_Z2682: LUT3 
generic map(
  INIT => X"BF"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => R_TD_OCC,
  O => UN1_V_TXFIFO_76_2_B0_0_0);
UN1_V_TXFIFO_76_3_M9_I_0_Z2683: LUT3 
generic map(
  INIT => X"73"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => COMB_UN40_CHANGE,
  I2 => R_TD_OCC,
  O => UN1_V_TXFIFO_76_3_M9_I_0);
COMB_UN27_CHANGE_NE_0_Z2684: LUT4 
generic map(
  INIT => X"A041"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN_0_REP1,
  I2 => R_TBITCNT(0),
  I3 => R_TBITCNT(4),
  O => COMB_UN27_CHANGE_NE_0);
COMB_UN40_SAMPLE_NE_1_Z2685: LUT4 
generic map(
  INIT => X"0804"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => COMB_UN40_SAMPLE_NE_2_N_8_I,
  I2 => COMB_UN40_SAMPLE_NE_2_N_12_I,
  I3 => R_RBITCNT(4),
  O => COMB_UN40_SAMPLE_NE_1);
V_TD_OCC_1_SQMUXA_3_Z2686: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(4),
  I2 => apbi_paddr(5),
  I3 => COMB_UN30_APBI_PSEL,
  O => V_TD_OCC_1_SQMUXA_3);
APBOUT_4_SQMUXA_0: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(4),
  I2 => COMB_UN1_APBI_PSEL,
  I3 => COMB_UN17_APBI_PSEL_2,
  O => APBOUT_5_SQMUXA_1);
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
R_MODE_LEN_RNI42OTq0z: LUT4 
generic map(
  INIT => X"1000"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(2),
  I2 => UN1_R_MODE_EN_184_A6_1_4,
  I3 => UN1_R_MODE_EN_184_A6_1_5,
  O => N_2175);
R_TDLI_RNIJFCB1q2z_Z2690: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1(2));
R_TDLI_RNIJFCB1_0q2z_Z2691: LUT4 
generic map(
  INIT => X"2000"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  I2 => R_TDLI(1),
  I3 => R_TDLI(2),
  O => R_TDLI_RNIJFCB1_0(2));
V_IRQ_0_SQMUXA_1_Z2692: LUT4 
generic map(
  INIT => X"1030"
)
port map (
  I0 => COMB_UN1_AM_EN,
  I1 => R_EVENT_NE,
  I2 => R_MASK_NE,
  I3 => R_RD_FREE,
  O => V_IRQ_0_SQMUXA_1);
R_RBITCNT_RNI42OTq2z: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => N_2165_0,
  I1 => R_MODE_LEN(2),
  I2 => R_RBITCNT(2),
  I3 => UN1_R_MODE_EN_184_A6_0_1,
  O => N_2174);
COMB_OP_EQ_V_SPIO_SCK2_Z2694: LUT4 
generic map(
  INIT => X"0008"
)
port map (
  I0 => COMB_OP_EQ_V_SPIO_SCK2_5,
  I1 => COMB_OP_EQ_V_SPIO_SCK2_6,
  I2 => R_DIVCNT(1),
  I3 => R_DIVCNT(8),
  O => COMB_OP_EQ_V_SPIO_SCK2);
RDATA_0q7z: LUT4 
generic map(
  INIT => X"007E"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => RDATA_4);
APBOUT_0_SQMUXA_Z2696: LUT3 
generic map(
  INIT => X"40"
)
port map (
  I0 => apbi_paddr(2),
  I1 => APBOUT_0_SQMUXA_3,
  I2 => COMB_UN1_APBI_PSEL,
  O => APBOUT_0_SQMUXA);
COMB_V_IRQ_1_IV_M3_E_Z2697: LUT4_L 
generic map(
  INIT => X"1030"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_EVENT_NF,
  I2 => R_MASK_NF,
  I3 => R_TD_OCC,
  LO => COMB_V_IRQ_1_IV_M3_E);
R_RDLIC_1_Z2698: LUT4_L 
generic map(
  INIT => X"7800"
)
port map (
  I0 => CO0_3,
  I1 => R_RDLI(1),
  I2 => R_RDLI(2),
  I3 => rstn,
  LO => R_RDLIC_1);
R_RXDONE2_RNO: LUT1_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => COMB_UN1_R_RUNNING_1,
  LO => COMB_UN1_R_RUNNING_1_I);
R_TD_OCC_RNO: LUT2_L 
generic map(
  INIT => X"B"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  LO => COMB_V_TXFIFO_76_I);
COMB_V_TWDIR_1_IV_0_TZ_Z2701: LUT3 
generic map(
  INIT => X"7D"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_MODE_TTO,
  O => COMB_V_TWDIR_1_IV_0_TZ);
R_RBITCNT_RNIU6HEq2z: LUT4_L 
generic map(
  INIT => X"7BDF"
)
port map (
  I0 => R_MODE_LEN(2),
  I1 => R_MODE_LEN(3),
  I2 => R_RBITCNT(2),
  I3 => R_RBITCNT(3),
  LO => N_2167_0);
COMB_UN27_CHANGE_2_0: LUT3 
generic map(
  INIT => X"1E"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN_2_REP1,
  I2 => R_TBITCNT(2),
  O => COMB_UN27_CHANGE_2);
COMB_SELECT_DATA_RDATA114_2: LUT4 
generic map(
  INIT => X"F001"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => COMB_SELECT_DATA_RDATA116_1);
R_TDLI_RNOq0z_Z2705: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => COMB_V_TXFIFO_76,
  I1 => R_TDLI(0),
  LO => R_TDLI_RNO(0));
V_EVENT_NF_0_SQMUXA_Z2706: LUT3 
generic map(
  INIT => X"2A"
)
port map (
  I0 => N_2126_0,
  I1 => COMB_UN1_R_TFREECNT,
  I2 => R_TD_OCC,
  O => V_EVENT_NF_0_SQMUXA);
V_EVENT_NE_0_SQMUXA_1_Z2707: LUT3 
generic map(
  INIT => X"2A"
)
port map (
  I0 => N_2126_0,
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
COMB_UN40_SAMPLE_2_0: LUT3 
generic map(
  INIT => X"1E"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_MODE_LEN(2),
  I2 => R_RBITCNT(2),
  O => COMB_UN40_SAMPLE_2);
R_RXFIFO_I_11_RNI8J1E: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RXFIFO(6),
  I1 => RDATA_0_0,
  O => RDATA(6));
R_RXFIFO_I_23_RNITGVH: LUT3 
generic map(
  INIT => X"D0"
)
port map (
  I0 => N_1759_I,
  I1 => R_MODE_LEN(3),
  I2 => R_RXFIFO(5),
  O => RDATA(5));
COMB_UN26_AM_EN: LUT4 
generic map(
  INIT => X"45CF"
)
port map (
  I0 => COMB_SLV_START_UN13_AM_EN,
  I1 => COMB_UN30_AM_EN,
  I2 => R_MODE_MS_FAST,
  I3 => SAMPLE_0_SQMUXA_1,
  O => COMB_UN26_AM_EN_0);
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
APBOUT_3_SQMUXA_Z2715: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(5),
  I2 => COMB_UN1_APBI_PSEL,
  I3 => COMB_UN13_APBI_PSEL_2,
  O => APBOUT_3_SQMUXA);
APBOUT_1_SQMUXA_Z2716: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => APBOUT_0_SQMUXA_2,
  I1 => COMB_UN1_APBI_PSEL,
  I2 => COMB_UN5_APBI_PSEL_1,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => APBOUT_1_SQMUXA);
V_MODE_CPHA_0_SQMUXA_Z2717: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => APBOUT_0_SQMUXA_2,
  I1 => COMB_UN5_APBI_PSEL_1,
  I2 => COMB_UN30_APBI_PSEL,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => V_MODE_CPHA_0_SQMUXA);
V_MASK_LT_1_SQMUXA_Z2718: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(5),
  I2 => COMB_UN13_APBI_PSEL_2,
  I3 => COMB_UN30_APBI_PSEL,
  O => V_MASK_LT_1_SQMUXA);
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
  LO => N_2143);
APBOUT_0_SQMUXA_3_Z2721: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => apbi_paddr(5),
  I1 => apbi_paddr(6),
  I2 => apbi_paddr(7),
  I3 => APBOUT_0_SQMUXA_2,
  O => APBOUT_0_SQMUXA_3);
COMB_UN16_SAMPLE_Z2722: LUT4 
generic map(
  INIT => X"0002"
)
port map (
  I0 => COMB_UN16_SAMPLE_1,
  I1 => R_RFREECNT(0),
  I2 => R_RFREECNT(2),
  I3 => R_RFREECNT(3),
  O => COMB_UN16_SAMPLE);
RDATA_0q6z: LUT4 
generic map(
  INIT => X"003E"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => RDATA_0_0);
COMB_UN21_APBI_PSEL_Z2724: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(4),
  I2 => COMB_UN5_APBI_PSEL_1,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => COMB_UN21_APBI_PSEL);
COMB_UN9_APBI_PSEL_Z2725: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  I2 => APBOUT_0_SQMUXA_2,
  I3 => V_TD_OCC_1_SQMUXA_4,
  O => COMB_UN9_APBI_PSEL);
R_RDLIC_0_Z2726: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => CO0_3,
  I1 => R_RDLI(1),
  I2 => rstn,
  LO => R_RDLIC_0);
R_RXFIFO_I_22_RNI8B1E: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_RXFIFO(4),
  I1 => RDATA_2_0,
  O => RDATA(4));
COMB_TINDEX_1q4z_Z2728: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  I3 => R_TBITCNT(4),
  O => COMB_TINDEX_1(4));
COMB_TINDEX_1q3z_Z2729: LUT4 
generic map(
  INIT => X"FD00"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  I3 => R_TBITCNT(3),
  O => COMB_TINDEX_1(3));
COMB_TINDEX_1q2z_Z2730: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(2),
  I1 => TINDEX_0_SQMUXA,
  O => COMB_TINDEX_1(2));
COMB_TINDEX_1q1z_Z2731: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(1),
  I1 => TINDEX_0_SQMUXA,
  O => COMB_TINDEX_1(1));
COMB_TINDEX_1q0z_Z2732: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_TBITCNT(0),
  I1 => TINDEX_0_SQMUXA,
  O => COMB_TINDEX_1(0));
COMB_V_TXFIFO_76_Z2733: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => COMB_UN1_R_TFREECNT,
  I1 => R_TD_OCC,
  O => COMB_V_TXFIFO_76);
COMB_UN1_R_RUNNING_1_Z2734: LUT4 
generic map(
  INIT => X"0F0E"
)
port map (
  I0 => COMB_UN1_R_MODE_TW,
  I1 => R_OV2,
  I2 => R_RUNNING,
  I3 => R_RXDONE2,
  O => COMB_UN1_R_RUNNING_1);
R_RBITCNT_RNIMMGEq1z: LUT4 
generic map(
  INIT => X"7BDF"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_RBITCNT(0),
  I3 => R_RBITCNT(1),
  O => N_2165_0);
R_RXFIFO_I_3_RNIF33D: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_RXFIFO(23),
  O => RDATA(23));
R_RXFIFO_I_2_RNIE33D: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_RXFIFO(19),
  O => RDATA(19));
COMB_UN40_CHANGE_Z2738: LUT4 
generic map(
  INIT => X"00BF"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_TW,
  I2 => R_TWDIR,
  I3 => R_UF,
  O => COMB_UN40_CHANGE);
LEN_1q3z: LUT4 
generic map(
  INIT => X"00FE"
)
port map (
  I0 => R_MODE_LEN_0_REP1,
  I1 => R_MODE_LEN_2_REP1,
  I2 => R_MODE_LEN_FAST(1),
  I3 => R_MODE_LEN_FAST(3),
  O => LEN_1_0(3));
LEN_1q1z: LUT4 
generic map(
  INIT => X"0F0E"
)
port map (
  I0 => R_MODE_LEN_0_REP1,
  I1 => R_MODE_LEN_2_REP1,
  I2 => R_MODE_LEN_FAST(1),
  I3 => R_MODE_LEN_FAST(3),
  O => LEN_1_0(1));
LEN_1q0z: LUT4 
generic map(
  INIT => X"5554"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => LEN_1_0(0));
R_RXFIFO_I_4_RNIG33D: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_RXFIFO(24),
  O => RDATA(24));
R_MODE_PM_RNIUNLG_0q3z: LUT4 
generic map(
  INIT => X"7F80"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  I3 => R_MODE_PM(3),
  O => N_635);
COMB_INDATA_1_U_RNO: LUT3 
generic map(
  INIT => X"0B"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_MS,
  I2 => V_PSCK_0_SQMUXA,
  O => COMB_INDATA_1_SN_N_6_0);
R_MODE_PM_RNIOEJGq2z_Z2745: LUT4 
generic map(
  INIT => X"1540"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  I2 => R_MODE_PM(1),
  I3 => R_MODE_PM(2),
  O => R_MODE_PM_RNIOEJG(2));
R_MODE_PM_RNIUNLGq3z: LUT4 
generic map(
  INIT => X"8000"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  I3 => R_MODE_PM(3),
  O => N_636);
COMB_V_RD4_Z2747: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => COMB_UN1_AM_EN,
  I1 => R_RD_FREE,
  O => COMB_V_RD4);
R_RXFIFO_I_5_RNIH33D: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_SPILEN_LEN,
  I1 => R_RXFIFO(28),
  O => RDATA(28));
UN152_CHANGE_6q31z_Z2749: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(31),
    I1 => UN152_CHANGE_6_BM(31),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(31));
UN152_CHANGE_6_BMq31z_Z2750: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(31),
  I2 => R_TXFIFO_7(31),
  O => UN152_CHANGE_6_BM(31));
UN152_CHANGE_6_AMq31z_Z2751: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(31),
  I2 => R_TXFIFO_5(31),
  O => UN152_CHANGE_6_AM(31));
UN152_CHANGE_6q30z_Z2752: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(30),
    I1 => UN152_CHANGE_6_BM(30),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(30));
UN152_CHANGE_6_BMq30z_Z2753: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(30),
  I2 => R_TXFIFO_7(30),
  O => UN152_CHANGE_6_BM(30));
UN152_CHANGE_6_AMq30z_Z2754: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(30),
  I2 => R_TXFIFO_5(30),
  O => UN152_CHANGE_6_AM(30));
UN152_CHANGE_6q28z_Z2755: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(28),
    I1 => UN152_CHANGE_6_BM(28),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(28));
UN152_CHANGE_6_BMq28z_Z2756: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(28),
  I2 => R_TXFIFO_7(28),
  O => UN152_CHANGE_6_BM(28));
UN152_CHANGE_6_AMq28z_Z2757: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(28),
  I2 => R_TXFIFO_5(28),
  O => UN152_CHANGE_6_AM(28));
UN152_CHANGE_6q27z_Z2758: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(27),
    I1 => UN152_CHANGE_6_BM(27),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(27));
UN152_CHANGE_6_BMq27z_Z2759: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(27),
  I2 => R_TXFIFO_7(27),
  O => UN152_CHANGE_6_BM(27));
UN152_CHANGE_6_AMq27z_Z2760: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(27),
  I2 => R_TXFIFO_5(27),
  O => UN152_CHANGE_6_AM(27));
UN152_CHANGE_6q25z_Z2761: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(25),
    I1 => UN152_CHANGE_6_BM(25),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(25));
UN152_CHANGE_6_BMq25z_Z2762: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(25),
  I2 => R_TXFIFO_7(25),
  O => UN152_CHANGE_6_BM(25));
UN152_CHANGE_6_AMq25z_Z2763: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(25),
  I2 => R_TXFIFO_5(25),
  O => UN152_CHANGE_6_AM(25));
UN152_CHANGE_6q23z_Z2764: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(23),
    I1 => UN152_CHANGE_6_BM(23),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(23));
UN152_CHANGE_6_BMq23z_Z2765: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(23),
  I2 => R_TXFIFO_7(23),
  O => UN152_CHANGE_6_BM(23));
UN152_CHANGE_6_AMq23z_Z2766: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(23),
  I2 => R_TXFIFO_5(23),
  O => UN152_CHANGE_6_AM(23));
UN152_CHANGE_6q19z_Z2767: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(19),
    I1 => UN152_CHANGE_6_BM(19),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(19));
UN152_CHANGE_6_BMq19z_Z2768: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(19),
  I2 => R_TXFIFO_7(19),
  O => UN152_CHANGE_6_BM(19));
UN152_CHANGE_6_AMq19z_Z2769: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(19),
  I2 => R_TXFIFO_5(19),
  O => UN152_CHANGE_6_AM(19));
UN152_CHANGE_6q17z_Z2770: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(17),
    I1 => UN152_CHANGE_6_BM(17),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(17));
UN152_CHANGE_6_BMq17z_Z2771: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(17),
  I2 => R_TXFIFO_7(17),
  O => UN152_CHANGE_6_BM(17));
UN152_CHANGE_6_AMq17z_Z2772: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(17),
  I2 => R_TXFIFO_5(17),
  O => UN152_CHANGE_6_AM(17));
UN152_CHANGE_6q15z_Z2773: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(15),
    I1 => UN152_CHANGE_6_BM(15),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(15));
UN152_CHANGE_6_BMq15z_Z2774: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(15),
  I2 => R_TXFIFO_7(15),
  O => UN152_CHANGE_6_BM(15));
UN152_CHANGE_6_AMq15z_Z2775: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(15),
  I2 => R_TXFIFO_5(15),
  O => UN152_CHANGE_6_AM(15));
UN152_CHANGE_6q14z_Z2776: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(14),
    I1 => UN152_CHANGE_6_BM(14),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(14));
UN152_CHANGE_6_BMq14z_Z2777: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(14),
  I2 => R_TXFIFO_7(14),
  O => UN152_CHANGE_6_BM(14));
UN152_CHANGE_6_AMq14z_Z2778: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(14),
  I2 => R_TXFIFO_5(14),
  O => UN152_CHANGE_6_AM(14));
UN152_CHANGE_6q12z_Z2779: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(12),
    I1 => UN152_CHANGE_6_BM(12),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(12));
UN152_CHANGE_6_BMq12z_Z2780: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(12),
  I2 => R_TXFIFO_7(12),
  O => UN152_CHANGE_6_BM(12));
UN152_CHANGE_6_AMq12z_Z2781: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(12),
  I2 => R_TXFIFO_5(12),
  O => UN152_CHANGE_6_AM(12));
UN152_CHANGE_6q11z_Z2782: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(11),
    I1 => UN152_CHANGE_6_BM(11),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(11));
UN152_CHANGE_6_BMq11z_Z2783: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(11),
  I2 => R_TXFIFO_7(11),
  O => UN152_CHANGE_6_BM(11));
UN152_CHANGE_6_AMq11z_Z2784: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(11),
  I2 => R_TXFIFO_5(11),
  O => UN152_CHANGE_6_AM(11));
UN152_CHANGE_6q9z_Z2785: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(9),
    I1 => UN152_CHANGE_6_BM(9),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(9));
UN152_CHANGE_6_BMq9z_Z2786: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(9),
  I2 => R_TXFIFO_7(9),
  O => UN152_CHANGE_6_BM(9));
UN152_CHANGE_6_AMq9z_Z2787: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(9),
  I2 => R_TXFIFO_5(9),
  O => UN152_CHANGE_6_AM(9));
UN152_CHANGE_6q7z_Z2788: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(7),
    I1 => UN152_CHANGE_6_BM(7),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(7));
UN152_CHANGE_6_BMq7z_Z2789: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(7),
  I2 => R_TXFIFO_7(7),
  O => UN152_CHANGE_6_BM(7));
UN152_CHANGE_6_AMq7z_Z2790: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(7),
  I2 => R_TXFIFO_5(7),
  O => UN152_CHANGE_6_AM(7));
UN152_CHANGE_6q3z_Z2791: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(3),
    I1 => UN152_CHANGE_6_BM(3),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(3));
UN152_CHANGE_6_BMq3z_Z2792: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(3),
  I2 => R_TXFIFO_7(3),
  O => UN152_CHANGE_6_BM(3));
UN152_CHANGE_6_AMq3z_Z2793: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(3),
  I2 => R_TXFIFO_5(3),
  O => UN152_CHANGE_6_AM(3));
UN152_CHANGE_6q1z_Z2794: MUXF5 port map (
    I0 => UN152_CHANGE_6_AM(1),
    I1 => UN152_CHANGE_6_BM(1),
    S => R_TDFI(1),
    O => UN152_CHANGE_6(1));
UN152_CHANGE_6_BMq1z_Z2795: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(1),
  I2 => R_TXFIFO_7(1),
  O => UN152_CHANGE_6_BM(1));
UN152_CHANGE_6_AMq1z_Z2796: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(1),
  I2 => R_TXFIFO_5(1),
  O => UN152_CHANGE_6_AM(1));
UN152_CHANGE_3q31z_Z2797: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(31),
    I1 => UN152_CHANGE_3_BM(31),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(31));
UN152_CHANGE_3_BMq31z_Z2798: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(31),
  I2 => R_TXFIFO_6(31),
  O => UN152_CHANGE_3_BM(31));
UN152_CHANGE_3_AMq31z_Z2799: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(31),
  I2 => R_TXFIFO_4(31),
  O => UN152_CHANGE_3_AM(31));
UN152_CHANGE_3q30z_Z2800: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(30),
    I1 => UN152_CHANGE_3_BM(30),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(30));
UN152_CHANGE_3_BMq30z_Z2801: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(30),
  I2 => R_TXFIFO_6(30),
  O => UN152_CHANGE_3_BM(30));
UN152_CHANGE_3_AMq30z_Z2802: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(30),
  I2 => R_TXFIFO_4(30),
  O => UN152_CHANGE_3_AM(30));
UN152_CHANGE_3q28z_Z2803: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(28),
    I1 => UN152_CHANGE_3_BM(28),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(28));
UN152_CHANGE_3_BMq28z_Z2804: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(28),
  I2 => R_TXFIFO_6(28),
  O => UN152_CHANGE_3_BM(28));
UN152_CHANGE_3_AMq28z_Z2805: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(28),
  I2 => R_TXFIFO_4(28),
  O => UN152_CHANGE_3_AM(28));
UN152_CHANGE_3q27z_Z2806: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(27),
    I1 => UN152_CHANGE_3_BM(27),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(27));
UN152_CHANGE_3_BMq27z_Z2807: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(27),
  I2 => R_TXFIFO_6(27),
  O => UN152_CHANGE_3_BM(27));
UN152_CHANGE_3_AMq27z_Z2808: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(27),
  I2 => R_TXFIFO_4(27),
  O => UN152_CHANGE_3_AM(27));
UN152_CHANGE_3q25z_Z2809: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(25),
    I1 => UN152_CHANGE_3_BM(25),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(25));
UN152_CHANGE_3_BMq25z_Z2810: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(25),
  I2 => R_TXFIFO_6(25),
  O => UN152_CHANGE_3_BM(25));
UN152_CHANGE_3_AMq25z_Z2811: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(25),
  I2 => R_TXFIFO_4(25),
  O => UN152_CHANGE_3_AM(25));
UN152_CHANGE_3q23z_Z2812: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(23),
    I1 => UN152_CHANGE_3_BM(23),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(23));
UN152_CHANGE_3_BMq23z_Z2813: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(23),
  I2 => R_TXFIFO_6(23),
  O => UN152_CHANGE_3_BM(23));
UN152_CHANGE_3_AMq23z_Z2814: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(23),
  I2 => R_TXFIFO_4(23),
  O => UN152_CHANGE_3_AM(23));
UN152_CHANGE_3q19z_Z2815: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(19),
    I1 => UN152_CHANGE_3_BM(19),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(19));
UN152_CHANGE_3_BMq19z_Z2816: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(19),
  I2 => R_TXFIFO_6(19),
  O => UN152_CHANGE_3_BM(19));
UN152_CHANGE_3_AMq19z_Z2817: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(19),
  I2 => R_TXFIFO_4(19),
  O => UN152_CHANGE_3_AM(19));
UN152_CHANGE_3q17z_Z2818: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(17),
    I1 => UN152_CHANGE_3_BM(17),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(17));
UN152_CHANGE_3_BMq17z_Z2819: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(17),
  I2 => R_TXFIFO_6(17),
  O => UN152_CHANGE_3_BM(17));
UN152_CHANGE_3_AMq17z_Z2820: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(17),
  I2 => R_TXFIFO_4(17),
  O => UN152_CHANGE_3_AM(17));
UN152_CHANGE_3q15z_Z2821: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(15),
    I1 => UN152_CHANGE_3_BM(15),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(15));
UN152_CHANGE_3_BMq15z_Z2822: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(15),
  I2 => R_TXFIFO_6(15),
  O => UN152_CHANGE_3_BM(15));
UN152_CHANGE_3_AMq15z_Z2823: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(15),
  I2 => R_TXFIFO_4(15),
  O => UN152_CHANGE_3_AM(15));
UN152_CHANGE_3q14z_Z2824: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(14),
    I1 => UN152_CHANGE_3_BM(14),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(14));
UN152_CHANGE_3_BMq14z_Z2825: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(14),
  I2 => R_TXFIFO_6(14),
  O => UN152_CHANGE_3_BM(14));
UN152_CHANGE_3_AMq14z_Z2826: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(14),
  I2 => R_TXFIFO_4(14),
  O => UN152_CHANGE_3_AM(14));
UN152_CHANGE_3q12z_Z2827: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(12),
    I1 => UN152_CHANGE_3_BM(12),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(12));
UN152_CHANGE_3_BMq12z_Z2828: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(12),
  I2 => R_TXFIFO_6(12),
  O => UN152_CHANGE_3_BM(12));
UN152_CHANGE_3_AMq12z_Z2829: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(12),
  I2 => R_TXFIFO_4(12),
  O => UN152_CHANGE_3_AM(12));
UN152_CHANGE_3q11z_Z2830: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(11),
    I1 => UN152_CHANGE_3_BM(11),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(11));
UN152_CHANGE_3_BMq11z_Z2831: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(11),
  I2 => R_TXFIFO_6(11),
  O => UN152_CHANGE_3_BM(11));
UN152_CHANGE_3_AMq11z_Z2832: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(11),
  I2 => R_TXFIFO_4(11),
  O => UN152_CHANGE_3_AM(11));
UN152_CHANGE_3q9z_Z2833: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(9),
    I1 => UN152_CHANGE_3_BM(9),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(9));
UN152_CHANGE_3_BMq9z_Z2834: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(9),
  I2 => R_TXFIFO_6(9),
  O => UN152_CHANGE_3_BM(9));
UN152_CHANGE_3_AMq9z_Z2835: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(9),
  I2 => R_TXFIFO_4(9),
  O => UN152_CHANGE_3_AM(9));
UN152_CHANGE_3q7z_Z2836: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(7),
    I1 => UN152_CHANGE_3_BM(7),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(7));
UN152_CHANGE_3_BMq7z_Z2837: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(7),
  I2 => R_TXFIFO_6(7),
  O => UN152_CHANGE_3_BM(7));
UN152_CHANGE_3_AMq7z_Z2838: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(7),
  I2 => R_TXFIFO_4(7),
  O => UN152_CHANGE_3_AM(7));
UN152_CHANGE_3q3z_Z2839: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(3),
    I1 => UN152_CHANGE_3_BM(3),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(3));
UN152_CHANGE_3_BMq3z_Z2840: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(3),
  I2 => R_TXFIFO_6(3),
  O => UN152_CHANGE_3_BM(3));
UN152_CHANGE_3_AMq3z_Z2841: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(3),
  I2 => R_TXFIFO_4(3),
  O => UN152_CHANGE_3_AM(3));
UN152_CHANGE_3q1z_Z2842: MUXF5 port map (
    I0 => UN152_CHANGE_3_AM(1),
    I1 => UN152_CHANGE_3_BM(1),
    S => R_TDFI(1),
    O => UN152_CHANGE_3(1));
UN152_CHANGE_3_BMq1z_Z2843: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(1),
  I2 => R_TXFIFO_6(1),
  O => UN152_CHANGE_3_BM(1));
UN152_CHANGE_3_AMq1z_Z2844: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(1),
  I2 => R_TXFIFO_4(1),
  O => UN152_CHANGE_3_AM(1));
R_SPIO_SCKOEN_RNO_0: LUT2 
generic map(
  INIT => X"E"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_MODE_LOOPB,
  O => V_SPIO_SCKOEN_1_SQMUXA_I);
V_IRQ_0_SQMUXA_3_1_0_Z2846: LUT3 
generic map(
  INIT => X"04"
)
port map (
  I0 => R_EVENT_OV,
  I1 => R_MASK_OV,
  I2 => R_OV,
  O => V_IRQ_0_SQMUXA_3_1_0);
R_RBITCNT_RNIQDU7q0z: LUT3 
generic map(
  INIT => X"09"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_RBITCNT(0),
  I2 => R_RBITCNT(4),
  O => UN1_R_MODE_EN_184_A6_0);
R_RBITCNT_RNI0QU7q3z: LUT3_L 
generic map(
  INIT => X"01"
)
port map (
  I0 => R_MODE_LEN(3),
  I1 => R_RBITCNT(3),
  I2 => R_RBITCNT(4),
  LO => UN1_R_MODE_EN_184_A6_0_1);
R_RBITCNT_RNI9AK8q2z: LUT4 
generic map(
  INIT => X"4000"
)
port map (
  I0 => R_MODE_LEN(1),
  I1 => R_RBITCNT(0),
  I2 => R_RBITCNT(2),
  I3 => R_RBITCNT(4),
  O => UN1_R_MODE_EN_184_A6_1_5);
R_RBITCNT_RNITDU7q1z: LUT3_L 
generic map(
  INIT => X"40"
)
port map (
  I0 => R_MODE_LEN(3),
  I1 => R_RBITCNT(1),
  I2 => R_RBITCNT(3),
  LO => UN1_R_MODE_EN_184_A6_1_4);
COMB_UN30_AM_EN_Z2851: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => R_TFREECNT_FAST(0),
  I1 => R_TFREECNT_FAST(1),
  I2 => R_TFREECNT_FAST(2),
  I3 => R_TFREECNT_FAST(3),
  O => COMB_UN30_AM_EN);
COMB_UN1_R_TFREECNT_Z2852: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_TFREECNT(0),
  I1 => R_TFREECNT(1),
  I2 => R_TFREECNT(2),
  I3 => R_TFREECNT(3),
  O => COMB_UN1_R_TFREECNT);
COMB_UN1_AM_EN_Z2853: LUT4 
generic map(
  INIT => X"0100"
)
port map (
  I0 => R_RFREECNT(0),
  I1 => R_RFREECNT(1),
  I2 => R_RFREECNT(2),
  I3 => R_RFREECNT(3),
  O => COMB_UN1_AM_EN);
R_TD_OCC_FAST_RNIGJTD: LUT3 
generic map(
  INIT => X"D2"
)
port map (
  I0 => R_TD_OCC_FAST,
  I1 => R_TFREECNT(0),
  I2 => R_TFREECNT(1),
  O => COMB_V_TFREECNT_30(1));
R_RDLIC_Z2855: LUT3_L 
generic map(
  INIT => X"60"
)
port map (
  I0 => R_RDLI(0),
  I1 => R_RXDONE,
  I2 => rstn,
  LO => R_RDLIC);
R_SPIO_SCKOEN_RNO: LUT2_L 
generic map(
  INIT => X"B"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_MS,
  LO => COMB_SAMPLE_6_0_I);
RDATA_0q3z: LUT4 
generic map(
  INIT => X"0006"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => RDATA_3_0);
COMB_UN40_SAMPLE_NE_2_M7_0_X2_0: LUT3 
generic map(
  INIT => X"36"
)
port map (
  I0 => R_MODE_LEN_0_REP1,
  I1 => R_RBITCNT(0),
  I2 => R_RBITCNT(4),
  O => COMB_UN40_SAMPLE_NE_2_N_12_I);
COMB_UN40_SAMPLE_NE_2_M7_0_X2: LUT3 
generic map(
  INIT => X"C9"
)
port map (
  I0 => R_MODE_LEN(3),
  I1 => R_RBITCNT(3),
  I2 => R_RBITCNT(4),
  O => COMB_UN40_SAMPLE_NE_2_N_8_I);
COMB_UN47_SAMPLE: LUT3 
generic map(
  INIT => X"04"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_TW,
  I2 => R_TWDIR,
  O => COMB_UN47_SAMPLE_0);
COMB_V_MODE_MS_1_Z2861: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(25),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_MS_1);
R_SAMP_RNO_1: LUT2_L 
generic map(
  INIT => X"4"
)
port map (
  I0 => N_2127_0,
  I1 => R_SPII_1_SPISEL,
  LO => N_2128_0);
COMB_V_SPIO_MOSIOEN24: LUT3 
generic map(
  INIT => X"15"
)
port map (
  I0 => R_MODE_LOOPB,
  I1 => R_MODE_TW,
  I2 => R_TWDIR,
  O => COMB_V_SPIO_MOSIOEN25);
TINDEX_0_SQMUXA_Z2864: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_RUNNING,
  O => TINDEX_0_SQMUXA);
TINDEX_1_SQMUXA_Z2865: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_MODE_MS,
  O => TINDEX_1_SQMUXA);
V_CHNG_0_SQMUXA_Z2866: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => COMB_UN1_R_MODE_EN,
  I1 => R_SPII_1_SPISEL,
  O => V_CHNG_0_SQMUXA);
V_PSCK_0_SQMUXA_Z2867: LUT3 
generic map(
  INIT => X"02"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_MODE_MS,
  I2 => R_SPII_1_SPISEL,
  O => V_PSCK_0_SQMUXA);
SAMPLE_0_SQMUXA_1_Z2868: LUT3 
generic map(
  INIT => X"06"
)
port map (
  I0 => R_PSCK,
  I1 => R_SPII_1_SCK_FAST,
  I2 => R_SPII_1_SPISEL_FAST,
  O => SAMPLE_0_SQMUXA_1);
COMB_V_MODE_EN_1_Z2869: LUT2_L 
generic map(
  INIT => X"2"
)
port map (
  I0 => apbi_pwdata(24),
  I1 => V_IRQ_0_SQMUXA_1_0,
  LO => COMB_V_MODE_EN_1);
RDATA_0_X2_0q5z: LUT3 
generic map(
  INIT => X"1E"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  O => N_1759_I);
COMB_SPILEN_LEN_Z2871: LUT4 
generic map(
  INIT => X"0001"
)
port map (
  I0 => R_MODE_LEN_FAST(0),
  I1 => R_MODE_LEN_FAST(1),
  I2 => R_MODE_LEN_FAST(2),
  I3 => R_MODE_LEN_FAST(3),
  O => COMB_SPILEN_LEN);
RDATA_0q4z: LUT4 
generic map(
  INIT => X"000E"
)
port map (
  I0 => R_MODE_LEN(0),
  I1 => R_MODE_LEN(1),
  I2 => R_MODE_LEN(2),
  I3 => R_MODE_LEN(3),
  O => RDATA_2_0);
UN1_RELOAD_RN_RNOq3z: LUT3 
generic map(
  INIT => X"78"
)
port map (
  I0 => R_MODE_PM(0),
  I1 => R_MODE_PM(1),
  I2 => R_MODE_PM(2),
  O => N_634);
R_MODE_PM_RNIOUDCq1z_Z2874: LUT3 
generic map(
  INIT => X"14"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  I2 => R_MODE_PM(1),
  O => R_MODE_PM_RNIOUDC(1));
COMB_UN1_APBI_PSEL_Z2875: LUT3 
generic map(
  INIT => X"08"
)
port map (
  I0 => apbi_penable,
  I1 => apbi_psel,
  I2 => apbi_pwrite,
  O => COMB_UN1_APBI_PSEL);
REG_R_SPIO_SCK_3_Z2876: LUT3_L 
generic map(
  INIT => X"2E"
)
port map (
  I0 => R_MODE_CPOL,
  I1 => R_RUNNING,
  I2 => SPIO_SCK_6,
  LO => REG_R_SPIO_SCK_3);
UN152_CHANGE_4q29z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(29),
  I2 => R_TXFIFO_5(29),
  O => N_1601);
UN152_CHANGE_1q5z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(5),
  I2 => R_TXFIFO_4(5),
  O => N_1484);
UN152_CHANGE_1q21z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(21),
  I2 => R_TXFIFO_4(21),
  O => N_1500);
UN152_CHANGE_2q5z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(5),
  I2 => R_TXFIFO_6(5),
  O => N_1515);
UN152_CHANGE_2q21z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(21),
  I2 => R_TXFIFO_6(21),
  O => N_1531);
UN152_CHANGE_4q5z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(5),
  I2 => R_TXFIFO_5(5),
  O => N_1577);
UN152_CHANGE_5q5z: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(5),
  I2 => R_TXFIFO_7(5),
  O => N_1608);
COMB_V_TXFIFO_0_5_0q18z_Z2884: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(13),
  I2 => R_TD(18),
  O => COMB_V_TXFIFO_0_5_0(18));
COMB_V_TXFIFO_0_5_0q17z_Z2885: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(14),
  I2 => R_TD(17),
  O => COMB_V_TXFIFO_0_5_0(17));
COMB_V_TXFIFO_0_5_0q16z_Z2886: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(15),
  I2 => R_TD(16),
  O => COMB_V_TXFIFO_0_5_0(16));
COMB_V_TXFIFO_0_5_0q15z_Z2887: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(15),
  I2 => R_TD(16),
  O => COMB_V_TXFIFO_0_5_0(15));
COMB_V_TXFIFO_0_5_0q14z_Z2888: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(14),
  I2 => R_TD(17),
  O => COMB_V_TXFIFO_0_5_0(14));
COMB_V_TXFIFO_0_5_0q13z_Z2889: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(13),
  I2 => R_TD(18),
  O => COMB_V_TXFIFO_0_5_0(13));
COMB_V_TXFIFO_0_5_0q22z_Z2890: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(9),
  I2 => R_TD(22),
  O => COMB_V_TXFIFO_0_5_0(22));
COMB_V_TXFIFO_0_5_0q21z_Z2891: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(10),
  I2 => R_TD(21),
  O => COMB_V_TXFIFO_0_5_0(21));
COMB_V_TXFIFO_0_5_0q20z_Z2892: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(11),
  I2 => R_TD(20),
  O => COMB_V_TXFIFO_0_5_0(20));
COMB_V_TXFIFO_0_5_0q19z_Z2893: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(12),
  I2 => R_TD(19),
  O => COMB_V_TXFIFO_0_5_0(19));
COMB_V_TXFIFO_0_5_0q12z_Z2894: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(12),
  I2 => R_TD(19),
  O => COMB_V_TXFIFO_0_5_0(12));
COMB_V_TXFIFO_0_5_0q11z_Z2895: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(11),
  I2 => R_TD(20),
  O => COMB_V_TXFIFO_0_5_0(11));
COMB_V_TXFIFO_0_5_0q10z_Z2896: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(10),
  I2 => R_TD(21),
  O => COMB_V_TXFIFO_0_5_0(10));
COMB_V_TXFIFO_0_5_0q9z_Z2897: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(9),
  I2 => R_TD(22),
  O => COMB_V_TXFIFO_0_5_0(9));
COMB_V_TXFIFO_0_5_0q26z_Z2898: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(5),
  I2 => R_TD(26),
  O => COMB_V_TXFIFO_0_5_0(26));
COMB_V_TXFIFO_0_5_0q25z_Z2899: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(6),
  I2 => R_TD(25),
  O => COMB_V_TXFIFO_0_5_0(25));
COMB_V_TXFIFO_0_5_0q24z_Z2900: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(7),
  I2 => R_TD(24),
  O => COMB_V_TXFIFO_0_5_0(24));
COMB_V_TXFIFO_0_5_0q23z_Z2901: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(8),
  I2 => R_TD(23),
  O => COMB_V_TXFIFO_0_5_0(23));
COMB_V_TXFIFO_0_5_0q8z_Z2902: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(8),
  I2 => R_TD(23),
  O => COMB_V_TXFIFO_0_5_0(8));
COMB_V_TXFIFO_0_5_0q7z_Z2903: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(7),
  I2 => R_TD(24),
  O => COMB_V_TXFIFO_0_5_0(7));
COMB_V_TXFIFO_0_5_0q6z_Z2904: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(6),
  I2 => R_TD(25),
  O => COMB_V_TXFIFO_0_5_0(6));
COMB_V_TXFIFO_0_5_0q5z_Z2905: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(5),
  I2 => R_TD(26),
  O => COMB_V_TXFIFO_0_5_0(5));
COMB_V_TXFIFO_0_5_0q30z_Z2906: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(1),
  I2 => R_TD(30),
  O => COMB_V_TXFIFO_0_5_0(30));
COMB_V_TXFIFO_0_5_0q29z_Z2907: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(2),
  I2 => R_TD(29),
  O => COMB_V_TXFIFO_0_5_0(29));
COMB_V_TXFIFO_0_5_0q28z_Z2908: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(3),
  I2 => R_TD(28),
  O => COMB_V_TXFIFO_0_5_0(28));
COMB_V_TXFIFO_0_5_0q27z_Z2909: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(4),
  I2 => R_TD(27),
  O => COMB_V_TXFIFO_0_5_0(27));
COMB_V_TXFIFO_0_5_0q4z_Z2910: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(4),
  I2 => R_TD(27),
  O => COMB_V_TXFIFO_0_5_0(4));
COMB_V_TXFIFO_0_5_0q3z_Z2911: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(3),
  I2 => R_TD(28),
  O => COMB_V_TXFIFO_0_5_0(3));
COMB_V_TXFIFO_0_5_0q2z_Z2912: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(2),
  I2 => R_TD(29),
  O => COMB_V_TXFIFO_0_5_0(2));
COMB_V_TXFIFO_0_5_0q1z_Z2913: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(1),
  I2 => R_TD(30),
  O => COMB_V_TXFIFO_0_5_0(1));
COMB_V_TXFIFO_0_5_0q31z_Z2914: LUT3 
generic map(
  INIT => X"D8"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(0),
  I2 => R_TD(31),
  O => COMB_V_TXFIFO_0_5_0(31));
COMB_V_TXFIFO_0_5_0q0z_Z2915: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_MODE_REV,
  I1 => R_TD(0),
  I2 => R_TD(31),
  O => COMB_V_TXFIFO_0_5_0(0));
UN152_CHANGE_5q29z_Z2916: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(29),
  I2 => R_TXFIFO_7(29),
  O => UN152_CHANGE_5(29));
UN152_CHANGE_5q21z_Z2917: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(21),
  I2 => R_TXFIFO_7(21),
  O => UN152_CHANGE_5(21));
UN152_CHANGE_5q13z_Z2918: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_3(13),
  I2 => R_TXFIFO_7(13),
  O => UN152_CHANGE_5(13));
UN152_CHANGE_4q21z_Z2919: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(21),
  I2 => R_TXFIFO_5(21),
  O => UN152_CHANGE_4(21));
UN152_CHANGE_4q13z_Z2920: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_1(13),
  I2 => R_TXFIFO_5(13),
  O => UN152_CHANGE_4(13));
UN152_CHANGE_2q29z_Z2921: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(29),
  I2 => R_TXFIFO_6(29),
  O => UN152_CHANGE_2(29));
UN152_CHANGE_2q13z_Z2922: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_2(13),
  I2 => R_TXFIFO_6(13),
  O => UN152_CHANGE_2(13));
UN152_CHANGE_1q29z_Z2923: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(29),
  I2 => R_TXFIFO_4(29),
  O => UN152_CHANGE_1(29));
UN152_CHANGE_1q13z_Z2924: LUT3 
generic map(
  INIT => X"E4"
)
port map (
  I0 => R_TDFI(2),
  I1 => R_TXFIFO_0(13),
  I2 => R_TXFIFO_4(13),
  O => UN152_CHANGE_1(13));
UN1_R_DIVCNT_1_S_9_RNO: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_DIVCNT(9),
  O => UN1_R_DIVCNT_1_S_9_SF);
V_SPIO_MOSIOEN_0_SQMUXA_0_Z2926: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_MODE_TW,
  O => V_SPIO_MOSIOEN_0_SQMUXA_0);
COMB_UN16_SAMPLE_1_Z2927: LUT2_L 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_RD_FREE,
  I1 => R_RFREECNT(1),
  LO => COMB_UN16_SAMPLE_1);
R_PSCK_RNO_1: LUT2_L 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_SPII_1_SPISEL,
  I1 => rstn,
  LO => COMB_V_PSCK_1_0_159_I_O4_0);
V_IRQ_0_SQMUXA_1_0_Z2929: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_MS_REP1,
  I1 => R_SPII_1_SPISEL,
  O => V_IRQ_0_SQMUXA_1_0);
UN1_R_RFREECNT_AXB_3_Z2930: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_RFREECNT(3),
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_3);
UN1_R_RFREECNT_AXB_2_Z2931: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_RFREECNT(2),
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_2);
UN1_R_RFREECNT_AXB_1_Z2932: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_RFREECNT(1),
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_1);
UN1_R_RFREECNT_AXB_0_Z2933: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => COMB_V_RD4,
  I1 => R_RXDONE,
  LO => UN1_R_RFREECNT_AXB_0);
COMB_UN1_R_MODE_EN_Z2934: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_EN,
  I1 => R_RUNNING,
  O => COMB_UN1_R_MODE_EN);
COMB_UN1_R_INCRDLI_Z2935: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_INCRDLI,
  I1 => R_SYNCSAMP(1),
  O => COMB_UN1_R_INCRDLI);
COMB_UN54_SAMPLE_0: LUT2_L 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_MS_FAST,
  I1 => R_MODE_TTO,
  LO => COMB_UN54_SAMPLE);
COMB_SLV_START_UN13_AM_EN_0: LUT2 
generic map(
  INIT => X"6"
)
port map (
  I0 => R_MODE_CPOL_FAST,
  I1 => R_SPII_1_SCK_FAST,
  O => COMB_SLV_START_UN13_AM_EN);
R_TOGGLE_RNIGVLP: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_MODE_MS_REP1,
  I1 => R_TOGGLE,
  O => N_2127_0);
COMB_UN1_R_MODE_TW_Z2939: LUT2_L 
generic map(
  INIT => X"4"
)
port map (
  I0 => R_MODE_MS,
  I1 => R_MODE_TW,
  LO => COMB_UN1_R_MODE_TW);
R_RDLI_RNIPOPJq0z: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_RDLI(0),
  I1 => R_RXDONE,
  O => CO0_3);
R_MODE_EN_RNIVS7B: LUT2 
generic map(
  INIT => X"8"
)
port map (
  I0 => R_MODE_EN,
  I1 => rstn,
  O => N_2126_0);
R_MODE_DIV16_RNIQGCG: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_FACT,
  O => N_881);
R_MODE_DIV16_RNIPI88_Z2943: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_MODE_DIV16,
  I1 => R_MODE_PM(0),
  O => R_MODE_DIV16_RNIPI88);
COMB_UN21_SAMPLE: LUT2 
generic map(
  INIT => X"2"
)
port map (
  I0 => R_MODE_TW,
  I1 => R_TWDIR,
  O => COMB_UN21_SAMPLE_0);
COMB_UN21_APBI_PSEL_2: LUT2 
generic map(
  INIT => X"4"
)
port map (
  I0 => apbi_paddr(2),
  I1 => apbi_paddr(5),
  O => COMB_UN5_APBI_PSEL_1);
COMB_UN13_APBI_PSEL_3: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => apbi_paddr(6),
  I1 => apbi_paddr(7),
  O => V_TD_OCC_1_SQMUXA_4);
APBOUT_0_SQMUXA_2_Z2947: LUT2 
generic map(
  INIT => X"1"
)
port map (
  I0 => apbi_paddr(3),
  I1 => apbi_paddr(4),
  O => APBOUT_0_SQMUXA_2);
R_RUNNING_Z2948: FDR port map (
    Q => R_RUNNING,
    D => R_RUNNINGC,
    C => clk,
    R => R_MODE_EN_I);
R_RDLIq0z_Z2949: FDR port map (
    Q => R_RDLI(0),
    D => R_RDLIC,
    C => clk,
    R => R_MODE_EN_I);
R_RDLIq1z_Z2950: FDR port map (
    Q => R_RDLI(1),
    D => R_RDLIC_0,
    C => clk,
    R => R_MODE_EN_I);
R_RDLIq2z_Z2951: FDR port map (
    Q => R_RDLI(2),
    D => R_RDLIC_1,
    C => clk,
    R => R_MODE_EN_I);
R_RDFIq0z_Z2952: FDR port map (
    Q => R_RDFI(0),
    D => R_RDFIC,
    C => clk,
    R => R_MODE_EN_I);
R_RDFIq1z_Z2953: FDR port map (
    Q => R_RDFI(1),
    D => R_RDFIC_0,
    C => clk,
    R => R_MODE_EN_I);
R_RDFIq2z_Z2954: FDR port map (
    Q => R_RDFI(2),
    D => R_RDFIC_1,
    C => clk,
    R => R_MODE_EN_I);
R_TXFIFO_1q0z_Z2955: FDS port map (
    Q => R_TXFIFO_1(0),
    D => R_TXFIFO_1S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_2q0z_Z2956: FDS port map (
    Q => R_TXFIFO_2(0),
    D => R_TXFIFO_2S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_3q0z_Z2957: FDS port map (
    Q => R_TXFIFO_3(0),
    D => R_TXFIFO_3S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_4q0z_Z2958: FDS port map (
    Q => R_TXFIFO_4(0),
    D => R_TXFIFO_4S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_5q0z_Z2959: FDS port map (
    Q => R_TXFIFO_5(0),
    D => R_TXFIFO_5S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_6q0z_Z2960: FDS port map (
    Q => R_TXFIFO_6(0),
    D => R_TXFIFO_6S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_7q0z_Z2961: FDS port map (
    Q => R_TXFIFO_7(0),
    D => R_TXFIFO_7S_I,
    C => clk,
    S => R_MODE_EN_I);
R_TXFIFO_0q0z_Z2962: FDS port map (
    Q => R_TXFIFO_0(0),
    D => R_TXFIFO_0S_I,
    C => clk,
    S => R_MODE_EN_I);
R_SYNCSAMPq0z_Z2963: FDR port map (
    Q => R_SYNCSAMP(0),
    D => R_SYNCSAMPC,
    C => clk,
    R => R_OV);
R_RBITCNTq4z_Z2964: FDRE port map (
    Q => R_RBITCNT(4),
    D => R_RBITCNT_LM(4),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq4z_Z2965: XORCY port map (
    LI => R_RBITCNT(4),
    CI => R_RBITCNT_CRY(3),
    O => R_RBITCNT_S(4));
R_RBITCNTq3z_Z2966: FDRE port map (
    Q => R_RBITCNT(3),
    D => R_RBITCNT_LM(3),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq3z_Z2967: XORCY port map (
    LI => R_RBITCNT_QXU(3),
    CI => R_RBITCNT_CRY(2),
    O => R_RBITCNT_S(3));
R_RBITCNT_CRYq3z_Z2968: MUXCY_L port map (
    DI => NN_2,
    CI => R_RBITCNT_CRY(2),
    S => R_RBITCNT_QXU(3),
    LO => R_RBITCNT_CRY(3));
R_RBITCNTq2z_Z2969: FDRE port map (
    Q => R_RBITCNT(2),
    D => R_RBITCNT_LM(2),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq2z_Z2970: XORCY port map (
    LI => R_RBITCNT_QXU(2),
    CI => R_RBITCNT_CRY(1),
    O => R_RBITCNT_S(2));
R_RBITCNT_CRYq2z_Z2971: MUXCY_L port map (
    DI => NN_2,
    CI => R_RBITCNT_CRY(1),
    S => R_RBITCNT_QXU(2),
    LO => R_RBITCNT_CRY(2));
R_RBITCNTq1z_Z2972: FDRE port map (
    Q => R_RBITCNT(1),
    D => R_RBITCNT_LM(1),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_RBITCNT_Sq1z_Z2973: XORCY port map (
    LI => R_RBITCNT_QXU(1),
    CI => R_RBITCNT(0),
    O => R_RBITCNT_S(1));
R_RBITCNT_CRYq1z_Z2974: MUXCY_L port map (
    DI => NN_2,
    CI => R_RBITCNT(0),
    S => R_RBITCNT_QXU(1),
    LO => R_RBITCNT_CRY(1));
R_RBITCNTq0z_Z2975: FDRE port map (
    Q => R_RBITCNT(0),
    D => R_RBITCNT_LM(0),
    C => clk,
    R => RSTN_I,
    CE => R_RBITCNTE_0_I);
R_CGCNTq5z_Z2976: FDRE port map (
    Q => R_CGCNT(5),
    D => R_CGCNT_LM(5),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq5z_Z2977: XORCY port map (
    LI => R_CGCNT_QXU(5),
    CI => R_CGCNT_CRY(4),
    O => R_CGCNT_S(5));
R_CGCNT_QXUq5z_Z2978: LUT1 
generic map(
  INIT => X"1"
)
port map (
  I0 => R_CGCNT(5),
  O => R_CGCNT_QXU(5));
R_CGCNTq4z_Z2979: FDRE port map (
    Q => R_CGCNT(4),
    D => R_CGCNT_LM(4),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq4z_Z2980: XORCY port map (
    LI => R_CGCNT_QXU(4),
    CI => R_CGCNT_CRY(3),
    O => R_CGCNT_S(4));
R_CGCNT_CRYq4z_Z2981: MUXCY_L port map (
    DI => NN_1,
    CI => R_CGCNT_CRY(3),
    S => R_CGCNT_QXU(4),
    LO => R_CGCNT_CRY(4));
R_CGCNTq3z_Z2982: FDRE port map (
    Q => R_CGCNT(3),
    D => R_CGCNT_LM(3),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq3z_Z2983: XORCY port map (
    LI => R_CGCNT_QXU(3),
    CI => R_CGCNT_CRY(2),
    O => R_CGCNT_S(3));
R_CGCNT_CRYq3z_Z2984: MUXCY_L port map (
    DI => NN_1,
    CI => R_CGCNT_CRY(2),
    S => R_CGCNT_QXU(3),
    LO => R_CGCNT_CRY(3));
R_CGCNTq2z_Z2985: FDRE port map (
    Q => R_CGCNT(2),
    D => R_CGCNT_LM(2),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq2z_Z2986: XORCY port map (
    LI => R_CGCNT_QXU(2),
    CI => R_CGCNT_CRY(1),
    O => R_CGCNT_S(2));
R_CGCNT_CRYq2z_Z2987: MUXCY_L port map (
    DI => NN_1,
    CI => R_CGCNT_CRY(1),
    S => R_CGCNT_QXU(2),
    LO => R_CGCNT_CRY(2));
R_CGCNTq1z_Z2988: FDRE port map (
    Q => R_CGCNT(1),
    D => R_CGCNT_LM(1),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_Sq1z_Z2989: XORCY port map (
    LI => R_CGCNT_QXU(1),
    CI => R_CGCNT_CRY(0),
    O => R_CGCNT_S(1));
R_CGCNT_CRYq1z_Z2990: MUXCY_L port map (
    DI => NN_1,
    CI => R_CGCNT_CRY(0),
    S => R_CGCNT_QXU(1),
    LO => R_CGCNT_CRY(1));
R_CGCNTq0z_Z2991: FDRE port map (
    Q => R_CGCNT(0),
    D => R_CGCNT_LM(0),
    C => clk,
    R => RSTN_I,
    CE => R_CGCNTE_0_I);
R_CGCNT_CRYq0z_Z2992: MUXCY_L port map (
    DI => NN_1,
    CI => NN_2,
    S => R_CGCNT_S(0),
    LO => R_CGCNT_CRY(0));
R_TBITCNTq4z_Z2993: FDRE port map (
    Q => R_TBITCNT(4),
    D => R_TBITCNT_LM(4),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq4z_Z2994: XORCY port map (
    LI => R_TBITCNT(4),
    CI => R_TBITCNT_CRY(3),
    O => R_TBITCNT_S(4));
R_TBITCNTq3z_Z2995: FDRE port map (
    Q => R_TBITCNT(3),
    D => R_TBITCNT_LM(3),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq3z_Z2996: XORCY port map (
    LI => R_TBITCNT_QXU(3),
    CI => R_TBITCNT_CRY(2),
    O => R_TBITCNT_S(3));
R_TBITCNT_CRYq3z_Z2997: MUXCY_L port map (
    DI => NN_2,
    CI => R_TBITCNT_CRY(2),
    S => R_TBITCNT_QXU(3),
    LO => R_TBITCNT_CRY(3));
R_TBITCNTq2z_Z2998: FDRE port map (
    Q => R_TBITCNT(2),
    D => R_TBITCNT_LM(2),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq2z_Z2999: XORCY port map (
    LI => R_TBITCNT_QXU(2),
    CI => R_TBITCNT_CRY(1),
    O => R_TBITCNT_S(2));
R_TBITCNT_CRYq2z_Z3000: MUXCY_L port map (
    DI => NN_2,
    CI => R_TBITCNT_CRY(1),
    S => R_TBITCNT_QXU(2),
    LO => R_TBITCNT_CRY(2));
R_TBITCNTq1z_Z3001: FDRE port map (
    Q => R_TBITCNT(1),
    D => R_TBITCNT_LM(1),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TBITCNT_Sq1z_Z3002: XORCY port map (
    LI => R_TBITCNT_QXU(1),
    CI => R_TBITCNT(0),
    O => R_TBITCNT_S(1));
R_TBITCNT_CRYq1z_Z3003: MUXCY_L port map (
    DI => NN_2,
    CI => R_TBITCNT(0),
    S => R_TBITCNT_QXU(1),
    LO => R_TBITCNT_CRY(1));
R_TBITCNTq0z_Z3004: FDRE port map (
    Q => R_TBITCNT(0),
    D => R_TBITCNT_LM(0),
    C => clk,
    R => RSTN_I,
    CE => R_TBITCNTE_0_I);
R_TD_OCC_FAST_RNIGJTD_0: LUT3 
generic map(
  INIT => X"A8"
)
port map (
  I0 => R_TD_OCC_FAST,
  I1 => R_TFREECNT(0),
  I2 => R_TFREECNT(1),
  O => COMB_V_TFREECNT_P4);
UN1_V_DIVCNT_0_SQMUXA_1_P7_Z3006: LUT4 
generic map(
  INIT => X"FFFE"
)
port map (
  I0 => UN1_RELOAD(4),
  I1 => UN1_RELOAD_MB(3),
  I2 => UN1_RELOAD(2),
  I3 => UN1_V_DIVCNT_0_SQMUXA_1_P4,
  O => UN1_V_DIVCNT_0_SQMUXA_1_P7);
UN1_V_DIVCNT_0_SQMUXA_1_P4_Z3007: LUT4 
generic map(
  INIT => X"FFFE"
)
port map (
  I0 => UN1_RELOAD(5),
  I1 => R_MODE_PM_RNIOEJG(2),
  I2 => R_MODE_PM_RNIOUDC(1),
  I3 => R_MODE_DIV16_RNIPI88,
  O => UN1_V_DIVCNT_0_SQMUXA_1_P4);
UN1_R_DIVCNT_1_S_9_Z3008: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_9_SF,
    CI => UN1_R_DIVCNT_1_CRY_8,
    O => UN1_R_DIVCNT_1_S_9);
UN1_R_DIVCNT_1_S_8_Z3009: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_8_SF,
    CI => UN1_R_DIVCNT_1_CRY_7,
    O => UN1_R_DIVCNT_1_S_8);
UN1_R_DIVCNT_1_CRY_8_Z3010: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_7,
    S => UN1_R_DIVCNT_1_S_8_SF,
    LO => UN1_R_DIVCNT_1_CRY_8);
UN1_R_DIVCNT_1_S_7_Z3011: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_7_SF,
    CI => UN1_R_DIVCNT_1_CRY_6,
    O => UN1_R_DIVCNT_1_S_7);
UN1_R_DIVCNT_1_CRY_7_Z3012: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_6,
    S => UN1_R_DIVCNT_1_S_7_SF,
    LO => UN1_R_DIVCNT_1_CRY_7);
UN1_R_DIVCNT_1_S_6_Z3013: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_6_SF,
    CI => UN1_R_DIVCNT_1_CRY_5,
    O => UN1_R_DIVCNT_1_S_6);
UN1_R_DIVCNT_1_CRY_6_Z3014: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_5,
    S => UN1_R_DIVCNT_1_S_6_SF,
    LO => UN1_R_DIVCNT_1_CRY_6);
UN1_R_DIVCNT_1_S_5_Z3015: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_5_SF,
    CI => UN1_R_DIVCNT_1_CRY_4,
    O => UN1_R_DIVCNT_1_S_5);
UN1_R_DIVCNT_1_CRY_5_Z3016: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_4,
    S => UN1_R_DIVCNT_1_S_5_SF,
    LO => UN1_R_DIVCNT_1_CRY_5);
UN1_R_DIVCNT_1_S_4_Z3017: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_4_SF,
    CI => UN1_R_DIVCNT_1_CRY_3,
    O => UN1_R_DIVCNT_1_S_4);
UN1_R_DIVCNT_1_CRY_4_Z3018: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_3,
    S => UN1_R_DIVCNT_1_S_4_SF,
    LO => UN1_R_DIVCNT_1_CRY_4);
UN1_R_DIVCNT_1_S_3_Z3019: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_3_SF,
    CI => UN1_R_DIVCNT_1_CRY_2,
    O => UN1_R_DIVCNT_1_S_3);
UN1_R_DIVCNT_1_CRY_3_Z3020: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_2,
    S => UN1_R_DIVCNT_1_S_3_SF,
    LO => UN1_R_DIVCNT_1_CRY_3);
UN1_R_DIVCNT_1_S_2_Z3021: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_2_SF,
    CI => UN1_R_DIVCNT_1_CRY_1,
    O => UN1_R_DIVCNT_1_S_2);
UN1_R_DIVCNT_1_CRY_2_Z3022: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_1,
    S => UN1_R_DIVCNT_1_S_2_SF,
    LO => UN1_R_DIVCNT_1_CRY_2);
UN1_R_DIVCNT_1_S_1_Z3023: XORCY port map (
    LI => UN1_R_DIVCNT_1_S_1_SF,
    CI => UN1_R_DIVCNT_1_CRY_0,
    O => UN1_R_DIVCNT_1_S_1);
UN1_R_DIVCNT_1_CRY_1_Z3024: MUXCY_L port map (
    DI => NN_1,
    CI => UN1_R_DIVCNT_1_CRY_0,
    S => UN1_R_DIVCNT_1_S_1_SF,
    LO => UN1_R_DIVCNT_1_CRY_1);
UN1_R_DIVCNT_1_CRY_0_Z3025: MUXCY_L port map (
    DI => NN_1,
    CI => NN_2,
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
UN1_R_RFREECNT_CRY_2_Z3028: MUXCY_L port map (
    DI => R_RXDONE,
    CI => UN1_R_RFREECNT_CRY_1,
    S => UN1_R_RFREECNT_AXB_2,
    LO => UN1_R_RFREECNT_CRY_2);
UN1_R_RFREECNT_S_1: XORCY port map (
    LI => UN1_R_RFREECNT_AXB_1,
    CI => UN1_R_RFREECNT_CRY_0,
    O => UN1_R_RFREECNT_0(1));
UN1_R_RFREECNT_CRY_1_Z3030: MUXCY_L port map (
    DI => R_RXDONE,
    CI => UN1_R_RFREECNT_CRY_0,
    S => UN1_R_RFREECNT_AXB_1,
    LO => UN1_R_RFREECNT_CRY_1);
UN1_R_RFREECNT_S_0: XORCY port map (
    LI => UN1_R_RFREECNT_AXB_0,
    CI => R_RFREECNT(0),
    O => UN1_R_RFREECNT_0(0));
UN1_R_RFREECNT_CRY_0_Z3032: MUXCY_L port map (
    DI => COMB_V_RD4,
    CI => R_RFREECNT(0),
    S => UN1_R_RFREECNT_AXB_0,
    LO => UN1_R_RFREECNT_CRY_0);
R_EVENT_UN_Z3033: FDRSE port map (
    Q => R_EVENT_UN,
    D => NN_2,
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
  A3 => NN_2,
  D => R_RXD(16),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_31: RAM16X1D port map (
  DPO => R_RXFIFO(8),
  SPO => R_RXFIFO_N_34,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(8),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_30: RAM16X1D port map (
  DPO => R_RXFIFO(17),
  SPO => R_RXFIFO_N_33,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(17),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_29: RAM16X1D port map (
  DPO => R_RXFIFO(13),
  SPO => R_RXFIFO_N_32,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(13),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_28: RAM16X1D port map (
  DPO => R_RXFIFO(9),
  SPO => R_RXFIFO_N_31,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(9),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_27: RAM16X1D port map (
  DPO => R_RXFIFO(18),
  SPO => R_RXFIFO_N_30,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(18),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_26: RAM16X1D port map (
  DPO => R_RXFIFO(14),
  SPO => R_RXFIFO_N_29,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(14),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_25: RAM16X1D port map (
  DPO => R_RXFIFO(1),
  SPO => R_RXFIFO_N_28,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(1),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_24: RAM16X1D port map (
  DPO => R_RXFIFO(2),
  SPO => R_RXFIFO_N_27,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(2),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_23: RAM16X1D port map (
  DPO => R_RXFIFO(5),
  SPO => R_RXFIFO_N_26,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(5),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_22: RAM16X1D port map (
  DPO => R_RXFIFO(4),
  SPO => R_RXFIFO_N_25,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(4),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_21: RAM16X1D port map (
  DPO => R_RXFIFO(0),
  SPO => R_RXFIFO_N_24,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(0),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_20: RAM16X1D port map (
  DPO => R_RXFIFO(29),
  SPO => R_RXFIFO_N_23,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(29),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_19: RAM16X1D port map (
  DPO => R_RXFIFO(3),
  SPO => R_RXFIFO_N_22,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(3),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_18: RAM16X1D port map (
  DPO => R_RXFIFO(21),
  SPO => R_RXFIFO_N_21,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(21),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_17: RAM16X1D port map (
  DPO => R_RXFIFO(30),
  SPO => R_RXFIFO_N_20,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(30),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_16: RAM16X1D port map (
  DPO => R_RXFIFO(26),
  SPO => R_RXFIFO_N_19,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(26),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_15: RAM16X1D port map (
  DPO => R_RXFIFO(22),
  SPO => R_RXFIFO_N_18,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(22),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_14: RAM16X1D port map (
  DPO => R_RXFIFO(31),
  SPO => R_RXFIFO_N_17,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(31),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_13: RAM16X1D port map (
  DPO => R_RXFIFO(27),
  SPO => R_RXFIFO_N_16,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(27),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_12: RAM16X1D port map (
  DPO => R_RXFIFO(10),
  SPO => R_RXFIFO_N_15,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(10),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_11: RAM16X1D port map (
  DPO => R_RXFIFO(6),
  SPO => R_RXFIFO_N_14,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(6),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_10: RAM16X1D port map (
  DPO => R_RXFIFO(15),
  SPO => R_RXFIFO_N_13,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(15),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_9: RAM16X1D port map (
  DPO => R_RXFIFO(11),
  SPO => R_RXFIFO_N_12,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(11),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_8: RAM16X1D port map (
  DPO => R_RXFIFO(7),
  SPO => R_RXFIFO_N_11,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(7),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_7: RAM16X1D port map (
  DPO => R_RXFIFO(25),
  SPO => R_RXFIFO_N_10,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(25),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_6: RAM16X1D port map (
  DPO => R_RXFIFO(12),
  SPO => R_RXFIFO_N_9,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(12),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_5: RAM16X1D port map (
  DPO => R_RXFIFO(28),
  SPO => R_RXFIFO_N_8,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(28),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_4: RAM16X1D port map (
  DPO => R_RXFIFO(24),
  SPO => R_RXFIFO_N_7,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(24),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_3: RAM16X1D port map (
  DPO => R_RXFIFO(23),
  SPO => R_RXFIFO_N_6,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(23),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_2: RAM16X1D port map (
  DPO => R_RXFIFO(19),
  SPO => R_RXFIFO_N_5,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(19),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_RXFIFO_I_1: RAM16X1D port map (
  DPO => R_RXFIFO(20),
  SPO => R_RXFIFO_N_4,
  A0 => R_RDLI(0),
  A1 => R_RDLI(1),
  A2 => R_RDLI(2),
  A3 => NN_2,
  D => R_RXD(20),
  DPRA0 => R_RDFI(0),
  DPRA1 => R_RDFI(1),
  DPRA2 => R_RDFI(2),
  DPRA3 => NN_2,
  WCLK => clk,
  WE => R_RXDONE);
R_SPIO_SCKOEN: FDSE port map (
    Q => spio_sckoen,
    D => COMB_SAMPLE_6_0_I,
    C => clk,
    S => N_2126_0_I,
    CE => V_SPIO_SCKOEN_1_SQMUXA_I);
R_MASK_LT_Z3067: FDRE port map (
    Q => R_MASK_LT,
    D => apbi_pwdata(14),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_MME_Z3068: FDRE port map (
    Q => R_MASK_MME,
    D => apbi_pwdata(10),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_NE_Z3069: FDRE port map (
    Q => R_MASK_NE,
    D => apbi_pwdata(9),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_NF_Z3070: FDRE port map (
    Q => R_MASK_NF,
    D => apbi_pwdata(8),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_OV_Z3071: FDRE port map (
    Q => R_MASK_OV,
    D => apbi_pwdata(12),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_TIP_Z3072: FDRE port map (
    Q => R_MASK_TIP,
    D => apbi_pwdata(31),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MASK_UN_Z3073: FDRE port map (
    Q => R_MASK_UN,
    D => apbi_pwdata(11),
    C => clk,
    R => RSTN_I,
    CE => V_MASK_LT_1_SQMUXA);
R_MODE_CPHA_Z3074: FDRE port map (
    Q => R_MODE_CPHA,
    D => apbi_pwdata(28),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CPOL_Z3075: FDRE port map (
    Q => R_MODE_CPOL,
    D => apbi_pwdata(29),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_DIV16_Z3076: FDRE port map (
    Q => R_MODE_DIV16,
    D => apbi_pwdata(27),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_FACT_Z3077: FDRE port map (
    Q => R_MODE_FACT,
    D => apbi_pwdata(13),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LOOPB_Z3078: FDRE port map (
    Q => R_MODE_LOOPB,
    D => apbi_pwdata(30),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_REV_Z3079: FDRE port map (
    Q => R_MODE_REV,
    D => apbi_pwdata(26),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_TTO_Z3080: FDRE port map (
    Q => R_MODE_TTO,
    D => apbi_pwdata(3),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_TW_Z3081: FDRE port map (
    Q => R_MODE_TW,
    D => apbi_pwdata(15),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_EVENT_MME_Z3082: FDRSE port map (
    Q => R_EVENT_MME,
    D => NN_2,
    C => clk,
    R => RSTN_I,
    S => V_IRQ_0_SQMUXA_1_0,
    CE => R_EVENT_MMECE);
R_MODE_LENq3z_Z3083: FDRE port map (
    Q => R_MODE_LEN(3),
    D => apbi_pwdata(23),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LENq2z_Z3084: FDRE port map (
    Q => R_MODE_LEN(2),
    D => apbi_pwdata(22),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LENq1z_Z3085: FDRE port map (
    Q => R_MODE_LEN(1),
    D => apbi_pwdata(21),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_LENq0z_Z3086: FDRE port map (
    Q => R_MODE_LEN(0),
    D => apbi_pwdata(20),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq3z_Z3087: FDRE port map (
    Q => R_MODE_PM(3),
    D => apbi_pwdata(19),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq2z_Z3088: FDRE port map (
    Q => R_MODE_PM(2),
    D => apbi_pwdata(18),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq1z_Z3089: FDRE port map (
    Q => R_MODE_PM(1),
    D => apbi_pwdata(17),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_PMq0z_Z3090: FDRE port map (
    Q => R_MODE_PM(0),
    D => apbi_pwdata(16),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq4z_Z3091: FDRE port map (
    Q => R_MODE_CG(4),
    D => apbi_pwdata(11),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq3z_Z3092: FDRE port map (
    Q => R_MODE_CG(3),
    D => apbi_pwdata(10),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq2z_Z3093: FDRE port map (
    Q => R_MODE_CG(2),
    D => apbi_pwdata(9),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq1z_Z3094: FDRE port map (
    Q => R_MODE_CG(1),
    D => apbi_pwdata(8),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_MODE_CGq0z_Z3095: FDRE port map (
    Q => R_MODE_CG(0),
    D => apbi_pwdata(7),
    C => clk,
    R => RSTN_I,
    CE => V_MODE_CPHA_0_SQMUXA);
R_SLVSELq31z: FDSE port map (
    Q => SLVSEL_39,
    D => apbi_pwdata(31),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq30z: FDSE port map (
    Q => SLVSEL_38,
    D => apbi_pwdata(30),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq29z: FDSE port map (
    Q => SLVSEL_37,
    D => apbi_pwdata(29),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq28z: FDSE port map (
    Q => SLVSEL_36,
    D => apbi_pwdata(28),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq27z: FDSE port map (
    Q => SLVSEL_35,
    D => apbi_pwdata(27),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq26z: FDSE port map (
    Q => SLVSEL_34,
    D => apbi_pwdata(26),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq25z: FDSE port map (
    Q => SLVSEL_33,
    D => apbi_pwdata(25),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq24z: FDSE port map (
    Q => SLVSEL_32,
    D => apbi_pwdata(24),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq23z: FDSE port map (
    Q => SLVSEL_31,
    D => apbi_pwdata(23),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq22z: FDSE port map (
    Q => SLVSEL_30,
    D => apbi_pwdata(22),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq21z: FDSE port map (
    Q => SLVSEL_29,
    D => apbi_pwdata(21),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq20z: FDSE port map (
    Q => SLVSEL_28,
    D => apbi_pwdata(20),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq19z: FDSE port map (
    Q => SLVSEL_27,
    D => apbi_pwdata(19),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq18z: FDSE port map (
    Q => SLVSEL_26,
    D => apbi_pwdata(18),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq17z: FDSE port map (
    Q => SLVSEL_25,
    D => apbi_pwdata(17),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq16z: FDSE port map (
    Q => SLVSEL_24,
    D => apbi_pwdata(16),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq15z: FDSE port map (
    Q => SLVSEL_23,
    D => apbi_pwdata(15),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq14z: FDSE port map (
    Q => SLVSEL_22,
    D => apbi_pwdata(14),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq13z: FDSE port map (
    Q => SLVSEL_21,
    D => apbi_pwdata(13),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq12z: FDSE port map (
    Q => SLVSEL_20,
    D => apbi_pwdata(12),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq11z: FDSE port map (
    Q => SLVSEL_19,
    D => apbi_pwdata(11),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq10z: FDSE port map (
    Q => SLVSEL_18,
    D => apbi_pwdata(10),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq9z: FDSE port map (
    Q => SLVSEL_17,
    D => apbi_pwdata(9),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq8z: FDSE port map (
    Q => SLVSEL_16,
    D => apbi_pwdata(8),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq7z: FDSE port map (
    Q => SLVSEL_15,
    D => apbi_pwdata(7),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq6z: FDSE port map (
    Q => SLVSEL_14,
    D => apbi_pwdata(6),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq5z: FDSE port map (
    Q => SLVSEL_13,
    D => apbi_pwdata(5),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq4z: FDSE port map (
    Q => SLVSEL_12,
    D => apbi_pwdata(4),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq3z: FDSE port map (
    Q => SLVSEL_11,
    D => apbi_pwdata(3),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq2z: FDSE port map (
    Q => SLVSEL_10,
    D => apbi_pwdata(2),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq1z: FDSE port map (
    Q => SLVSEL_9,
    D => apbi_pwdata(1),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SLVSELq0z: FDSE port map (
    Q => NN_3,
    D => apbi_pwdata(0),
    C => clk,
    S => RSTN_I,
    CE => V_SLVSEL_1_SQMUXA);
R_SPIO_MISOOEN: FDSE port map (
    Q => spio_misooen,
    D => UN1_V_SPIO_MOSIOEN24_0_I,
    C => clk,
    S => N_2126_0_I,
    CE => V_SPIO_MISOOEN_2_SQMUXA_I);
R_EVENT_NE_Z3129: FDRSE port map (
    Q => R_EVENT_NE,
    D => NN_2,
    C => clk,
    R => RSTN_I,
    S => V_EVENT_NE_0_SQMUXA_1,
    CE => R_MODE_EN);
R_EVENT_NF_Z3130: FDRSE port map (
    Q => R_EVENT_NF,
    D => NN_2,
    C => clk,
    R => RSTN_I,
    S => V_EVENT_NF_0_SQMUXA,
    CE => R_MODE_EN);
R_MODE_EN_Z3131: FDRE port map (
    Q => R_MODE_EN,
    D => COMB_V_MODE_EN_1,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
R_MODE_MS_Z3132: FDRE port map (
    Q => R_MODE_MS,
    D => COMB_V_MODE_MS_1,
    C => clk,
    R => RSTN_I,
    CE => V_MODE_EN_1_SQMUXA_I);
R_RD_FREE_Z3133: FDSE port map (
    Q => R_RD_FREE,
    D => COMB_V_RD4_I,
    C => clk,
    S => N_2126_0_I,
    CE => V_RD_FREE_0_SQMUXA_I);
R_TDLIq2z_Z3134: FDR port map (
    Q => R_TDLI(2),
    D => R_TDLI_RNO(2),
    C => clk,
    R => N_2126_0_I);
R_TDLIq1z_Z3135: FDR port map (
    Q => R_TDLI(1),
    D => R_TDLI_RNO(1),
    C => clk,
    R => N_2126_0_I);
R_TDLIq0z_Z3136: FDR port map (
    Q => R_TDLI(0),
    D => R_TDLI_RNO(0),
    C => clk,
    R => N_2126_0_I);
R_TD_OCC_Z3137: FDRE port map (
    Q => R_TD_OCC,
    D => COMB_V_TXFIFO_76_I,
    C => clk,
    R => N_2126_0_I,
    CE => V_TD_OCC_0_SQMUXA_I);
R_RFREECNTq3z_Z3138: FDS port map (
    Q => R_RFREECNT(3),
    D => UN1_R_RFREECNT_0(3),
    C => clk,
    S => N_2126_0_I);
R_RFREECNTq2z_Z3139: FDR port map (
    Q => R_RFREECNT(2),
    D => UN1_R_RFREECNT_0(2),
    C => clk,
    R => N_2126_0_I);
R_RFREECNTq1z_Z3140: FDR port map (
    Q => R_RFREECNT(1),
    D => UN1_R_RFREECNT_0(1),
    C => clk,
    R => N_2126_0_I);
R_RFREECNTq0z_Z3141: FDR port map (
    Q => R_RFREECNT(0),
    D => UN1_R_RFREECNT_0(0),
    C => clk,
    R => N_2126_0_I);
R_EVENT_OV_Z3142: FDRSE port map (
    Q => R_EVENT_OV,
    D => NN_2,
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
R_OV_Z3144: FDRE port map (
    Q => R_OV,
    D => V_OV_0_SQMUXA_1_I,
    C => clk,
    R => N_2126_0_I,
    CE => UN1_V_OV10_0);
R_TWDIR_Z3145: FDSE port map (
    Q => R_TWDIR,
    D => COMB_V_TWDIR_1_0_I,
    C => clk,
    S => N_2126_0_I,
    CE => V_TWDIR_2_SQMUXA_I);
R_UF_Z3146: FDR port map (
    Q => R_UF,
    D => COMB_V_UF_7,
    C => clk,
    R => N_2126_0_I);
R_TDFIq2z_Z3147: FDR port map (
    Q => R_TDFI(2),
    D => R_TDFI_RNO(2),
    C => clk,
    R => N_2126_0_I);
R_TDFIq1z_Z3148: FDR port map (
    Q => R_TDFI(1),
    D => R_TDFI_RNO(1),
    C => clk,
    R => N_2126_0_I);
R_TDFIq0z_Z3149: FDR port map (
    Q => R_TDFI(0),
    D => R_TDFI_RNO(0),
    C => clk,
    R => N_2126_0_I);
R_INCRDLI_Z3150: FDR port map (
    Q => R_INCRDLI,
    D => COMB_V_INCRDLI_1,
    C => clk,
    R => N_2126_0_I);
R_SPIO_MISO: FDSE port map (
    Q => SPIO_MOSI_5,
    D => COMB_V_SPIO_MISO_3_0_I,
    C => clk,
    S => N_2126_0_I,
    CE => COMB_UN133_CHANGE_0_I);
R_RXDONE2_Z3152: FDRE port map (
    Q => R_RXDONE2,
    D => COMB_UN1_R_RUNNING_1_I,
    C => clk,
    R => N_2126_0_I,
    CE => V_RXDONE2_1_SQMUXA_I);
R_TFREECNTq3z_Z3153: FDS port map (
    Q => R_TFREECNT(3),
    D => R_EVENT_LTD_1,
    C => clk,
    S => N_2126_0_I);
R_TFREECNTq2z_Z3154: FDR port map (
    Q => R_TFREECNT(2),
    D => UN1_V_TXFIFO_76_3_M9_I_2_RNIJ0LAI2,
    C => clk,
    R => N_2126_0_I);
R_TFREECNTq1z_Z3155: FDR port map (
    Q => R_TFREECNT(1),
    D => UN1_V_TXFIFO_76_3_M9_I_2_RNI3TPF81,
    C => clk,
    R => N_2126_0_I);
R_TFREECNTq0z_Z3156: FDR port map (
    Q => R_TFREECNT(0),
    D => UN1_R_TFREECNT_1_AXB0,
    C => clk,
    R => N_2126_0_I);
R_SPIO_MOSIOEN: FDSE port map (
    Q => spio_mosioen,
    D => COMB_V_SPIO_MOSIOEN_1_0_I,
    C => clk,
    S => N_2126_0_I,
    CE => V_SPIO_MOSIOEN_4_SQMUXA_I);
R_DIVCNTq9z_Z3158: FDR port map (
    Q => R_DIVCNT(9),
    D => COMB_V_DIVCNT_1(9),
    C => clk,
    R => RSTN_I);
R_DIVCNTq8z_Z3159: FDR port map (
    Q => R_DIVCNT(8),
    D => COMB_V_DIVCNT_1(8),
    C => clk,
    R => RSTN_I);
R_DIVCNTq7z_Z3160: FDR port map (
    Q => R_DIVCNT(7),
    D => COMB_V_DIVCNT_1(7),
    C => clk,
    R => RSTN_I);
R_DIVCNTq6z_Z3161: FDR port map (
    Q => R_DIVCNT(6),
    D => COMB_V_DIVCNT_1(6),
    C => clk,
    R => RSTN_I);
R_DIVCNTq5z_Z3162: FDR port map (
    Q => R_DIVCNT(5),
    D => COMB_V_DIVCNT_1(5),
    C => clk,
    R => RSTN_I);
R_DIVCNTq4z_Z3163: FDR port map (
    Q => R_DIVCNT(4),
    D => COMB_V_DIVCNT_1(4),
    C => clk,
    R => RSTN_I);
R_DIVCNTq3z_Z3164: FDR port map (
    Q => R_DIVCNT(3),
    D => COMB_V_DIVCNT_1(3),
    C => clk,
    R => RSTN_I);
R_DIVCNTq2z_Z3165: FDR port map (
    Q => R_DIVCNT(2),
    D => COMB_V_DIVCNT_1(2),
    C => clk,
    R => RSTN_I);
R_DIVCNTq1z_Z3166: FDR port map (
    Q => R_DIVCNT(1),
    D => COMB_V_DIVCNT_1(1),
    C => clk,
    R => RSTN_I);
R_DIVCNTq0z_Z3167: FDR port map (
    Q => R_DIVCNT(0),
    D => COMB_V_DIVCNT_1(0),
    C => clk,
    R => RSTN_I);
R_LST_Z3168: FDRE port map (
    Q => R_LST,
    D => COMB_V_LST_1,
    C => clk,
    R => RSTN_I,
    CE => V_LST_1_SQMUXA_1_I);
II_GND: GND port map (
    G => NN_2);
II_VCC: VCC port map (
    P => NN_1);
spio_miso <= SPIO_MOSI_5;
spio_mosi <= SPIO_MOSI_5;
spio_sck <= SPIO_SCK_6;
spio_astart <= NN_2;
slvsel(0) <= NN_3;
slvsel(1) <= SLVSEL_9;
slvsel(2) <= SLVSEL_10;
slvsel(3) <= SLVSEL_11;
slvsel(4) <= SLVSEL_12;
slvsel(5) <= SLVSEL_13;
slvsel(6) <= SLVSEL_14;
slvsel(7) <= SLVSEL_15;
slvsel(8) <= SLVSEL_16;
slvsel(9) <= SLVSEL_17;
slvsel(10) <= SLVSEL_18;
slvsel(11) <= SLVSEL_19;
slvsel(12) <= SLVSEL_20;
slvsel(13) <= SLVSEL_21;
slvsel(14) <= SLVSEL_22;
slvsel(15) <= SLVSEL_23;
slvsel(16) <= SLVSEL_24;
slvsel(17) <= SLVSEL_25;
slvsel(18) <= SLVSEL_26;
slvsel(19) <= SLVSEL_27;
slvsel(20) <= SLVSEL_28;
slvsel(21) <= SLVSEL_29;
slvsel(22) <= SLVSEL_30;
slvsel(23) <= SLVSEL_31;
slvsel(24) <= SLVSEL_32;
slvsel(25) <= SLVSEL_33;
slvsel(26) <= SLVSEL_34;
slvsel(27) <= SLVSEL_35;
slvsel(28) <= SLVSEL_36;
slvsel(29) <= SLVSEL_37;
slvsel(30) <= SLVSEL_38;
slvsel(31) <= SLVSEL_39;
end beh;

