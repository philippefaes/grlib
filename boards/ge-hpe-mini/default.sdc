#
# Clocks
#
define_clock -name   {clk}  -freq 60.000 -clockgroup default_clkgroup
define_clock -name   {etx_clk}  -freq 40.000 -clockgroup etx_clkgroup
define_clock -name   {erx_clk}  -freq 40.000 -clockgroup erx_clkgroup

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_output_delay -disable     -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
define_input_delay -disable      -default  14.00 -improve 0.00 -route 0.00 -ref {clk:r}
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
