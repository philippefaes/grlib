VER=$(VNAME)1.1.0
BID=4113
GVER=1100
CC=gcc
SED=sed
DISTLIB=~/vhdl

ASICLIBS = ihp25 sgb25vrh ut025crh virage rh_lib18t rh_lib18t_io2 \
	atc18 artisan umc18 virage90 tsmc90 dare nextreme atc18rha_cell smic13 \
	tm65gplus st65lp st65gp cmos9sf nextreme2 gtech
FPGALIBS = apa proasic3 axcelerator ec fusion unisim secureip altera altera_mf stratixii \
	eclipsee cycloneiii stratixiii synplify simprim stratixiv proasic3e proasic3l
ifeq ("$(TECHLIBS)","")
TECHLIBS=$(FPGALIBS) $(ASICLIBS)
endif
ifeq ("$(GRLIB_CONFIG)","")
GRLIB_CONFIG = dummy
endif
XTECHLIBS = $(TECHLIBS:%=tech/% )
SIMLIBS = hynix micron cypress
ACTELLIBS = apa apa3 axcelerator proasic3 fusion
XILINXLIBS = unisim simprim
ALTERALIBS = altera_mf stratixii altera cycloneiii stratixiii
ALTERAFILES = $(ALTERALIBS:%=lib/techmap/%) $(RMCOMLIBS:%=lib/tech/%) netlists/altera
LATTICELIBS = ec
BRMLIBS = core1553bbc core1553brm core1553brt gr1553
COREPCILIB = corePCIF
CONTRIBLIBS = openchip gleichmann contrib sun

RMFTLIBS=ihp25 sgb25vrh ut025crh rh_lib18t rh_lib18t_io2 pere05 rhumc \
	dare tsmc90 atc18rha_cell
RMCOMLIBS=artisan cust1 virage90 nextreme

RMFTLIBSX = $(RMFTLIBS:%=lib/techmap/%) $(RMFTLIBS:%=lib/tech/%)
RMCOMLIBSX = $(RMCOMLIBS:%=lib/techmap/%) $(RMCOMLIBS:%=lib/tech/%)
RMFPGALIBSX = $(ASICLIBS:%=lib/techmap/%) $(ASICLIBS:%=lib/tech/%)

HAPSFILES = lib/gaisler/haps doc/haps.pdf boards/hardi* designs/leon3-hardi*

L3FTNET = leon3ft_grfpu_unisim.vhd leon3ft_grfpul_unisim.vhd
#V2NET =
#V4NET =
#V5NET =
GRFPWNET = grfpw_0_unisim.vhd
GRFPW4NET = grfpw4_0_unisim.vhd

GRSPWFILES = lib/spw/source_dist
GRSPWCORE  = lib/spw/core

GR1553BFILES = lib/gaisler/gr1553b/core lib/gaisler/gr1553b/test \
	lib/gaisler/gr1553b/wrap verification/gr1553b verification/ahbmst2

GRFPC = lib/gaisler/leon3/libfpu.vhd lib/gaisler/leon3/grfpc.vhd \
	lib/gaisler/leon3/grfpw.vhd lib/gaisler/leon3/grfpwsh.vhd \
	lib/gaisler/leon3ft/libfpuft.vhd lib/gaisler/leon3ft/grfpcft.vhd \
	lib/gaisler/leon3ft/grfpwft.vhd \
	lib/gaisler/leon3ftv2/libfpuft.vhd lib/gaisler/leon3ftv2/grfpcft.vhd \
	lib/gaisler/leon3ftv2/grfpwft.vhd \
	lib/gaisler/leon4b64/libfpu4.vhd lib/gaisler/leon4b64/grfpc4.vhd \
	lib/gaisler/leon4b64/grfpw4.vhd lib/gaisler/leon4b64/grfpwx4.vhd

GRLFPC = lib/gaisler/leon3/libgrlfpc.vhd lib/gaisler/leon3/grlfpc.vhd \
	lib/gaisler/leon3/grlfpc2.vhd lib/gaisler/leon3/grlfpw.vhd \
	lib/gaisler/leon3ft/grlfpcft.vhd lib/gaisler/leon3ft/grlfpc2ft.vhd \
	lib/gaisler/leon3ft/grlfpwft.vhd \
	lib/gaisler/leon3ftv2/grlfpcft.vhd lib/gaisler/leon3ftv2/grlfpc2ft.vhd \
	lib/gaisler/leon3ftv2/grlfpwft.vhd \
	lib/gaisler/leon4b64/grlfpc24.vhd lib/gaisler/leon4b64/grlfpw4.vhd \
	lib/gaisler/leon4b64/grlfpwx4.vhd lib/gaisler/leon4b64/grfpwsh4.vhd

FPC = $(GRFPC) $(GRLFPC)
GRFPU = lib/gaisler/grfpu
FPU = $(FPC) $(GRFPU)

TMTC = lib/tmtc software/ccsds verification/grtm verification/grtc \
	verification/grctm verification/rs232 verification/spwcuc \
	verification/pw verification/grpulse verification/grtimer \
	doc/tmtc/tmtc.pdf

SKIPTMTC1 = lib/tmtc/grtm/grtm_pahb.vhd lib/tmtc/grtm/grtm_desc.vhd \
	lib/tmtc/grtm/geffe.vhd lib/tmtc/grtm/grtm_clcwmux.vhd \
	lib/tmtc/grtm/grtm_clcwrx.vhd lib/tmtc/grtm/grtm_vc.vhd \
	lib/tmtc/grtm/grtm_pw.vhd lib/tmtc/grtc/grtc_uart.vhd \
	lib/tmtc/grtc/grtc_hw.vhd lib/tmtc/grtc/grtc_clcwtx.vhd

SKIPTMTC2 = lib/tmtc/grtm/grtmrx.vhd lib/tmtc/grtc/grtctx.vhd

PRAESUM = \
	lib/praesum designs/basic_passthru

INTFILES =  TODO.txt \
	bin/etools_create_project \
	boards/*/doc \
	doc/guide \
	doc/crypto doc/companion-core doc/design-reuse doc/esa \
	doc/gr1553 doc/greth doc/grspw \
	lib/actel/*/source \
	lib/esa/leon2* lib/gaisler/fpu \
	lib/gaisler/leon3ft lib/gaisler/pcif lib/gaisler/satcan \
	lib/gaisler/hcan \
	lib/gaisler/pwm \
	lib/gaisler/crypto lib/ihp* \
	lib/gaisler/slink \
	$(RMFTLIBSX) lib/tech/nextreme/cells \
	lib/topnet lib/tmtc \
	designs/suidemo \
	designs/*esa* designs/leon3-ft-a* designs/leon3-ft-d* \
	designs/leon3-ft-r* designs/leon3-ft-m* \
	designs/leon3-ft-*flex designs/leon3-celeno designs/leon3ihp-tbench \
	designs/*flexody* designs/*/rhlib* \
	designs/*-cosim designs/leon2-gr-cpci-xc4v \
	designs/leon2* \
	designs/ethspw designs/leon3ihp designs/pcispw \
	designs/leon3-1553 \
	designs/gr701-pci-1553-bridge \
	designs/rasta-if-board designs/leon3-bsd \
	verification/ahb2ahb/multi_ahb2ahb.py \
	verification/ahbctrl \
	verification/ahbram \
	verification/at \
	verification/ddrspa \
	verification/ddr2spa \
	verification/ddr2phy \
	verification/b1553brm \
	verification/dma2ahb verification/esa_spw \
	verification/grfpw \
	verification/grfpw4 \
	verification/grhcan \
	verification/grslink verification/grspw \
	verification/spimctrl \
	verification/grpwm \
	verification/tb_msp \
	verification/gf4_e1 \
	verification/rs_gf4_e1 \
	verification/rs_gf4_e2 \
	verification/pw \
	verification/rs232 \
	verification/grctm \
	verification/tmtc \
	verification/grfifo \
	verification/crypto \
	verification/gradcdac \
	verification/ahb2pp \
	verification/grpulse \
	verification/grtimer \
	verification/grtc \
	verification/grtm \
	verification/grtmtc \
	verification/grascs \
	verification/sdctrl \
	verification/svgactrl \
	verification/l2c \
	verification/grfpu \
	verification/ahbjtag \
	verification/techmap \
	verification/pci \
	lib/spansion/flash/s29gl128p.vhd lib/spansion/flash/s29gl128p_vhd.ftm \
	lib/techmap/*/grusbhc_*_*.vhd netlists/xilinx/spartan3/grspwc2.ngo\
	lib/techmap/*/corepcif_* lib/actel/corePCIF/netlist \
	lib/tech/atc18/cells lib/tech/atc18rha_cell\
	lib/techmap/*/pci_arb_* lib/gaisler/ascs \
	software/leon3/grslink.c software/leon3/grascs.c \
	software/ccsds \
	lib/tech/*/doc lib/gaisler/haps/ddr2_1x2* \
	lib/tech/tsmc90/tci lib/tech/smic13 lib/techmap/smic13 \
	lib/actel/*/netlist/primitives.vhd \
	lib/gaisler/spacewire/grspw_codec.vhd \
	lib/gaisler/spacewire/grspwrouter.vhd \
	lib/gaisler/spacewire/grspw2_dma.vhd \
	lib/gaisler/spacewire/grspw2_fifo.vhd \
	lib/gaisler/spacewire/sim \
	lib/gaisler/leon4ft \
	verification/grspw* \
	$(GR1553BFILES) \
	lib/gaisler/misc/memscrub.* verification/memscrub \
	lib/gaisler/iommu verification/griommu \
	lib/tech/cmos9sf lib/techmap/cmos9sf \
	lib/tech/tm65gplus lib/techmap/tm65gplus \
	lib/tech/ut130hbd lib/techmap/ut130hbd \
	verification/spwcuc designs/ftproa3 \
	lib/tech/nextreme2 lib/techmap/nextreme2 \
	lib/techmap/ut90nhbd lib/tech/ut90nhbd \
	lib/gaisler/leon3ftv2 projects $(GRSPWFILES) \
	lib/gaisler/l2cachev1 \
	software/ccsds/*aes* \
	verification/memperf \
	software/mil1553 

#	lib/tech/secureip lib/tech/unisim/ise/G* \
#	lib/tech/unisim/ise/MCB.vhd

FTFILES =  \
	doc/reedsolomon doc/tmtc \
	designs/leon3-rtax* designs/leon3-ft* \
	designs/ft* designs/ut699rh-evab boards/ut699rh-evab verification/ft* \
	lib/actel \
	lib/gaisler/*/ft* lib/gaisler/misc/ft* \
	lib/gaisler/sim/*ft* \
	lib/gaisler/b1553 lib/gr1553 \
	lib/gaisler/spacewire/grspw2_phy.vhd \
	lib/grlib/ftlib \
	lib/micron/sdram/ft* \
	lib/techmap/maps/*ft* \
	lib/techmap/unisim/*ft* \
	lib/spw/core \
	lib/techmap/*/grspwc_*_*.vhd \
	lib/techmap/*/grspwc2_*_*.vhd \
	lib/techmap/*/leon3ft*_*.vhd \
	lib/techmap/*/ftmctrl_*_*.vhd \
	software/leon3/*ft* software/leon3/bch* \
	software/leon3/brm.c

PROA3TMAP = \
	lib/tech*/fusion* lib/tech*/proasic* lib/tech*/apa \
	boards/gr-mcc-c designs/leon3-gr-mcc-c designs/*actel* \

USBHCFILES = \
	verification/grusbhc lib/gaisler/usb/hc lib/techmap/*/grusbhc_*_*.vhd

USBDCFILES = \
	verification/grusbdc lib/gaisler/usb/dc \
	verification/grusb_dcl lib/gaisler/usb/dcl

USBFILES = $(USBHCFILES) $(USBDCFILES)

GBITFILES = \
	verification/greth/*gbit* \
	lib/eth/core/*gbit*

T1FILES = lib/sun designs/t1*

COREMP7FILES = lib/gaisler/coremp7 designs/coremp7-actel-proasic3

LEON4FILES = \
	lib/gaisler/leon4 lib/gaisler/leon4b64 lib/gaisler/l2cache \
	designs/leon4* \
	lib/techmap/maps/grfpw4* lib/techmap/maps/grlfpw4* \
	netlists/*/*/*4* verification/leon4-clk2x verification/grfpw4 \
	verification/l2c

#	software/leon3/base_test4.c software/leon3/griommu.c \
#	software/leon3/leon4_test.c software/leon3/memscrub_test.c

COMFILES = \
	designs/leon3-clk2x designs/*spw* \
	verification/ahbbridge verification/ahb2ahb \
	verification/greth verification/spictrl verification/i2c \
	verification/pci verification/can_oc \
	verification/mobile_ddr_sdr \
	verification/grcan \
	lib/grlib/amba/ahbmon.vhd lib/grlib/amba/apbmon.vhd \
	lib/grlib/amba/ambamon.vhd lib/grlib/amba/ahbctrl_mb.vhd \
	lib/gaisler/misc/ahb2ahb.vhd lib/gaisler/misc/ahbbridge.vhd \
	lib/gaisler/leon3/*2x*  lib/gaisler/memctrl/ssrctrl.vhd \
	lib/gaisler/misc/grfifo* \
	lib/gaisler/misc/gradcdac* \
	lib/gaisler/can/can_oc_core.vhd lib/gaisler/can/grcan.vhd \
	lib/opencores/can/can_top_core_sync.vhd lib/opencores/can/can_top_sync.vhd \
	lib/gaisler/sim/ulpi.vhd lib/gaisler/sim/utmi.vhd \
	lib/techmap/inferred/tap_inferred.vhd \
	lib/gaisler/leon4* lib/gaisler/l2c* \
	lib/gaisler/leon3/irqamp.vhd \
	lib/tech*/axcelerator \
	designs/leon3-gr-cpci-ax \
	lib/gaisler/jtag/bscanctrl.vhd lib/techmap/inferred/scanreg_inferred.vhd \
	designs/leon3-asic/bsdl \
	lib/gaisler/pci/grpci2 \
	lib/eth/core/1000basex_pcs_layer.vhd \
	lib/grlib/atf \
	$(USBFILES) $(RMCOMLIBSX) $(GBITFILES)

INTFTFPGAFILES = \
	verification/greth verification/greth/*gbit* \
	designs/leon3-clk2x lib/gaisler/greth/*gbit* \
	lib/grlib/amba/ahbctrl_mb.vhd \
	lib/gaisler/misc/ahb2ahb.vhd lib/gaisler/misc/ahbbridge.vhd \
	lib/gaisler/leon3/*2x* lib/gaisler/memctrl/ssrctrl.vhd \
	lib/gaisler/greth/*gbit* \
	lib/gaisler/memctrl/ftsrctrl-v1.* \
	lib/gleichmann lib/openchip \
	lib/tech/altera lib/techmap/altera \
	lib/tech/cycloneiii lib/techmap/cycloneiii \
	lib/tech/stratixiii lib/techmap/stratixiii \
	lib/tech/altera_mf lib/techmap/altera_mf \
	lib/tech/stratixii lib/techmap/stratixii \
	lib/tech/apa lib/techmap/apa \
	lib/tech/ec lib/techmap/ec \
	designs/leon3-altera* designs/leon3-avnet* designs/leon3-clock-gate \
	designs/leon3-jopdesign-ep1c12 designs/leon3-ge-* \
	designs/leon3-memec-v2mb1000 \
	designs/ut699rh-evab \
	designs/leon3-asic designs/leon3-wildcard-xcv300e \
	designs/leon3-ft-terasic-de2-115 designs/leon3-arrow-bemicro-sdk \
	designs/leon3-terasic-de2-115 designs/netcard designs/grspwrouter \
	lib/gaisler/sim/ulpi.vhd lib/gaisler/sim/utmi.vhd \
	designs/actel-coremp7-1000 \
	netlists/altera netlists/xilinx/*/grfpw* \
	verification \
	doc/Changelog-gpl.txt doc/tmtc doc/reedsolomon \
	lib/opencores/ac97 $(PRAESUM)

INTFPGAFILES = \
	verification/greth verification/greth/*gbit* \
	designs/leon3-clk2x lib/gaisler/greth/*gbit* \
	lib/grlib/amba/ahbctrl_mb.vhd \
	lib/gaisler/misc/ahb2ahb.vhd lib/gaisler/misc/ahbbridge.vhd \
	lib/gaisler/leon3/*2x* lib/gaisler/memctrl/ssrctrl.vhd \
	lib/gaisler/greth/*gbit* \
	lib/gaisler/memctrl/ftsrctrl-v1.* \
	lib/gleichmann lib/openchip \
	designs/leon3-jopdesign-ep1c12 \
	designs/leon3-clock-gate \
	designs/leon3-asic \
	designs/leon3-ge-*

EXTRAL4 = \
	lib/gaisler/pci lib/gaisler/ata \
	lib/gaisler/can  \
	lib/opencores/ac97 lib/techmap/inferred/ddr* \
	lib/tech*/eclipsee

GRLIB2FILES = \
	designs2 cfg bin/make.grlib2 make.grlib2 doc/grip2 doc/grlib2 \
	lib/*/*/cfg lib/*/*/doc lib/*/*/*/cfg  lib/*/*/*/*/cfg \
	lib/grlib/amba/ahbmon2.vhd lib/grlib/amba/apbctrl2.vhd \
	lib/grlib/amba/rtl lib/grlib/amba/ahbctrl2.vhd \
	software/grlib2 software/leon3/make.grlib2 \
	bin/synplify bin/make.xconfig bin/Grlib2.class bin/make.docbook \
	bin/Housekeeping.class bin/make.housekeeping bin/Record.class \
	bin/make.sw bin/verify-designs.sh bin/config-tool \
	bin/modelsim

RMPROA3FILES = \
	lib/tech/alt* lib/tech/apa lib/tech/axc* lib/tech/atc18 \
	lib/tech/cycloneiii lib/tech/dware lib/tech/ec* lib/tech/simprim \
	lib/tech/snps lib/tech/stra* lib/tech/tm65gplus \
	lib/tech/umc18 lib/tech/unisim lib/tech/virage \
	lib/contrib lib/esa/misc lib/esa/pci lib/gleichmann lib/openchip \
	lib/opencores/ata lib/opencores/ac97 \
	lib/techmap/alt* lib/techmap/apa lib/techmap/axc* lib/techmap/atc18 \
	lib/techmap/cycloneiii lib/techmap/dware lib/techmap/ec* lib/techmap/simprim \
	lib/techmap/snps lib/techmap/stra* lib/techmap/tm65gplus \
	lib/techmap/umc18 lib/techmap/unisim lib/techmap/virage \
	lib/gaisler/ata lib/gaisler/ddr lib/gaisler/ambatest lib/gaisler/arith \
	lib/gaisler/leon3/* lib/gaisler/pci lib/gaisler/usb lib/gaisler/misc/ahbram* \
	lib/gaisler/misc/wild* lib/gaisler/misc/*vga* lib/gaisler/misc/char* \
	lib/gaisler/misc/grsys* lib/gaisler/misc/*ps2* lib/gaisler/misc/grace* \
	lib/grlib/atf lib/gaisler/memctrl/ss* lib/gaisler/can/gr* \
	lib/techmap/maps/grf* lib/techmap/maps/grl* lib/techmap/proasic3*/*.srr \
	lib/gaisler/sim/gru* lib/gaisler/sim/usb* lib/gaisler/sim/ata* \
	lib/techmap/maps/mul_61x61.vhd lib/gaisler/memctrl/sdctrl64.vhd \
	lib/techmap/maps/ringosc.vhd lib/techmap/maps/ssrctrl_net.vhd \
	lib/techmap/maps/syncram128.vhd lib/techmap/maps/syncram256bw.vhd \
	lib/techmap/maps/syncram128bw.vhd lib/techmap/maps/nandtree.vhd \
	lib/techmap/maps/ddrphy.vhd lib/techmap/inferred/mul_inferred.vhd \
	lib/techmap/inferred/ddr_inferred.vhd lib/techmap/maps/system_monitor.vhd \
	lib/tech/gtech lib/tech/secureip \
	lib/techmap/*/*_fpu* lib/techmap/*/grlfpw_*_* \
	verification netlists

ADDPROA3FILES = \
	lib/techmap/proasic3/leon3ft*.vhd \
	lib/techmap/proasic3e/leon3ft*.vhd \
	lib/techmap/proasic3l/leon3ft*.vhd \
	lib/techmap/proasic3/ftm*.vhd \
	lib/techmap/proasic3e/ftm*.vhd \
	lib/techmap/proasic3l/ftm*.vhd \
	lib/gaisler/memctrl/ftmctrl.in* lib/gaisler/gr1553b/gr1553b.in* \
	lib/gaisler/memctrl/ftmctrl.vhd \
	lib/gaisler/memctrl/ftsrctrl.vhd lib/gaisler/memctrl/ftsrctrl.in* \
	lib/gaisler/can/grcan.in* lib/gaisler/gr1553b/gr1553b_pkg.vhd \
	lib/gaisler/gr1553b/vhdls*.txt \
	lib/gaisler/leon3/leon3.vhd lib/gaisler/leon3/irqmp* \
	lib/gaisler/leon3/dsu* lib/gaisler/leon3/tbuf* \
	lib/gaisler/leon3/vhdlsyn.txt lib/gaisler/leon3/leon3.in* \
	lib/techmap/maps/leon3* lib/techmap/maps/ft*


ADDPROA3SPWFILES = \
	lib/techmap/proasic3*/grspwc2*.vhd \
	lib/gaisler/spacewire/grspw2_phy.vhd

VHDLP = vhdlp -s -work
SONATALIBSKIP = pere05

ALIB = alib
ACOM = acom -quiet $(ACOMOPT) -accept87 -work
ALOG = alog -quiet $(ALOGOPT) -work
AVHDL = avhdl

VLIB = vlib
VCOM = vcom -quiet $(VCOMOPT) -93
VLOG = vlog -quiet $(VLOGOPT)
VSIM = vsim

NCVHDL = ncvhdl -nowarn DLCPTH -NOVITALCHECK -linedebug -v93 -nocopyright -work
NCVLOG = ncvlog -nowarn DLCPTH -nocopyright -linedebug $(NCVLOGOPT) -work

DCVHDL = analyze -f VHDL -library
DCVLOG = analyze -f VERILOG -library
FMVHDL = read_vhdl -r -libname
FMVLOG = read_verilog -r -libname
ifeq ("$(DCSCRIPT)","")
DCSCRIPT=$(TOP).dc
endif
DCLIBSKIP = $(FPGALIBS) corePCIF
#DCLIBSKIP = dware corePCIF
DCDIRSKIP =  $(FPGALIBS) corePCIF pcif
#DCDIRSKIP =  corePCIF pcif
XDCLIBSKIP = $(DCLIBSKIP:%=% | ) dummy
XDCDIRSKIP = $(DCDIRSKIP:%=% | ) dummy
DCSKIP = $(DCLIBSKIP:%=*_%.vhd | ) dummy

RTLCVHDL = read_hdl -vhdl -lib
RTLCVLOG = read_hdl
RCSCRIPT=$(TOP).rc

SYNPVHDL = add_file -vhdl -lib
SYNPVLOG = add_file -verilog
SYNPLIBSKIP = $(ASICLIBS)
XSYNPLIBSKIP = $(SYNPLIBSKIP:%=%|) dware
XSYNPDIRSKIP = $(SYNPLIBSKIP:%=%|) dware

XSTVHDL = elaborate -ifmt vhdl -work_lib
XSTVLOG = elaborate -ifmt verilog -work_lib
XSTLIBSKIPX = $(ASICLIBS) $(BRMLIBS) $(ACTELLIBS) $(ALTERALIBS) \
	$(LATTICELIBS) $(COREPCILIB) $(SIMLIBS)
XSTLIBSKIP = $(XSTLIBSKIPX:%=%|) dware
XSTDIRSKIPX = $(ASICLIBS) $(ACTELLIBS) $(ALTERALIBS) $(LATTICELIBS)
XSTDIRSKIP = $(XSTDIRSKIPX:%=%|) dware
#XSTSKIPX = $(XSTLIBSKIPX:%=*_%.vhd |)
XSTSKIP = $(XSTSKIPX) b1553* | pci_components* | pcicore* | snpsmul.vhd

ifeq ("$(ISETECH)","")
ISETECH=$(TECHNOLOGY)
endif

ifeq ("$(ISE11TECH)","")
ISE11TECH=$(ISETECH)
endif

ifeq ("$(NETLISTTECH)","")
# Some .ngo netlists are reused for other FPGA families
ifeq ("$(TECHNOLOGY)","Spartan6")
NETLISTTECH = Spartan3
else
ifeq ("$(TECHNOLOGY)","Virtex6")
NETLISTTECH = Virtex4
else
ifeq ("$(TECHNOLOGY)","Virtex2p")
NETLISTTECH = Virtex2
else
ifeq ("$(TECHNOLOGY)","Spartan3A")
NETLISTTECH = Spartan3
else
ifeq ("$(TECHNOLOGY)","Spartan3E")
NETLISTTECH = Spartan3
else
NETLISTTECH = $(TECHNOLOGY)
endif
endif
endif
endif
endif
endif

PRECLIBSKIPX = $(SIMLIBS) $(ASICLIBS)
PRECLIBSKIP =  $(PRECLIBSKIPX:%=%|) dware
PRECDIRSKIP =  $(PRECLIBSKIPX:%=%|) dware
PRECSKIP = dummy

PROASIC3LIBS = proasic3 proasic3e proasic3l fusion
XLIBEROLIBSKIP = $(ASICLIBS) $(LATTICELIBS) \
	$(ALTERALIBS) $(XILINXLIBS) $(PROASIC3LIBS) axcelerator
LIBEROLIBSKIP = $(XLIBEROLIBSKIP:%=%|) dware
LIBERODIRSKIPX = $(ASICLIBS) $(XILINXLIBS) $(ALTERALIBS) $(LATTICELIBS)
LIBERODIRSKIP = $(LIBERODIRSKIPX:%=%|) dware
LIBEROSKIP = dummy

# The paths below apply to CoreConsole v. 1.4
ifeq ("$(CORECONSOLE)","")
CORECONSOLE = dummy
else
CORECONSOLE_PATH = $(CORECONSOLE)/repository/Components/Actel/DirectCore
COREMP7BRIDGE_PATH = $(CORECONSOLE_PATH)/CoreMP7Bridge/2.1/rtl/vhdl/o
COREMP7BRIDGE_FILES = A7WrapMaster.vhd A7WrapSM.vhd CoreMP7Bridge_a3p.vhd Sync.vhd uj_jtag.vhd
COREMP7_PATH = $(CORECONSOLE_PATH)/A7S/2.0/M7A3P1000-2/debug/timingshell/vhdl
COREMP7_FILES = arm_synplify.vhd
endif

SYNPSKIP = snpsmul.vhd

GHDL = ghdl -a -fexplicit --ieee=synopsys
GHDLE = ghdl -e -fexplicit --ieee=synopsys
GHDLM = ghdl --gen-makefile -fexplicit --ieee=synopsys
GHDLSKIP = orca.vhd _ec.vhd grcan.vhd

SYNPLIFY = synplify_pro

DESIGNER = designer
LIBERO = libero

OS = `uname`

UNISIMSRC = $(XILINX)/vhdl/src/unisims/unisim_VPKG.vhd  \
	$(XILINX)/vhdl/src/unisims/unisim_VCOMP.vhd \
	$(XILINX)/vhdl/src/unisims/unisim_VITAL.vhd

SIMPRIMSRC = $(XILINX)/vhdl/src/simprims/simprim_Vpackage.vhd  \
	$(XILINX)/vhdl/src/simprims/simprim_Vcomponents.vhd \
	$(XILINX)/vhdl/src/simprims/simprim_VITAL.vhd


#ifeq ("$(QUARTUS_ROOTDIR)","")
QUARTUS_CDB = quartus_cdb
QUARTUS_MAP = quartus_map
QUARTUS_FIT = quartus_fit
QUARTUS_ASM = quartus_asm
QUARTUS_STA = quartus_sta
QUARTUS_PGM = quartus_pgm
#else
#QUARTUS_MAP = $(QUARTUS_ROOTDIR)/bin/quartus_map
#QUARTUS_FIT = $(QUARTUS_ROOTDIR)/bin/quartus_fit
#QUARTUS_ASM = $(QUARTUS_ROOTDIR)/bin/quartus_asm
#QUARTUS_STA = $(QUARTUS_ROOTDIR)/bin/quartus_tan
#endif
ALTCABLE=USB-Blaster
QLIBSKIPX = $(SIMLIBS) $(ASICLIBS) $(BRMLIBS) $(ACTELLIBS) $(XILINXLIBS) \
	$(LATTICELIBS) $(COREPCILIB)
QUARTUSLIBSKIP = $(QLIBSKIPX:%=%|) dware
QDIRSKIPX = $(ASICLIBS) $(ACTELLIBS) $(XILINXLIBS) $(LATTICELIBS)
QDIRSKIP = $(QDIRSKIPX:%=%|) dware | satcan | leon2ft
QUARTUSSKIP = b1553* | pci_components* | pcicore* | snpsmul.vhd

SYN=synplify
SIM=$(VSIM)
PR=ise

PRECISION=precision

ifeq ("$(ETOOLS_N2X_HOME)","")
ETOOLS_N2X_HOME = dummy
endif

ifeq ("$(SIMTOP)","")
SIMTOP=$(TOP)
endif

ifeq ("$(LIBSKIP)","")
XLIBSKIP="x"
else
XLIBSKIP= $(LIBSKIP:%=%|) dummy
endif

YDIRSKIP=$(DIRSKIP) $(LIBSKIP)

ifeq ("$(YDIRSKIP)","")
XDIRSKIP="dummy"
else
XDIRSKIP= $(YDIRSKIP:%=%|) $(LIBSKIP:%=%|) dummy
endif

XFILESKIP = $(FILESKIP:%=%|) $(LIBSKIP:%=*_%.vhd|) dummy

# GRLIB_NHCPU defines # of CPUs available on host for synthesis, value
# may be used in script generation
ifeq ("$(GRLIB_NHCPU)","")
GRLIB_NHCPU=4
endif

all: help

help:
	@echo
	@echo " interactive targets:"
	@echo
	@echo " make avhdl-launch         : start active-hdl gui mode"
	@echo " make riviera-launch       : start riviera"
	@echo " make vsim-launch          : start modelsim"
	@echo " make ncsim-launch         : compile design using ncsim"
	@echo " make sonata-launch        : compile design using sonata"
	@echo " make actel-launch         : start Actel Designer for current project"
	@echo " make ise-launch           : start ISE project navigator for XST project"
	@echo " make ise-launch-synp      : start ISE project navigator for synplify project"
	@echo " make quartus-launch       : start Quartus for current project"
	@echo " make quartus-launch-synp  : start Quartus for synplify project"
	@echo " make synplify-launch      : start synplify"
	@echo " make xgrlib               : start grlib GUI"
	@echo
	@echo " batch targets:"
	@echo
	@echo " make avhdl           : compile design using active-hdl gui mode"
	@echo " make vsimsa          : compile design using active-hdl batch mode"
	@echo " make riviera         : compile design using riviera"
	@echo " make sonata          : compile design using sonata"
	@echo " make vsim            : compile design using modelsim"
	@echo " make ncsim           : compile design using ncsim"
	@echo " make ghdl            : compile design using GHDL"
	@echo " make actel           : synthesize with synplify, place&route Actel Designer"
	@echo " make ise             : synthesize and place&route with Xilinx ISE"
	@echo " make ise-map         : synthesize design using Xilinx XST"
	@echo " make ise-prec        : synthesize with precision, place&route with Xilinx ISE"
	@echo " make ise-synp        : synthesize with synplify, place&route with Xilinx ISE"
	@echo " make isp-synp        : synthesize with synplify, place&route with ISPLever"
	@echo " make quartus         : synthesize and place&route using Quartus"
	@echo " make quartus-map     : synthesize design using Quartus"
	@echo " make quartus-synp    : synthesize with synplify, place&route with Quartus"
	@echo " make precision       : synthesize design using precision"
	@echo " make synplify        : synthesize design using synplify"
	@echo " make import-actel-cc : import CoreMP7 files from CoreConsole library"
	@echo " make scripts         : generate compile scripts only"
	@echo " make clean           : remove all temporary files except scripts"
	@echo " make distclean       : remove all temporary files"
	@echo

make xgrlib:
	  @if test -r "/mingw/bin/wish84.exe"; then \
	    if !(test -r "/mingw/bin/echo.bat"); then \
	      cp $(GRLIB)/bin/echo.bat /mingw/bin/echo.bat; \
	    fi; \
	    if !(test -r "/mingw/bin/wish"); then \
	      cp $(GRLIB)/bin/wish /mingw/bin/wish; \
	    fi; \
	  fi; \
	$(GRLIB)/bin/xgrlib.tcl $(TOP) $(TECHNOLOGY) $(DEVICE) $(BOARD)

############  AHB ROM Generation     ########################

FILE=prom.exe

ahbrom: $(GRLIB)/bin/ahbrom.c
	@if test -r "/mingw/bin/gcc.exe"; then \
	  $(CC) $(GRLIB)/bin/ahbrom.c -o ahbrom -lwsock32; \
	else \
	  $(CC) $(GRLIB)/bin/ahbrom.c -o ahbrom; \
	fi;

ahbrom.vhd:
	make ahbrom
	sparc-elf-objcopy -O binary $(FILE) ahbrom.bin
	./ahbrom ahbrom.bin ahbrom.vhd

#########    Generic simulation target ###############

sim:
	make $(SIM)

sim-run:
	make $(SIM)-run

sim-launch:
	make $(SIM)-launch

#########    Symphony-EDA Sonata targets   ############

make.son: compile.son
sonata sonata/compiled : make.son
	@make -f make.son sonata-compile
	@touch sonata/compiled

sonata-run : sonata/compiled
	vhdle -ini sonata.sws -work sonata -breakon FAILURE -r 1ps testbench

sonata-launch : sonata/compiled
	sonata sonata.sws

sonata-clean:
	-rm -rf *\.sym sonata.sws sonata symphony.ini symphony.sws tmp.son

#########    Active-HDL batch mode targets   ############

vsimsa: compile.vsim
	@cat libs.do | sed -e s/modelsim/activehdl/ | sed -e s/vlib/alib/ > alibs-batch.do
	@echo "do alibs-batch.do" > vsimsa-batch.do
	@vsimsa vsimsa-batch.do
	@vmap work activehdl/work
	@make -f make.vsim
	@-rm -f alibs-batch.do vsimsa-batch.do

vsimsa-run:
	@vsim $(SIMTOP) <  $(GRLIB)/bin/runvsim.do

vsimsa-launch: vsimsa-run

vsimsa-clean:
	-rm -rf activehdl vsimsa.cfg library.cfg wave.asdb alibs-batch.do vsimsa-batch.do

#vsimsa-modelsim:
#	echo "importmodelsim $(SIMTOP).mpf" . > activehdl.tcl
#	echo "quiet on" >> activehdl.tcl
#	echo "SET SIM_WORKING_FOLDER ..\\.." >> activehdl.tcl
#	AVHDL -do activehdl.tcl &

#########    Active-HDL gui mode targets   ############

avhdl: compile.asim
	@echo "createdesign work ." > avhdl.tcl
	@echo "opendesign -a work.adf" >> avhdl.tcl
	@cat alibs.do >> avhdl.tcl
	@echo "" >> avhdl.tcl
	@cat make.asim-addfile >> avhdl.tcl
	@cat make.asim >> avhdl.tcl
	@echo "" >> avhdl.tcl
	@echo SET SIM_WORKING_FOLDER $$\DSN/.. >> avhdl.tcl
	@echo "" >> avhdl.tcl
	@echo asim work.testbench >> avhdl.tcl

avhdl-run: avhdl-launch

avhdl-launch:
	@avhdl -do avhdl.tcl

avhdl-clean:
	-rm -rf work avhdl.tcl vsimsa.cfg wave.asdb

#########    Riviera targets   ############

riviera: compile.vsim
	@cat libs.do | sed -e s/modelsim/riviera/ > rlibs.do
	@vsimsa rlibs.do
	@make -f make.vsim
	@vmap work riviera/work
	@-rm -f rlibs.do

riviera-run:
	@vsim $(SIMTOP) <  $(GRLIB)/bin/runvsim.do

riviera-launch:
	@echo asim $(SIMTOP) > riviera.do
	@echo run -all >> riviera.do
	@echo abort >> riviera.do
	@riviera riviera.do

riviera-clean:
	-rm -rf riviera vsimsa.cfg wave.asdb riviera.do library.cfg .riviera_project rlibs.do

#########    Modelsim targets   ############

vsim: make.work
	@make -f make.work

make.work: compile.vsim modelsim
	@make -f make.vsim
	@echo "" > make.work
	@for i in `cat libs.txt`; do vmake $$i >> make.work ; done

modelsim: compile.vsim
	@vsim -c -quiet -do "do libs.do; quit"

vsim-grlib: modelsim
	make vsim
#	@for i in `cat libs.txt`; do \
#	  make -f modelsim/make.$$i ; \
#	done ;

vsim-run: vsim
	@vsim -c $(SIMTOP) <  $(GRLIB)/bin/runvsim.do

vsim-launch: scripts modelsim
	@vsim -quiet $(SIMTOP).mpf

vsim-mcb: scripts
	-vlib modelsim
	-vlib modelsim/unisim
	vcom -quiet -explicit -work unisim $(XILINX)/vhdl/src/unisims/secureip/MCB.vhd

vsim-unisim: modelsim
	vcom -quiet -explicit -work unisim $(UNISIMSRC)

vsim-simprim: modelsim
	vcom -quiet -explicit -work simprim -ignorevitalerrors $(SIMPRIMSRC)

vsim-clean:
	-rm -rf modelsim transcript *.mti stdout.log vsim.wlf \
	$(SIMTOP).mpf.bak $(SIMTOP).mti *.mpf

vsim-fix:
	cat make.work | sed 's/\([a-zA-Z]\)\(:\\\)/\/\1\//'  > make.work2
	mv make.work2 make.work

#########   GHDL targets   ############

ghdl $(SIMTOP): make.ghdl
	make -f make.ghdl GHDLFLAGS="-fexplicit --ieee=synopsys --workdir=gnu/work --work=work `cat ghdl.path`"

make.ghdl: compile.ghdl
	-rm -rf gnu
	make -f tmpmake.ghdl ghdl
	$(GHDLE) $(VHDLOPT) --workdir=gnu/work --work=work `cat ghdl.path` $(SIMTOP)
	$(GHDLM) $(VHDLOPT) --workdir=gnu/work --work=work `cat ghdl.path` $(SIMTOP) > make.ghdl
	cat tmpmake.ghdl >> make.ghdl

ghdl-run ghdl-launch: $(TOP)
	./$(SIMTOP)

ghdl-clean:
	-rm -rf gnu $(SIMTOP) make.ghdl

#########   NcSim targets   ############

ncsim: xncsim/done
	ncupdate $(SIMTOP)

ncsim-run: ncsim
	ncsim $(SIMTOP)

ncsim-launch: ncsim
	ncsim -gui $(SIMTOP)&

xncsim xncsim/done : compile.ncsim
	-rm -rf xncsim
	make -f make.ncsim
	touch xncsim/done

ncsim-clean:
	-rm -rf xncsim nc*.log ncsim.key

#########   Lattice ISPLEVER targets   ############

isp-synp: $(TOP)_synplify.prj synplify/$(TOP).edf
	$(GRLIB)/bin/route_lattice $(TOP) $(UCF) $(PART) synplify $(ISPLIB) $(ISPPACKAGE) $(BITGEN)

isp-prec: $(TOP)_precision.prj precision/$(TOP).edf
	$(GRLIB)/bin/route_lattice $(TOP) $(UCF) $(PART) precision $(ISPLIB) $(ISPPACKAGE) $(BITGEN)

isp-launch-synp: $(TOP)_synplify.prj synplify/$(TOP).edf
	projnav ./$(TOP).syn

isp-launch-prec: $(TOP)_precision.prj precision/$(TOP).edf
	projnav ./$(TOP)_precision.syn

diamond-launch: $(TOP).ldf
	diamond $(TOP).ldf

isp-prom:
	synsvf $(PROMGENPAR)
isp-clean:
	-rm -rf $(TOP).dir *.jid *.alt *.lci *.mt *.nc1 *.nc2 *.p?t \
	*.err compxlib.cfg *.jhd *.lct $(TOP).log *.ngy *.prf  *.pt *.rev \
	*.syn *.t2b *.tcm *.tcp *.tw1 $(TOP).tcl *.sty *.svl *.env fonts.dir \
	$(TOP)_tcl.ini lattice $(TOP).ldf $(TOP).lpf



#########   Xilinx ISE targets   ############

ise: $(TOP).ngc
	$(GRLIB)/bin/route_ngc $(TOP) $(UCF) $(DEVICE) $(EFFORT) $(BITGEN) $(GRLIB)/netlists/xilinx/$(NETLISTTECH) $(ISEMAPOPT)

ise-synp: $(TOP)_synplify.prj synplify/$(TOP).edf
	$(GRLIB)/bin/route $(TOP) $(UCF) $(DEVICE) $(EFFORT) $(BITGEN) synplify \
	$(GRLIB)/netlists/xilinx/$(NETLISTTECH) $(ISEMAPOPT)

ise-prec: $(TOP).psp precision/$(TOP).edf
	$(GRLIB)/bin/route $(TOP) $(UCF) $(DEVICE) $(EFFORT) $(BITGEN) precision \
	$(GRLIB)/netlists/xilinx/$(NETLISTTECH)  $(ISEMAPOPT)

ise-launch8 xst-launch: $(TOP).npl $(TOP)_ise.tcl
	ise $(TOP).npl>& ise.err&

ise-launch10 ise-launch9: $(TOP).ise
	ise $(TOP).ise

ise-launch11 : $(TOP).xise
	ise $(TOP).xise

ise-launch :
	@isever=`promgen | grep Rele | awk '{print $$2}'`; \
	case $$isever in \
	8*) \
		make ise-launch8 ;;\
	9*) \
		make ise-launch9 ;;\
	10*) \
		make ise-launch10 ;;\
	*) \
		make ise-launch11 ;;\
	esac



ise-launch-synp: $(TOP).npl $(TOP)_synplify.prj synplify/$(TOP).edf $(TOP)_synplify.prj
	ise $(TOP)_synplify.npl>& ise.err&

$(TOP).xst: compile.xst
	@touch $(TOP).xst; rm $(TOP).xst
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
		if test -r $$i; then \
		  echo vhdl work $$i >> $(TOP)_files.prj ; \
		fi; \
	done
#	@for i in $(VERILOGSYNFILES); do $(GRLIB)/bin/xstverilog $ii >> $(TOP).xst; done
	@$(GRLIB)/bin/xstrun $(TOP) $(TOP).vhd  $(DEVICE) >> $(TOP).xst
	@echo -ofn $(TOP) $(XSTOPT) -define {XSTDUMMY $(SYNPVLOGDEFS)} -sd $(GRLIB)/netlists/xilinx/$(NETLISTTECH) >> $(TOP).xst
	@echo  $(TOP).xst

ise-xstmod :
	$(GRLIB)/bin/xstmod $(CORE) $(CORE).vhd $(DEVICE) vhdl  > tmp.xst
	xst -ifn tmp.xst

$(TOP).bit: $(TOP).ngc
	$(GRLIB)/bin/route_ngc $(TOP) $(UCF) $(DEVICE) $(EFFORT) $(BITGEN) $(GRLIB)/netlists/xilinx/$(NETLISTTECH)

ise-map xst-map ise-xst xst: $(TOP).ngc

$(TOP).ngc: $(TOP).xst $(VHDLSYNFILES) $(VERILOGSYNFILES) compile.xst
	-rm -rf xst
	@-mkdir xst xst/projnav.tmp
#	xst -ifn compile.xst
	xst -ifn $(TOP).xst

$(TOP).ise: $(TOP)_ise.tcl
	@echo "Creating $(TOP).ise using xtclsh - this can take up to 20 minutes."
	@echo "Fell free to ask Xilinx why the xtclsh runs so slowly .... "
	xtclsh $(TOP)_ise.tcl

ise-prom:
ifeq ("$(PROMGENPAR)","")
	@echo "no prom programming support for this board"
	@exit 1
else
	promgen $(PROMGENPAR)
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
endif

ise-cp-ref:
	cp bitfiles/*.* .

ise-prog-prom: ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom.cmd

ise-prog-prom-usb: ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom-usb.cmd

ise-prog-prom-ref: ise-cp-ref ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom.cmd

ise-prog-prom-ref-usb: ise-cp-ref ise-prom
	impact -batch $(GRLIB)/boards/$(BOARD)/prom-usb.cmd

ise-prog-fpga:
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga.cmd

ise-prog-fpga-usb:
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga-usb.cmd


ise-prog-fpga-ref: ise-cp-ref
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga.cmd

ise-prog-fpga-ref-usb: ise-cp-ref
	cp $(TOP).bit $(BOARD).bit
	cp $(TOP).msk $(BOARD).msk
	impact -batch $(GRLIB)/boards/$(BOARD)/fpga-usb.cmd

ise-clean xst-clean:
	-rm -rf xst *.srp xstmods *.twr *.pad _impact* coregen.log \
	tmp.xst *.ngc __projnav* *.stx *.lso *.dhp automake.log \
	$(TOP).prj  $(TOP)_vhdl.prj  *.bit *.bgn *.bld \
	*.cmd_log *.ll *.mrp *.msk *.ncd *.ngd *.syr *.xpi *.csv \
	*pad.txt *.ngm *.lst *.drc *.par *.pcf *.ngo *.mcs *.prm \
	*.sig *.rba *.rbb *.rbd *.rbt *.msd _ngo _impact* stdout.log \
	ngd2vhdl.log _xmsgs tmp.txt $(TOP).unroutes $(TOP)_usage.xml *.cfi \
	$(TOP).ise* $(TOP).npl* xlnx_auto_0* *.xrpt *.ptwx $(TOP)_xdb \
	$(TOP)_summary.html $(TOP).restore $(TOP).ntrc_log $(TOP).twx \
	$(TOP)_map.map $(TOP).ngr $(TOP).xise $(TOP).gise \
	device_usage_statistics.html* __*.lock $(TOP)_files.prj \
	*.xwbt *webtalk* par_usage_statistics.html fuse.log fuse.xmsgs \
	fuseRelaunch.cmd iseconfig isim isim.cmd isim.log testbench_beh.prj \
	version_isim_beh.wdb xilinxsim.ini

UNISIM = $(XILINX)/vhdl/src/unisims
UNISIMFILES = unisim_VPKG.vhd unisim_VCOMP.vhd unisim_VITAL.vhd \
	unisim_virtex5_SMODEL.vhd secureip/MCB.vhd secureip/GTXE1.vhd \
	secureip/GTP_DUAL.vhd secureip/GTPA1_DUAL.vhd secureip/GT11.vhd \
	secureip/GT11CLK.vhd secureip/GT11CLK_MGT.vhd secureip/GT11_CUSTOM.vhd \
	secureip/GT11_DUAL.vhd secureip/GTX_DUAL.vhd secureip/GTHE1_QUAD.vhd
GRUNISIM = $(GRLIB)/lib/tech/unisim/ise
SIMPRIM = $(XILINX)/vhdl/src/simprims

install-gtech:
	@echo GTECH source path: $(SNPS_HOME)/packages/gtech/src; \
	if test -r $(SNPS_HOME)/packages/gtech/src; then \
	  cp $(SNPS_HOME)/packages/gtech/src/*.vhd $(GRLIB)/lib/tech/gtech/simprims; \
        fi

remove-gtech:
	@-rm $(GRLIB)/lib/tech/gtech/simprims/*.vhd

install-unisim:
	@echo UNISIM source path: $(UNISIM); \
	for i in $(UNISIMFILES); do \
	  if test -r $(UNISIM)/$$i; then \
	    cp  $(UNISIM)/$$i  $(GRUNISIM);\
	    echo  installing $$i ;\
	  else \
	    if [ "unisim_VITAL.vhd" = $$i ]; then \
	      if test -r $(UNISIM)/primitive/vhdl_analyze_order; then \
		echo "creating unisim_VITAL.vhd from primitives" ; \
		echo "" >  $(GRUNISIM)/unisim_VITAL.vhd; \
		for j in `cat $(UNISIM)/primitive/vhdl_analyze_order`; do \
		  cat $(UNISIM)/primitive/$$j >> $(GRUNISIM)/unisim_VITAL.vhd; \
		done ; \
	      fi ; \
	    fi ; \
	  fi ; \
	done; \
	if (test -r $(GRUNISIM)/unisim_VITAL.vhd); then \
	  cat $(GRUNISIM)/unisim_VITAL.vhd | sed -e s/'SIM_COLLISION_CHECK : string := "ALL"'/'SIM_COLLISION_CHECK : string := "GENERATE_X_ONLY"'/ \
	   > $(GRUNISIM)/unisim_vitalx.vhd;\
	   cp $(GRUNISIM)/unisim_vitalx.vhd $(GRUNISIM)/unisim_VITAL.vhd;\
	   rm $(GRUNISIM)/unisim_vitalx.vhd;\
	  echo  patching unisim_VITAL.vhd ;\
	fi

install-secureip: install-unisim
	@if (test -r $(XILINX)/secureip/mti/mcb_mti); then \
	  echo  installing $(XILINX)/secureip ;\
	  cp  $(XILINX)/secureip/mti/mcb_mti/*.vp  $(GRLIB)/lib/tech/secureip/ise;\
	fi

remove-secureip uninstall-secureip: 
	@make uninstall-unisim

remove-unisim uninstall-unisim:
	@-rm $(GRLIB)/lib/tech/secureip/ise/*.vp
	@-rm $(GRLIB)/lib/tech/unisim/ise/*.vhd; \
	cp $(GRLIB)/lib/tech/unisim/gr/*.vhd $(GRLIB)/lib/tech/unisim/ise/

install-simprim:
	@if (test -r $(SIMPRIM)/simprim_Vpackage.vhd); then \
	  cp  $(SIMPRIM)/simprim_Vpackage.vhd  $(GRLIB)/lib/tech/unisim/ise/simprim_vpackage.vhd;\
	  echo  installing $(XILINX)/vhdl/src/unisims/simprim_Vpackage.vhd ;\
	fi ; \
	if (test -r $(XILINX)/vhdl/src/unisims/simprim_Vcomponents.vhd); then \
	  cp  $(XILINX)/vhdl/src/unisims/simprim_Vcomponents.vhd  $(GRLIB)/lib/tech/unisim/ise/simprim_vcomponents.vhd;\
	  echo  installing $(XILINX)/vhdl/src/unisims/simprim_Vcomponents.vhd ;\
	fi ; \
	if (test -r $(XILINX)/vhdl/src/simprims/unisim_VITAL.vhd); then \
	  cat  $(XILINX)/vhdl/src/unisims/unisim_VITAL.vhd  \
	   | sed -e s/'SIM_COLLISION_CHECK : string := "ALL"'/'SIM_COLLISION_CHECK : string := "GENERATE_X_ONLY"'/ \
	   > $(GRLIB)/lib/tech/unisim/ise/unisim_vital.vhd;\
	  echo  installing $(XILINX)/vhdl/src/unisims/unisim_VITAL.vhd ;\
	fi ;\
	if (test -r $(XILINX)/vhdl/src/unisims/unisim_virtex5_SMODEL.vhd); then \
	if (test -r $(XILINX)/vhdl/src/unisims/simprim_VITAL.vhd); then \
	  cp  $(XILINX)/vhdl/src/unisims/simprim_VITAL.vhd  $(GRLIB)/lib/tech/unisim/ise/simprim_vital.vhd;\
	  echo  installing $(XILINX)/vhdl/src/unisims/simprim_VITAL.vhd ;\
	fi ; \


#########   Altera Quartus targets   ############

quartus-vqm:
	-@case $(TECHNOLOGY) in \
	CYCLONEII) \
		cp  $(GRLIB)/netlists/altera/cyclone2/*.vqm . ;;\
	CYCLONEIII) \
		cp  $(GRLIB)/netlists/altera/cyclone3/*.vqm . ;;\
	CYCLONEIV) \
		cp  $(GRLIB)/netlists/altera/cyclone3/*.vqm . ;;\
	STRATIXIII) \
		cp  $(GRLIB)/netlists/altera/stratix3/*.vqm . ;;\
	STRATIXII) \
		cp  $(GRLIB)/netlists/altera/stratix2/*.vqm . ;;\
	esac

quartus: quartus-vqm
	make quartus-map quartus-route

quartus-synp:  $(TOP)_synplify.prj synplify/$(TOP).edf quartus-vqm
	@-cp synplify/*.hex .
	$(QUARTUS_MAP) --import_settings_files=on  --export_settings_files=off $(TOP)_synplify -c $(TOP)_synplify
	$(QUARTUS_CDB) --merge $(TOP)_synplify
	$(QUARTUS_FIT) --import_settings_files=off --export_settings_files=off $(TOP)_synplify -c $(TOP)_synplify
	$(QUARTUS_ASM) --import_settings_files=off --export_settings_files=off $(TOP)_synplify -c $(TOP)_synplify
	$(QUARTUS_STA) $(TOP)_synplify 

quartus-launch: $(TOP).qsf quartus-vqm
	quartus  $(TOP).qpf

quartus-launch-synp:  $(TOP)_synplify.prj synplify/$(TOP).edf quartus-vqm
	quartus $(TOP)_synplify.qpf

quartus-map: $(TOP).qsf quartus-vqm
	$(QUARTUS_MAP) --import_settings_files=on  --export_settings_files=off $(TOP) -c $(TOP)

quartus-route: $(TOP).qsf
	$(QUARTUS_CDB) --merge $(TOP)
	$(QUARTUS_FIT) --import_settings_files=off --export_settings_files=off $(TOP) -c $(TOP)
	$(QUARTUS_ASM) --import_settings_files=off --export_settings_files=off $(TOP) -c $(TOP)
	$(QUARTUS_STA) $(TOP)

quartus-prog-fpga:
	$(QUARTUS_PGM) -c $(ALTCABLE) -m JTAG -o p\;$(TOP).sof

quartus-prog-fpga-ref:
	cp bitfiles/$(TOP).sof $(TOP)_ref.sof
	$(QUARTUS_PGM) -c $(ALTCABLE) -m JTAG -o p\;$(TOP)_ref.sof

quartus-srec:
	$(QUARTUS_PGM)

quartus-clean:
	-rm -rf db *.syr *.qws automake.log dumpdata.txt \
	*.rpt *.done *.eqn *.pof *.summary *.ttf *.pin *.sof \
	*.jam *.jbc cmp_state.ini simulation undo_redo.txt *.vqm *.qdf \
	*.csf *.psf *.quartus *.smsg .undefinedlib .jaguarc .unorderedFilePath \
	incremental_db PLLJ_PLLSPE_INFO.txt *.jdi

########   Synplify targets   ########################

synplify synplify-map: $(TOP)_synplify.prj synplify/$(TOP).edf

synplify-launch: $(TOP)_synplify.prj
	$(SYNPLIFY) $(TOP)_synplify.prj&
	-@mkdir synplify>& tmp.err; touch synplify/dummy.mif
	-@mv synplify/*.mif .

synplify/$(TOP).edf: $(VHDLSYNFILES) $(VERILOGSYNFILES)
	$(SYNPLIFY) -batch $(TOP)_synplify.prj
	@touch synplify/dummy.mif
	-@mv synplify/*.mif .

$(TOP)_synplify.prj: compile.synp
	@echo source compile.synp > $(TOP)_synplify.prj
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	    if test -r $$i; then \
		echo add_file "-vhdl -lib work" $$i >> $(TOP)_synplify.prj; \
	    fi; \
	done
	@if test -r $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/edifsyn.txt; then \
	  for q in `cat $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/edifsyn.txt`; do \
	    if test -r $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/$$q; then \
	      echo add_file -edif $(GRLIB)/netlists/xilinx/$(NETLISTTECH)/$$q >> $(TOP)_synplify.prj ; \
	    fi; \
	  done; \
	fi
#	@for i in $(VERILOGSYNFILES); do echo add_file "-verilog -lib work" $ii >> $(TOP)_synplify.prj; done
	@for i in $(SDCFILE); do echo add_file "-constraint " $$i >> $(TOP)_synplify.prj; done
	@cat $(GRLIB)/bin/synplify.prj | sed -e s/TOP/$(TOP)/ \
	-e s/TECHNOLOGY/$(TECHNOLOGY)/ \
	-e s/PART/$(PART)/ -e s/SPEED/$(SPEED)/ -e s/SYNFREQ/$(SYNFREQ)/ >> $(TOP)_synplify.prj
ifneq ("$(PACKAGE)","")
	@echo set_option -package $(PACKAGE) >> $(TOP)_synplify.prj
endif
ifneq ("$(SYNPVLOGDEFS)","")
	@echo set_option -hdl_define -set \"$(SYNPVLOGDEFS)\" >> $(TOP)_synplify.prj
endif
ifneq ("$(SYNPVLOGINC)","")
	@echo set_option -include_path \"$(SYNPVLOGINC)\" >> $(TOP)_synplify.prj
endif
	@echo $(SYNPOPT) >> $(TOP)_synplify.prj
	@echo impl -active \"synplify\" >> $(TOP)_synplify.prj
	@echo  $(TOP)_synplify.prj

synplify-clean:
	-rm -rf synplify *.prd stdout.log *.mif syntmp.* synplify_* \
	$(TOP).map $(TOP)_summary.xml

########   Precision targets   ########################

precision precision-map: $(TOP)_precision.tcl $(TOP).psp precision/$(TOP).edf

$(TOP).psp: $(TOP)_precision.tcl
	$(PRECISION) -shell -file $(TOP)_precision.tcl

precision-launch: $(TOP).psp
	$(PRECISION)  -project $(TOP).psp

precision/$(TOP).edf: $(TOP)_precision.tcl  $(VHDLSYNFILES) $(VERILOGSYNFILES)
	$(PRECISION) -shell -file $(TOP)_precrun.tcl

precision-clean:
	-rm -rf *.psp stdout.log prec.log  $(TOP)_prec* precision* $(TOP)_temp*

#########   Actel Libero targets    ############################

libero-launch : $(TOP)_libero.prj
	cp *.srec simulation
	$(LIBERO) $(TOP)_libero.prj

#########   Actel Designer targets    ############################

actel: $(TOP)_synplify.prj synplify/$(TOP).edf $(TOP)_designer.tcl
	-mkdir ./actel
	$(DESIGNER) script:$(TOP)_designer.tcl

actel-launch actel-launch-synp: $(TOP)_synplify.prj synplify/$(TOP).edf $(TOP)_designer.tcl $(TOP).adb
	$(DESIGNER) $(TOP).adb &

$(TOP).adb:
	$(DESIGNER) script:$(TOP)_designer_act.tcl

$(TOP)_designer.tcl:
	@echo "new_design -name \""$(TOP)\"" -family \""$(TECHNOLOGY)\"" " > $(TOP)_designer.tcl
ifeq ("$(DESIGNER_RADEXP)","")
	@echo "set_device -die \""$(PART)\"" -package \""$(DESIGNER_PINS) $(DESIGNER_PACKAGE)\"" -speed \""$(SPEED)\"" -voltage \"1.5\" -iostd \"LVTTL\" -jtag \"yes\" -probe \"yes\" -trst \"yes\" -temprange \""$(DESIGNER_VOLTAGE)\"" -voltrange \""$(DESIGNER_VOLTAGE)\"" " >> $(TOP)_designer.tcl
else
	@echo "set_device -die \""$(PART)\"" -package \""$(DESIGNER_PINS) $(DESIGNER_PACKAGE)\"" -speed \""$(SPEED)\"" -voltage \"1.5\" -iostd \"LVTTL\" -jtag \"yes\" -probe \"yes\" -trst \"yes\" -temprange \""$(DESIGNER_VOLTAGE)\"" -voltrange \""$(DESIGNER_VOLTAGE)\"" -radexp \""$(DESIGNER_RADEXP)\"" " >> $(TOP)_designer.tcl
endif
	@echo "if {[file exist "$(TOP).pdc"]} {" >> $(TOP)_designer.tcl
	@echo "import_source -format \"edif\" -edif_flavor \"GENERIC\" " -merge_physical \"no\" -merge_timing \"no\"" {"synplify/$(TOP)".edf"} -format \"pdc\" -abort_on_error \"no\" {"$(TOP).pdc"} >> $(TOP)_designer.tcl
	@echo "} else {" >> $(TOP)_designer.tcl
	@echo "import_source -format \"edif\" -edif_flavor \"GENERIC\" " -merge_physical \"no\" -merge_timing \"no\"" {"synplify/$(TOP)".edf"} >> $(TOP)_designer.tcl
	@echo "}" >> $(TOP)_designer.tcl
	@cp $(TOP)_designer.tcl $(TOP)_designer_act.tcl
	@echo "save_design {"$(TOP).adb"}" >> $(TOP)_designer_act.tcl
	@echo "compile -combine_register 1" >> $(TOP)_designer.tcl
	@echo "if {[file exist "$(PDC)"]} {" >> $(TOP)_designer.tcl
	@echo "   import_aux -format \"pdc\" -abort_on_error \"no\" {"$(PDC)"}" >> $(TOP)_designer.tcl
	@echo "   pin_commit" >> $(TOP)_designer.tcl
	@echo "} else {" >> $(TOP)_designer.tcl
	@echo "   puts \"WARNING: No PDC file imported.\"" >> $(TOP)_designer.tcl
	@echo "}" >> $(TOP)_designer.tcl
ifeq ("$(PDC_EXTRA)","")
else
	@echo "if {[file exist "$(PDC_EXTRA)"]} {" >> $(TOP)_designer.tcl
	@echo "   import_aux -format \"pdc\" -abort_on_error \"no\" {"$(PDC_EXTRA)"}" >> $(TOP)_designer.tcl
	@echo "   pin_commit" >> $(TOP)_designer.tcl
	@echo "} else {" >> $(TOP)_designer.tcl
	@echo "   puts \"WARNING: No PDC_EXTRA file imported.\"" >> $(TOP)_designer.tcl
	@echo "}" >> $(TOP)_designer.tcl
endif

	@echo "if {[file exist "$(SDC)"]} {" >> $(TOP)_designer.tcl
	@echo "   import_aux -format \"sdc\" -merge_timing \"no\" {"$(SDC)"}" >> $(TOP)_designer.tcl
	@echo "} else {" >> $(TOP)_designer.tcl
	@echo "   puts \"WARNING: No SDC file imported.\"" >> $(TOP)_designer.tcl
	@echo "}" >> $(TOP)_designer.tcl
ifeq ("$(SDC_EXTRA)","")
else
	@echo "if {[file exist "$(SDC_EXTRA)"]} {" >> $(TOP)_designer.tcl
	@echo "   import_aux -format \"sdc\" -merge_timing \"yes\" {"$(SDC_EXTRA)"}" >> $(TOP)_designer.tcl
	@echo "} else {" >> $(TOP)_designer.tcl
	@echo "   puts \"WARNING: No SDC_EXTRA file imported.\"" >> $(TOP)_designer.tcl
	@echo "}" >> $(TOP)_designer.tcl
endif
	@echo "save_design {"$(TOP).adb"}" >> $(TOP)_designer.tcl
	@echo "report -type status {./actel/report_status_pre.log}" >> $(TOP)_designer.tcl
ifeq ("$(TECHNOLOGY)","AXCELERATOR")
	@echo "layout -effort_level 5 -timing_driven -incremental \"OFF\"" >> $(TOP)_designer.tcl
else
	@echo "layout -timing_driven -incremental \"OFF\"" >> $(TOP)_designer.tcl
endif
	@echo "save_design {"$(TOP).adb"}" >> $(TOP)_designer.tcl
	@echo "backannotate -dir {./actel} -name \"$(TOP)\" -format \"SDF\" -language \"VHDL93\" -netlist"  >> $(TOP)_designer.tcl
	@echo "report -type \"timer\" -analysis \"max\" -print_summary \"yes\" -use_slack_threshold \"no\" -print_paths \"yes\" -max_paths 100 -max_expanded_paths 5 -include_user_sets \"yes\" -include_pin_to_pin \"yes\" -select_clock_domains \"no\"  {./actel/report_timer_max.txt}" >> $(TOP)_designer.tcl
	@echo "report -type \"timer\" -analysis \"min\" -print_summary \"yes\" -use_slack_threshold \"no\" -print_paths \"yes\" -max_paths 100 -max_expanded_paths 5 -include_user_sets \"yes\" -include_pin_to_pin \"yes\" -select_clock_domains \"no\"  {./actel/report_timer_min.txt}" >> $(TOP)_designer.tcl
	@echo "report -type \"pin\" -listby \"name\" {./actel/report_pin_name.log}" >> $(TOP)_designer.tcl
	@echo "report -type \"pin\" -listby \"number\" {./actel/report_pin_number.log}" >> $(TOP)_designer.tcl
	@echo "report -type \"datasheet\" {./actel/report_datasheet.txt}" >> $(TOP)_designer.tcl
ifeq ("$(TECHNOLOGY)","AXCELERATOR")
	@echo "export -format \"AFM-APS2\" -trstb_pullup \"yes\" -global_set_fuse \"reset\" -axprg_set_algo \"UMA\" {./actel/$(TOP).afm}"  >> $(TOP)_designer.tcl
	@echo "export -format \"prb\" {./actel/$(TOP).prb}"  >> $(TOP)_designer.tcl
else
	@echo "export -format \"pdb\" -feature \"prog_fpga\" -io_state \"Tri-State\" {./actel/$(TOP).pdb}"  >> $(TOP)_designer.tcl
endif
	@echo "export -format log -diagnostic {./actel/report_log.log}" >> $(TOP)_designer.tcl
	@echo "report -type status {./actel/report_status_post.log}" >> $(TOP)_designer.tcl
	@echo "save_design {"$(TOP).adb"}" >> $(TOP)_designer.tcl

actel-clean:
	-rm -rf *.adb report*.log ./actel hdl constraint \
	actgen constraint designer package phy_synthesis simulation \
	smartgen stimulus synthesis viewdraw libero x $(TOP)_libero.prj \
	libero_sim_files libero_syn_files coreconsole libero_simlist \
	libero_synlist libero.do component *.pdb *.pdb.depends *.stp \
	*.sdb *_layout.log *.dtf

############  Synopsys DC targets   ########################

dc-launch: $(TOP)_dc.tcl
	-mkdir synopsys
	design_compiler&

dc: $(TOP)_dc.tcl
	-mkdir synopsys
	dc_shell-xg-t -f $(DCSCRIPT)

$(TOP)_dc.tcl: compile.dc
	@cp $(GRLIB)/bin/top.dc $(TOP)_dc.tcl
	@for i in $(VERILOGSYNFILES); do \
	 if test -r $$i; then \
	    echo $(DCVLOG) work $$i >> $(TOP)_dc.tcl; \
	    echo $(FMVLOG) $work $i >> fmref.tcl; \
	 fi; \
	done
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	    echo $(DCVHDL) work $$i >> $(TOP)_dc.tcl; \
	    echo $(FMVHDL) work $$i >> fmref.tcl; \
	 fi; \
	done
	@echo elaborate $(TOP) >> $(TOP)_dc.tcl
	@echo  $(TOP)_dc.tcl

dc-clean:
	-rm -rf synopsys view_command.log command.log dumpdata.txt filenames.log \
	dc.log dwsvf* alib* $(TOP)_dc.tcl fmref.tcl fm_shell_command.log \
	formality*.log formality_svf

############  Cadence RTL Compiler   ########################

rc: $(TOP).rc
	-mkdir rtlc
	rc -files $(RCSCRIPT)

$(TOP).rc: compile.rc
	@cp $(GRLIB)/bin/top.rc $(TOP).rc
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	    echo "read_hdl -vhdl -lib work" $$i >> $(TOP).rc; \
	 fi; \
	done
#	@for i in $(VERILOGSYNFILES); do echo "read_hdl " $$i >> $(TOP).rc; done
	@echo elaborate $(TOP) >> $(TOP).rc
	@echo  $(TOP).rc

rc-clean:
	-rm -rf rtlc rc.log rc.cmd

######## easic targets   ####################
# 
# etools-n2x-init creates a project file
# etools-n2x-launch starts design navigator and loads the current project
#
etools-n2x-init: $(TOP).eprj

$(TOP).eprj: scripts $(TOP)_etools_create.tcl
	$(ETOOLS_N2X_HOME)/bin/designNavigator -no_ui -script $(TOP)_etools_create.tcl

etools-n2x-launch: #$(TOP).eprj
	$(ETOOLS_N2X_HOME)/bin/designNavigator -project $(TOP).eprj

etools-n2x-launch-no_ui: #$(TOP).eprj
	$(ETOOLS_N2X_HOME)/bin/designNavigator -no_ui -project $(TOP).eprj

$(TOP)_etools_create.tcl: compile.etools
	@if test -r $(GRLIB)/bin/etools_create_project; then \
	  cat $(GRLIB)/bin/etools_create_project | sed -e s/TOP/$(TOP)/ \
		-e s/DEVICE/$(DEVICE)/ -e s/PACKAGE/$(PACKAGE)/ \
		 -e s/PNC/$(PNC)/ -e s!SDCFILE!$(SDCFILE)! \
		 -e s/NUM_CPU/$(GRLIB_NHCPU)/ >> $(TOP)_etools_create.tcl; \
	else \
	  echo "eTools project creation not supported" > $(TOP)_etools_create.tcl ; \
	fi;

etools-n2x-clean:
	-rm -rf history.tcl $(TOP).tasks log project.tcl

########## Generation of compile scripts ###############

scripts: compile.dc compile.synp compile.son compile.vsim compile.asim compile.xst compile.ncsim compile.rc \
	$(TOP)_synplify.prj $(TOP)_dc.tcl $(TOP).rc $(TOP).xst $(TOP).npl $(TOP)_ise.tcl $(TOP).qsf \
	$(TOP)_designer.tcl $(TOP)_libero.prj compile.etools $(TOP)_etools_create.tcl $(TOP).ldf

verilog.txt $(TOP)_libero.prj compile.dc compile.synp compile.son compile.vsim compile.asim compile.xst \
compile.ncsim compile.rc compile.ghdl $(TOP).npl $(TOP)_ise.tcl $(TOP).qsf $(TOP)_precision.tcl $(TOP).xise \
compile.etools $(TOP).ldf :
	@touch libs.txt; rm libs.txt;
	@touch tmp.son; rm tmp.son;
	@cp $(GRLIB)/bin/cds.lib cds.lib; touch hdl.var;
	@for i in vsim synp xst dc ncsim ghdl rc son; do \
	    touch compile.$$i; rm compile.$$i ; \
	done
	@printf "\tmkdir xncsim\n" > compile.ncsim
	@echo sh mkdir synopsys > compile.dc
	@echo "# Formality script to read reference design" > fmref.tcl
	@echo set vhdlList     { > easic.vhdl
	@echo set verilogList  { > easic.vlog
	@echo vlib modelsim > libs.do
	@echo ""  > alibs.do
	@printf "\tmkdir gnu\n" > compile.ghdl
	@echo set_attribute input_pragma_keyword \"cadence synopsys get2chip g2c fast ambit pragma\" > compile.rc
	@echo "[Library]" > modelsim.ini;
	@echo "" > tmp.mpf;
	@echo "" > verilog.txt;
	@-mkdir lattice
	@echo \<\?xml version=\"1.0\" encoding=\"UTF-8\"\?\> > $(TOP).ldf
	@echo \<BaliProject version=\"1.3\" title=\"$(TOP)\" device=\"$(PART)$(SPEED)$(PACKAGE)\" default_implementation=\"$(TOP)\"\> >> $(TOP).ldf
	@echo "    "\<Options\/\> >> $(TOP).ldf
	@echo "    "\<Implementation title=\"$(TOP)\" dir=\"lattice\" description=\"$(TOP)\" default_strategy=\"Timing\"\> >> $(TOP).ldf
	@echo "        "\<Options\/\> >> $(TOP).ldf
	@echo [Device] > $(TOP).lct
	@echo Family = $(ISPLIB)\; >> $(TOP).lct
	@echo PartNumber = $(PART)$(SPEED)$(PACKAGE)\; >> $(TOP).lct
	@echo Package = $(ISPPACKAGE)\; >> $(TOP).lct
	@echo PartType = $(PART)\; >> $(TOP).lct
	@echo Speed = $(SPEED)\; >> $(TOP).lct
	@echo Operating_condition = COM\; >> $(TOP).lct
	@echo Status = Production\; >> $(TOP).lct
	@echo JDF B > $(TOP).syn
	@echo PROJECT $(TOP) >> $(TOP).syn
	@echo DESIGN $(TOP) Normal >> $(TOP).syn
	@echo DEVKIT $(PART)$(SPEED)$(PACKAGE) >> $(TOP).syn
	@echo ENTRY EDIF >> $(TOP).syn
	@echo MODULE ./synplify/$(TOP).edf >> $(TOP).syn
	@echo MODSTYLE $(TOP) Normal >> $(TOP).syn
	@echo JDF G > $(TOP).npl
	@echo PROJECT $(TOP) >> $(TOP).npl
	@echo project new $(TOP).ise > $(TOP)_ise.tcl
	@echo DESIGN $(TOP) >> $(TOP).npl
	@echo DEVFAM $(TECHNOLOGY) >> $(TOP).npl
	@echo project set family \"$(ISETECH)\" >> $(TOP)_ise.tcl
	@echo DEVICE $(PART) >> $(TOP).npl
	@echo project set device $(PART) >> $(TOP)_ise.tcl
	@echo DEVSPEED $(SPEED) >> $(TOP).npl
	@echo project set speed $(SPEED) >> $(TOP)_ise.tcl
	@echo DEVPKG $(PACKAGE) >> $(TOP).npl
	@echo project set package $(PACKAGE) >> $(TOP)_ise.tcl
	@cp $(TOP).npl $(TOP)_synplify.npl
	@echo DEVTOPLEVELMODULETYPE HDL >> $(TOP).npl
	@echo DEVTOPLEVELMODULETYPE EDIF >> $(TOP)_synplify.npl
	@cat  $(GRLIB)/bin/def.npl >> $(TOP).npl
	@cat  $(GRLIB)/bin/def.npl >> $(TOP)_synplify.npl
	@touch tmp.npl; rm tmp.npl
	@for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	   echo SOURCE $$i >> tmp.npl; \
	 fi; \
	done; \
	cp  $(GRLIB)/bin/head.xise $(TOP).xise; \
	echo   "  "\<files\> >> $(TOP).xise; \
	echo "    "\<file xil_pn:name=\"$(UCF)\" xil_pn:type=\"FILE_UCF\"\> >>  $(TOP).xise; \
	echo "      "\<association xil_pn:name=\"Implementation\"/\>  >>  $(TOP).xise; \
	echo "    "\</file\>  >>  $(TOP).xise; \
	echo puts \"Adding files to project\" >> $(TOP)_ise.tcl; \
	cp $(GRLIB)/bin/quartus.qsf_head $(TOP).qsf; \
	cp $(GRLIB)/bin/quartus.qsf_head $(TOP)_synplify.qsf; \
	echo "set_global_assignment -name VQM_FILE" "synplify/$(TOP).edf" >> $(TOP)_synplify.qsf; \
	if test -r "$(QSF)"; then cat $(QSF) >> $(TOP)_synplify.qsf; fi; \
	cp $(GRLIB)/bin/quartus.qpf $(TOP).qpf; \
	cp $(TOP).qpf $(TOP)_synplify.qpf; \
	echo PROJECT_REVISION = $(TOP) >> $(TOP).qpf; \
	echo PROJECT_REVISION = $(TOP)_synplify >> $(TOP)_synplify.qpf; \
	echo KEY LIBERO \"9.1\" > $(TOP)_libero.prj; \
	echo KEY CAPTURE \"9.1.1.5\" >> $(TOP)_libero.prj; \
	echo KEY HDLTechnology \"VHDL\" >> $(TOP)_libero.prj; \
	echo KEY VendorTechnology_Family \"$(TECHNOLOGY)\" >> $(TOP)_libero.prj; \
	echo KEY VendorTechnology_Die \"$(LIBERO_DIE)\" >> $(TOP)_libero.prj; \
	echo KEY VendorTechnology_Package \"$(LIBERO_PACKAGE)\" >> $(TOP)_libero.prj; \
	echo KEY ProjectLocation \"\.\" >> $(TOP)_libero.prj; \
	echo KEY SimulationType \"VHDL\" >> $(TOP)_libero.prj; \
	echo KEY Vendor \"Actel\" >> $(TOP)_libero.prj; \
	echo KEY ActiveRoot \"$(TOP)\"	 >> $(TOP)_libero.prj; \
	echo LIST REVISIONS >> $(TOP)_libero.prj; \
	echo VALUE=\"Impl1\",NUM=1 >> $(TOP)_libero.prj; \
	echo CURREV=1 >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST FileManager > libero_syn_files ; \
	echo LIST ExcludePackageForSynthesis > libero_sim_files; \
	echo LIST $(TOP) >> libero_sim_files; \
	echo LIST \"ideSYNTHESIS\" > libero_synlist; \
	echo USE_LIST=TRUE >> libero_synlist; \
	echo FILELIST >> libero_synlist; \
	echo LIST \"ideSIMULATION\" >> libero_simlist; \
	echo USE_LIST=TRUE >> libero_simlist; \
	echo FILELIST >> libero_simlist; \
	cat $(GRLIB)/bin/sonata1.sws > sonata.sws; \
	echo "open_project ./$(TOP).psp"> $(TOP)_precrun.tcl; \
	echo compile >> $(TOP)_precrun.tcl; echo synthesize >> $(TOP)_precrun.tcl; \
	echo save_impl >> $(TOP)_precrun.tcl; \
	echo "new_project -name $(TOP) -folder . -createimpl_name precision"> $(TOP)_precision.tcl; \
	echo "setup_design -manufacturer $(MANUFACTURER) -family $(MGCTECHNOLOGY) -part $(MGCPART) -package $(MGCPACKAGE) -speed $(SPEED)" >> $(TOP)_precision.tcl; \
	echo "set_input_dir ." >> $(TOP)_precision.tcl ;\
	echo "" > $(TOP)_files.prj; \
	echo "Scanning libraries" ;
	@if (test -r $(EXTRALIBS)/libs.txt); then extralib=$(EXTRALIBS)/libs.txt; else \
	extralib=$(GRLIB)/bin/libs.txt; fi; \
	ppath="gnu"; nfiles=0; xfiles=8;\
	easic_lib=""; \
	easic_lib_prev="previous"; \
	for j in grlib $(XTECHLIBS) `cat $(GRLIB)/lib/libs.txt  $(GRLIB)/lib/*/libs.txt $$extralib` $(LIBADD) work ; do \
	  bn=`basename $$j` ; \
          ppath="$$ppath -Pgnu/$$bn"; \
	  k=$(GRLIB)/lib/$$j; \
	  if test -r $$k; then xxx=0; else k=$(EXTRALIBS)/$$j; fi;\
	  if (test $$bn = "techmap"); then tdirs="$(TECHLIBS) maps"; \
	  else tdirs="$(DIRADD)"; fi; \
	  case $$bn in $(XLIBSKIP) )\
	    ;; \
	  *) \
	    if (test -r $$k/dirs.txt); then \
	        echo DEFINE $$bn xncsim/$$bn "" >> cds.lib; \
	        printf "\tmkdir gnu/$$bn\n" >> compile.ghdl; \
                echo -n $$bn "" >> libs.txt; echo $$bn = modelsim/$$bn >> modelsim.ini; \
	        echo vlib modelsim/$$bn "" >> libs.do; \
	        echo alib $$bn $$bn.lib "" >> alibs.do; \
	      	printf "\tmkdir xncsim/$$bn\n" >> compile.ncsim; \
	  	if (test $$bn != "dware"); then \
	          echo sh mkdir synopsys/$$bn "" >> compile.dc; \
	          echo define_design_lib $$bn -path synopsys/$$bn "" >> compile.dc; \
		else \
	          echo define_design_lib $$bn -path $(SNPS_HOME)/packages/dware/lib/DWARE "" >> compile.dc; \
		fi ; \
	        case $$bn in \
		work) \
	          echo " "sonata "=" sonata/sonata.sym >> sonata.sws; \
		  set bn = "sonata"; \
	    	  echo "[library]" >> tmp.son; \
	    	  echo name = sonata >> tmp.son; \
	    	  echo toplevel = $(SIMTOP) >> tmp.son; \
	    	  echo "  [options]" >>  tmp.son; \
	    	  echo "   [booloption]" >>  tmp.son; \
	    	  echo "    name   = -autoorder" >>  tmp.son; \
	    	  echo "    value  = 0" >>  tmp.son; \
	    	  echo "    invert = 0" >>  tmp.son; \
	    	  echo "   []" >>  tmp.son; \
	    	  echo "  []" >>  tmp.son;; \
	        *) \
	          echo " "$$bn "=" sonata/$$bn.sym >> sonata.sws; \
	    	  echo "[library]" >> tmp.son; \
	    	  echo name = $$bn >> tmp.son; \
	    	  echo "  [options]" >>  tmp.son; \
	    	  echo "   [booloption]" >>  tmp.son; \
	    	  echo "    name   = -autoorder" >>  tmp.son; \
	    	  echo "    value  = 0" >>  tmp.son; \
	    	  echo "    invert = 0" >>  tmp.son; \
	    	  echo "   []" >>  tmp.son; \
	    	  echo "  []" >>  tmp.son;; \
	        esac; \
		case $$bn in $(XSTLIBSKIP) )\
		  uu=0;; \
		*) \
	          echo SUBLIB $$bn VhdlLibrary vhdl >> tmp.npl; \
	          echo lib_vhdl new $$bn >> $(TOP)_ise.tcl;; \
	        esac; \
	        echo -n "  "$$bn":"; \
	      for l in `cat $$k/dirs.txt` $$tdirs ; do \
	        case $$l in $(XDIRSKIP) )\
		  ;; \
		*) \
		  if test -r $$k/$$l; then \
		    echo -n " "$$l; \
		  fi; \
	    	  for i in vlogsyn vhdlsyn vlogsim vhdlsim ; do \
		   m=$$k/$$l/$$i; \
		   if test -r $$m.txt; then \
		    for q in `cat $$m.txt` $(FILEADD) ; do \
		      f=$$k/$$l/$$q; fx=$$l/$$q; \
	              if (test $$bn = "grlib") && (test $$l = "stdlib") && (test $$q = "config.vhd"); then \
			if (test $(GRLIB_CONFIG) != "dummy"); then f=$(GRLIB_CONFIG); grcfg=$$f; fi ;\
		      fi; \
	              case $$q in $(XFILESKIP) )\
		        ;; \
		      *) \
		       if test -r $$f; then \
			case $$i in \
			vhdlsyn) \
		           echo Project_File_$$nfiles = $$f >> tmp.mpf; \
		           echo Project_File_P_$$nfiles = vhdl_novitalcheck 0 file_type VHDL group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0 vhdl_synth 0 folder {Top Level} last_compile 0 vhdl_disableopt 0 vhdl_vital 0 vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0 vhdl_showsource 1 vhdl_warn3 1 vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0 compile_to $$bn compile_order $$nfiles dont_compile 0 cover_stmt 1 vhdl_use93 93 >> tmp.mpf; \
			   nfiles=`expr $$nfiles + 1`; \
                           printf "\t$(VCOM) $(VHDLOPT) -work $$bn $$f\n" >> compile.vsim; \
                           printf "\t$(ACOM) $(VHDLOPT) $$bn ../../$$f\n" >> compile.asim; \
                           printf "\t$(NCVHDL) $(VHDLOPT) $$bn $$f\n" >> compile.ncsim; \
		           printf "\t$(GHDL) $(VHDLOPT) --workdir=gnu/$$bn --work=$$bn -P$$ppath $$f\n" >> compile.ghdl; \
			   case $$bn in $(XDCLIBSKIP) ) ;; *) \
			    case $$l in $(XDCDIRSKIP) ) ;; *) \
			      case $$q in $(DCSKIP) ) ;; *) \
		                echo $(DCVHDL) $$bn $(VHDLOPT) $$f >> compile.dc; \
		                echo $(FMVHDL) $$bn $(FMVHDLOPT) $$f >> fmref.tcl; \
				if [ $$easic_lib_prev != $$bn ]; then \
				  if [ $$easic_lib_prev != "previous" ]; then \
				    echo "{$$easic_lib_prev $$easic_lib}" >> easic.vhdl; \
				  fi; \
				  easic_lib=""; \
				  easic_lib_prev=$$bn; \
				fi; \
				easic_lib="$$easic_lib $$f"; \
		                echo $(RTLCVHDL) $(VHDLOPT) $$bn $$f >> compile.rc; \
			      esac; \
			    esac; \
			   esac; \
			   case $$bn in $(XSYNPLIBSKIP) )\
				uu=0;; \
			   *) \
			    case $$l in $(XSYNPDIRSKIP) ) ;; *) \
			      case $$q in $(SYNPSKIP) ) ;; *) \
		                echo $(SYNPVHDL) $(VHDLOPT) $$bn $$f >> compile.synp; \
				echo "        "\<Source name=\"$$f\" type=\"VHDL\" type_short=\"VHDL\"\> >> $(TOP).ldf; \
				echo "            "\<Options lib=\"$$bn\"\/\> >> $(TOP).ldf; \
				echo "        "\<\/Source\> >> $(TOP).ldf;; \
			      esac; \
			    esac; \
			   esac; \
	                   if (test $$bn = "work"); then \
		             printf "\t$(VHDLP) $(VHDLOPT) sonata $$f\n" >> compile.son; \
	  		   else \
		             printf "\t$(VHDLP) $(VHDLOPT) $$bn $$f\n" >> compile.son; \
			   fi; \
			   echo " [file]" >> tmp.son; \
			   echo "  name" = $$f >> tmp.son; \
			   echo " []" >> tmp.son; \
			   case $$bn in $(LIBEROLIBSKIP) )\
				uu=0;; \
			   *) \
			    case $$l in $(LIBERODIRSKIP) ) ;; *) \
			      case $$q in $(LIBEROSKIP) ) ;; *) \
	    		        echo VALUE \"\<project\>/$$f,hdl\" >> libero_syn_files; \
	    		        echo VALUE \"\<project\>/$$f,hdl\" >> libero_synlist; \
	    		        echo VALUE \"\<project\>/$$f,hdl\" >> libero_simlist; \
	  		        echo STATE=\"utd\" >> libero_syn_files; \
	  		        echo TIME=\"1310766027\" >> libero_syn_files; \
	  		        echo LIBRARY=\"$$bn\" >> libero_syn_files; \
	  		        echo ENDFILE >> libero_syn_files;; \
			      esac; \
			    esac; \
			   esac; \
			   case $$bn in $(XSTLIBSKIP) )\
				uu=0;; \
			   *) \
			     case $$l in $(XSTDIRSKIP) )\
				uu=0;; \
			     *) \
			       case $$q in $(XSTSKIP) ) ;; *) \
		                 echo LIBFILE $$f $$bn vhdl >> tmp.npl; \
		                 echo xfile add \"$$f\" -lib_vhdl $$bn >> $(TOP)_ise.tcl; \
		                 echo puts \"$$f\" >> $(TOP)_ise.tcl; \
				 echo "    "\<file xil_pn:name=\"$$f\" xil_pn:type=\"FILE_VHDL\"\> >>  $(TOP).xise; \
				 echo "      "\<association xil_pn:name=\"BehavioralSimulation\"/\>  >>  $(TOP).xise; \
				 echo "      "\<association xil_pn:name=\"Implementation\"/\>  >>  $(TOP).xise; \
				 echo "      "\<library xil_pn:name=\"$$bn\"/\>  >>  $(TOP).xise; \
				 echo "    "\</file\>  >>  $(TOP).xise; \
		                 echo $(XSTVHDL) $(VHDLOPT) $$bn -ifn $$f >> compile.xst; \
		                 echo vhdl $$bn  $$f >> $(TOP)_files.prj; \
			         xfiles=`expr $$xfiles + 1`;; \
			       esac; \
			     esac; \
			   esac; \
			   case $$bn in $(QUARTUSLIBSKIP) )\
				uu=0;; \
			   *) \
			     case $$l in $(QDIRSKIP) )\
				uu=0;; \
			     *) \
			      case $$q in $(QUARTUSSKIP) ) ;; *) \
		               echo set_global_assignment -name VHDL_FILE $$f -library $$bn >> $(TOP).qsf;; \
			      esac; \
			    esac; \
			   esac; \
			   case $$bn in $(PRECLIBSKIP) )\
				uu=0;; \
			   *) \
			     case $$ln in $(PRECDIRSKIP) )\
				uu=0;; \
			     *) \
			      case $$q in $(PRECSKIP) ) ;; *) \
		               echo add_input_file -format VHDL -work $$bn  $$f >> $(TOP)_precision.tcl;; \
			      esac; \
			    esac; \
			   esac;; \
			vlogsyn) \
		           echo Project_File_$$nfiles = $$f >> tmp.mpf; \
		           echo Project_File_P_$$nfiles = vlog_protect 0 file_type Verilog group_id 0 vlog_1995compat 0 vlog_nodebug 0 folder {Top Level} vlog_noload 0 last_compile 0 vlog_disableopt 0 vlog_hazard 0 vlog_showsource 0 ood 1 compile_to $$bn vlog_upper 0 vlog_options {} compile_order $$nfiles dont_compile 0 >> tmp.mpf; \
			   nfiles=`expr $$nfiles + 1`; \
		           printf "\t$(VLOG) -work $$bn +incdir+$$k/$$l $$f\n" >> compile.vsim; \
		           printf "\t$(ALOG) $$bn ../../$$f\n" >> compile.asim; \
		           printf "\t$(NCVLOG) $$bn -INCDIR $$k/$$l $$f\n" >> compile.ncsim; \
		           echo $(XSTVLOG) $$bn -ifn $$f >> compile.xst; \
		           echo verilog $$bn  $$f >> $(TOP)_files.prj; \
			   case $$bn in $(LIBEROLIBSKIP) )\
				uu=0;; \
			   *) \
			    case $$q in $(LIBEROSKIP) ) ;; *) \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_syn_files; \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_synlist; \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_simlist; \
	  		      echo STATE=\"utd\" >> libero_syn_files; \
	  		      echo TIME=\"1310766027\" >> libero_syn_files; \
	  		      echo LIBRARY=\"$$bn\" >> libero_syn_files; \
	  		      echo ENDFILE >> libero_syn_files;; \
			    esac; \
			   esac; \
		           echo $$f >> verilog.txt; \
		           echo $(DCVLOG) $$bn $$f >> compile.dc; \
		           echo $(FMVLOG) $$bn $$f >> fmref.tcl; \
		           echo $$f >> easic.vlog; \
		           echo $(RTLCVLOG) $$f >> compile.rc; \
		           echo LIBFILE $$f $$bn verilog >> tmp.npl; \
		           echo xfile add \"$$f\" >> $(TOP)_ise.tcl; \
		           echo puts \"$$f\" >> $(TOP)_ise.tcl; \
		           echo $(SYNPVLOG) $$f >> compile.synp; \
		           echo add_input_file -format VERILOG -work $$bn  $$f >> $(TOP)_precision.tcl; \
		           echo set_global_assignment -name VERILOG_FILE $$f -library $$bn >> $(TOP).qsf;; \
			vhdlsim) \
			   echo " [file]" >> tmp.son; \
			   echo "  name" = $$f >> tmp.son; \
			   echo " []" >> tmp.son; \
			   case $$bn in $(LIBEROLIBSKIP) )\
				uu=0;; \
			   *) \
			    case $$q in $(LIBEROSKIP) ) ;; *) \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_sim_files; \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_syn_files; \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_simlist; \
	  		      echo STATE=\"utd\" >> libero_syn_files; \
	  		      echo TIME=\"1310766027\" >> libero_syn_files; \
	  		      echo LIBRARY=\"$$bn\" >> libero_syn_files; \
	  		      echo ENDFILE >> libero_syn_files;; \
			    esac; \
			   esac; \
		           echo Project_File_$$nfiles = $$f >> tmp.mpf; \
		           echo Project_File_P_$$nfiles = vhdl_novitalcheck 0 file_type VHDL group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0 vhdl_synth 0 folder {Top Level} last_compile 0 vhdl_disableopt 0 vhdl_vital 0 vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0 vhdl_showsource 1 vhdl_warn3 1 vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0 compile_to $$bn compile_order $$nfiles dont_compile 0 cover_stmt 1 vhdl_use93 93 >> tmp.mpf; \
			   nfiles=`expr $$nfiles + 1`; \
		           printf "\t$(VCOM) $(VHDLOPT) -work $$bn $$f\n" >> compile.vsim; \
	                   if (test $$bn = "work"); then \
		             printf "\t$(VHDLP) $(VHDLOPT) sonata $$f\n" >> compile.son; \
	  		   else \
		             printf "\t$(VHDLP) $(VHDLOPT) $$bn $$f\n" >> compile.son; \
			   fi; \
		           printf "\t$(ACOM) $(VHDLOPT) $$bn ../../$$f\n" >> compile.asim; \
		           printf "\t$(NCVHDL) $(VHDLOPT) $$bn $$f\n" >> compile.ncsim; \
	  		   echo "    "\<file xil_pn:name=\"$$f\" xil_pn:type=\"FILE_VHDL\"\> >>  $(TOP).xise; \
	  		   echo "      "\<association xil_pn:name=\"BehavioralSimulation\"/\>  >>  $(TOP).xise; \
			   echo "      "\<library xil_pn:name=\"$$bn\"/\>  >>  $(TOP).xise; \
	  		   echo "    "\</file\>  >>  $(TOP).xise; \
		           printf "\t$(GHDL) $(VHDLOPT) --workdir=gnu/$$bn --work=$$bn -P$$ppath $$f\n" >> compile.ghdl; \
			   echo "        "\<Source name=\"$$f\" type=\"VHDL\" type_short=\"VHDL\" syn_sim=\"SimOnly\" excluded=\"TRUE\" \> >> $(TOP).ldf; \
			   echo "            "\<Options lib=\"$$bn\"\/\> >> $(TOP).ldf; \
			   echo "        "\<\/Source\> >> $(TOP).ldf;; \
			vlogsim) \
		           echo Project_File_$$nfiles = $$f >> tmp.mpf; \
		           echo Project_File_P_$$nfiles = vlog_protect 0 file_type Verilog group_id 0 vlog_1995compat 0 vlog_nodebug 0 folder {Top Level} vlog_noload 0 last_compile 0 vlog_disableopt 0 vlog_hazard 0 vlog_showsource 0 ood 1 compile_to $$bn vlog_upper 0 vlog_options {} compile_order $$nfiles dont_compile 0 >> tmp.mpf; \
			   nfiles=`expr $$nfiles + 1`; \
			   case $$bn in $(LIBEROLIBSKIP) )\
				uu=0;; \
			   *) \
			    case $$q in $(LIBEROSKIP) ) ;; *) \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_syn_files; \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_sim_files; \
	    		      echo VALUE \"\<project\>/$$f,hdl\" >> libero_simlist; \
	  		      echo STATE=\"utd\" >> libero_syn_files; \
	  		      echo TIME=\"1310766027\" >> libero_syn_files; \
	  		      echo LIBRARY=\"$$bn\" >> libero_syn_files; \
	  		      echo ENDFILE >> libero_syn_files;; \
			    esac; \
			   esac; \
		           printf "\t$(VLOG) -work $$bn $$f\n" >> compile.vsim; \
		           printf "\t$(ALOG) $$bn ../../$$f\n" >> compile.asim; \
		           printf "\t$(NCVLOG) $$bn $$f\n" >> compile.ncsim;; \
			esac ; \
		       fi ;; \
	    	      esac; \
	    	    done ; \
		   fi ; \
	    	  done;; \
	         esac; \
	        done ; \
	        if (test $$bn = "work"); then \
	           for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES) $(VHDLSIMFILES); do \
	 	    if test -r $$i; then \
		     echo " [file]" >> tmp.son; \
		     echo "  name" = $$i >> tmp.son; \
		     echo " []" >> tmp.son; \
		    fi; \
	           done; \
                fi ; \
	        echo "[]" >> tmp.son; \
                echo ""; \
            fi ; \
	  esac; \
	done ; \
	if (test $(GRLIB_CONFIG) != "dummy"); then echo GRLIB_CONFIG = $$grcfg; fi ;\
	echo "{$$easic_lib_prev $$easic_lib}" >> easic.vhdl; \
	easic_lib=""; \
	for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	  easic_lib="$$easic_lib $$i"; \
	  echo "        "\<Source name=\"$$i\" type=\"VHDL\" type_short=\"VHDL\"\> >> $(TOP).ldf; \
	  echo "            "\<Options\/\> >> $(TOP).ldf; \
	  echo "        "\<\/Source\> >> $(TOP).ldf; \
	 fi; \
	done; \
	echo "{work $$easic_lib}" >> easic.vhdl; \
	for i in $(VERILOGSYNFILES); do \
	  echo $$i >> easic.vlog; \
	done; \
	echo "        "\<Source name=\"$(UCF)\" type=\"Logic Preference\" type_short=\"LPF\"\> >> $(TOP).ldf; \
	echo "            "\<Options\/\> >> $(TOP).ldf; \
	echo "        "\<\/Source\> >> $(TOP).ldf; \
	echo "        "\<Source name=\"$(SDCFILE)\" type=\"Synplify Design Constraints File\" type_short=\"SDC\"\> >> $(TOP).ldf; \
	echo "            "\<Options\/\> >> $(TOP).ldf; \
	echo "        "\<\/Source\> >> $(TOP).ldf; \
	echo "    "\<\/Implementation\> >> $(TOP).ldf; \
	echo \<\/BaliProject\> >> $(TOP).ldf; \
	for i in $(GHDLSKIP); do grep -v $$i compile.ghdl > xx; mv xx compile.ghdl; done;\
	echo -P$$ppath > ghdl.path; \
	echo ghdl: > tmpmake.ghdl;  cat compile.ghdl >> tmpmake.ghdl; \
	for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES) $(VHDLSIMFILES); do \
	 if test -r $$i; then \
	  printf "\t$(GHDL) $(VHDLOPT) --workdir=gnu/work --work=work -P$$ppath $$i\n" >> tmpmake.ghdl; \
	  echo Project_File_$$nfiles = $$i >> tmp.mpf; \
	  echo Project_File_P_$$nfiles = vhdl_novitalcheck 0 file_type VHDL group_id 0 vhdl_nodebug 0 vhdl_1164 1 vhdl_noload 0 vhdl_synth 0 folder {Top Level} last_compile 0 vhdl_disableopt 0 vhdl_vital 0 vhdl_warn1 0 vhdl_warn2 1 vhdl_explicit 0 vhdl_showsource 1 vhdl_warn3 1 vhdl_options {} vhdl_warn4 1 ood 0 vhdl_warn5 0 compile_to work compile_order $$nfiles dont_compile 0 cover_stmt 1 vhdl_use93 93 >> tmp.mpf; \
	  nfiles=`expr $$nfiles + 1`; \
	 fi; \
	done; \
        echo "Project_Sim_Count = 1" >> tmp.mpf; \
	echo "Project_Sim_0 = Simulation 1" >> tmp.mpf; \
	echo "Project_Sim_P_0 = Generics {} timing default -std_output {} +notimingchecks 0 -L {} selected_du {} -hazards 0 -sdf {} +acc {} ok 1 folder {Top Level} -absentisempty 0 +pulse_r {} OtherArgs {} -multisource_delay {} +pulse_e {} -coverage 0 -sdfnoerror 0 +plusarg {} -vital2.2b 0 -t ps additional_dus" work.$(SIMTOP) "-nofileshare 0 -noglitch 0 -wlf {} +no_pulse_msg 0 -assertfile {} -sdfnowarn 0 -Lf {} -std_input {}" >> tmp.mpf; \
	cat $(GRLIB)/bin/modelsim.ini >> modelsim.ini; \
	cp modelsim.ini $(SIMTOP).mpf; \
	echo "[Project]" >> $(SIMTOP).mpf; \
	echo Project_Version = 5 >> $(SIMTOP).mpf; \
	echo Project_DefaultLib = work >> $(SIMTOP).mpf; \
	echo Project_SortMethod = unused >> $(SIMTOP).mpf; \
        echo Project_Files_Count = $$nfiles >> $(SIMTOP).mpf;
	@echo xfile add \"$(UCF)\" >> $(TOP)_ise.tcl; \
	for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	  echo add_input_file -format VHDL -work work  $$i >> $(TOP)_precision.tcl; \
	  echo set_global_assignment -name VHDL_FILE $$i >> $(TOP).qsf; \
	  echo VALUE \"\<project\>/$$i,hdl\" >> libero_synlist; \
	  echo xfile add \"$$i\" -lib_vhdl work >> $(TOP)_ise.tcl; \
	  echo puts \"$$i\" >> $(TOP)_ise.tcl; \
	  echo "    "\<file xil_pn:name=\"$$i\" xil_pn:type=\"FILE_VHDL\"\> >>  $(TOP).xise; \
	  echo "      "\<association xil_pn:name=\"BehavioralSimulation\"/\>  >>  $(TOP).xise; \
	  echo "      "\<association xil_pn:name=\"Implementation\"/\>  >>  $(TOP).xise; \
	  echo "    "\</file\>  >>  $(TOP).xise; \
	 fi; \
	done; \
	for i in $(VHDLSIMFILES); do \
	  echo "    "\<file xil_pn:name=\"$$i\" xil_pn:type=\"FILE_VHDL\"\> >>  $(TOP).xise; \
	  echo "      "\<association xil_pn:name=\"BehavioralSimulation\"/\>  >>  $(TOP).xise; \
	  echo "    "\</file\>  >>  $(TOP).xise; \
	done; \
	echo "  "\</files\>  >>  $(TOP).xise; \
	echo setup_design -design $(TOP) >> $(TOP)_precision.tcl; \
	echo setup_design -retiming >> $(TOP)_precision.tcl; \
	echo setup_design -vhdl >> $(TOP)_precision.tcl; \
	echo setup_design -transformations=false >> $(TOP)_precision.tcl; \
	echo setup_design -frequency=\"$(SYNFREQ)\" >> $(TOP)_precision.tcl; \
	echo $(PRECOPT) >> $(TOP)_precision.tcl; \
	echo save_impl >> $(TOP)_precision.tcl; \
	echo "" >> $(TOP).qsf; \
	echo "set_global_assignment -name TOP_LEVEL_ENTITY" \"$(TOP)\" >> $(TOP).qsf; \
	echo "" >> $(TOP)_synplify.qsf; \
	echo "set_global_assignment -name TOP_LEVEL_ENTITY" \"$(TOP)\" >> $(TOP)_synplify.qsf; \
	cat tmp.npl >> $(TOP).npl; \
	echo DEPASSOC $(TOP) $(UCF) >> $(TOP).npl; \
	echo "  "\<properties\>  >>  $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Allow Unmatched LOC Constraints\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Auto Implementation Top\" xil_pn:value=\"false\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Bus Delimiter\" xil_pn:value=\"\(\)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Constraints Entry\" xil_pn:value=\"Constraints Editor\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Create Mask File\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Create ReadBack Data Files\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Device\" xil_pn:value=\"$(PART)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Device Family\" xil_pn:value=\"$(ISE11TECH)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Drive Done Pin High\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"FSM Encoding Algorithm\" xil_pn:value=\"None\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Implementation Top\" xil_pn:value=\"Architecture\|$(TOP)\|rtl\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Implementation Top Instance Path\" xil_pn:value=\"/$(TOP)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Macro Search Path\" xil_pn:value=\"$(GRLIB)/netlists/xilinx/$(NETLISTTECH)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Other Map Command Line Options\" xil_pn:value=\"$(ISEMAPOPT)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Other XST Command Line Options\" xil_pn:value=\"$(XSTOPT)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Place \&amp\; Route Effort Level \(Overall\)\" xil_pn:value=\"$(EFFORT)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"PROP_DesignName\" xil_pn:value=\"$(TOP)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"PROP_xilxBitgCfg_GenOpt_MaskFile_virtex2\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"PROP_xilxBitgCfg_GenOpt_ReadBack_virtex2\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Pack I/O Registers into IOBs\" xil_pn:value=\"Yes\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Pack I/O Registers/Latches into IOBs\" xil_pn:value=\"For Inputs and Outputs\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Package\" xil_pn:value=\"$(PACKAGE)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Preferred Language\" xil_pn:value=\"VHDL\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Run Design Rules Checker \(DRC\)\" xil_pn:value=\"false\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Simulator\" xil_pn:value=\"ISim \(VHDL/Verilog\)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Speed Grade\" xil_pn:value=\"$(SPEED)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Synthesis Tool\" xil_pn:value=\"XST \(VHDL/Verilog\)\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Top-Level Source Type\" xil_pn:value=\"HDL\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Verbose Property Persistence\" xil_pn:value=\"false\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"Manual Implementation Compile Order\" xil_pn:value=\"true\"/\> >> $(TOP).xise; \
	echo "    "\<property xil_pn:name=\"PROP_BehavioralSimTop\" xil_pn:value=\"$(SIMTOP)\"/\> >> $(TOP).xise; \
	echo "  "\</properties\>  >>  $(TOP).xise; \
	echo "  "\<bindings/\>  >>  $(TOP).xise; \
	echo "  "\<libraries\>  >>  $(TOP).xise; \
	  for i in `cat libs.txt`; do \
	    echo "    "\<library xil_pn:name=\"$$i\"/\> >>$(TOP).xise ; \
	  done ; \
	echo "  "\</libraries\>  >>  $(TOP).xise; \
	echo "  "\<partitions\>  >>  $(TOP).xise; \
	echo "    "\<partition xil_pn:name=\"/$(TOP)\"/\> >>  $(TOP).xise; \
	echo "  "\</partitions\>  >>  $(TOP).xise; \
	echo \</project\>  >>  $(TOP).xise; \
	echo project set top \"rtl\" \"$(TOP)\" >> $(TOP)_ise.tcl ;\
	echo project set \"Bus Delimiter\" \(\) >> $(TOP)_ise.tcl ;\
	echo project set \"FSM Encoding Algorithm\" None >> $(TOP)_ise.tcl ;\
	echo project set \"Pack I/O Registers into IOBs\" yes >> $(TOP)_ise.tcl ;\
	echo project set \"Verilog Macros\" \"$(SYNPVLOGDEFS)\" >> $(TOP)_ise.tcl ;\
	echo project set \"Other XST Command Line Options\" \"$(XSTOPT)\" -process \"Synthesize - XST\" >> $(TOP)_ise.tcl ;\
	echo project set \"Allow Unmatched LOC Constraints\" true -process \"Translate\" >> $(TOP)_ise.tcl ;\
	echo project set \"Macro Search Path\" \"$(GRLIB)/netlists/xilinx/$(NETLISTTECH)\" -process \"Translate\" >> $(TOP)_ise.tcl ;\
	echo project set \"Pack I/O Registers/Latches into IOBs\" \{For Inputs and Outputs\}   >> $(TOP)_ise.tcl ;\
	echo project set \"Other MAP Command Line Options\" \"$(ISEMAPOPT)\" -process Map >> $(TOP)_ise.tcl ;\
	echo project set \"Drive Done Pin High\" true -process \"Generate Programming File\" >> $(TOP)_ise.tcl ;\
	echo project set \"Create ReadBack Data Files\" true -process \"Generate Programming File\" >> $(TOP)_ise.tcl ;\
	echo project set \"Create Mask File\" true -process \"Generate Programming File\" >> $(TOP)_ise.tcl ;\
	echo project set \"Run Design Rules Checker \(DRC\)\" false -process \"Generate Programming File\" >> $(TOP)_ise.tcl ;\
	echo project close >> $(TOP)_ise.tcl ;\
	echo exit >> $(TOP)_ise.tcl ;\
	xfiles=`expr $$xfiles + 1`; \
	echo SOURCE synplify/$(TOP).edf >> $(TOP)_synplify.npl; \
	echo DEPASSOC $(TOP) $(UCF) >> $(TOP)_synplify.npl; \
	echo "[Normal]" >> $(TOP).npl; echo "[Normal]" >> $(TOP)_synplify.npl; \
	echo "_SynthFsmEncode=xstvhd, " $(TECHNOLOGY)", VHDL.t_synthesize, 1102507235, None" >> $(TOP).npl; \
	echo "p_xstBusDelimiter=xstvhd, " $(TECHNOLOGY)", VHDL.t_synthesize, 1102507235, ()" >> $(TOP).npl; \
	echo "xilxMapAllowLogicOpt=xstvhd, " $(TECHNOLOGY)", VHDL.t_placeAndRouteDes, 1102861051, True" >>  $(TOP).npl; \
	echo "xilxMapCoverMode=xstvhd, " $(TECHNOLOGY)", VHDL.t_placeAndRouteDes, 1102861051, Speed" >>  $(TOP).npl; \
	echo "xilxMapTimingDrivenPacking=xstvhd, " $(TECHNOLOGY)", VHDL.t_placeAndRouteDes, 1102861051, True" >>  $(TOP).npl; \
	echo "xilxNgdbld_AUL=xstvhd, " $(TECHNOLOGY)", VHDL.t_placeAndRouteDes, 1102861051, True" >>  $(TOP).npl; \
	echo "xilxNgdbldMacro=xstvhd, " $(TECHNOLOGY)", VHDL.t_ngdbuild, 1105377047, "$(GRLIB)/netlists/xilinx/$(NETLISTTECH) >>  $(TOP).npl; \
	echo "xilxPAReffortLevel=xstvhd, " $(TECHNOLOGY)", VHDL.t_placeAndRouteDes, 1102861051, Medium" >>  $(TOP).npl; \
	echo "xilxMapAllowLogicOpt=edif, " $(TECHNOLOGY)", EDIF.t_placeAndRouteDes, 1102861051, True" >>  $(TOP)_synplify.npl; \
	echo "xilxMapCoverMode=edif, " $(TECHNOLOGY)", EDIF.t_placeAndRouteDes, 1102861051, Speed" >>  $(TOP)_synplify.npl; \
	echo "xilxNgdbld_AUL=edif, " $(TECHNOLOGY)", EDIF.t_placeAndRouteDes, 1102861051, True" >>  $(TOP)_synplify.npl; \
	echo "xilxPAReffortLevel=edif, " $(TECHNOLOGY)", EDIF.t_placeAndRouteDes, 1102861051, Medium" >>  $(TOP)_synplify.npl; \
	echo "xilxNgdbldMacro=edif, " $(TECHNOLOGY)", EDIF.t_placeAndRouteDes, 1105378344, "$(GRLIB)/netlists/xilinx/$(NETLISTTECH) >>  $(TOP)_synplify.npl; \
	cat $(TOP).npl | sed -e s/'\/'/'\\'/g > tmp.npl; \
	cp tmp.npl $(TOP)_win32.npl; \
	cat $(TOP)_synplify.npl | sed -e s/'\/'/'\\'/g > tmp.npl; \
	cp tmp.npl $(TOP)_synplify_win32.npl; \
	if test $(OS) != "Linux"; then \
	  if test $(OS) != "SunOs"; then \
	    cp $(TOP)_win32.npl $(TOP).npl; \
	    cp $(TOP)_synplify_win32.npl $(TOP)_synplify.npl; \
	  fi; \
	fi; \
	echo "[STRATEGY-LIST]" >> $(TOP).npl; echo "[STRATEGY-LIST]" >> $(TOP)_synplify.npl; \
	echo "Normal=True" >> $(TOP).npl; echo "Normal=True" >> $(TOP)_synplify.npl; \
	echo "DEVSYNTHESISTOOL XST (VHDL/Verilog)" >>  $(TOP).npl; \
	for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES) $(VHDLSIMFILES); do \
	 if test -r $$i; then \
	   printf "\t$(VHDLP) $(VHDLOPT) sonata $$i\n" >> compile.son; \
	 fi; \
	done; rm tmp.npl; \
	for i in $(SONATALIBSKIP); do grep -v $$i compile.son > xx; mv xx compile.son; done;\
        cat tmp.mpf >> $(SIMTOP).mpf; rm tmp.mpf; \
	cat $(GRLIB)/bin/mt1.mpf >> $(SIMTOP).mpf; \
	if test -r "$(QSF)"; then cat $(QSF) >> $(TOP).qsf; fi; \
	echo ncsim: > make.ncsim; cat compile.ncsim >> make.ncsim; \
	echo vsim: > make.vsim; cat compile.vsim >> make.vsim; \
	echo sonata-compile: > make.son; cat compile.son >> make.son; \
	cat compile.asim >> make.asim; \
	printf "# Work-around for stupid secureip bug ...\n" >>  make.vsim; \
	printf "\t@if test -r $(GRLIB)/lib/tech/secureip/ise/mcb_001.vp; then vlog -quiet -novopt -work secureip $(GRLIB)/lib/tech/secureip/ise/mcb_*.vp; fi\n" >> make.vsim; \
	for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES) $(VHDLSIMFILES); do \
	 if test -r $$i; then \
	  printf "\t$(VCOM) $(VHDLOPT) -work work $$i\n" >> make.vsim; \
	  printf "\t$(ACOM) $(VHDLOPT) work ../../$$i\n" >> make.asim; \
	  printf "\t$(NCVHDL) $(VHDLOPT) work $$i\n" >> make.ncsim; \
	  echo VALUE \"\<project\>/$$i,hdl\" >> libero_simlist; \
	 fi; \
	done; \
	for i in $(VERILOGSYNFILES) $(VHDLOPTSYNFILES) $(VHDLSYNFILES); do \
	 if test -r $$i; then \
	  echo VALUE \"\<project\>/$$i,hdl\" >> libero_syn_files; \
	  echo STATE=\"utd\" >> libero_syn_files; \
	  echo TIME=\"1310766027\" >> libero_syn_files; \
	  echo LIBRARY=\"work\" >> libero_syn_files; \
	  echo ENDFILE >> libero_syn_files; \
	 fi; \
	done; \
	for i in $(VERILOGSIMFILES) $(VHDLSIMFILES); do \
	 if test -r $$i; then \
	  echo VALUE \"\<project\>/$$i,tb_hdl\" >> libero_syn_files; \
	  echo STATE=\"utd\" >> libero_syn_files; \
	  echo TIME=\"1310766027\" >> libero_syn_files; \
	  echo LIBRARY=\"work\" >> libero_syn_files; \
	  echo ENDFILE >> libero_syn_files; \
	  echo VALUE \"\<project\>/$$i,hdl\" >> libero_sim_files; \
	 fi; \
	done; \
	for i in $(VERILOGSYNFILES) $(VERILOGSIMFILES); do \
	 if test -r $$i; then \
	  printf "\t$(VLOG) -work work $$i\n" >> make.vsim; \
	  printf "\t$(ALOG) work ../../$$i\n" >> make.asim; \
	  printf "\t$(NCVLOG) work $$i\n" >> make.ncsim; \
	 fi; \
	done; \
	if test -r "$(SDCFILE)"; then \
	  echo VALUE \"\<project\>/$(SDCFILE),sdc\" >> libero_syn_files; \
	  echo STATE=\"utd\" >> libero_syn_files; \
	  echo TIME=\"1310766027\" >> libero_syn_files; \
	  echo ENDFILE >> libero_syn_files; \
	fi; \
	if test -r "$(SDC)"; then \
	  echo VALUE \"\<project\>/$(SDC),sdc\" >> libero_syn_files; \
	  echo STATE=\"utd\" >> libero_syn_files; \
	  echo TIME=\"1310766027\" >> libero_syn_files; \
	  echo ENDFILE >> libero_syn_files; \
	fi; \
	if test -r "$(PDC)"; then \
	  echo VALUE \"\<project\>/$(PDC),pdc\" >> libero_syn_files; \
	  echo STATE=\"utd\" >> libero_syn_files; \
	  echo TIME=\"1310766027\" >> libero_syn_files; \
	  echo ENDFILE >> libero_syn_files; \
	fi; \
	echo "cd .." > libero.do; \
	echo do libs.do >> libero.do; \
	echo project open $(SIMTOP).mpf >> libero.do; \
	echo project compileoutofdate >> libero.do; \
	echo vsim $(SIMTOP) >> libero.do; \
	echo do wave.do >> libero.do; \
	mkdir simulation; mv libero.do simulation; \
	cp wave.do *.srec simulation; \
	echo "" > make.asim-addfile; \
	for i in $(VHDLOPTSYNFILES) $(VHDLSYNFILES) $(VHDLSIMFILES); do \
	 if test -r $$i; then \
	  echo addfile -vhdl ../../$$i >> make.asim-addfile; \
	 fi; \
	done; \
	if test -r "$(SIMTOP)".vhd; then \
	  arch=`grep -i architecture $(SIMTOP).vhd | grep -i $(SIMTOP) | awk '{ print $$2}'`; \
	  printf "\tncelab -timescale 10ps/10ps $(SIMTOP):$$arch\n" >> make.ncsim ; \
	else \
	  if test -r "$(SIMTOP)".v; then \
	    printf "\tncelab -timescale 10ps/10ps $(SIMTOP)\n" >> make.ncsim ; \
	  fi; \
	fi; \
	echo $(SIMTOP).mpf; \
	echo LIST LIBRARIES >> $(TOP)_libero.prj; \
	for i in `cat libs.txt`; do \
	   case $$i in $(LIBEROLIBSKIP) )\
	     uu=0;; \
	   *) \
	     echo $$i >> $(TOP)_libero.prj; \
	   esac; \
	done; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	cat $(GRLIB)/bin/sonata2.sws >> sonata.sws; \
	cp sonata.sws symphony.ini; \
	cat tmp.son >> sonata.sws; \
	echo "[properties]" >> sonata.sws; \
	echo " work = sonata" >> sonata.sws; \
	echo "[]" >> sonata.sws; \
	echo ENDFILELIST >> libero_simlist; \
	echo ENDLIST >> libero_simlist; \
	echo ENDFILELIST >> libero_synlist; \
	echo ENDLIST >> libero_synlist; \
	for i in `cat libs.txt`; do \
	   case $$i in $(LIBEROLIBSKIP) )\
	     uu=0;; \
	   *) \
	     echo LIST LIBRARIES_$$i >> $(TOP)_libero.prj; \
	     echo ALIAS=$$i >> $(TOP)_libero.prj; \
	     echo "COMPILE_OPTION=COMPILE" >> $(TOP)_libero.prj; \
	     echo ENDLIST >> $(TOP)_libero.prj; \
	   esac; \
	done; \
	cat libero_syn_files >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST AssociatedStimulus >> $(TOP)_libero.prj; \
	echo LIST $(TOP) >> $(TOP)_libero.prj; \
	echo VALUE \"\<project\>/$(SIMTOP).vhd,tb_hdl\" >>  $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST SynthesisConstraints >> $(TOP)_libero.prj; \
	echo VALUE \"\<project\>/$(SDCFILE),sdc\" >>  $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST SimulationOptions >> $(TOP)_libero.prj; \
	echo EntityName=$(SIMTOP) >> $(TOP)_libero.prj; \
	echo UseAutomaticDoFile=true >> $(TOP)_libero.prj; \
	echo IncludeWaveDo=true >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST ExcludePackageForSimulation >> $(TOP)_libero.prj; \
	echo LIST $(TOP) >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	cat libero_sim_files >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST IncludeModuleForSimulation >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo LIST UserCustomizedFileList >> $(TOP)_libero.prj; \
	echo LIST \"$(TOP)\" >> $(TOP)_libero.prj; \
	cat libero_synlist >> $(TOP)_libero.prj; \
	cat libero_simlist >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj; \
	echo ENDLIST >> $(TOP)_libero.prj;
#	for i in $(TOOLSKIP); do \
	  case $$i in \
	  libero ) rm -rf simulation $(TOP)_libero.prj;; \
	  quartus ) rm  $(TOP).q?f;; \
	  ghdl ) rm  compile.ghdl tmpmake.ghdl ;; \
	  sonata ) rm -rf sonata.sws compile.son make.son ;; \
	  esac; \
	done
	@echo } >> easic.vhdl
	@echo } >> easic.vlog
	@cat easic.vhdl easic.vlog > compile.etools
	@-rm easic.vhdl easic.vlog

########## Import from other libraries ###############

## Import CoreMP7 files from Actel's CoreConsole IP Library
import-actel-cc:
	@if test -r $(CORECONSOLE); then \
	  echo "Importing CoreMP7 files from Actel CoreConsole IP Library"; \
	  echo " Importing $(COREMP7BRIDGE_FILES) to lib/techmap/proasic3"; \
	  for i in $(COREMP7BRIDGE_FILES); do cp $(COREMP7BRIDGE_PATH)/$$i $(GRLIB)/lib/techmap/proasic3; done; \
	  echo " Importing $(COREMP7_FILES) to lib/techmap/proasic3";\
	  for i in $(COREMP7_FILES); do cp $(COREMP7_PATH)/$$i $(GRLIB)/lib/techmap/proasic3; done; \
	else \
	  echo "CORECONSOLE environment variable is not correctly set!"; \
	fi

## Import eASIC RTL and IP libraries from eTools
# tested with eTools 9. eTools 8.2.0 has ip_lib under data instead of
# data_common, earlier versions may not have "data" directory in path
import-easic-n2x:
	@if test -r $(ETOOLS_N2X_HOME); then \
		echo "Importing eASIC RTL libraries to tech"; \
		cp -r $(ETOOLS_N2X_HOME)/data/design_libs/nextreme-2/logical/sim/verilog $(GRLIB)/lib/tech/nextreme2/sim/; \
		cp -r $(ETOOLS_N2X_HOME)/data/design_libs/nextreme-2/logical/msim/verilog $(GRLIB)/lib/tech/nextreme2/msim/; \
		echo "Importing DC simulation library to tech"; \
		cp $(ETOOLS_N2X_HOME)/data/design_libs/nextreme-2/dc/sim/verilog/* $(GRLIB)/lib/tech/nextreme2/dc/; \
		echo "Importing eASIC IP Library to techmap"; \
		cp -r $(ETOOLS_N2X_HOME)/data_common/ip_lib $(GRLIB)/lib/techmap/nextreme2/; \
		echo "Patching DDR2 PHY IP with local modifications"; \
		patch $(GRLIB)/lib/techmap/nextreme2/ip_lib/dfi/ddr2/src/rtl/verilog/eip_n2x_dfi_ddr2_phy_rden1.v $(GRLIB)/lib/techmap/nextreme2/dfiphy.patch; \
		echo "Importing eASIC RTL library wrappers to techmap"; \
		cp -r $(ETOOLS_N2X_HOME)/data/design_libs/nextreme-2/logical/msim/verilog/*wrapper.v  $(GRLIB)/lib/techmap/nextreme2/; \
	else \
		echo "ETOOLS_N2X_HOME environment variable is not correctly set!"; \
	fi

remove-easic-n2x:
	@echo "Removing imported eASIC libraries"; \
	rm -rf  "$(GRLIB)"/lib/tech/nextreme2/sim/verilog "$(GRLIB)"/lib/tech/nextreme2/msim/verilog \
	"$(GRLIB)"/lib/tech/nextreme2/dc/*.v "$(GRLIB)"/lib/techmap/nextreme2/ip_lib \
	"$(GRLIB)"/lib/techmap/nextreme2/n2x_phys_*_wrapper.v;

######## Common cleaning   ####################

clean: $(CLEAN) vsim-clean ise-clean ncsim-clean ghdl-clean synplify-clean quartus-clean sonata-clean \
	actel-clean dc-clean rc-clean isp-clean precision-clean vsimsa-clean avhdl-clean riviera-clean \
	etools-n2x-clean
	-rm -rf verilog.txt tkparse.exe main.tk ahbrom outdata ahbrom.bin

scripts-clean:
	-rm -rf compile\.* libs.txt $(TOP).qsf $(TOP)_synplify.qsf *.qpf *\.ghdl ghdl.path \
	compile\.* libs.do make\.* *.xst cds.lib *.npl $(TOP)_ise.tcl \
	config.h .config.old hdl.var $(TOP)_dc.tcl  $(TOP).rc  \
	$(TOP)_synplify.prj $(SIMTOP).mpf tmpmake.ghdl \
	$(TOP)_designer.tcl $(TOP)_designer_act.tcl \
	modelsim.ini \
	alibs.do avhdl.tcl riviera.do \
	$(TOP)_etools_create.tcl $(TOP).eprj

distclean: $(CLEAN) clean scripts-clean

libclean:
	-@rm work.v; \
	for j in `cat libs.txt` work ; do \
	  rm $$j.vhd; \
	done;
	make distclean

none-clean:

######## xconfig targets   ####################

ifneq ($(CURLIB), $(GRLIB))
  include $(GRLIB)/bin/Makefile.config
endif

TKCONFIG= $(GRLIB)/bin/tkconfig

tkparse.o: $(TKCONFIG)/tkparse.c
	$(CC) -g -c $<

tkcond.o: $(TKCONFIG)/tkcond.c
	$(CC) -g -c $<

tkgen.o: $(TKCONFIG)/tkgen.c
	$(CC) -g -c $<


tkparse.exe: tkparse.o tkcond.o tkgen.o
	$(CC) -g tkparse.o tkcond.o tkgen.o -o tkparse.exe

lconfig.tk: config.in $(CONFDEP) $(HELPDEP)
	make main.tk
	cat $(TKCONFIG)/header.tk main.tk $(TKCONFIG)/tail.tk > lconfig.tk
	chmod a+x lconfig.tk

main.tk : config.in tkparse.exe $(CONFDEP) $(HELPDEP)
	./tkparse.exe config.in $(GRLIB) $(EXTRALIBS) > main.tk

$(GRLIB)/bin/Makefile.config:
	make -C $(GRLIB) -f bin/Makefile cfgdep

xconfig: lconfig.tk $(GRLIB)/bin/Makefile.config
	@if test -r "/usr/bin/wish84.exe"; then /usr/bin/wish84.exe -f lconfig.tk; \
	else \
	  if test -r "/mingw/bin/wish84.exe"; then \
	    if !(test -r "/mingw/bin/echo.bat"); then \
	      cp $(GRLIB)/bin/echo.bat /mingw/bin/echo.bat; \
	    fi; \
	    if !(test -r "/mingw/bin/wish"); then \
	      cp $(GRLIB)/bin/wish /mingw/bin/wish; \
	    fi; \
	  fi; \
	  wish -f lconfig.tk; \
	fi; \
	if test $$? = "2" ; then                   \
	   cpp -P -DGRLIB_PATH=$(GRLIB) config.vhd.in > config.vhd; \
	   echo config.vhd created; \
	fi

xdep:
	cpp -P -DGRLIB_PATH=$(GRLIB) config.vhd.in > config.vhd

config:
	cp $(GRLIB)/boards/$(BOARD)/config .config
	cp $(GRLIB)/boards/$(BOARD)/config.h config.h
	make xdep

.PHONY: sonata xst precision synplify scripts bitfiles cut-actel



############ Maintenance - do not remove!   ##################

docs:
	find ./ -name '*.gif' | zip ../grdocs.zip -@
	find ./ -name '*.html' | zip ../grdocs.zip -@
	find ./ -name '*.pdf' | zip ../grdocs.zip -@
	find ./ -name '*.jpg' | zip ../grdocs.zip -@

usbhost:
	tar czf ../grlib-usb-host-$(VER).tar.gz $(USBHCFILES)
	rm -rf $(USBHCFILES)

usbdevice:
	tar czf ../grlib-usb-device-$(VER).tar.gz $(USBDCFILES)
	rm -rf $(USBDCFILES)


bitfiles:
	@echo creating grlib-bitfiles-$(VER).tar.gz ;\
	tar czf ../grlib-bitfiles-$(VER).tar.gz `find -name '*bitfiles' -print | xargs` ;\
	rm -rf `find -name '*bitfiles' -print | xargs`

cfgdep:
	@printf "CONFDEP = "  > bin/Makefile.config
	@for i in `find lib -name '*.in' -print | grep -v vhd | xargs`; do \
	  echo -n '$$(GRLIB)'/$$i >> bin/Makefile.config ; \
	  printf " \\"  >> bin/Makefile.config ; \
	  printf "\n"  >> bin/Makefile.config ; \
	done;
	@printf "  \n" >> bin/Makefile.config
	@printf "HELPDEP = "  >> bin/Makefile.config
	@for i in `find lib -name '*.in.help' -print | xargs`; do \
	  echo -n '$$(GRLIB)'/$$i >> bin/Makefile.config ; \
	  printf " \\"  >> bin/Makefile.config ; \
	  printf "\n"  >> bin/Makefile.config ; \
	done;
	@printf "  \n" >> bin/Makefile.config

clean-lib:
	@make -f bin/Makefile cfgdep
	@-rm `find -name '*.backup.fm' -print | xargs`
	@-rm `find -name '*.recover.fm' -print | xargs`
	@-rm `find -name '*.backup.book' -print | xargs`
	@-rm `find -name '*.backup.book' -print | xargs`
	@echo "-- pragma translate_off"   > lib/grlib/stdlib/version.vhd ;\
	echo "use std.textio.all;"   >> lib/grlib/stdlib/version.vhd ;\
	echo "-- pragma translate_on"   >> lib/grlib/stdlib/version.vhd ;\
	echo "package version is"   >> lib/grlib/stdlib/version.vhd ;\
	echo "  constant grlib_version : integer := $(GVER);" >> lib/grlib/stdlib/version.vhd ;\
	echo "-- pragma translate_off"   >> lib/grlib/stdlib/version.vhd ;\
	echo -n "  constant grlib_date : string := \""  >> lib/grlib/stdlib/version.vhd ;\
	date +%Y%m%d | tr "\n" "\"" >> lib/grlib/stdlib/version.vhd ;\
	echo ";"     >> lib/grlib/stdlib/version.vhd ;\
	echo "-- pragma translate_on"   >> lib/grlib/stdlib/version.vhd ;\
	echo -n "  constant grlib_build : integer := " >> lib/grlib/stdlib/version.vhd ;\
	svn info | awk '/Revision:/ {print $$2 + 1}'  | tr "\n" ";" >> lib/grlib/stdlib/version.vhd ;\
	echo "" >> lib/grlib/stdlib/version.vhd ;\
	echo "end;"  >> lib/grlib/stdlib/version.vhd ;\

fpunet:
	@mv lib/gaisler/leon3/grfpwx-net.vhd lib/gaisler/leon3/grfpwx.vhd ; \
	mv lib/gaisler/leon4b64/grfpwx4-net.vhd lib/gaisler/leon4b64/grfpwx4.vhd ; \
	mv lib/gaisler/leon3/grlfpwx-net.vhd lib/gaisler/leon3/grlfpwx.vhd ; \
	mv lib/gaisler/leon4b64/grlfpwx4-net.vhd lib/gaisler/leon4b64/grlfpwx4.vhd

delint:
	rm -rf $(INTFILES)
	rm -rf $(FPU)
	@cd doc; mv grlib/grlib.pdf grip/grip.pdf haps/haps.pdf tmtc/tmtc.pdf .; \
	mkdir devices ;\
	mv leon3ft-rtax/leon3ft-rtax-ag.pdf devices; \
	mv ftfpga/ftfpga.pdf grlib-ft-fpga.pdf ; \
	mv gr701/*.pdf devices ; \
	rm -rf grlib grip leon3ft-rtax ftfpga gr701 haps
	@echo creating grlib-haps-$(VER).tar.gz ;\
	tar czf ../grlib-haps-$(VER).tar.gz $(HAPSFILES) ;\
	rm -rf $(HAPSFILES)
	@-rm `find -name '*.fm' -print | xargs`
	@-rm `find -name '*.book' -print | xargs`
	@-rm -rf designs/leon3-ft*/bitfiles designs2 designs/leon4*/bitfiles \
		designs/t1*/bitfiles designs/*actel*/bitfiles designs/*mcc*/bitfiles
	@make -f bin/Makefile bitfiles
	@cd lib/gaisler; mv leon3sim leon3ft
	make -f bin/Makefile filterhash

filterhash:
	cat lib/techmap/unisim/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/unisim/vhdlsyn.txt
	cat lib/techmap/unisim/vhdlsim.txt | sed -e s/#// > x; mv x lib/techmap/unisim/vhdlsim.txt
	cat lib/techmap/axcelerator/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/axcelerator/vhdlsyn.txt
	cat lib/techmap/proasic3/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/proasic3/vhdlsyn.txt
	cat lib/techmap/proasic3e/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/proasic3e/vhdlsyn.txt
	cat lib/techmap/proasic3l/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/proasic3l/vhdlsyn.txt
	cat lib/techmap/fusion/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/fusion/vhdlsyn.txt
	cat lib/techmap/cycloneiii/vhdlsim.txt | sed -e s/#// > x; mv x lib/techmap/cycloneiii/vhdlsim.txt
	cat lib/techmap/stratixii/vhdlsim.txt | sed -e s/#// > x; mv x lib/techmap/stratixii/vhdlsim.txt
	cat lib/techmap/stratixiii/vhdlsim.txt | sed -e s/#// > x; mv x lib/techmap/stratixiii/vhdlsim.txt
	cat lib/techmap/maps/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/maps/vhdlsyn.txt
	cat netlists/xilinx/Spartan3/edifsyn.txt | sed -e s/#// > x; mv x netlists/xilinx/Spartan3/edifsyn.txt
	cat netlists/xilinx/Virtex2/edifsyn.txt | sed -e s/#// > x; mv x netlists/xilinx/Virtex2/edifsyn.txt
	cat netlists/xilinx/Virtex4/edifsyn.txt | sed -e s/#// > x; mv x netlists/xilinx/Virtex4/edifsyn.txt
	cat netlists/xilinx/Virtex5/edifsyn.txt | sed -e s/#// > x; mv x netlists/xilinx/Virtex5/edifsyn.txt

ft: delint fpunet
	echo creating grlib-ft-netlists-$(VER).tar.gz ;\
	tar czf ../grlib-ft-netlists-$(VER).tar.gz netlists ;\
	rm -rf lib/techmap/*/gr*fp*_*_*
	rm -rf $(USBFILES) $(COREMP7FILES) $(T1FILES)
	@cd lib/actel/core1553brm; mv dirs_netlist.txt dirs.txt
	@make -f bin/Makefile cfgdep
	@for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done
	@xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

ftfpga: delint fpunet
	@cd lib/tech; rm -rf $(ASICLIBS)
	@cd lib/techmap; rm -rf $(ASICLIBS)
	@cd lib/spw; rm -rf core
	@cd boards; rm -rf ge-* altera* jop* ut699rh*
	@cp -r designs/ft*/* designs; rm -rf designs/ft*
	rm -rf $(INTFTFPGAFILES) $(USBFILES) $(COREMP7FILES) $(T1FILES) \
		$(GRLIB2FILES) designs2 cfg boards/avnet* \
		$(LEON4FILES)  $(GBITFILES)
	@cd lib/actel/core1553brm; mv dirs_netlist.txt dirs.txt
ifneq ("$(EXTRA)","")
	  for i in $(EXTRA); do cp -rp $(GRLIB)/$$i `dirname $$i`; done
endif
ifneq ("$(REMOVE)","")
	  for i in $(REMOVE); do rm -rf $$i; done
endif
	@make -f bin/Makefile cfgdep
#	@make -f bin/Makefile filterhash
	@for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done
	@xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

fpga: delft
	@cd lib/tech; rm -rf $(ASICLIBS)
	@cd lib/techmap; rm -rf $(ASICLIBS)
	@cd boards; rm -rf ge-* jop*
	@rm -rf $(INTFPGAFILES) ;\
	rm -rf $(COMFILES) $(GRLIB2FILES)  $(T1FILES) $(LEON4FILES)  $(GBITFILES) ;
ifneq ("$(EXTRA)","")
	  for i in $(EXTRA); do cp -rp $(GRLIB)/$$i `dirname $$i`; done
endif
ifneq ("$(REMOVE)","")
	  for i in $(REMOVE); do rm -rf $$i; done
endif
	for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done
	make -f bin/Makefile cfgdep
#	make -f bin/Makefile filterhash
	xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

ftfpgamda: delint fpunet
	@cd lib/tech; rm -rf $(ASICLIBS)
	@cd lib/techmap; rm -rf $(ASICLIBS)
	@cd lib/spw; rm -rf core
	@cd boards; rm -rf ge-* altera* jop* ut699rh*
	-rm -rf designs/* $(ALTERAFILES) \
		$(INTFTFPGAFILES) $(USBFILES) $(COREMP7FILES) $(T1FILES) \
		lib/gaisler/leon* lib/techmap/*/leon* \
		lib/gaisler/b1553  lib/techmap/*/grspw*16* \
		lib/gr1553 software lib/spw lib/gaisler/spacewire \
		lib/gaisler/usb lib/gaisler/ata lib/gaisler/l2cache \
		lib/gaisler/can  lib/gaisler/*/doc lib/grlib/amba/doc \
		lib/techmap/maps/doc lib/techmap/unisim/*_0_* \
		$(GRLIB2FILES) designs2 cfg netlists boards/avnet* \
		boards/digi* boards/memec* boards/nuho* boards/xili* \
		lib/gaisler/net lib/gaisler/greth lib/eth \
		lib/tmtc/grtm/grtmrx.vhd lib/tmtc/grtc/grtctx.vhd \
		lib/opencores/ac97 lib/actel \
		lib/tmtc/grctm/grctm-generics.xls \
		lib/tmtc/grctm/spacewirecuc.vhd \
		lib/tmtc/grctm/spwcuc.vhd
	svn export ~/vhdl/PROJECTS/grlib/mda designs/mda
	mv designs/mda/* designs
	rmdir designs/mda
	cp -rp $(GRLIB)/lib/grlib/atf lib/grlib/amba
	-mkdir software
	cp -rp $(GRLIB)/software/ccsds software
	cp -rp $(GRLIB)/lib/tmtc lib
	-mkdir lib/ihp
	cp -rp $(GRLIB)/lib/ihp/aes128_256 lib/ihp
	cp -rp $(GRLIB)/lib/ihp/dirs.txt lib/ihp
	cp -rp $(GRLIB)/lib/gaisler/gr1553b lib/gaisler
	-mkdir verification
	cp -rp $(GRLIB)/verification/grtm verification
	cp -rp $(GRLIB)/verification/grtc verification
	cp -rp $(GRLIB)/verification/gr1553b verification
	cp  -rp $(GRLIB)/lib/gaisler/leon3 lib/gaisler
	rm -rf lib/gaisler/leon3/*.vhd lib/gaisler/leon3/doc
	cp  -rp $(GRLIB)/lib/gaisler/leon3/leon3.vhd lib/gaisler/leon3
	cp  -rp $(GRLIB)/lib/gaisler/leon3/irqmp.vhd lib/gaisler/leon3
	cp  -rp $(GRLIB)/lib/gaisler/crypto lib/gaisler
	rm -rf lib/gaisler/crypto/*.vhd
	cp  -rp $(GRLIB)/lib/gaisler/crypto/crypto.vhd lib/gaisler/crypto
	cp  -rp $(GRLIB)/lib/gaisler/crypto/graes_dma.vhd lib/gaisler/crypto
	-mkdir verification/crypto
	cp -rp $(GRLIB)/verification/crypto/Makefile verification/crypto
	cp -rp $(GRLIB)/verification/crypto/graes_dma_tb.vhd verification/crypto
	rm -rf /lib/tmtc/grtm/grtmrx.vhd /lib/tmtc/grtc/grtctx.vhd
	@make -f bin/Makefile cfgdep
	@for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done
	@xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

delftl4: delint
	@if test -r .svn; then echo .svn found, exiting; exit; fi;
	@-rm netlists/*/*/*ft*
	@-rm netlists/*/*/*grspw*
	@-rm netlists/*/*/gr*
	rm -rf doc/devices doc/grlib-ft-fpga.pdf doc/tmtc.pdf ;\
	rm -rf $(T1FILES) ; \
	rm -rf $(COREMP7FILES) ; \
	rm -rf lib/techmap/*/grl*fp*_*_* ; \
	rm -rf lib/techmap/unisim/grfp*_0_unisim_v2.vhd; \
	rm -rf $(FTFILES)
	@mv software/leon3/Makefile.com software/leon3/Makefile
	@make -f bin/Makefile cfgdep

delft: delint fpunet
	@-rm netlists/*/*/*ft*
	@-rm lib/techmap/*/*ft*
	@-rm netlists/*/*/*grspw* ;\
	rm -rf doc/devices doc/grlib-ft-fpga.pdf doc/tmtc.pdf ;\
	echo creating grlib-netlists-$(VER).tar.gz ;\
	tar czf ../grlib-netlists-$(VER).tar.gz lib/techmap/*/gr*fpw_*  netlists ;\
	echo creating grlib-niagara-$(VER).tar.gz ;\
	tar czf ../grlib-niagara-$(VER).tar.gz $(T1FILES) ; \
	rm -rf $(T1FILES) ; \
	echo creating grlib-coremp7-$(VER).tar.gz ;\
	tar czf ../grlib-coremp7-$(VER).tar.gz $(COREMP7FILES) ; \
	rm -rf $(COREMP7FILES) ; \
	rm -rf netlists lib/techmap/*/gr*fp*_*_* ; \
	rm -rf netlists ;\
	rm -rf $(FTFILES)
	@mv software/leon3/Makefile.gpl software/leon3/Makefile
	@make -f bin/Makefile cfgdep

com: delft
	rm -rf $(GRLIB2FILES) $(LEON4FILES) doc/ftproasic3 doc/gr1553b
ifneq ("$(EXTRA)","")
	  for i in $(EXTRA); do cp -rp $(GRLIB)/$$i `dirname $$i`; done
endif
ifneq ("$(REMOVE)","")
	  for i in $(REMOVE); do rm -rf $$i; done
endif
	for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done ;\
	rm -rf $(CONTRIBLIBS) designs/*ft* designs/t1*;\
	rm -rf lib/spw/netlists ; \
	echo creating grlib-usb-host-$(VER).tar.gz ;\
	tar czf ../grlib-usb-host-$(VER).tar.gz $(USBHCFILES) ; \
	echo creating grlib-usb-device-$(VER).tar.gz ;\
	tar czf ../grlib-usb-device-$(VER).tar.gz $(USBDCFILES) ; \
	rm -rf $(USBFILES) ; \
	make -f bin/Makefile cfgdep ;\
	xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname


coml4: delftl4
	rm -rf $(CONTRIBLIBS) designs/*ft* designs/t1*;\
	rm -rf lib/spw/netlists ; \
	rm -rf $(USBFILES) ; \
	rm -rf $(GRLIB2FILES); \
	cp -rp $(GRLIB)/lib/gaisler/fpu lib/gaisler ;\
	rm -rf $(GRLIB2FILES); \
	rm -rf $(FPU) ;\
	rm -rf \
	verification/* \
	lib/gleichmann lib/openchip
ifneq ("$(EXTRA)","")
	  for i in $(EXTRA); do cp -rp $(GRLIB)/$$i `dirname $$i`; done
endif
ifneq ("$(REMOVE)","")
	  for i in $(REMOVE); do rm -rf $$i; done
endif
	rm -rf lib/*/*/cfg lib/*/*/doc lib/*/*/*/cfg  lib/*/*/*/*/cfg
	for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done
	make -f bin/Makefile cfgdep ;\
	xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

fpga-com: delft
	@cd lib/tech; rm -rf $(ASICLIBS)
	@cd lib/techmap; rm -rf $(ASICLIBS)
	@for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done ;\
	rm -rf lib/openchip designs/*ft* ;\
	rm -rf lib/spw/netlists ; \
	rm -rf $(USBFILES) ; \
	make -f bin/Makefile cfgdep ;\
	xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

gpl: delft
	rm -rf $(COMFILES) $(GRLIB2FILES) $(LEON4FILES) \
	verification doc/ftproasic3 doc/gr1553b
ifneq ("$(EXTRA)","")
	  for i in $(EXTRA); do cp -rp $(GRLIB)/$$i `dirname $$i`; done
endif
ifneq ("$(REMOVE)","")
	  for i in $(REMOVE); do rm -rf $$i; done
endif
	for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gpl.sed $$i > x; mv x $$i; fi; \
	done ;\
	mv lib/techmap/gencomp/tech.in.gpl lib/techmap/gencomp/tech.in
	mv doc/Changelog-gpl.txt doc/Changelog.txt
	make -f bin/Makefile cfgdep ;\
	xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

distft:
	rm -rf $(DISTLIB)/grlib-ft-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-ft-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-ft-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	make -C $(DISTLIB)/grlib-ft-$(VER)-b$(BID) ft

distftfpgabase:
	rm -rf $(DISTLIB)/grlib-ft-fpga-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-ft-fpga-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-ft-fpga-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	cp bin/Makefile $(DISTLIB)/grlib-ft-fpga-$(VER)-b$(BID)/bin
	make -C $(DISTLIB)/grlib-ft-fpga-$(VER)-b$(BID) ftfpga

distftfpgamda:
	rm -rf $(DISTLIB)/grlib-ft-fpga-mda-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-ft-fpga-mda-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-ft-fpga-mda-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	cp bin/Makefile $(DISTLIB)/grlib-ft-fpga-mda-$(VER)-b$(BID)/bin
	make -C $(DISTLIB)/grlib-ft-fpga-mda-$(VER)-b$(BID) ftfpgamda

distfpgabase:
	rm -rf $(DISTLIB)/grlib-fpga-com-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-fpga-com-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-fpga-com-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	cp bin/Makefile $(DISTLIB)/grlib-fpga-com-$(VER)-b$(BID)/bin
	make -C $(DISTLIB)/grlib-fpga-com-$(VER)-b$(BID) fpga

distcom:
	rm -rf $(DISTLIB)/grlib-com-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-com-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-com-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	cp bin/Makefile $(DISTLIB)/grlib-com-$(VER)-b$(BID)/bin ;\
	make -C $(DISTLIB)/grlib-com-$(VER)-b$(BID) com

proa3:
	cp -r designs/ft*/* designs; rm -rf designs/ft*
	rm -rf $(INTFILES) $(HAPSFILES) netlists doc/Changelog-gpl.txt
	rm -rf doc/devices doc/grlib-ft-fpga.pdf doc/tmtc.pdf ;\
	rm -rf $(T1FILES) $(RMPROA3FILES) ; \
	rm -rf $(COREMP7FILES) ; \
	rm -rf $(FTFILES)
	rm -rf $(COMFILES) $(GRLIB2FILES); \
	cd doc; mv grlib/grlib.pdf grip/grip.pdf .; \
	mkdir devices ;\
	mv leon3ft-rtax/leon3ft-rtax-ag.pdf devices; \
	mv ftproasic3/ftfpga.pdf grlib-ft-proasic3.pdf ; \
	mv gr701/*.pdf devices ; \
	rm -rf grlib grip leon3ft-rtax ftfpga gr701 haps devices gr1553b ftproasic3
	-rm `find -name '*.fm' -print | xargs`
	-rm `find -name '*.book' -print | xargs`
	-rm -rf designs/leon3-ft*/bitfiles
	-rm -rf `find -name '*bitfiles' -print | xargs`
	-mkdir doc/tmtc
	-rm lib/techmap/proasic3*/leon3ft_proasic3*mmu*.vhd
	-rm lib/techmap/proasic3*/leon3ft_proasic3*fpu*.vhd
ifneq ("$(EXTRA)","")
	  for i in $(EXTRA); do cp -rp $(GRLIB)/$$i `dirname $$i`; done
endif
	cat lib/techmap/proasic3/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/proasic3/vhdlsyn.txt
	cat lib/techmap/proasic3e/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/proasic3e/vhdlsyn.txt
	cat lib/techmap/proasic3l/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/proasic3l/vhdlsyn.txt
	cat lib/techmap/fusion/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/fusion/vhdlsyn.txt
	cat lib/techmap/maps/vhdlsyn.txt | sed -e s/#// > x; mv x lib/techmap/maps/vhdlsyn.txt
ifneq ("$(REMOVE)","")
	  for i in $(REMOVE); do rm -rf $$i; done
endif
	cd lib/gaisler; mv leon3sim leon3ft
	mv software/leon3/Makefile.gpl software/leon3/Makefile
	-mkdir lib/gaisler/gr1553b lib/gaisler/leon3
	for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done
	mkdir tmp; mv boards/actel* boards/gr-mcc-c tmp; \
	rm -rf boards/*; mv tmp/* boards; rmdir tmp; \
	mkdir tmp; mv designs/*actel* designs/*gr-mcc-c* tmp; \
	rm -rf designs/*; mv tmp/* designs; rmdir tmp; \
	make -f bin/Makefile cfgdep
	xpwd=`pwd`; tname=`basename $$xpwd`; \
	echo creating $$xpwd.tar.gz ;\
	cd .. ; tar czf $$tname.tar.gz $$tname

distproa3base:
	rm -rf $(DISTLIB)/grlib-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	cp bin/Makefile $(DISTLIB)/grlib-$(VER)-b$(BID)/bin
	make -C $(DISTLIB)/grlib-$(VER)-b$(BID) proa3

distgplbase:
	rm -rf $(DISTLIB)/grlib-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grlib-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grlib-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	cp bin/Makefile $(DISTLIB)/grlib-$(VER)-b$(BID)/bin
	make -C $(DISTLIB)/grlib-$(VER)-b$(BID) gpl

dist:
	make distft distcom distgpl distfpga

axsmall:
	cp $(GRLIB)/lib/tech/axcelerator/components/axcelerator_small.vhd \
	   $(GRLIB)/lib/tech/axcelerator/components/axcelerator.vhd
	cp $(GRLIB)/lib/tech/axcelerator/components/axcelerator_components_small.vhd \
	   $(GRLIB)/lib/tech/axcelerator/components/axcelerator_components.vhd

axfull:
	cp $(GRLIB)/lib/tech/axcelerator/components/axcelerator_full.vhd \
	   $(GRLIB)/lib/tech/axcelerator/components/axcelerator.vhd
	cp $(GRLIB)/lib/tech/axcelerator/components/axcelerator_components_full.vhd \
	   $(GRLIB)/lib/tech/axcelerator/components/axcelerator_components.vhd

GPLDESIGNS = \
	leon3-altera-ep1c20        leon3-digilent-xup         leon3-xilinx-ml403 \
	leon3-altera-ep2s60-ddr    leon3-xilinx-ml40x \
	leon3-altera-ep2s60-sdr    leon3-ge-hpe-mini          leon3-xilinx-ml501 \
	leon3-xilinx-ml505 \
	leon3-altera-ep3c25        leon3-xilinx-ml506 \
	leon3-altera-ep3c25-eek    leon3-gr-cpci-xc2v6000     leon3-xilinx-ml507 \
	leon3-altera-ep3sl150      leon3-gr-cpci-xc4v         leon3-xilinx-ml509 \
	leon3-asic                 leon3-gr-pci-xc2v3000      leon3-xilinx-ml510 \
	leon3-avnet-3s1500         leon3-gr-pci-xc5v          \
	leon3-avnet-eval-xc4vlx25  leon3-gr-xc3s-1500         leon3-xilinx-xc3sd-1800 \
	leon3-avnet-eval-xc4vlx60  leon3mp \
	leon3-avnet-xc2v1500       leon3-memec-v2mb1000        \
	leon3-clock-gate           leon3-nuhorizons-3s1500     \
	leon3-digilent-xc3s1000    leon3-terasic-de2-115       \
	leon3-digilent-xc3s1600e   

vsimgpl:
	for i in $(GPLDESIGNS); do \
	  make -C designs/$$i vsim vsim-run; \
	done

cleangpl:
	for i in $(GPLDESIGNS); do \
	  make -C designs/$$i distclean; \
	done

COMDESIGNS = \
	leon3-actel-fusion leon3-actel-proasic3 leon3-actel-proasic3l \
	leon3-clk2x leon3-clock-gate leon3-gr-cpci-ax leon3-a3pe-proto-kit

vsimcom:
	for i in $(COMDESIGNS); do \
	  make -C designs/$$i vsim vsim-run; \
	done

disttases:
	make distftfpgabase EXTRA="netlists" \
	REMOVE="lib/tech*/proasic3*  lib/tech*/fusion doc/*proa* \
	designs/*proa* designs/*mcc* designs/*fusion* \
	lib/techmap/*/grfpw* lib/techmap/*/*grfpu_* lib/techmap/unisim/*4* \
	netlists/altera netlists/*/*/grf* \
	lib/gaisler/ddr/ft_ddr2spax_ahb.vhd \
	lib/techmap/unisim/ftmctrl_unisim_sd0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb1.vhd \
	lib/tech*/cust1 lib/tech*/eclipsee \
	lib/gr1553 lib/grlib/ftlib lib/gaisler/b1553 \
	lib/gaisler/spacewire/sim lib/gaisler/pci lib/gaisler/gr1553b \
	lib/actel " \
	VNAME="tases-"

disttai:
	make distftfpgabase EXTRA="netlists lib/gaisler/gr1553b lib/gaisler/pcif \
	lib/techmap/maps/corepcif_net.vhd" \
	REMOVE="lib/tech*/proasic3*  lib/tech*/fusion doc/*proa* \
	designs/*proa* designs/*mcc* designs/*fusion* \
	lib/techmap/*/grfpw* lib/techmap/*/*grfpu_* lib/techmap/unisim/*4* \
	netlists/altera netlists/*/*/grf* \
	lib/gaisler/ddr/ft_ddr2spax_ahb.vhd \
	lib/techmap/unisim/ftmctrl_unisim_sd0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb1.vhd \
	lib/tech*/cust1 lib/tech*/eclipsee" \
	VNAME="tai-"

distkari:
	make distftfpgabase EXTRA="netlists lib/gaisler/pcif \
	lib/gaisler/gr1553b/test lib/techmap/maps/corepcif_net.vhd" \
	REMOVE="lib/tech*/proasic3*  lib/tech*/fusion doc/*proa* \
	designs/*proa* designs/*mcc* designs/*fusion* \
	designs/leon3-ft-cpci-xc2v6000 designs/leon3-ft-hardi-haps51 \
	designs/leon3-ft-pci-xc2v3000 designs/leon3-gr-xc6s \
	lib/techmap/*/grfpw* lib/techmap/*/*grfpu_* lib/techmap/unisim/*4* \
	netlists/altera netlists/*/*/grf* \
	lib/gaisler/ddr/ft_ddr2spax_ahb.vhd \
	lib/techmap/unisim/ftmctrl_unisim_sd0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb1.vhd \
	lib/tech*/cust1 lib/tech*/eclipsee \
	lib/techmap/*/*_fpu* lib/techmap/*/grlfpw_*_* \
	lib/techmap/inferred/scanreg_inferred.vhd  lib/techmap/maps/scanreg.vhd \
	lib/gaisler/pci/grpci2 \
	designs/leon3-rtax-cid1 \
	lib/gaisler/spacewire/sim \
	lib/gaisler/gr1553b/test/gr1553b_tgapb.vhd \
	" \
	VNAME="kari-"

distiaa:
	make distftfpgabase EXTRA="netlists lib/gaisler/gr1553b/core lib/gaisler/gr1553b/test \
	lib/gaisler/gr1553b/wrap \
	designs/leon3-rtax-iaa" \
	REMOVE="lib/tech*/proasic3*  lib/tech*/fusion doc/*proa* \
	designs/*proa* designs/*mcc* designs/*fusion* \
	designs/leon3-ft-cpci-xc2v6000 designs/leon3-ft-hardi-haps51 \
	designs/leon3-ft-pci-xc2v3000 designs/leon3-gr-xc6s \
	lib/techmap/*/grfpw* lib/techmap/*/*grfpu_* lib/techmap/unisim/*4* \
	lib/techmap/inferred/scanreg_inferred.vhd  lib/techmap/maps/scanreg.vhd \
	netlists/altera netlists/*/*/grf* \
	lib/gaisler/ddr/ft_ddr2spax_ahb.vhd \
	lib/techmap/unisim/ftmctrl_unisim_sd0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb0.vhd \
	lib/techmap/unisim/spictrl_unisim_comb1.vhd \
	lib/tech*/cust1 lib/tech*/eclipsee \
	lib/techmap/*/*_fpu* lib/techmap/*/grlfpw_*_* \
	lib/gaisler/pci/grpci2 \
	designs/leon3-rtax-ci* \
	lib/gr1553 lib/gaisler/b1553/b1553b*.vhd \
	lib/gaisler/b1553/b1553r*.vhd lib/actel \
	lib/gaisler/spacewire/sim \
	" \
	VNAME="iaa-"

distfpga:
	make distfpgabase \
	REMOVE="\
	lib/techmap/inferred/scanreg_inferred.vhd  lib/techmap/maps/scanreg.vhd \
	"

distfpga-lanl:
	make distfpgabase \
	EXTRA="netlists \
	lib/tech/axcelerator lib/techmap/axcelerator \
	lib/techmap/proasic3 \
	lib/techmap/proasic3e \
	lib/techmap/proasic3l \
	lib/techmap/unisim \
	lib/gaisler/spacewire/grspw2_phy.vhd \
	designs/leon3-gr-cpci-ax \
	verification/grspw \
	doc/grspw \
	" \
	REMOVE="\
	netlists/*/*/*ft* netlists/*/*/grl* netlists/*/*/grf* \
	lib/techmap/inferred/scanreg_inferred.vhd  lib/techmap/maps/scanreg.vhd \
	lib/techmap/*/*ft* lib/techmap/*/grl* lib/techmap/*/grf* \
	lib/techmap/*/corepci* lib/techmap/*/grusb* lib/techmap/*/spi* \
	verification/leon3-clk2x verification/leon4-clk2x verification/apbuart \
	verification/grpci2 doc/grspw/*.fm doc/grspw/*.book doc/grspw/*.txt \
	doc/grspw/grspw2_gen.pdf doc/Changelog-gpl.txt doc/ftproasic3 \
	doc/gr1553b boards/altera* designs/*altera* \
	" \
	VNAME="lanl-"

distftfpga:
	make distftfpgabase EXTRA="" \
	REMOVE="\
	doc/ftproasic3 doc/gr1553b \
	lib/techmap/*/grfpu_* lib/techmap/unisim/*4* \
	netlists/altera netlists/*/*/*4* \
	lib/techmap/*/ftmctrl_unisim_*.vhd \
	lib/techmap/*/spictrl_unisim_*.vhd \
	lib/tech*/cust1 lib/tech*/eclipsee \
	lib/techmap/inferred/scanreg_inferred.vhd  \
	lib/techmap/maps/scanreg.vhd \
	lib/gaisler/spacewire/sim \
	designs/leon3-rtax-iaa"


grspwbase:
	@for i in `find -name '*.vhd' -print | xargs`; do \
	  if test -r $$i; then sed -f bin/gr.sed $$i > x; mv x $$i; fi; \
	done ;\
	mkdir tmp
	mkdir tmp/doc
	mkdir tmp/core
	cp doc/grspw/grspw.pdf doc/grspw/grspw2_gen.pdf tmp/doc
	rm -rf doc
	cp lib/techmap/maps/allddr.vhd lib/techmap/maps/allmem.vhd \
        lib/grlib/amba/amba.vhd lib/techmap/axcelerator/axcomp.vhd \
	lib/techmap/axcelerator/ddr_axcelerator.vhd lib/techmap/inferred/ddr_inferred.vhd \
	lib/techmap/maps/ddr_ireg.vhd lib/techmap/maps/ddr_oreg.vhd lib/techmap/unisim/ddr_unisim.vhd \
	lib/grlib/amba/devices.vhd lib/grlib/ftlib/ftlib.vhd lib/techmap/gencomp/gencomp.vhd \
	lib/gaisler/spacewire/grspw2_phy.vhd lib/spw/core/grspwpkg.vhd \
	lib/spw/core/grspwrx2.vhd lib/spw/core/grspwtx2.vhd  \
	lib/techmap/axcelerator/memory_axcelerator.vhd lib/techmap/inferred/memory_inferred.vhd \
	lib/techmap/unisim/memory_unisim.vhd lib/gaisler/spacewire/spacewire.vhd lib/spw/comp/spwcomp.vhd \
	lib/spw/core/sw_rstgen.vhd lib/techmap/maps/syncram.vhd \
	lib/techmap/maps/syncram_2p.vhd lib/techmap/maps/syncram_2pft.vhd \
	lib/grlib/stdlib/stdlib.vhd lib/grlib/util/util.vhd lib/grlib/stdlib/version.vhd \
	lib/grlib/stdlib/config.vhd tmp/core
	rm -rf designs designs2 cfg boards TODO.txt netlists projects 

grspw2_gen: 
	mkdir tmp/software
	cp -R lib/spw/source_dist/grspw2_gen/* tmp
	rm verification/grspw/spw_phy.vhd verification/grspw/grspw_tb.vhd
	mv verification/grspw tmp/testbench
	cp lib/grlib/stdlib/stdio.vhd lib/grlib/stdlib/testlib.vhd tmp/testbench
	cp lib/spw/wrapper/grspw2_gen.vhd lib/spw/core/grspwc2.vhd lib/spw/core/sw_ahb_mst.vhd tmp/core 
	cp lib/grlib/atf/at_* lib/grlib/amba/apbctrl.vhd lib/gaisler/spacewire/sim/spacewire_tp.vhd \
        lib/gaisler/spacewire/sim/rmap_tp.vhd tmp/testbench
	cp software/spw/Makefile software/spw/rmapapi.c software/spw/rmapapi.h software/spw/spwapi.c \
	software/spw/spwapi.h software/spw/spwtest.c software/spw/spw_test_dual.c software/spw/spw_test_dual_sep.c \
	tmp/software 
	rm -rf verification software bin Makefile make.grlib2 lib
	mv tmp/* . 
	rm -rf tmp

grspwcodec:
	cp -R lib/spw/source_dist/grspw_codec/* tmp
	cp lib/spw/core/grspw_codec_core.vhd lib/gaisler/spacewire/grspw_codec.vhd tmp/core
	rm verification/grspw_codec/spw_phy.vhd
	mv verification/grspw_codec tmp/testbench
	cp lib/grlib/atf/at_* lib/grlib/amba/apbctrl.vhd lib/gaisler/spacewire/sim/spacewire_tp.vhd \
        lib/gaisler/spacewire/sim/rmap_tp.vhd lib/gaisler/spacewire/sim/spw_sim_codec.vhd \
        lib/gaisler/spacewire/sim/spw_sim_codec_pkg.vhd tmp/testbench
	cp lib/grlib/stdlib/stdio.vhd lib/grlib/stdlib/testlib.vhd tmp/testbench
	rm -rf verification software bin Makefile make.grlib2 lib
	rm tmp/doc/grspw2_gen.pdf
	mv tmp/* . 
	rm -rf tmp

distgrspw2_gen:
	rm -rf $(DISTLIB)/grspw2-source-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grspw2_gen-source-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grspw2_gen-source-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	make -C $(DISTLIB)/grspw2_gen-source-$(VER)-b$(BID) grspwbase
	make -C $(DISTLIB)/grspw2_gen-source-$(VER)-b$(BID) grspw2_gen

distgrspwcodec: 
	rm -rf $(DISTLIB)/grspwcodec-source-$(VER)-b$(BID) ;\
	echo exporting repository to $(DISTLIB)/grspwcodec-source-$(VER)-b$(BID) ;\
	git archive --format=tar --prefix=grspwcodec-source-$(VER)-b$(BID)/ HEAD | tar -x -C $(DISTLIB) ;\
	make -C $(DISTLIB)/grspwcodec-source-$(VER)-b$(BID) grspwbase
	make -C $(DISTLIB)/grspwcodec-source-$(VER)-b$(BID) grspwcodec

distcomfuji:
	make distcom \
	EXTRA="lib/techmap/proasic3/grlfpw_0_proasic3.vhd \
	lib/techmap/proasic3e/grlfpw_0_proasic3e.vhd \
	lib/techmap/proasic3l/grlfpw_0_proasic3l.vhd" \
	REMOVE="lib/gaisler/leon3ft doc/Changelog-gpl.txt" \
	VNAME="fuji-"

distgpl:
	make distgplbase \
	REMOVE="lib/tech*/proa* lib/tech*/axc* boards/actel* \
	boards/gr-mcc-c designs/*actel* designs/*mcc* lib/tech*/apa* \
	lib/tech*/fusion designs/*a3pe*" \
	VNAME="gpl-"

distcoml4:
	make distcom \
	EXTRA="$(LEON4FILES)" \
	REMOVE="$(FPU) designs/leon4-avnet-eval-xc4vlx60 \
	designs/leon4-gr-xc6s-l2 designs/leon4-natasha \
	designs/leon4-ngmp designs/leon4-test" \
	VNAME="l4-"

distorbita:
	make distcoml4base \
	EXTRA="$(GBITFILES) $(USBFILES) $(GR1553BFILES) \
	$(GRSPWCORE) \
	lib/tech/tm65gplus lib/techmap/tm65gplus \
	lib/tmtc software/ccsds doc/tmtc \
	lib/gaisler/spacewire/grspw2_phy.vhd \
	verification/ahb2ahb \
	verification/ahbbridge \
	verification/ahbmst2 \
	verification/can_oc \
	verification/grcan \
	verification/grfpu \
	verification/grspw \
	verification/grtc \
	verification/grtm \
	verification/grtmtc \
	verification/i2c \
	verification/mobile_ddr_sdr \
	verification/spictrl \
	verification/grctm \
	lib/tech/virage90 lib/techmap/virage90 \
	verification/greth \
	" \
	REMOVE="\
	lib/gaisler/leon4ft \
	lib/gaisler/pci/grpci2 lib/gaisler/pci/doc \
	doc/ft* doc/Changelog-gpl.txt \
	doc/tmtc/*_* doc/tmtc/Makefile doc/tmtc/ecss.gif doc/tmtc/ccsds.jpg  doc/tmtc/tmtc.book \
	lib/tmtc/grctm/*cuc* \
	software/ccsds/*aes* \
	lib/tech/proasic3e lib/techmap/proasic3e \
	lib/tech/proasic3l lib/techmap/proasic3l \
	lib/tech/virage90 lib/techmap/virage90 \
	designs/leon3-gr-mcc-c \
	lib/techmap/proasic3/*ft* \
	lib/techmap/*/gr*_*_* \
	lib/techmap/t*/grf* \
	lib/tech/*/*/grf* \
	" \
	VNAME="orbita-"

distfpga-mfti:
	make distproa3base \
	EXTRA="$(ADDPROA3FILES) $(TMTC) \
	lib/techmap/proasic3/leon3ft_proasic3_8_4_fpu.vhd \
	lib/techmap/proasic3/leon3ft_proasic3_8_4_fpu_v8.vhd \
	lib/techmap/proasic3e/leon3ft_proasic3e_8_4_fpu.vhd \
	lib/techmap/proasic3e/leon3ft_proasic3e_8_4_fpu_v8.vhd \
	lib/techmap/proasic3l/leon3ft_proasic3l_8_4_fpu.vhd \
	lib/techmap/proasic3l/leon3ft_proasic3l_8_4_fpu_v8.vhd \
	" \
	REMOVE="$(SKIPTMTC1) $(SKIPTMTC2) \
	lib/tech*/fusion designs/leon3-actel-fusion" \
	VNAME="ft-proasic3-mfti-"

disti2c:
	make distcom \
	EXTRA="lib/gaisler/l2cache verification/l2c" \
	REMOVE="designs lib/contrib lib/cypress lib/esa lib/fmf \
	lib/gleichmann lib/gsi lib/hynix lib/micron lib/openchip \
	lib/praesum lib/spansion lib/spw \
	lib/gaisler/arith lib/gaisler/ata \
	lib/gaisler/can lib/gaisler/ddr lib/gaisler/gr1553b \
	lib/gaisler/jtag lib/gaisler/leon3 lib/gaisler/leon3ft \
	lib/gaisler/memctrl lib/gaisler/misc lib/gaisler/pci \
	lib/gaisler/spacewire lib/gaisler/uart lib/gaisler/usb \
	verification/ahb2ahb verification/ahbbridge verification/apbuart \
	verification/can_oc verification/grcan verification/grpci2 \
	verification/leon3-clk2x verification/mobile_ddr_sdr \
	verification/spi* lib/*/spi \
	lib/opencores/can lib/opencores/ata lib/opencores/ac97 \
	" \
	VNAME="i2c-"
