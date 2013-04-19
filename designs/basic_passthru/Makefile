include .config
GRLIB=../..
TOP=basic_passthru
BOARD=xilinx-sp601-xc6slx16
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
#ISEMAPOPT=-timing
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT="-uc basic_passthru.xcf"
SYNPOPT="set_option -pipe 1; set_option -retiming 1; set_option -write_apr_constraint 0"
VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp_core.vhd
VERILOGSYNFILES=basic_passthru.v
VERILOGSIMFILES=test_basic_passthru.v
SIMTOP=test_basic_passthru
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw eth dw02 \
        esa fmf spansion gsi cypress hynix micron 
DIRSKIP = b1553 pcif leon2 leon2ft crypto satcan pci leon3ft ambatest can \
	usb grusbhc spacewire ata haps coremp7 ascs slink hcan hasp \
        greth net ddr memctrl leon4 leon4b64 l2cache pwm gr1553b iommu
FILESKIP = grcan.vhd i2cmst.vhd i2cmst_gen.vhd ahbram.vhd 
LIBADD = praesum

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

