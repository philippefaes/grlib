GRLIB=../..
TOP=cycore12
BOARD=jopdesign-ep1c12
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=std
XSTOPT=
VHDLSYNFILES=config.vhd ahbrom.vhd leon3mp.vhd cycore12.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=$(GRLIB)/boards/$(BOARD)/default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean

TECHLIBS = altera altera_mf

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc ihp hynix cypress
DIRSKIP = b1553 pci/pcif leon2 leon2ft crypto satcan leon3ft \
	ddr grusbhc usb spi slink ascs leon4v0

FILESKIP = grcan.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile


##################  project specific targets ##########################

