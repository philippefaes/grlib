--Pass through AHB slave port to off-chip
library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.config.all;
use grlib.stdlib.all;
use grlib.amba.all;
library praesum;
use praesum.ahbpassthru_vhdl.all;

entity ahbpassthru_slave_vhdl is

    generic(
      hindex_set : integer := 0;
      hbaseaddr  : integer := 0;
      hmask      : integer := 16#fff#;
      htype      : integer := 1;        -- '1' = AHB memory
                                        -- '0' = AHB I/O
      PREFETCHABLE : integer := 1;
      CACHEABLE  : integer := 1;
      NAHBAMR    : integer := 4;                              --Number of Bank Address registers
      AHBDW      : integer := 64                              --Data bus width
      );
    port(
     --Slave inputs
      hsel       : in std_logic;                              --slave select
      haddr      : in std_logic_vector(31 downto 0);          --slave address (byte addressing)
      hwrite     : in std_logic;                              --read/write
      htrans     : in std_logic_vector(1 downto 0);           --transfer type
      hsize      : in std_logic_vector(2 downto 0);           --transfer size
      hburst     : in std_logic_vector(2 downto 0);           --burst type
      hwdata     : in std_logic_vector(AHBDW-1 downto 0);     --write data
      hprot      : in std_logic_vector(3 downto 0);           --protection control
      hready     : in std_logic;                              --transfer done
      hmaster    : in std_logic_vector(3 downto 0);           --current master
      hmastlock  : in std_logic;                              --locked access
      hmbsel     : in std_logic_vector(0 to NAHBAMR-1);       --memory bank select
      hcache     : in std_logic;                              --cacheable
      hirq       : in std_logic;                              --interrupt
      --Slave outputs
      hready_o   : out std_logic;                             --transfer done
      hresp      : out std_logic_vector(1 downto 0);          --response type
      hrdata     : out std_logic_vector(AHBDW-1 downto 0);    --read data
      hsplit     : out std_logic_vector(15 downto 0);         --split completion
      hcache_o   : out std_logic;                             --cacheable
      hirq_o     : out std_logic;                             --interrupt out
      hconfig    : out ahb_config_type;	                      -- memory access reg.
      hindex     : out integer range 0 to NAHBSLV-1;
      
   --pass-through ports
   --pass through outputs
      pt_hsel    : out std_logic;                             --slave select
      pt_haddr   : out std_logic_vector(31 downto 0);         --slave address (byte addressing)
      pt_hwrite  : out std_logic;                             --read/write
      pt_htrans  : out std_logic_vector(1 downto 0);          --transfer type
      pt_hsize   : out std_logic_vector(2 downto 0);          --transfer size
      pt_hburst  : out std_logic_vector(2 downto 0);          --burst type
      pt_hwdata  : out std_logic_vector(AHBDW-1 downto 0);    --write data
      pt_hprot   : out std_logic_vector(3 downto 0);          --protection control
      pt_hready  : out std_logic;                             --transfer done
      pt_hmaster : out std_logic_vector(3 downto 0);          --current master
      pt_hmastlock : out std_logic;                           --locked access
      pt_hmbsel  : out std_logic_vector(0 to NAHBAMR-1);      --memory bank select
      pt_hcache  : out std_logic;                             --cacheable
      pt_hirq    : out std_logic;                             --interrupt
      --pass through inputs
      pt_hready_o : in std_logic;                             --transfer done
      pt_hresp   : in std_logic_vector(1 downto 0);           --response type
      pt_hrdata  : in std_logic_vector(AHBDW-1 downto 0);     --read data
      pt_hsplit  : in std_logic_vector(15 downto 0);          --split completion
      pt_hcache_o : in std_logic;                             --cacheable
      pt_hirq_o  : in std_logic                               --interrupt
      );
end;

   
architecture rtl of ahbpassthru_slave_vhdl is
-- purpose: Copy input signals to outputs
-- type   : combinational
-- inputs : *
-- outputs: *

  constant RESERVED0 : integer := 0;      -- Reserved field
  constant VERSION   : integer := 1;      -- Core version
  constant SELECTIRQ : integer := hindex_set; -- For now irq equals hindex_set
  constant VENDOR : integer := 16#01#;    -- Gaisler is the vendor for now
  constant DEVICE : integer := 16#068#;   -- Gaisler AT AHB SLV for now
  constant hconfig_0 : ahb_config_type := (
    0 => ahb_device_reg ( VENDOR, DEVICE, RESERVED0, VERSION, SELECTIRQ),
    4 => ahb_ptbar      ( hbaseaddr, PREFETCHABLE, CACHEABLE,  hmask, htype),
    others => (others => '0'));

begin  -- rtl of ahbpassthru_slave_vhdl

  -- purpose: Copy AHB Slave signals in/out of the module
  -- type   : combinational
  -- inputs : hgrant, hready, hresp, hrdata, hcache, hirq, pt_hbusreq,
  -- pt_hlock, pt_htrans, pt_haddr, pt_hwrite, pt_hsize, pt_hburst, pt_hprot,
  -- pt_hwdata, pt_hirq_o
  -- outputs: hbusreq, hlock, htrans, haddr, hwrite, hsize, hburst, hprot, hwdata,
  -- hirq_o, pt_hgrant, pt_hready, pt_hresp, pt_hrdata, pt_hcache, pt_hirq

  ahbpassthru: process (hsel, haddr, hwrite, htrans, hsize, hburst, hwdata,
                        hprot, hready, hmaster, hmastlock, hmbsel, hcache,
                        hirq, pt_hready_o, pt_hresp, pt_hrdata, pt_hsplit,
                        pt_hcache_o, pt_hirq_o)
  begin  -- process ahbpassthru
    pt_hsel      <= hsel;
    pt_haddr     <= haddr;
    pt_hwrite    <= hwrite;
    pt_htrans    <= htrans;
    pt_hsize     <= hsize;
    pt_hburst    <= hburst;
    pt_hwdata    <= hwdata;
    pt_hprot     <= hprot;
    pt_hready    <= hready;
    pt_hmaster   <= hmaster;
    pt_hmastlock <= hmastlock;
    pt_hmbsel    <= hmbsel;
    pt_hcache    <= hcache;
    pt_hirq      <= hirq;

    hready_o     <= pt_hready_o;
    hresp        <= pt_hresp;
    hrdata       <= pt_hrdata;
    hsplit       <= pt_hsplit;
    hcache_o     <= pt_hcache_o;
    hirq_o       <= pt_hirq_o;
  end process ahbpassthru;
  hconfig <= hconfig_0;
  hindex  <= hindex_set;
  
end rtl;

  
   
