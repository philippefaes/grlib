GRLIB=../..
TOP=netcard
BOARD=gr-pci-xc2v
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/default.ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=-resource_sharing no
SIMTOP=netcard
VHDLSYNFILES=config.vhd netcard.vhd
VHDLSIMFILES=
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = unisim
LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip hynix cypress micron ihp opencores esa

DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan ddr usb leon3ft \
	usbhc leon3 can i2c satcan ascs spi memctrl hcan slink \
	leon4 leon4v0 leon3v3 clk2x srmmu irqmp

FILESKIP = i2cmst.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

