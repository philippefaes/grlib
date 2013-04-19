library ieee;
use ieee.std_logic_1164.all;
library gaisler;
use gaisler.misc.all;
use gaisler.net.all;
library grlib;
use grlib.stdlib.all;

-- pragma translate_off
library unisim;
use unisim.BUFG;
use unisim.DCM;
-- pragma translate_on

library techmap;
use techmap.gencomp.all;

entity rgmii is
  
  generic (
    tech    : integer := 0;
    rxclk   : integer := 0;
    gmii    : integer := 0;
    odelen  : integer := 0
    );
  port (
    rstn        : in  std_ulogic;
    clk50       : in  std_ulogic;
    lock        : out std_ulogic;
    gmiii	: out eth_in_type;
    gmiio	: in  eth_out_type;
    rgmiii	: in  eth_in_type;
    rgmiio	: out eth_out_type
    );
  
end ;

architecture rtl of rgmii is

  component BUFG port (O : out std_logic; I : in std_logic); end component;

  component BUFGMUX port ( O : out std_ulogic; I0 : in std_ulogic;
                           I1 : in std_ulogic; S : in std_ulogic);
  end component;

component PLL_BASE is
generic (
  BANDWIDTH : string := "OPTIMIZED";
  CLKFBOUT_MULT : integer := 1;
  CLKFBOUT_PHASE : real := 0.0;
  CLKIN_PERIOD : real := 0.000;
  CLKOUT0_DIVIDE : integer := 1;
  CLKOUT0_DUTY_CYCLE : real := 0.5;
  CLKOUT0_PHASE : real := 0.0;
  CLKOUT1_DIVIDE : integer := 1;
  CLKOUT1_DUTY_CYCLE : real := 0.5;
  CLKOUT1_PHASE : real := 0.0;
  CLKOUT2_DIVIDE : integer := 1;
  CLKOUT2_DUTY_CYCLE : real := 0.5;
  CLKOUT2_PHASE : real := 0.0;
  CLKOUT3_DIVIDE : integer := 1;
  CLKOUT3_DUTY_CYCLE : real := 0.5;
  CLKOUT3_PHASE : real := 0.0;
  CLKOUT4_DIVIDE : integer := 1;
  CLKOUT4_DUTY_CYCLE : real := 0.5;
  CLKOUT4_PHASE : real := 0.0;
  CLKOUT5_DIVIDE : integer := 1;
  CLKOUT5_DUTY_CYCLE : real := 0.5;
  CLKOUT5_PHASE : real := 0.0;
  CLK_FEEDBACK : string := "CLKFBOUT";
  COMPENSATION : string := "SYSTEM_SYNCHRONOUS";
  DIVCLK_DIVIDE : integer := 1;
  REF_JITTER : real := 0.100;
  RESET_ON_LOSS_OF_LOCK : boolean := FALSE
);
port (
  CLKFBOUT : out std_ulogic;
  CLKOUT0 : out std_ulogic;
  CLKOUT1 : out std_ulogic;
  CLKOUT2 : out std_ulogic;
  CLKOUT3 : out std_ulogic;
  CLKOUT4 : out std_ulogic;
  CLKOUT5 : out std_ulogic;
  LOCKED : out std_ulogic;
  
  CLKFBIN : in std_ulogic;
  CLKIN : in std_ulogic;
  RST : in std_ulogic
  );
end component PLL_BASE;

component DCM_SP is
  generic (
    CLKDV_DIVIDE : real := 2.0;
    CLKFX_DIVIDE : integer := 1;
    CLKFX_MULTIPLY : integer := 4;
    CLKIN_DIVIDE_BY_2 : boolean := false;
    CLKIN_PERIOD : real := 10.0;                         --non-simulatable
    CLKOUT_PHASE_SHIFT : string := "NONE";
    CLK_FEEDBACK : string := "1X";
    DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS";     --non-simulatable
    DFS_FREQUENCY_MODE : string := "LOW";
    DLL_FREQUENCY_MODE : string := "LOW";
    DSS_MODE : string := "NONE";                        --non-simulatable
    DUTY_CYCLE_CORRECTION : boolean := true;
    FACTORY_JF : bit_vector := X"C080";                 --non-simulatable
    PHASE_SHIFT : integer := 0;
    STARTUP_WAIT : boolean := false                     --non-simulatable
    );
  port (
    CLK0 : out std_ulogic := '0';
    CLK180 : out std_ulogic := '0';
    CLK270 : out std_ulogic := '0';
    CLK2X : out std_ulogic := '0';
    CLK2X180 : out std_ulogic := '0';
    CLK90 : out std_ulogic := '0';
    CLKDV : out std_ulogic := '0';
    CLKFX : out std_ulogic := '0';
    CLKFX180 : out std_ulogic := '0';
    LOCKED : out std_ulogic := '0';
    PSDONE : out std_ulogic := '0';
    STATUS : out std_logic_vector(7 downto 0) := "00000000";
    CLKFB : in std_ulogic := '0';
    CLKIN : in std_ulogic := '0';
    DSSEN : in std_ulogic := '0';
    PSCLK : in std_ulogic := '0';
    PSEN : in std_ulogic := '0';
    PSINCDEC : in std_ulogic := '0';
    RST : in std_ulogic := '0'
    );
end component DCM_SP;
                    
component DCM
  generic (
     CLKDV_DIVIDE : real := 2.0;
     CLKFX_DIVIDE : integer := 1;
     CLKFX_MULTIPLY : integer := 4;
     CLKIN_DIVIDE_BY_2 : boolean := false;
     CLKIN_PERIOD : real := 10.0;
     CLKOUT_PHASE_SHIFT : string := "NONE";
     CLK_FEEDBACK : string := "1X";
     DESKEW_ADJUST : string := "SYSTEM_SYNCHRONOUS";
     DFS_FREQUENCY_MODE : string := "LOW";
     DLL_FREQUENCY_MODE : string := "LOW";
     DSS_MODE : string := "NONE";
     DUTY_CYCLE_CORRECTION : boolean := true;
     FACTORY_JF : bit_vector := X"C080";
     PHASE_SHIFT : integer := 0;
     SIM_MODE : string := "SAFE";
     STARTUP_WAIT : boolean := false
  );
  port (
     CLK0 : out std_ulogic := '0';
     CLK180 : out std_ulogic := '0';
     CLK270 : out std_ulogic := '0';
     CLK2X : out std_ulogic := '0';
     CLK2X180 : out std_ulogic := '0';
     CLK90 : out std_ulogic := '0';
     CLKDV : out std_ulogic := '0';
     CLKFX : out std_ulogic := '0';
     CLKFX180 : out std_ulogic := '0';
     LOCKED : out std_ulogic := '0';
     PSDONE : out std_ulogic := '0';
     STATUS : out std_logic_vector(7 downto 0) := "00000000";
     CLKFB : in std_ulogic := '0';
     CLKIN : in std_ulogic := '0';
     DSSEN : in std_ulogic := '0';
     PSCLK : in std_ulogic := '0';
     PSEN : in std_ulogic := '0';
     PSINCDEC : in std_ulogic := '0';
     RST : in std_ulogic := '0'
  );
end component;

component ODDR2
  generic (
     DDR_ALIGNMENT : string := "NONE";
     INIT : bit := '0';
     SRTYPE : string := "SYNC"
  );
  port (
     Q : out std_ulogic;
     C0 : in std_ulogic;
     C1 : in std_ulogic;
     CE : in std_ulogic := 'H';
     D0 : in std_ulogic;
     D1 : in std_ulogic;
     R : in std_ulogic := 'L';
     S : in std_ulogic := 'L'
  );
end component;

component FDDRRSE
  generic (
     INIT : bit := '0'
  );
  port (
     Q : out std_ulogic;
     C0 : in std_ulogic;
     C1 : in std_ulogic;
     CE : in std_ulogic;
     D0 : in std_ulogic;
     D1 : in std_ulogic;
     R : in std_ulogic;
     S : in std_ulogic
  );
end component;

component IDDR2
  generic (
     DDR_ALIGNMENT : string := "NONE";
     INIT_Q0 : bit := '0';
     INIT_Q1 : bit := '0';
     SRTYPE : string := "SYNC"
  );
  port (
     Q0 : out std_ulogic;
     Q1 : out std_ulogic;
     C0 : in std_ulogic;
     C1 : in std_ulogic;
     CE : in std_ulogic := 'H';
     D : in std_ulogic;
     R : in std_ulogic := 'L';
     S : in std_ulogic := 'L'
  );
end component;

component IODELAY2
  generic (
     COUNTER_WRAPAROUND : string := "WRAPAROUND";
     DATA_RATE : string := "SDR";
     DELAY_SRC : string := "IO";
     IDELAY2_VALUE : integer := 0;
     IDELAY_MODE : string := "NORMAL";
     IDELAY_TYPE : string := "DEFAULT";
     IDELAY_VALUE : integer := 0;
     ODELAY_VALUE : integer := 0;
     SERDES_MODE : string := "NONE";
     SIM_TAPDELAY_VALUE : integer := 75
  );
  port (
     BUSY : out std_ulogic;
     DATAOUT : out std_ulogic;
     DATAOUT2 : out std_ulogic;
     DOUT : out std_ulogic;
     TOUT : out std_ulogic;
     CAL : in std_ulogic;
     CE : in std_ulogic;
     CLK : in std_ulogic;
     IDATAIN : in std_ulogic;
     INC : in std_ulogic;
     IOCLK0 : in std_ulogic;
     IOCLK1 : in std_ulogic;
     ODATAIN : in std_ulogic;
     RST : in std_ulogic;
     T : in std_ulogic
  );
end component;

  constant VERSION : integer := 1;
  constant CLKIN_PERIOD_ST : string := "8.0";

  signal vcc, gnd : std_ulogic;
  signal tx_en, tx_ctlp, tx_ctl : std_ulogic;
  signal txd, txd1 : std_logic_vector(7 downto 0);
  signal rxd1, rxd2, rxd3, rxd4 : std_logic_vector(7 downto 0);
  signal rx_clk, nrx_clk : std_ulogic;
  signal rx_clki, rx_clk_tmp : std_ulogic;
  signal rx_ctlp, rx_ctln : std_logic_vector(1 to 4);
  signal clk125, nclk125, uclk125, clk125i, clk125ii : std_ulogic;
  signal clk125_90, nclk125_90, uclk125_90, clk125_90i : std_ulogic;
  signal clk25, clk25i, clk25tmp : std_ulogic;
  signal txp, txn, tx_clk : std_ulogic;
  signal rst : std_ulogic;
  signal clkm0, clkm1, clkm2, clk_2_5, clk_5_0, clk25_tmp, clk125_tmp : std_ulogic;
  signal sel0, sel1 : std_ulogic;

  attribute keep : boolean;
  attribute syn_keep : boolean;
  attribute syn_preserve : boolean;

  attribute syn_preserve of clkm0 : signal is true;
  attribute keep of clkm0 : signal is true;
  attribute syn_preserve of clkm1 : signal is true;
  attribute keep of clkm1 : signal is true;
  
begin  -- rtl

  vcc <= '1'; gnd <= '0';
  txp <= '1' when gmii = 1 else '0';
  txn <= '0' when gmii = 1 else '1';
  rst <= not rstn;

  g1 : if gmii = 1 generate
    clk125 <= clkm1;
    nclk125 <= not clkm1;
    clk125_90 <= clkm1;
    nclk125_90 <= not clkm1;
    gmiii.gtx_clk <= clkm1;
    gmiii.tx_clk <= clkm0;
  end generate;

  g0 : if gmii = 0 generate
    clk125 <= clk25;
    nclk125 <= not clk25;
    clk125_90 <= clk25;
    nclk125_90 <= not clk25;
    gmiii.gtx_clk <= clk25;
    gmiii.tx_clk <= clk25;
  end generate;

  gmiii.mdint <= rgmiii.mdint;
  gmiii.mdio_i <= rgmiii.mdio_i;
  rgmiio.mdio_o <= gmiio.mdio_o;
  rgmiio.mdio_oe <= gmiio.mdio_oe;
  rgmiio.mdc <= gmiio.mdc;

-- TX path
  
  rgmii_txd : for i in 0 to 3 generate
    ddr_oreg0 : ODDR2
    generic map(
      DDR_ALIGNMENT => "NONE",
      INIT         => '0',
      SRTYPE       => "SYNC")
    port map(
      Q            => rgmiio.txd(i),
      C0           => clk125,
      C1           => nclk125,
      CE           => vcc,
      D0           => txd(i),
      D1           => txd1(i+4),
      R            => gnd,
      S            => gnd);
  end generate;

  rgmii_tx_clk : ODDR2
    generic map(
      DDR_ALIGNMENT => "NONE",
      INIT         => '0',
      SRTYPE       => "SYNC")
    port map(
      Q            => tx_clk,
      C0           => clk125_90,
      C1           => nclk125_90,
      CE           => vcc,
      D0           => txp,
      D1           => txn,
      R            => gnd,
      S            => gnd);

  rgmii_tx_ctl : ODDR2
    generic map(
      DDR_ALIGNMENT => "NONE",
      INIT         => '0',
      SRTYPE       => "SYNC")
    port map(
      Q            => rgmiio.tx_en,
      C0           => clk125,
      C1           => nclk125,
      CE           => vcc,
      D0           => tx_en,
      D1           => tx_ctl,
      R            => gnd,
      S            => gnd);

  d1 : if odelen = 1 generate
    txclk_del : IODELAY2
    generic map (
      IDELAY_TYPE              => "FIXED",
      DATA_RATE                => "SDR",
      ODELAY_VALUE             => 0,
      COUNTER_WRAPAROUND       => "STAY_AT_LIMIT",
      DELAY_SRC                => "ODATAIN",
      SERDES_MODE              => "NONE",
      SIM_TAPDELAY_VALUE       => 38)
    port map (
      -- required datapath
      T                      => '0',
      DOUT                   => rgmiio.tx_er,
      ODATAIN                => tx_clk,
      -- inactive data connections
      IDATAIN                => '0',
      TOUT                   => open,
      DATAOUT                => open,
      DATAOUT2               => open,
       -- connect up the clocks
      IOCLK0                => '0',                 -- No calibration needed
      IOCLK1                => '0',                 -- No calibration needed
      -- Tie of the variable delay programming
      CLK                   => '0',
      CAL                   => '0',
      INC                   => '0',
      CE                    => '0',
      BUSY                  => open,
      RST                   => '0');
  end generate;

  d0 : if odelen = 0 generate
      rgmiio.tx_er <= tx_clk;
  end generate;

  bf : BUFGMUX port map (O => rx_clki, I0 => rgmiii.rx_clk, I1 => gnd, S => gnd);
 
  process (clk125)
  begin  -- process
    if rising_edge(clk125) then
      txd(7 downto 0) <= gmiio.txd(7 downto 0);
      tx_en <= gmiio.tx_en;
      tx_ctlp <= gmiio.tx_en xor gmiio.tx_er;
    end if;
  end process;
  
  process (nclk125)
  begin  -- process
    if rising_edge(nclk125) then
      if gmii = 1 then
        txd1(7 downto 4) <= txd(7 downto 4);
      else
        txd1(7 downto 4) <= txd(3 downto 0);
      end if;
      tx_ctl <= tx_ctlp;
    end if;
  end process;
    
  process (clk_5_0)
  begin  -- process
    if rising_edge(clk_5_0) then
      clk_2_5 <= not clk_2_5;
      if rstn = '0' then clk_2_5 <= '0'; end if;
    end if;
  end process;
    

-- RX path

  rx_clk <= rx_clki;
  nrx_clk <= not rx_clki;

  gmiii.rxd <= rxd4;
  gmiii.rx_dv <= rx_ctlp(4);
  gmiii.rx_er <= rx_ctln(4);
  gmiii.rx_clk <= rx_clki;
  gmiii.rx_col <= '0';
  gmiii.rx_crs <= rx_ctlp(4);

  rgmii_rxd : for i in 0 to 3 generate
      ddr_ireg0 : ddr_ireg generic map (tech)
        port map (q1 => rxd1(i), q2 => rxd1(i+4), c1 => rx_clk, c2 => nrx_clk,
	 ce => vcc, d => rgmiii.rxd(i), r => gnd, s => gnd);
  end generate;
  ddr_ireg0 : ddr_ireg generic map (tech)
     port map (q1 => rx_ctlp(1), q2 => rx_ctln(1), c1 => rx_clk, c2 => nrx_clk,
	 ce => vcc, d => rgmiii.rx_dv, r => gnd, s => gnd);


  process (rx_clk)
  begin  -- process
    if rising_edge(rx_clk) then
      rx_ctlp(2) <= rx_ctlp(1);
      rx_ctlp(3) <= rx_ctlp(2);
      rx_ctlp(4) <= rx_ctlp(3);
      rx_ctln(3) <= rx_ctln(2);
      rx_ctln(4) <= rx_ctln(3) xor rx_ctlp(3);
      rxd2(3 downto 0) <= rxd1(3 downto 0);
      rxd3 <= rxd2;
      rxd4 <= rxd3;
    end if;
  end process;
  
  process (nrx_clk)
  begin  -- process
    if rising_edge(nrx_clk) then
      rx_ctln(2) <= rx_ctln(1);
      rxd2(7 downto 4) <= rxd1(7 downto 4);
    end if;
  end process;

  process(clk25)
  begin
    if rising_edge(clk25) then
      sel0 <= gmiio.speed;
    end if;
  end process;

  process(uclk125)
  begin
    if rising_edge(uclk125) then
      sel1 <= gmiio.gbit;
    end if;
  end process;
  
  clkmux0 : clkmux
    generic map(
      tech => tech,
      rsel => 0)
    port map(
      i0   => clk_2_5,
      i1   => clk25,
      sel  => sel0,
      o    => clkm0,
      rst  => rstn
    );

  clkmux1 : clkmux
    generic map(
      tech => tech,
      rsel => 0)
    port map(
      i0   => clkm0,
      i1   => uclk125,
      sel  => sel1,
      o    => clkm1,
      rst  => rstn
    );

--   clkmux2 : clkmux
--     generic map(
--       tech => tech,
--       rsel => 0)
--     port map(
--       i0   => clkm0,
--       i1   => uclk125_90,
--       sel  => gmiio.gbit,
--       o    => clkm2,
--       rst  => rstn
--     );

  
  tx_pll0 : PLL_BASE
    generic map(
      BANDWIDTH             => "OPTIMIZED",
      CLKFBOUT_MULT         => 10,
      CLKFBOUT_PHASE        => 0.0,
      CLKIN_PERIOD          => 20.000,
      CLKOUT0_DIVIDE        => 4,
      CLKOUT0_DUTY_CYCLE    => 0.5,
      CLKOUT0_PHASE         => 0.0,
      CLKOUT1_DIVIDE        => 4,
      CLKOUT1_DUTY_CYCLE    => 0.5,
      CLKOUT1_PHASE         => 90.0,
      CLKOUT2_DIVIDE        => 20,
      CLKOUT2_DUTY_CYCLE    => 0.5,
      CLKOUT2_PHASE         => 0.0,
      CLKOUT3_DIVIDE        => 100,
      CLKOUT3_DUTY_CYCLE    => 0.5,
      CLKOUT3_PHASE         => 0.0,
      CLKOUT4_DIVIDE        => 1,
      CLKOUT4_DUTY_CYCLE    => 0.5,
      CLKOUT4_PHASE         => 0.0,
      CLKOUT5_DIVIDE        => 1,
      CLKOUT5_DUTY_CYCLE    => 0.5,
      CLKOUT5_PHASE         => 0.0,
      CLK_FEEDBACK          => "CLKFBOUT",
      COMPENSATION          => "INTERNAL",
      DIVCLK_DIVIDE         => 1,
      REF_JITTER            => 0.100,
      RESET_ON_LOSS_OF_LOCK => FALSE
    )
  port map(
    CLKFBOUT                => clk125_tmp,
    CLKOUT0                 => uclk125,
    CLKOUT1                 => open, --uclk125_90,
    CLKOUT2                 => clk25,
    CLKOUT3                 => clk_5_0,
    CLKOUT4                 => open,
    CLKOUT5                 => open,
    LOCKED                  => open,
    CLKFBIN                 => clk125_tmp,
    CLKIN                   => clk50,
    RST                     => rst);
        
  
--   txdll1 : DCM 
--     generic map (CLKFX_MULTIPLY => 2, CLKFX_DIVIDE => 2, CLK_FEEDBACK => "NONE",
--       DFS_FREQUENCY_MODE => "LOW", DLL_FREQUENCY_MODE => "LOW", CLKIN_PERIOD => 8.0)
--     port map ( CLKIN => clk125_tmp, 
--       CLK0 => uclk125, clk90 => uclk125_90, locked => lock);

--   txdll0 :  DCM_SP
--   generic map(
--     CLKDV_DIVIDE          => 10.0,
--     CLKFX_DIVIDE          => 1,
--     CLKFX_MULTIPLY        => 5,
--     CLKIN_DIVIDE_BY_2     => false,
--     CLKIN_PERIOD          => 40.0,
--     CLKOUT_PHASE_SHIFT    => "NONE",
--     CLK_FEEDBACK          => "NONE",
--     DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",
--     DFS_FREQUENCY_MODE    => "LOW",
--     DLL_FREQUENCY_MODE    => "LOW",
--     DSS_MODE              => "NONE",
--     DUTY_CYCLE_CORRECTION => TRUE, 
--     FACTORY_JF            => X"C080",
--     PHASE_SHIFT           => 0,
--     STARTUP_WAIT          => false
--     )
--   port map(
--     CLK0                  => clk25,
--     CLK180                => open,
--     CLK270                => open,
--     CLK2X                 => open,
--     CLK2X180              => open,
--     CLK90                 => open,
--     CLKDV                 => clk_2P5,
--     CLKFX                 => clk125_tmp,
--     CLKFX180              => open,
--     LOCKED                => open,
--     PSDONE                => open,
--     STATUS                => open,
--     CLKFB                 => gnd,
--     CLKIN                 => clk25_tmp,
--     DSSEN                 => gnd,
--     PSCLK                 => gnd,
--     PSEN                  => gnd,
--     PSINCDEC              => gnd,
--     RST                   => rst
--     );
  
end rtl;
