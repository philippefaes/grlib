#GRLIB_SIMULATOR=ModelSim

include .config

GRLIB=../..
TOP=leon3mp
BOARD=xilinx-vc707-xc7vx485t
DESIGN=leon3-xilinx-vc707
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)$(PACKAGE)-$(SPEED)
XDC=$(GRLIB)/boards/$(BOARD)/$(BOARD).xdc

VHDLSYNFILES= \
	config.vhd ahbrom.vhd leon3mp.vhd ddr_dummy.vhd sgmii_vc707.vhd
VHDLSIMFILES=testbench.vhd

SIMTOP=testbench
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit -O0
ifeq ($(CONFIG_MIG_SERIES7),y)
GRLIB_XIL_Vivado_sim_verilog_define=x1Gb sg125 x8
VLOGOPT= +define+x1Gb +define+sg125 +define+x8
ifeq ("$(GRLIB_SIMULATOR)","ALDEC")
VSIMOPT= +access +w -gEXAMPLE_SIMULATION=1 -gUSE_MIG_INTERFACE_MODEL=true -gdisas=1 -gDEBUG=0 -do "do riviera_preload_ddr3_dimm.do; run -all" -t ps -voptargs="+acc" +notimingchecks -L gig_ethernet_pcs_pma_v13_0 -L secureip_ver -L xilinxcorelib_ver -L unisims_ver glbl $(SIMTOP)
else
VSIMOPT= -gEXAMPLE_SIMULATION=1 -gUSE_MIG_INTERFACE_MODEL=true -gdisas=1 -gDEBUG=0 -c -do "do preload_ddr3_dimm.do; run -all" -t ps -voptargs="+acc" +notimingchecks -L gig_ethernet_pcs_pma_v13_0 -L secureip_ver -L xilinxcorelib_ver -L unisims_ver glbl $(SIMTOP)
endif
else
VSIMOPT= -gdisas=1 -t ps $(SIMTOP)
endif
TECHLIBS = secureip unisim 
EXTRA_SOFT = gen_hex_dim

LIBSKIP = pci pci/pcif core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp spw gsi cypress hynix \
	spansion leon4 leon4v0 secureip
DIRSKIP = b1553 pci pci/pcif leon2 leon2ft crypto satcan pci ambatest \
	spacewire ascs slink \
	leon4 leon4v0 l2cache pwm gr1553b iommu ac97 secureip
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v unisim_VPKG.vhd unisim_VCOMP.vhd simple_simprim.vhd unisim_VITAL.vhd memory_virtex.vhd clkgen_virtex.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

all: help-local

help-local: help
	@echo
	@echo " design specific targets:"
	@echo " (Only needed to generate and compile MIG Series7)"
	@echo
	@echo " make compile_xilinx_verilog_lib   : compile xilinx verilog library"
	@echo " make clean_xilinx_verilog_lib     : remove xilinx verilog library"
	@echo " make compile_xilinx_vhdl_lib      : compile xilinx vhdl library"
	@echo " make clean_xilinx_vhdl_lib        : remove xilinx vhdl library"
	@echo " make mig_series7                  : create xilinx memory controller using coregen."
	@echo " make sgmii_series7                : create SGMII interface using coregen."
	@echo
	@echo " ================================================================"
	@echo "         Quick start guide for simulation of systest.c"
	@echo
	@echo "  1. Setup search paths for Xilinx, GCC and Modelsim "
	@echo "  2. make map_xilinx_vhdl_lib"
	@echo "  3. make vsim"
	@echo "  4. make mig_series7"
	@echo "  5. make sgmii_series7"
	@echo "  6. make soft"
	@echo "  7. make vsim-launch"
	@echo
	@echo " Please note that this quick start guide will compile and simulate"
	@echo " a preconfigured version of the leon3 processor system."
	@echo " For customizing the leon3 susbsystem run make 'xconfig'"
	@echo " ================================================================"
	@echo
