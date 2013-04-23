include .config

GRLIB=../..
TOP=leon3mp
BOARD=xilinx-vc707-xc7vx485t
DESIGN=leon3-xilinx-vc707

include $(GRLIB)/boards/$(BOARD)/Makefile.inc

DEVICE=$(PART)$(PACKAGE)-$(SPEED)
XDC=$(GRLIB)/boards/$(BOARD)/$(BOARD).xdc

VHDLSYNFILES= \
	config.vhd ahbrom.vhd leon3mp.vhd ./ddr_dummy.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit
ifeq ($(CONFIG_MIG_SERIES7),y)
VLOGOPT= +define+1Gb +define+sg125 +define+x8
VSIMOPT= -gUSE_MIG_INTERFACE_MODEL=true -gdisas=1 -gDEBUG=0 -i -do preload_ddr3_dimm.do -t ps -novopt +notimingchecks -L secureip_ver -L xilinxcorelib_ver -L unisims_ver glbl $(SIMTOP)
else
VSIMOPT= -gdisas=1 -i -t ps $(SIMTOP)
endif
TECHLIBS = secureip unisim 
EXTRA_SOFT = gen_hex_dim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw gsi cypress hynix \
	spansion leon4 leon4v0 secureip
DIRSKIP = b1553 pcif leon2 leon2ft crypto satcan pci ambatest can \
	usb grusbhc spacewire ascs slink spi hcan \
	leon4 leon4v0 l2cache pwm gr1553b iommu ac97 secureip
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

all: help-local

help-local: help
	@echo
	@echo " design specific targets:"
	@echo " (Only needed to generate and compile MIG Series7)"
	@echo
	@echo " make compile_xilinx_verilog_lib   : compile xilinx library"
	@echo " make clean_xilinx_verilog_lib     : remove xilinx library"
	@echo " make mig_series7                  : create xilinx memory controller using coregen."
	@echo " make mig_series7_clean            : remove generated memory controller"
	@echo
	@echo " ================================================================"
	@echo "         Quick start guide for simulation of systest.c"
	@echo
	@echo "  1. Setup search paths for Xilinx, GCC and Modelsim "
	@echo "  2. make vsim"
	@echo "  3. make mig_series7"
	@echo "  4. make soft"
	@echo "  5. make vsim-launch"
	@echo
	@echo " Please note that this quick start guide will compile and simulate"
	@echo " a preconfigured version of the leon3 processor system."
	@echo " For customizing the leon3 susbsystem run make 'xconfig'"
	@echo " ================================================================"
	@echo
