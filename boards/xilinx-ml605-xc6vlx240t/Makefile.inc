# Since synplify seems to cause a synthsis error involving
# the DSP macro blocks the Spartan 3A technology 
# without DSP is used for synthesis
#
TECHNOLOGY=Virtex6
ISETECH="Virtex6"
PART=XC6VLX240T
PACKAGE=ff1156
SPEED=-1
SYNFREQ=220
PROMGENPAR=-x xcf08p -u 0 $(TOP).bit -p mcs -w -o xilinx-ml605-xc6vlx240t

MANUFACTURER=Xilinx
MGCPART=XC6VLX16$(PACKAGE)
MGCTECHNOLOGY=VIRTEX-6
MGCPACKAGE=$(PACKAGE)

# Set PlanAhead Synthesis Flow and Strategy used for build
PLANAHEAD_SYNTH_FLOW="XST 14"
PLANAHEAD_SYNTH_STRATEGY="TimingWithIOBPacking"

# Set PlanAhead Implementation strategy
PLANAHEAD_IMPL_STRATEGY="MapLogicOptParHighExtra"
