include .config

GRLIB=../..
TOP=leon3mp
BOARD=digilent-zedboard-xc7z020
DESIGN=leon3-zedboard-xc7z020
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)$(PACKAGE)-$(SPEED)
UCF_PLANAHEAD=$(GRLIB)/boards/$(BOARD)/$(BOARD).ucf

VHDLSYNFILES= \
	config.vhd ahbrom.vhd leon3mp.vhd

VHDLSIMFILES= \
	testbench.vhd leon3_zedboard_stub_sim.vhd

SIMTOP=testbench
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
VCOMOPT=-explicit
VLOGOPT= +define+1Gb +define+sg125 +define+x8
VSIMOPT=  -t ps -novopt +notimingchecks $(SIMTOP)
TECHLIBS = secureip unisim 

BOPT=-DRAMSTART=0x00000000
LDFLAGS=-Wl,-msparcleon0

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
	@echo " -----------------------------------------------------------------------------------------"
	@echo " design specific targets:"
	@echo
	@echo " make program-zedboard              : Load Leon3 Design and start clocks"
	@echo

program-zedboard:
	@echo "fpga -f ./planAhead/$(DESIGN)/$(DESIGN).runs/impl_1/$(TOP).bit" > ./xmd.ini
	@echo "connect arm hw" >> ./xmd.ini
	@echo "source ./planAhead/$(DESIGN)/$(DESIGN).sdk/SDK/SDK_Export/hw/ps7_init.tcl" >> ./xmd.ini
	@echo "ps7_init" >> ./xmd.ini
	@echo "init_user" >> ./xmd.ini
	@echo "exit" >> ./xmd.ini
	xmd

