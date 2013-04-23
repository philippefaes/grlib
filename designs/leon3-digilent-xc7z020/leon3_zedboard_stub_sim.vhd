-------------------------------------------------------------------------------
-- leon3_zedboard_stub.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity leon3_zedboard_stub is
  port (
    processing_system7_0_MIO : inout std_logic_vector(53 downto 0);
    processing_system7_0_PS_SRSTB : in std_logic;
    processing_system7_0_PS_CLK : in std_logic;
    processing_system7_0_PS_PORB : in std_logic;
    processing_system7_0_DDR_Clk : inout std_logic;
    processing_system7_0_DDR_Clk_n : inout std_logic;
    processing_system7_0_DDR_CKE : inout std_logic;
    processing_system7_0_DDR_CS_n : inout std_logic;
    processing_system7_0_DDR_RAS_n : inout std_logic;
    processing_system7_0_DDR_CAS_n : inout std_logic;
    processing_system7_0_DDR_WEB_pin : out std_logic;
    processing_system7_0_DDR_BankAddr : inout std_logic_vector(2 downto 0);
    processing_system7_0_DDR_Addr : inout std_logic_vector(14 downto 0);
    processing_system7_0_DDR_ODT : inout std_logic;
    processing_system7_0_DDR_DRSTB : inout std_logic;
    processing_system7_0_DDR_DQ : inout std_logic_vector(31 downto 0);
    processing_system7_0_DDR_DM : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_DQS_n : inout std_logic_vector(3 downto 0);
    processing_system7_0_DDR_VRN : inout std_logic;
    processing_system7_0_DDR_VRP : inout std_logic;
    ahblite_axi_bridge_0_S_AHB_HSEL_pin : in std_logic;
    ahblite_axi_bridge_0_S_AHB_HADDR_pin : in std_logic_vector(31 downto 0);
    ahblite_axi_bridge_0_S_AHB_HPROT_pin : in std_logic_vector(3 downto 0);
    ahblite_axi_bridge_0_S_AHB_HTRANS_pin : in std_logic_vector(1 downto 0);
    ahblite_axi_bridge_0_S_AHB_HSIZE_pin : in std_logic_vector(2 downto 0);
    ahblite_axi_bridge_0_S_AHB_HWRITE_pin : in std_logic;
    ahblite_axi_bridge_0_S_AHB_HBURST_pin : in std_logic_vector(2 downto 0);
    ahblite_axi_bridge_0_S_AHB_HWDATA_pin : in std_logic_vector(31 downto 0);
    ahblite_axi_bridge_0_S_AHB_HREADY_OUT_pin : out std_logic;
    ahblite_axi_bridge_0_S_AHB_HREADY_IN_pin : in std_logic;
    ahblite_axi_bridge_0_S_AHB_HRDATA_pin : out std_logic_vector(31 downto 0);
    ahblite_axi_bridge_0_S_AHB_HRESP_pin : out std_logic;
    processing_system7_0_FCLK_CLK0_pin : out std_logic;
    processing_system7_0_FCLK_RESET0_N_pin : out std_logic;
    processing_system7_0_FCLK_CLKTRIG0_N_pin : in std_logic
  );
end leon3_zedboard_stub;

architecture STRUCTURE of leon3_zedboard_stub is

signal gclk            : std_logic := '0';
signal rst             : std_logic := '0';

begin

  gclk <= not gclk after 10.0 ns;
  rst <= '1' after 1 us;

  processing_system7_0_FCLK_CLK0_pin <= gclk;
  processing_system7_0_FCLK_RESET0_N_pin <= rst;

end architecture STRUCTURE;

