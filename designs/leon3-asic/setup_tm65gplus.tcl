
set snps [getenv {SNPS_HOME}]
set tsmc [getenv {TSMCHOME}]
#set tsmc /usr/local/synlibs/tsmc/tcbn65lphvt
set dolphin  /usr/local/synlibs/dolphin
set synthetic_library {"dw01.sldb" "dw02.sldb"} 
set search_path  ". $dolphin/db $snps/libraries/syn"
set target_library "dti_tm65gplus_stdcells_tt_125C_rev2p3.db"
set link_library "dti_tm65gplus_stdcells_tt_125C_rev2p3.db * \
	dti_1pr_tm65gplus_1024x32_4ww3x_m_worst_lib.db \
	dti_1pr_tm65gplus_128x32_4ww1x_m_worst_lib.db \
	dti_1pr_tm65gplus_256x32_4ww1x_m_worst_lib.db \
	dti_1pr_tm65gplus_256x36_4ww1x_m_worst_lib.db \
	dti_1pr_tm65gplus_512x32_4ww3x_m_worst_lib.db \
	dti_2pr_tm65gplus_128x36_4ww1x_m_worst_lib.db \
	dti_2pr_tm65gplus_136x32_4ww1x_m_worst_lib.db \
	dti_2pr_tm65gplus_256x36_4ww1x_m_worst_lib.db \
	dti_dp_tm65gplus_256x36_16ww1x_m_worst_lib.db \
	standard.sldb dw01.sldb dw02.sldb \
	dw03.sldb dw04.sldb dw05.sldb dw07.sldb dw_foundation.sldb"
set symbol_library "generic.sdb"
set allow_newer_db_files "true"

#set wlgroup "WireAreaLowkCon"
set maxfreq 1500.0

proc dont_use_scan_cells args {
#set_dont_use {tcbn65lphvtwc/SDF* tcbn65lphvtwc/SEDF*}
}

proc use_scan_cells args {
#set_dont_use {tcbn65lphvtwc/DF* tcbn65lphvtwc/EDF*}
}

proc dont_use_spec_cells args {

# don't use delay lines
#echo "*** Info: Don't use DELAY cells for synthesis"
#set_dont_use {tcbn65lphvtwc/DEL*}

# don't use ECO cells
#echo "*** Info: Don't use ECO cells for synthesis"
#set_dont_use {tcbn65lphvtwc/G*}

# don't use CLOCK cells
#echo "*** Info: Don't use CLOCK cells for synthesis"
#set_dont_use {tcbn65lphvtwc/CK*}

}

set_ultra_optimization true
#define_design_lib work -path synopsys

#################################
# synopsys design vision setup
#################################
set sh_enable_line_editing true
#set hdlin_enable_presto_for_vhdl true
alias h history
alias rc "report_constraint -all_violators"
alias rda "remove_design -all"

# Architecture was already analyzed
suppress_message VHD-4

# Initial values not supported for synthesis
suppress_message VHD-7        

# Floating input ports are connected to ground
suppress_message ELAB-294     

# DEFAULT branch of CASE statement cannot be reached
suppress_message ELAB-311     

# Potential simulation-synthesis mismatch if index exceeds size of array
suppress_message ELAB-349

# Presto division message
suppress_message ELAB-402     

# Signal assignment delays not supported
suppress_message ELAB-924     

# Pads are dont touch
suppress_message OPT-1006

# ... index exceeds size of array
# suppress_message ELAB-349     

################
# Old options 
################

# set cache_write "/data/asic/synopsys_cache"  
# set cache_read  "/data/asic/synopsys_cache"

set hdlin_translate_off_skip_text true
#set bus_naming_style "%s_%d"
#set vhdlout_bit_type std_logic
#set vhdlout_write_components false
#set vhdlout_single_bit user
#set vhdlout_follow_vector_direction true
#set vhdlout_dont_write_types true

# Avoid Warning for setting Design Rule attributes from driving cell on a port.
suppress_message {UID-401}
# Avoid Warning for Assert statements.
suppress_message {VHDL-2099}


set view_script_submenu_items "$view_script_submenu_items\
  \"Clean Sweep\" \"remove_design -designs\""

#########################
# wire load estimation 
#########################
set auto_wire_load_selection "true"

############
# vhdl out 
############
#set vhdlout_single_bit "false" 
#set vhdlout_use_packages {IEEE.std_logic_1164 \
#	umc.vcomponents umc.ramcomponents }
#set vhdlout_write_top_configuration "true"

#######
# sge 
#######
set set_fix_multiple_port_nets "true"

##########
# hdlin 
##########
set hdlin_latch_synch_set_reset "false" 
