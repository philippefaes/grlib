# Synopsys, Inc. constraint file
#
# Collections
#

#
# Clocks
#
define_clock   {clk} -name {clk}  -freq 50 -clockgroup sys_group
define_clock   {clkm} -name {clkm}  -freq 25 -clockgroup sysm_group

#
# Clock to Clock
#

#
# Inputs/Outputs
#
define_input_delay               -default  15.00 -improve 0.00 -route 0.00
define_output_delay              -default  8.00 -improve 0.00 -route 0.00

#
# Registers
#

#
# Delay Paths
#

#
# Attributes
#
define_global_attribute  {syn_noarrayports} {1}
define_global_attribute  {syn_edif_bit_format} {%n<%i>}
define_global_attribute  {syn_edif_scalar_format} {%n}
define_global_attribute  {syn_global_buffers} {12}

#
# I/O Standards
#

#
# Compile Points
#

#
# Other
#
