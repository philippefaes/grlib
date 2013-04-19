# Synplicity, Inc. constraint file

#
# Clocks
#
define_clock            -name {Clocks_F_Clk}  -freq 60.000 -clockgroup default_clkgroup
define_clock            -name {Clocks_K_Clk}  -freq 40.000 -clockgroup pci_clkgroup

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable     -default  14.00 -improve 0.00 -route 0.00 -ref {Clocks_F_Clk:r}
define_input_delay -disable      -default  14.00 -improve 0.00 -route 0.00 -ref {Clocks_F_Clk:r}
define_input_delay -disable      {Reset_Reset}  0.00 -improve 0.00 -route 0.00 -ref {Clocks_K_Clk:r}

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
define_global_attribute          syn_useioff {1}

#
# Compile Points
#

#
# Other Constraints
#
