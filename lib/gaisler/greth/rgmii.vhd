library ieee;
use ieee.std_logic_1164.all;
library gaisler;
use gaisler.misc.all;
use gaisler.net.all;
library grlib;
use grlib.stdlib.all;

library techmap;
use techmap.gencomp.all;
use techmap.allclkgen.all;

entity rgmii is
  generic (
    tech    : integer := 0;
    gmii    : integer := 0;
    extclk  : integer := 0
    );
  port (
    rstn        : in  std_ulogic;
    clk50       : in  std_ulogic;
    clk125      : in  std_ulogic;
    gmiii : out eth_in_type;
    gmiio : in  eth_out_type;
    rgmiii  : in  eth_in_type;
    rgmiio  : out eth_out_type
    );
end ;

architecture rtl of rgmii is

  attribute keep : boolean;
  attribute syn_keep : boolean;
  attribute syn_preserve : boolean;

  signal vcc, gnd : std_ulogic;
  signal tx_en, tx_ctlp, tx_ctl : std_ulogic;
  signal txd, txd1 : std_logic_vector(7 downto 0);
  signal rxd1, rxd2, rxd3, rxd4 : std_logic_vector(7 downto 0);
  signal rx_clk, nrx_clk : std_ulogic;
  signal rx_ctlp, rx_ctln : std_logic_vector(1 to 4);
  signal clk25, clk25i, clk25ni, clk125i, clk2_5i, clk2_5ni : std_ulogic;
  signal txp, txn, tx_clk_ddr, tx_clk, tx_clki, ntx_clk : std_ulogic;
  signal cnt2_5 : std_logic_vector(3 downto 0);

  attribute syn_preserve of tx_clk : signal is true;
  attribute syn_keep of tx_clk : signal is true;
  attribute keep of tx_clk : signal is true;
  attribute syn_preserve of clk25ni : signal is true;
  attribute syn_keep of clk25ni : signal is true;
  attribute keep of clk25ni : signal is true;
  attribute syn_preserve of clk2_5ni : signal is true;
  attribute syn_keep of clk2_5ni : signal is true;
  attribute keep of clk2_5ni : signal is true;
  attribute syn_preserve of clk125i : signal is true;
  attribute syn_keep of clk125i : signal is true;
  attribute keep of clk125i : signal is true;

  attribute clock_signal : string;
  attribute clock_signal of clk25ni : signal is "yes";
  attribute clock_signal of clk2_5ni : signal is "yes";
  attribute clock_signal of tx_clki : signal is "yes";
  
begin  -- rtl

  vcc <= '1'; gnd <= '0';
  txp <= '1'; txn <= '0';

  g1 : if (extclk = 0) and (gmii = 1) generate
    clk125i <= clk125;
  end generate;
  g2 : if not ((extclk = 0) and (gmii = 1)) generate
    clk125i <=  rgmiii.gtx_clk;
  end generate;

  tx_clki <= clk125i when (gmii = 1) and (gmiio.gbit = '1') else 
    clk25ni when gmiio.speed = '1' else clk2_5ni;
  
  -- Generate transmit clocks.
  b1 : techbuf generic map (2, tech) port map (tx_clki, tx_clk);
  ntx_clk <= not tx_clk;
  
  gmiii.gtx_clk <= tx_clk;  
  gmiii.tx_clk <= tx_clk;

  gmiii.mdint <= rgmiii.mdint;
  gmiii.mdio_i <= rgmiii.mdio_i;
  rgmiio.mdio_o <= gmiio.mdio_o;
  rgmiio.mdio_oe <= gmiio.mdio_oe;
  rgmiio.mdc <= gmiio.mdc;

  rgmii_txd : for i in 0 to 3 generate
      ddr_oreg0 : ddr_oreg generic map (tech)
        port map (q => rgmiio.txd(i), c1 => tx_clk, c2 => ntx_clk, ce => vcc,
                  d1 => txd(i), d2 => txd1(i+4), r => gnd, s => gnd);
  end generate;
  rgmii_tx_ctl : ddr_oreg generic map (tech)
        port map (q => rgmiio.tx_en, c1 => tx_clk, c2 => ntx_clk, ce => vcc,
                  d1 => tx_en, d2 => tx_ctl, r => gnd, s => gnd);
  rgmii_tx_clk : ddr_oreg generic map (tech) 
        port map (q =>tx_clk_ddr, c1 => tx_clk, c2 => ntx_clk, ce => vcc,
                  d1 => txp, d2 => txn, r => gnd, s => gnd);
  
  rgmiio.tx_er <= tx_clk_ddr;
  rgmiio.reset <= '0';
  rgmiio.gbit <= '0';
  rgmiio.speed <= '0';
  rgmiio.txd(7 downto 4) <= (others => '0');

  process (tx_clk)
  begin  -- process
    if rising_edge(tx_clk) then
      txd(7 downto 0) <= gmiio.txd(7 downto 0);
      tx_en <= gmiio.tx_en;
      tx_ctlp <= gmiio.tx_en xor gmiio.tx_er;
    end if;
  end process;
  
  process (ntx_clk)
  begin  -- process
    if rising_edge(ntx_clk) then
      txd1(7 downto 4) <= txd(7 downto 4);
      tx_ctl <= tx_ctlp;
    end if;
  end process;
  
  process (clk50)
  begin  -- process
    if rising_edge(clk50) then
      clk25i  <= not clk25i;
      clk25ni <= not clk25i;
      if cnt2_5 = "1001" then cnt2_5 <= "0000"; clk2_5i <= not clk2_5i;
      else cnt2_5 <= cnt2_5 + 1; end if;
      clk2_5ni <= not clk2_5i;
      if rstn = '0' then clk25i <= '0'; clk2_5i <= '0'; cnt2_5 <= "0000"; end if;
    end if;
  end process;
  
-- RX path

  rx_clk <= rgmiii.rx_clk;
  nrx_clk <= not rgmiii.rx_clk;

  gmiii.rxd <= rxd4;
  gmiii.rx_dv <= rx_ctlp(4);
  gmiii.rx_er <= rx_ctln(4);
  gmiii.rx_clk <= rgmiii.rx_clk;
  gmiii.rx_col <= '0';
  gmiii.rx_crs <= rx_ctlp(4);
  gmiii.rmii_clk <= '0';
  gmiii.edclsepahb <= '0';
  gmiii.edcldisable <= '0';
  gmiii.phyrstaddr <= (others => '0');
  gmiii.edcladdr <= (others => '0');

  rgmii_rxd : for i in 0 to 3 generate
      ddr_ireg0 : ddr_ireg generic map (tech)
        port map (q1 => rxd1(i), q2 => rxd1(i+4), c1 => rx_clk, c2 => nrx_clk,
   ce => vcc, d => rgmiii.rxd(i), r => gnd, s => gnd);
  end generate;
  ddr_ireg0 : ddr_ireg generic map (tech)
     port map (q1 => rx_ctlp(1), q2 => rx_ctln(1), c1 => rx_clk, c2 => nrx_clk,
   ce => vcc, d => rgmiii.rx_dv, r => gnd, s => gnd);

  process (rx_clk)
  begin
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
  begin
    if rising_edge(nrx_clk) then
      rx_ctln(2) <= rx_ctln(1);
      rxd2(7 downto 4) <= rxd1(7 downto 4);
    end if;
  end process;
  
end rtl;
