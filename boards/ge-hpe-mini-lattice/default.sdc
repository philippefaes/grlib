# Synplicity, Inc. constraint file
# /home/jiri/ibm/vhdl/grlib/boards/gr-pci-xc2v/default.sdc
# Written on Fri Jul 30 18:56:40 2004
# by Synplify Pro, 7.6        Scope Editor

#
# Clocks
#
#define_clock -name   {clk}  -freq 35.000 -clockgroup default_clkgroup

#define_clock -name   {clkgen0.clkm_inferred_clock}  -freq 60.000 -clockgroup clkmgroup
define_clock -name   {clkgen0.ddrclk0_inferred_clock}  -freq 120.000 -clockgroup ddrclkgroup

#
# Inputs/Outputs
#
#define_output_delay -disable     -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay  -default  4.00 -improve 0.00 -route 0.00 -ref {clkgen0.ddrclk0_inferred_clock:r}

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
# Delay Path
#

#
# Attributes
#
define_global_attribute syn_useioff {1}
define_global_attribute syn_netlist_hierarchy {0}
#
# Compile Points
#

#
# Other Constraints
#
