library ieee;
use ieee.std_logic_1164.all;
library grlib;
use grlib.config.all;
use grlib.stdlib.all;
use grlib.amba.all;

package ahbpassthru_vhdl is

  function ahb_ptbar(memaddr : ahb_addr_type; prefetch, cache : integer;
	addrmask : ahb_addr_type; mem_io_select : integer)
  return std_logic_vector;

  component ahbpassthru_master_vhdl
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
      hrdata     : in std_logic_vector(AHBDW-1 downto 0);     --read data bus
      hcache     : in std_logic;                              --cacheable
      hirq       : in std_ulogic;                             --interrupt bus
   --master outputs
      hbusreq    : out std_logic;                             --bus request
      hlock      : out std_logic;                             --lock request
      htrans     : out std_logic_vector(1 downto 0);          --transfer type
      haddr      : out std_logic_vector(31 downto 0);         --address bus
      hwrite     : out std_logic;                             --read/write
      hsize      : out std_logic_vector(2 downto 0);          --transfer size
      hburst     : out std_logic_vector(2 downto 0);          --burst type
      hprot      : out std_logic_vector(3 downto 0);          --protection control
      hwdata     : out std_logic_vector(AHBDW-1 downto 0);    --write data bus
      hirq_o     : out std_ulogic;                            --interrupt buss
      hconfig    : out ahb_config_type;	                      -- memory access reg.
      hindex     : out integer range 0 to NAHBMST-1;          -- debug info
      
   --pass-through ports
   --pass through outputs
      pt_hgrant  : out std_logic;                             --bus grant
      pt_hready  : out std_logic;                             --transfer done
      pt_hresp   : out std_logic_vector(1 downto 0);          --response type
      pt_hrdata  : out std_logic_vector(AHBDW-1 downto 0);    --read data bus
      pt_hcache  : out std_logic;                             --cacheable
      pt_hirq    : out std_ulogic;                            --interrupt bus
   --pass through inputs
      pt_hbusreq : in std_logic;                              --bus request
      pt_hlock   : in std_logic;                              --lock request
      pt_htrans  : in std_logic_vector(1 downto 0);           --transfer type
      pt_haddr   : in std_logic_vector(31 downto 0);          --address bus
      pt_hwrite  : in std_logic;                              --read/write
      pt_hsize   : in std_logic_vector(2 downto 0);           --transfer size
      pt_hburst  : in std_logic_vector(2 downto 0);           --burst type
      pt_hprot   : in std_logic_vector(3 downto 0);           --protection control
      pt_hwdata  : in std_logic_vector(AHBDW-1 downto 0);     --write data bus
      pt_hirq_o  : in std_ulogic                              --interrupt buss
      );
  end component;

  component ahbpassthru_slave_vhdl
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
      hirq       : in std_ulogic;                             --interrupt
      --Slave outputs
      hready_o   : out std_logic;                             --transfer done
      hresp      : out std_logic_vector(1 downto 0);          --response type
      hrdata     : out std_logic_vector(AHBDW-1 downto 0);    --read data
      hsplit     : out std_logic_vector(15 downto 0);         --split completion
      hcache_o   : out std_logic;                             --cacheable
      hirq_o     : out std_ulogic;                            --interrupt out
      hconfig    : out ahb_config_type;	                      -- memory access reg.
      hindex     : out integer range 0 to NAHBSLV-1;          -- debug info
      
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
      pt_hirq    : out std_ulogic;                            --interrupt
      --pass through inputs
      pt_hready_o : in std_logic;                             --transfer done
      pt_hresp   : in std_logic_vector(1 downto 0);           --response type
      pt_hrdata  : in std_logic_vector(AHBDW-1 downto 0);     --read data
      pt_hsplit  : in std_logic_vector(15 downto 0);          --split completion
      pt_hcache_o : in std_logic;                             --cacheable
      pt_hirq_o  : in std_ulogic                              --interrupt out
      );
  end component;

end ahbpassthru_vhdl;

package body ahbpassthru_vhdl is

  function ahb_ptbar(memaddr : ahb_addr_type; prefetch, cache : integer;
  addrmask : ahb_addr_type; mem_io_select : integer)
    return std_logic_vector is
    variable prefetch_ulogic : std_ulogic := '1';  -- Used for conversion from integer to std_ulogic
    variable cache_ulogic : std_ulogic := '1';  -- Used for conversion from integer to std_ulogic
  begin
    if mem_io_select /= 0 then
      if prefetch /= 0 then
        prefetch_ulogic := '1';
      else
        prefetch_ulogic := '0';
      end if;

      if cache /= 0 then
        cache_ulogic := '1';
      else
        cache_ulogic := '0';
      end if;
      
      return (ahb_membar(memaddr, prefetch_ulogic, cache_ulogic, addrmask));
    else
      return (ahb_iobar(memaddr, addrmask));
    end if;
  end;
    

end ahbpassthru_vhdl;
