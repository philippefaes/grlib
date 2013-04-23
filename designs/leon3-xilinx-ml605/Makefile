include .config
GRLIB=../..
TOP=leon3mp
DESIGN=leon3-xilinx-ml605
BOARD=xilinx-ml605-xc6vlx240t
include $(GRLIB)/boards/$(BOARD)/Makefile.inc
DEVICE=$(PART)-$(PACKAGE)$(SPEED)
#UCF=$(GRLIB)/boards/$(BOARD)/$(TOP).ucf
UCF=$(TOP).ucf
UCF_PLANAHEAD=$(TOP)_mig39.ucf

#ISEMAPOPT=-timing
QSF=$(GRLIB)/boards/$(BOARD)/$(TOP).qsf
EFFORT=high
XSTOPT=-uc leon3mp.xcf
SYNPOPT="set_option -pipe 1; set_option -retiming 0; set_option -enable_prepacking 1;\
set_option -write_apr_constraint 0;set_option -resource_sharing 1; set_option -symbolic_fsm_compiler 1"
VHDLOPTSYNFILES= \
	mig_37/user_design/rtl/controller/arb_mux.vhd \
	mig_37/user_design/rtl/controller/arb_row_col.vhd \
	mig_37/user_design/rtl/controller/arb_select.vhd \
	mig_37/user_design/rtl/controller/bank_cntrl.vhd \
	mig_37/user_design/rtl/controller/bank_common.vhd \
	mig_37/user_design/rtl/controller/bank_compare.vhd \
	mig_37/user_design/rtl/controller/bank_mach.vhd \
	mig_37/user_design/rtl/controller/bank_queue.vhd \
	mig_37/user_design/rtl/controller/bank_state.vhd \
	mig_37/user_design/rtl/controller/col_mach.vhd \
	mig_37/user_design/rtl/controller/mc.vhd \
	mig_37/user_design/rtl/controller/rank_cntrl.vhd \
	mig_37/user_design/rtl/controller/rank_common.vhd \
	mig_37/user_design/rtl/controller/rank_mach.vhd \
	mig_37/user_design/rtl/controller/round_robin_arb.vhd \
	mig_37/user_design/rtl/ecc/ecc_buf.vhd \
	mig_37/user_design/rtl/ecc/ecc_dec_fix.vhd \
	mig_37/user_design/rtl/ecc/ecc_gen.vhd \
	mig_37/user_design/rtl/ecc/ecc_merge_enc.vhd \
	mig_37/user_design/rtl/ip_top/clk_ibuf.vhd \
	mig_37/user_design/rtl/ip_top/ddr2_ddr3_chipscope.vhd \
	mig_37/user_design/rtl/ip_top/infrastructure.vhd \
	mig_37/user_design/rtl/ip_top/iodelay_ctrl.vhd \
	mig_37/user_design/rtl/ip_top/mem_intfc.vhd \
	mig_37/user_design/rtl/ip_top/memc_ui_top.vhd \
	mig_37/user_design/rtl/ip_top/mig_37.vhd \
	mig_37/user_design/rtl/phy/circ_buffer.vhd \
	mig_37/user_design/rtl/phy/phy_ck_iob.vhd \
	mig_37/user_design/rtl/phy/phy_clock_io.vhd \
	mig_37/user_design/rtl/phy/phy_control_io.vhd \
	mig_37/user_design/rtl/phy/phy_data_io.vhd \
	mig_37/user_design/rtl/phy/phy_dly_ctrl.vhd \
	mig_37/user_design/rtl/phy/phy_dm_iob.vhd \
	mig_37/user_design/rtl/phy/phy_dq_iob.vhd \
	mig_37/user_design/rtl/phy/phy_dqs_iob.vhd \
	mig_37/user_design/rtl/phy/phy_init.vhd \
	mig_37/user_design/rtl/phy/phy_pd.vhd \
	mig_37/user_design/rtl/phy/phy_pd_top.vhd \
	mig_37/user_design/rtl/phy/phy_rdclk_gen.vhd \
	mig_37/user_design/rtl/phy/phy_rdctrl_sync.vhd \
	mig_37/user_design/rtl/phy/phy_rddata_sync.vhd \
	mig_37/user_design/rtl/phy/phy_rdlvl.vhd \
	mig_37/user_design/rtl/phy/phy_read.vhd \
	mig_37/user_design/rtl/phy/phy_top.vhd \
	mig_37/user_design/rtl/phy/phy_write.vhd \
	mig_37/user_design/rtl/phy/phy_wrlvl.vhd \
	mig_37/user_design/rtl/phy/rd_bitslip.vhd \
	mig_37/user_design/rtl/ui/ui_cmd.vhd \
	mig_37/user_design/rtl/ui/ui_rd_data.vhd \
	mig_37/user_design/rtl/ui/ui_top.vhd \
	mig_37/user_design/rtl/ui/ui_wr_data.vhd
VERILOGOPTSYNFILES= \
	mig/user_design/rtl/controller/*.v \
	mig/user_design/rtl/ecc/*.v \
	mig/user_design/rtl/ip_top/*.v \
	mig/user_design/rtl/phy/*.v \
	mig/user_design/rtl/phy/*.v \
	mig/user_design/rtl/ui/*.v \
	$$XILINX/verilog/src/glbl.v
VHDLSYNFILES= \
	ahb2mig_ml605.vhd config.vhd ahbrom.vhd \
	svga2ch7301c.vhd gtxclk.vhd leon3mp.vhd
VHDLSIMFILES=testbench.vhd
SIMTOP=testbench
SDCFILE=default.sdc
BITGEN=$(GRLIB)/boards/$(BOARD)/default.ut
CLEAN=soft-clean
TECHLIBS = secureip unisim
VLOGOPT= +define+x1Gb +define+sg187E +define+x16
VSIMOPT= -gdisas=1 -gDEBUG=0 -i -do preload_ddr3_dimm.do -t ps -novopt +notimingchecks -L secureip_ver -L xilinxcorelib_ver -L unisims_ver glbl $(SIMTOP)
EXTRA_SOFT = gen_hex_dim16

LIBSKIP = core1553bbc core1553brm core1553brt gr1553 corePCIF \
	tmtc openchip ihp usbhc spw gsi cypress hynix \
	spansion
DIRSKIP = b1553 pcif leon2 leon2ft crypto satcan pci ambatest can \
	usb grusbhc spacewire ascs slink spi hcan \
	leon4 leon4v0 l2cache pwm gr1553b iommu ac97
FILESKIP = grcan.vhd ddr2.v mobile_ddr.v
GRLIB_CONFIG = grlib_config.vhd

include $(GRLIB)/bin/Makefile
include $(GRLIB)/software/leon3/Makefile

##################  project specific targets ##########################

mig_37 mig:
	coregen -b mig.xco -p .
	patch -p1 < mig.diff

migclean:
	-rm -rf mig_37* tmp coregen.log

mig39:
	coregen -b mig39.xco -p mig39.cgp
	patch -p1 < mig_patch.txt
	patch -p1 < mig_iodelay_ctrl_patch.txt
	patch -p1 < mig_infrastructure_patch.txt
	patch -p1 < mig_ucf_patch.txt

mig39clean:
	-rm -rf mig tmp coregen.log
