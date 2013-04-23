# FPGA and Dev Board used in Design
TECHNOLOGY=zynq7000
PART=XC7Z020
PACKAGE=CLG484
PROTOBOARD=zedBoard
SPEED=1

# Set Vivado Synthesis Flow and Strategy used for build
# Choose 'XST 14' or 'Vivado Synthesis 2012'
PLANAHEAD_SYNTH_FLOW="XST 14"

# For 'Vivado Synthesis 2012'
#    1. 'Vivado Synthesis Defaults'
# For 'XST 14'
#    1. 'TimingWithIOBPacking'
#    2. 'TimingWithoutIOBPacking'
#    3. 'AreaReduction'
#    4. 'PowerOptimization'
#    5. 'XST Defaults'
PLANAHEAD_SYNTH_STRATEGY="XST Defaults"

# Set Vivado Implementation strategy
#   1. HighEffort
#   2. HighEffortPhySynth
#   3. 'Vivado Implemnation Defaults'
#   4. LowEffort
#   5. QuickEffort
PLANAHEAD_IMPL_STRATEGY="ParHighEffort"
