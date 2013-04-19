################################################################################
# Actel Designer Software Release Designer
################################################################################

########  Clock Constraints  ########

create_clock  -period 40.0000 [get_ports {clk}]

#create_clock  -period 30.0000 [get_ports {pci_clk}]
#
#create_clock  -period 10.0000 [get_ports {spw_clk}]
#
#create_clock  -period 10.0000 [get_ports {spwclk}]


########   Delay Constraints  ########

#set_max_delay  7.00 -from [all_inputs]  -to [get_clocks {pci_clk}]
#set_max_delay 11.00 -from [get_clocks {pci_clk}]  -to [all_outputs]

#set_max_delay 11.00 -from [all_inputs]  -to [all_outputs]

#set_max_delay  5.00 -from [all_inputs]  -to [get_clocks {clk}]
#set_max_delay 10.00 -from [get_clocks {clk}]  -to [all_outputs]


########   False Path Constraints  ########


########   OutPut load Constraints  ########


########   Multicycle Constraints  ########


