-----------------------------------------------------------------------------
--  LEON3 Demonstration design test bench
--  Copyright (C) 2013 Fredrik Ringhage, Gaisler Research
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
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
library unisim;
use unisim.vcomponents.all;

entity usb_spartan6_pll is
generic
  (
    C_INCLK_PERIOD     : integer := 16667;
    C_CLKOUT0_DIVIDE   : integer := 8;
    C_CLKFBOUT_MULT    : integer := 8;
    C_DIVCLK_DIVIDE    : integer := 1

  );
port
(
    sys_clk         : in std_logic;
    sys_rst_n       : in std_logic;
    clk0            : out std_logic;
    rst0            : out std_logic;
    locked          : out std_logic
);
end entity;
architecture syn of usb_spartan6_pll is

  constant RST_SYNC_NUM   : integer := 25;
  constant CLK_PERIOD_NS  : real := (real(C_INCLK_PERIOD)) / 1000.0;
  constant CLK_PERIOD_INT : integer := C_INCLK_PERIOD/1000;

  signal   clk0_bufg           : std_logic;
  signal   clk0_bufg_in        : std_logic;
  signal   clkfbout_clkfb_in   : std_logic;
  signal   clkfbout_clkfb_bufg : std_logic;
  signal   clkfbout_clkfb      : std_logic;
  signal   rst0_sync_r         : std_logic_vector(RST_SYNC_NUM-1 downto 0);
  signal   sys_rst_i           : std_logic;
  signal   pll_locked          : std_logic;

  attribute keep : boolean;
  attribute syn_keep : boolean;
  attribute syn_preserve : boolean;
  
  attribute keep of clk0_bufg : signal is true;
  attribute syn_keep of clk0_bufg : signal is true;
  attribute syn_preserve of clk0_bufg : signal is true;

begin 

  clk0     <= clk0_bufg;

  sys_rst_i  <= not(sys_rst_n);
  
    u_pll_adv : PLL_ADV 
    generic map 
        (
         BANDWIDTH          => "OPTIMIZED",
         CLKIN1_PERIOD      => CLK_PERIOD_NS,
         CLKIN2_PERIOD      => CLK_PERIOD_NS,
         CLKOUT0_DIVIDE     => C_CLKOUT0_DIVIDE,
         CLKOUT1_DIVIDE     => 1,
         CLKOUT2_DIVIDE     => 1,
         CLKOUT3_DIVIDE     => 1,
         CLKOUT4_DIVIDE     => 1,
         CLKOUT5_DIVIDE     => 1,
         CLKOUT0_PHASE      => 0.000,
         CLKOUT1_PHASE      => 0.000,
         CLKOUT2_PHASE      => 0.000,
         CLKOUT3_PHASE      => 0.000,
         CLKOUT4_PHASE      => 0.000,
         CLKOUT5_PHASE      => 0.000,
         CLKOUT0_DUTY_CYCLE => 0.500,
         CLKOUT1_DUTY_CYCLE => 0.500,
         CLKOUT2_DUTY_CYCLE => 0.500,
         CLKOUT3_DUTY_CYCLE => 0.500,
         CLKOUT4_DUTY_CYCLE => 0.500,
         CLKOUT5_DUTY_CYCLE => 0.500,
         SIM_DEVICE         => "SPARTAN6",
         COMPENSATION       => "SYSTEM_SYNCHRONOUS",
         DIVCLK_DIVIDE      => C_DIVCLK_DIVIDE,
         CLKFBOUT_MULT      => C_CLKFBOUT_MULT,
         CLKFBOUT_PHASE     => 0.0,
         REF_JITTER         => 0.005000
         )
        port map
          (
           CLKFBIN          => clkfbout_clkfb,
           CLKINSEL         => '1',
           CLKIN1           => sys_clk,
           CLKIN2           => '0',
           DADDR            => (others => '0'),
           DCLK             => '0',
           DEN              => '0',
           DI               => (others => '0'),
           DWE              => '0',
           REL              => '0',
           RST              => sys_rst_i,
           CLKFBDCM         => open,
           CLKFBOUT         => clkfbout_clkfb_in,
           CLKOUTDCM0       => open,
           CLKOUTDCM1       => open,
           CLKOUTDCM2       => open,
           CLKOUTDCM3       => open,
           CLKOUTDCM4       => open,
           CLKOUTDCM5       => open,
           CLKOUT0          => clk0_bufg_in,
           CLKOUT1          => open,
           CLKOUT2          => open,
           CLKOUT3          => open,
           CLKOUT4          => open,
           CLKOUT5          => open,
           DO               => open,
           DRDY             => open,
           LOCKED           => pll_locked
           );

    U_BUFG_CLK0 : BUFG
    port map
    (
     O => clk0_bufg,
     I => clk0_bufg_in
     );

    U_BUFG_CLK1 : BUFG
    port map
    (
     O => clkfbout_clkfb_bufg,
     I => clkfbout_clkfb_in
     );

    U_BUFG_CLK2 : BUFIO2FB
    port map
    (
     O => clkfbout_clkfb,
     I => clkfbout_clkfb_bufg
     );

   process (clk0_bufg, sys_rst_i)
   begin
      if (sys_rst_i = '1') then
         locked <= '0';
      elsif (rising_edge(clk0_bufg)) then
         if (pll_locked = '1') then
            locked <= '1';
         end if;
      end if;
   end process;      

   process (clk0_bufg, sys_rst_n)
   begin
     if (sys_rst_i = '1') then
       rst0_sync_r <= (others => '1');
     elsif (rising_edge(clk0_bufg)) then      
       rst0_sync_r <= rst0_sync_r(RST_SYNC_NUM-2 downto 0) & '0';  -- logical left shift by one (pads with 0)
     end if;
   end process;

  rst0    <= rst0_sync_r(RST_SYNC_NUM-1);

end architecture syn;

