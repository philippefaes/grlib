# FPGA and Dev Board used in Design
TECHNOLOGY=Kintex7
PART=XC7K325T
PACKAGE=ffg900
PROTOBOARD=kc705
SPEED=2
PROMGENPAR=-x xcf08p -u 0 $(TOP).bit -p mcs -w -o $(BOARD)

# Set Vivado Synthesis Flow and Strategy used for build
# Choose 'XST 14' or 'Vivado Synthesis 2012'
VIVADO_SYNTH_FLOW="Vivado Synthesis 2012"

# For 'Vivado Synthesis 2012'
#    1. 'Vivado Synthesis Defaults'
# For 'XST 14'
#    1. 'TimingWithIOBPacking'
#    2. 'TimingWithoutIOBPacking'
#    3. 'AreaReduction'
#    4. 'PowerOptimization'
#    5. 'XST Defaults'
VIVADO_SYNTH_STRATEGY="Vivado Synthesis Defaults"

# Set Vivado Implementation strategy
#   1. HighEffort
#   2. HighEffortPhySynth
#   3. 'Vivado Implemnation Defaults'
#   4. LowEffort
#   5. QuickEffort
VIVADO_IMPL_STRATEGY="HighEffort"
