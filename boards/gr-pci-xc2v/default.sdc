# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-pci-xc2v/default.sdc
# Written on Thu May  3 12:48:24 2007
# by Synplify Pro, Synplify Pro 8.6.2U Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock -disable   -name {clk}  -freq 50.000 -clockgroup default_clkgroup -route 5.000
define_clock            -name {pci_clk}  -period 30.000 -clockgroup pci_clkgroup -route 5.000

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable     -default  5.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  5.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_output_delay              -default  19.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}
define_input_delay               -default  23.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}
define_input_delay               {pci_rst}  0.00 -improve 0.00 -route 0.00 -ref {pci_clk:r}

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
# Path Delay
#

#
# Attributes
#
define_global_attribute          syn_useioff {1}
define_global_attribute -disable syn_netlist_hierarchy {0}

#
# I/O standards
#

#
# Compile Points
#

#
# Other Constraints
#
