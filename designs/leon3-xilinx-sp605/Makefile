include .config

GRLIB=../..
TOP=leon3mp
BOARD=xilinx-sp605-xc6slx45t
DESIGN=leon3-xilinx-sp605
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
UCF_PLANAHEAD=$(UCF)
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
ISEMAPOPT=-timing
XSTOPT=
SYNPOPT="set_option -maxfan 100; set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLOPTSYNFILES= mig/mig_38/user_design/rtl/iodrp_controller.vhd \
	mig/mig_38/user_design/rtl/iodrp_mcb_controller.vhd \
	mig/mig_38/user_design/rtl/mcb_raw_wrapper.vhd \
	mig/mig_38/user_design/rtl/mcb_soft_calibration.vhd \
	mig/mig_38/user_design/rtl/mcb_soft_calibration_top.vhd \
	mig/mig_38/user_design/rtl/memc3_infrastructure.vhd \
	mig/mig_38/user_design/rtl/memc3_wrapper.vhd \
	mig/mig_38/user_design/rtl/mig_38.vhd \
	mig39/mig_39/user_design/rtl/iodrp_controller.vhd \
	mig39/mig_39/user_design/rtl/iodrp_mcb_controller.vhd \
	mig39/mig_39/user_design/rtl/mcb_raw_wrapper.vhd \
	mig39/mig_39/user_design/rtl/mcb_soft_calibration.vhd \
	mig39/mig_39/user_design/rtl/mcb_soft_calibration_top.vhd \
	mig39/mig_39/user_design/rtl/memc3_infrastructure.vhd \
	mig39/mig_39/user_design/rtl/memc3_wrapper.vhd \
	mig39/mig_39/user_design/rtl/mig_39.vhd \
	config.vhd svga2ch7301c.vhd ahbrom.vhd \
	ahb2mig_sp605.vhd vga_clkgen.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
#SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit
TECHLIBS = secureip unisim 

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip cypress ihp gsi fmf spansion 
DIRSKIP = b1553 pcif leon2 leon2ft crypto satcan pci ambatest \
	leon4 leon4v0 l2cache gr1553b iommu ascs slink pwm \
	hcan usb grfpc4 grlfpc4
FILEADD = MCB.vhd
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

mig:
	coregen -b mig/mig.xco -p mig
	patch -p0 < mig.diff

migclean:
	-rm -rf mig/mig_38* mig/tmp

mig39:
	coregen -b mig39/mig.xco -p mig39
	patch -p0 < mig_patch.txt
	patch -p0 < memc3_infrastructure_patch.txt
	patch -p0 < mcb_soft_calibration_patch.txt

mig39clean:
	-rm -rf mig39/mig_39* mig39/tmp

.PHONY : mig mig39 mig39clean