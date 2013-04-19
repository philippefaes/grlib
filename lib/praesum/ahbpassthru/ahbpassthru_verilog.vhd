library ieee;
use ieee.std_logic_1164.all;

package ahbpassthru_verilog is

  component ahbpassthru_master
    generic(
      hindex     : integer := 3;
      hirqnum    : integer := 3;
      NUMMASTER  : integer := 1;                              --Number of AHB slaves
      NUMIRQ     : integer := 32;                             --Number of interrupts
      DATAWIDTH  : integer := 32                              --Data bus width
      );
    port(
   --master inputs
      hgrant     : in std_logic_vector(0 to NUMMASTER-1);     --bus grant
      hready     : in std_logic;                              --transfer done
      hresp      : in std_logic_vector(1 downto 0);           --response type
      hrdata     : in std_logic_vector(DATAWIDTH-1 downto 0); --read data bus
      hcache     : in std_logic;                              --cacheable
      hirq       : in std_logic_vector(NUMIRQ-1 downto 0);    --interrupt bus
   --master outputs
      hbusreq    : out std_logic;                             --bus request
      hlock      : out std_logic;                             --lock request
      htrans     : out std_logic_vector(1 downto 0);          --transfer type
      haddr      : out std_logic_vector(31 downto 0);         --address bus
      hwrite     : out std_logic;                             --read/write
      hsize      : out std_logic_vector(2 downto 0);          --transfer size
      hburst     : out std_logic_vector(2 downto 0);          --burst type
      hprot      : out std_logic_vector(3 downto 0);          --protection control
      hwdata     : out std_logic_vector(DATAWIDTH-1 downto 0);--write data bus
      hirq_o     : out std_logic_vector(NUMIRQ-1 downto 0);   --interrupt buss

   --pass-through ports
   --pass through outputs
      pt_hgrant  : out std_logic_vector(0 to NUMMASTER-1);    --bus grant
      pt_hready  : out std_logic;                             --transfer done
      pt_hresp   : out std_logic_vector(1 downto 0);          --response type
      pt_hrdata  : out std_logic_vector(DATAWIDTH-1 downto 0);--read data bus
      pt_hcache  : out std_logic;                             --cacheable
      pt_hirq    : out std_logic_vector(NUMIRQ-1 downto 0);   --interrupt bus
   --pass through inputs
      pt_hbusreq : in std_logic;                              --bus request
      pt_hlock   : in std_logic;                              --lock request
      pt_htrans  : in std_logic_vector(1 downto 0);           --transfer type
      pt_haddr   : in std_logic_vector(31 downto 0);          --address bus
      pt_hwrite  : in std_logic;                              --read/write
      pt_hsize   : in std_logic_vector(2 downto 0);           --transfer size
      pt_hburst  : in std_logic_vector(2 downto 0);           --burst type
      pt_hprot   : in std_logic_vector(3 downto 0);           --protection control
      pt_hwdata  : in std_logic_vector(DATAWIDTH-1 downto 0); --write data bus
      pt_hirq_o  : in std_logic_vector(NUMIRQ-1 downto 0)     --interrupt buss
      );
  end component;

  component ahbpassthru_slave
    generic(
      hindex     : integer := 3;
      hirqnum    : integer := 3;
      NUMSLAVE   : integer := 1;                              --Number of AHB slaves
      NUMIRQ     : integer := 32;                             --Number of interrupts
      NUMBANK    : integer := 1;                              --Number of Banks
      DATAWIDTH  : integer := 32                              --Data bus width
      );
    port(
     --Slave inputs
      hsel       : in std_logic;                              --slave select
      haddr      : in std_logic_vector(31 downto 0);          --slave address (byte addressing)
      hwrite     : in std_logic;                              --read/write
      htrans     : in std_logic_vector(1 downto 0);           --transfer type
      hsize      : in std_logic_vector(2 downto 0);           --transfer size
      hburst     : in std_logic_vector(2 downto 0);           --burst type
      hwdata     : in std_logic_vector(DATAWIDTH-1 downto 0); --write data
      hprot      : in std_logic_vector(3 downto 0);           --protection control
      hready     : in std_logic;                              --transfer done
      hmaster    : in std_logic_vector(3 downto 0);           --current master
      hmastlock  : in std_logic;                              --locked access
      hmbsel     : in std_logic_vector(NUMBANK-1 downto 0);   --memory bank select
      hcache     : in std_logic;                              --cacheable
      hirq       : in std_logic;                              --interrupt
      --Slave outputs
      hready_o   : out std_logic;                             --transfer done
      hresp      : out std_logic_vector(1 downto 0);          --response type
      hrdata     : out std_logic_vector(DATAWIDTH-1 downto 0);--read data
      hsplit     : out std_logic_vector(15 downto 0);         --split completion
      hcache_o   : out std_logic;                             --cacheable
      hirq_o     : out std_logic_vector(NUMIRQ-1 downto 0);   --interrupt out

   --pass-through ports
   --pass through outputs
      pt_hsel    : out std_logic;                             --slave select
      pt_haddr   : out std_logic_vector(31 downto 0);         --slave address (byte addressing)
      pt_hwrite  : out std_logic;                             --read/write
      pt_htrans  : out std_logic_vector(1 downto 0);          --transfer type
      pt_hsize   : out std_logic_vector(2 downto 0);          --transfer size
      pt_hburst  : out std_logic_vector(2 downto 0);          --burst type
      pt_hwdata  : out std_logic_vector(DATAWIDTH-1 downto 0);--write data
      pt_hprot   : out std_logic_vector(3 downto 0);          --protection control
      pt_hready_o : out std_logic;                            --transfer done
      pt_hmaster : out std_logic_vector(3 downto 0);          --current master
      pt_hmastlock : out std_logic;                           --locked access
      pt_hmbsel  : out std_logic_vector(NUMBANK-1 downto 0);  --memory bank select
      pt_hcache_o : out std_logic;                            --cacheable
      pt_hirq_o  : out std_logic;                             --interrupt
      --pass through inputs
      pt_hready  : in std_logic;                              --transfer done
      pt_hresp   : in std_logic_vector(1 downto 0);           --response type
      pt_hrdata  : in std_logic_vector(DATAWIDTH-1 downto 0); --read data
      pt_hsplit  : in std_logic_vector(15 downto 0);          --split completion
      pt_hcache  : in std_logic;                              --cacheable
      pt_hirq    : in std_logic_vector(NUMIRQ-1 downto 0)     --interrupt out
      );
  end component;

end ahbpassthru_verilog;
