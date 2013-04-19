include .config

GRLIB=../..
TOP=leon3mp
BOARD=xilinx-sp605-xc6slx45t
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=leon3mp.ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
ISEMAPOPT="-timing"
XSTOPT=""
SYNPOPT="set_option -maxfan 100; set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLOPTSYNFILES= mig/mig_38/user_design/rtl/iodrp_controller.vhd \
	mig/mig_38/user_design/rtl/iodrp_mcb_controller.vhd \
	mig/mig_38/user_design/rtl/mcb_raw_wrapper.vhd \
	mig/mig_38/user_design/rtl/mcb_soft_calibration.vhd \
	mig/mig_38/user_design/rtl/mcb_soft_calibration_top.vhd \
	mig/mig_38/user_design/rtl/memc3_infrastructure.vhd \
	mig/mig_38/user_design/rtl/memc3_wrapper.vhd \
	mig/mig_38/user_design/rtl/mig_38.vhd
VHDLSYNFILES= \
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
	tmtc openchip cypress ihp gleichmann gsi fmf spansion 
DIRSKIP = b1553 pcif leon2 leon2ft crypto satcan pci leon3ft ambatest \
	leon4 leon4b64 l2cache gr1553b iommu haps ascs slink coremp7 pwm \
	ac97 hcan usb
DIRADD = leon3ftv2
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

.PHONY: mig
