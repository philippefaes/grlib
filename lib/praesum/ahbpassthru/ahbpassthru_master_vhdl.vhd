--Pass through AHB master port to off-chip
library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.config.all;
use grlib.stdlib.all;
use grlib.amba.all;
library praesum;
use praesum.ahbpassthru_vhdl.all;

entity ahbpassthru_master_vhdl is
  
    generic(
      hindex_set : integer := 3;
      hbaseaddr  : integer := 0;
      hmask      : integer := 16#fff#;
      htype      : integer := 1;        -- '1' = AHB memory
                                        -- '0' = AHB I/O
      PREFETCHABLE : integer := 1;
      CACHEABLE  : integer := 1;
      AHBDW      : integer := 64                              --Data bus width
      );
    port(
   --master inputs
      hgrant     : in std_logic;                              --bus grant
      hready     : in std_logic;                              --transfer done
      hresp      : in std_logic_vector(1 downto 0);           --response type
      hrdata     : in std_logic_vector(AHBDW-1 downto 0); --read data bus
      hcache     : in std_ulogic;                              --cacheable
      hirq       : in std_logic;                              --interrupt
   --master outputs
      hbusreq    : out std_logic;                             --bus request
      hlock      : out std_logic;                             --lock request
      htrans     : out std_logic_vector(1 downto 0);          --transfer type
      haddr      : out std_logic_vector(31 downto 0);         --address bus
      hwrite     : out std_logic;                             --read/write
      hsize      : out std_logic_vector(2 downto 0);          --transfer size
      hburst     : out std_logic_vector(2 downto 0);          --burst type
      hprot      : out std_logic_vector(3 downto 0);          --protection control
      hwdata     : out std_logic_vector(AHBDW-1 downto 0);--write data bus
      hirq_o     : out std_logic;                             --interrupt
      hconfig    : out ahb_config_type;	                      -- memory access reg.
      hindex     : out integer range 0 to NAHBMST-1;          -- Used by the AHB controller to check
                                                              -- if the index is correct.
   --pass-through ports
   --pass through outputs
      pt_hgrant  : out std_logic;                             --bus grant
      pt_hready  : out std_logic;                             --transfer done
      pt_hresp   : out std_logic_vector(1 downto 0);          --response type
      pt_hrdata  : out std_logic_vector(AHBDW-1 downto 0);--read data bus
      pt_hcache  : out std_logic;                             --cacheable
      pt_hirq    : out std_logic;                             --interrupt
   --pass through inputs
      pt_hbusreq : in std_logic;                              --bus request
      pt_hlock   : in std_logic;                              --lock request
      pt_htrans  : in std_logic_vector(1 downto 0);           --transfer type
      pt_haddr   : in std_logic_vector(31 downto 0);          --address bus
      pt_hwrite  : in std_logic;                              --read/write
      pt_hsize   : in std_logic_vector(2 downto 0);           --transfer size
      pt_hburst  : in std_logic_vector(2 downto 0);           --burst type
      pt_hprot   : in std_logic_vector(3 downto 0);           --protection control
      pt_hwdata  : in std_logic_vector(AHBDW-1 downto 0); --write data bus
      pt_hirq_o  : in std_logic                               --interrupt
      );

end;
    
architecture rtl of ahbpassthru_master_vhdl is
-- purpose: Copy input signals to outputs
-- type   : combinational
-- inputs : *
-- outputs: *

  constant RESERVED0 : integer := 0;      -- Reserved field
  constant VERSION   : integer := 1;      -- Core version
  constant SELECTIRQ : integer := hindex_set; -- For now irq equals hindex
  constant VENDOR : integer := 16#01#;    -- Gaisler is the vendor for now
  constant DEVICE : integer := 16#069#;   -- Gaisler ATAHB Master for now
  constant hconfig_0 : ahb_config_type := (
    0 => ahb_device_reg ( VENDOR, DEVICE, RESERVED0, VERSION, SELECTIRQ),
    4 => ahb_ptbar      ( hbaseaddr, PREFETCHABLE, CACHEABLE,  hmask, htype),
    others => (others => '0'));

begin  -- rtl of ahbpassthru_master_vhdl

  -- purpose: Copy AHB Master signals in/out of the module
  -- type   : combinational
  -- inputs : hgrant, hready, hresp, hrdata, hcache, hirq, pt_hbusreq,
  -- pt_hlock, pt_htrans, pt_haddr, pt_hwrite, pt_hsize, pt_hburst, pt_hprot,
  -- pt_hwdata, pt_hirq_o
  -- outputs: hbusreq, hlock, htrans, haddr, hwrite, hsize, hburst, hprot, hwdata,
  -- hirq_o, pt_hgrant, pt_hready, pt_hresp, pt_hrdata, pt_hcache, pt_hirq
  ahbpassthru: process (hgrant, hready, hresp, hrdata, hcache, hirq, pt_hbusreq, pt_hlock, pt_htrans, pt_haddr, pt_hwrite, pt_hsize, pt_hburst, pt_hprot, pt_hwdata)
  begin  -- process ahbpassthru
    
    pt_hgrant  <= hgrant ; 
    pt_hready  <= hready ; 
    pt_hresp   <= hresp  ;  
    pt_hrdata  <= hrdata ; 
    pt_hcache  <= hcache ; 
    pt_hirq    <= hirq   ;   
   
    hbusreq    <= pt_hbusreq;
    hlock      <= pt_hlock  ;  
    htrans     <= pt_htrans ; 
    haddr      <= pt_haddr  ;  
    hwrite     <= pt_hwrite ; 
    hsize      <= pt_hsize  ;  
    hburst     <= pt_hburst ; 
    hprot      <= pt_hprot  ;  
    hwdata     <= pt_hwdata ; 
    hirq_o     <= pt_hirq_o ;
    
  end process ahbpassthru;
  hconfig <= hconfig_0;
  hindex  <= hindex_set;

end rtl;
