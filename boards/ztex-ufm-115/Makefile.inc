TECHNOLOGY=Spartan6
ISETECH="Spartan6"
PACKAGE=csg484
ifeq ("$(CONFIG_FPGA_LX45)","y")
PART=XC6SLX45
SPEED=-3
else
ifeq ("$(CONFIG_FPGA_LX75)","y")
PART=XC6SLX75
SPEED=-3
else
ifeq ("$(CONFIG_FPGA_LX100)","y")
PART=XC6SLX100
SPEED=-3
else
ifeq ("$(CONFIG_FPGA_LX150)","y")
PART=XC6SLX150
SPEED=-3
else
PART=XC6SLX75
SPEED=-3
endif
endif
endif
endif
SYNFREQ=100
MANUFACTURER=Xilinx
MGCPART=$(PART)$(PACKAGE)
MGCTECHNOLOGY=SPARTAN-6
MGCPACKAGE=$(PACKAGE)
