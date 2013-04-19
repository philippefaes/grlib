# Synplicity, Inc. constraint file

#
# Clocks
#
define_clock -name {clk}      -freq 40.000 -clockgroup clk_clkgroup
define_clock -name {pci_clk}  -freq 40.000 -clockgroup pci_clkgroup
define_clock -name {spw_clk}  -freq 100.000 -clockgroup spw_clkgroup
define_clock -name {spwclk}   -freq 100.000 -clockgroup spwclkgroup

#
# Inputs/Outputs
#
define_output_delay -disable     -default  14.00 -improve 0.00 -route 0.00 -ref clk:r
define_input_delay -disable      -default  20.00 -improve 0.00 -route 0.00 -ref clk:r
define_output_delay              -default  8.00 -improve 0.00 -route 0.00 -ref pci_clk:r
define_input_delay               -default  15.00 -improve 0.00 -route 0.00 -ref pci_clk:r
define_input_delay               {pci_rst}  0.00 -improve 0.00 -route 0.00 -ref pci_clk:r

#
# Registers
#

#
# Multicycle Path
#

#
# False Path
#

#
# Attributes
#
define_global_attribute          syn_useioff {1}
define_attribute          {cpu.0.l3ft.u0.holdn} syn_maxfan {10000}
define_attribute          {spw.spwloop.0.sw0.rxclko} syn_maxfan {10000}
define_attribute          {spw.spwloop.0.sw0.txclko} syn_maxfan {10000}
define_attribute          {cpu.0.l3ft.u0} syn_hier {flatten}
define_global_attribute -disable syn_netlist_hierarchy {1}

#
# Other Constraints
#

#
#  Order of waveforms
#
