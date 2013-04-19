# Synplicity, Inc. constraint file
# Z:\LEON3SDE\ALTERA\grlib-eval-1.0.8-ge\boards\ge-hpe-mini-lattice2\default.sdc
# Written on Wed Aug 16 13:55:14 2006
# by Synplify Pro, Synplify Pro 8.6.1 Scope Editor

#
# Collections
#

#
# Clocks
#
define_clock            -name {clkgen0.clkm_inferred_clock}  -freq 60.000 -clockgroup clkmgroup
define_clock            -name {clkgen0.ddrclk0_inferred_clock}  -freq 120.000 -clockgroup ddrclkgroup

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable     -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay               -default  4.00 -improve 0.00 -route 0.00 -ref {clkgen0.ddrclk0_inferred_clock:r}

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
define_global_attribute          syn_netlist_hierarchy {1}

#
# I/O standards
#

#
# Other Constraints
#
