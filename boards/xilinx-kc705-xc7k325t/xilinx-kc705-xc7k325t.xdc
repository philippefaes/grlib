# Define and contraint system clock
create_clock -name clk200 -period 5 [get_ports clk200p] 
set_propagated_clock clk200

set_property PACKAGE_PIN AD12 [get_ports {clk200p}]
set_property PACKAGE_PIN AD11 [get_ports {clk200n}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {clk200p}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {clk200n}]
set_property VCCAUX_IO DONTCARE [get_ports {clk200p}]
set_property VCCAUX_IO DONTCARE [get_ports {clk200n}]

set_property PACKAGE_PIN AG5  [get_ports {reset      }]

set_property PACKAGE_PIN AB8  [get_ports {led[0]     }]
set_property PACKAGE_PIN AA8  [get_ports {led[1]     }]
set_property PACKAGE_PIN AC9  [get_ports {led[2]     }]
set_property PACKAGE_PIN AB9  [get_ports {led[3]     }]
set_property PACKAGE_PIN AE26 [get_ports {led[4]     }]
set_property PACKAGE_PIN G19  [get_ports {led[5]     }]
set_property PACKAGE_PIN E18  [get_ports {led[6]     }]

set_property PACKAGE_PIN P24 [get_ports {data[0]     }]
set_property PACKAGE_PIN R25 [get_ports {data[1]     }]
set_property PACKAGE_PIN R20 [get_ports {data[2]     }]
set_property PACKAGE_PIN R21 [get_ports {data[3]     }]
set_property PACKAGE_PIN T20 [get_ports {data[4]     }]
set_property PACKAGE_PIN T21 [get_ports {data[5]     }]
set_property PACKAGE_PIN T22 [get_ports {data[6]     }]
set_property PACKAGE_PIN T23 [get_ports {data[7]     }]
set_property PACKAGE_PIN U20 [get_ports {data[8]     }]
set_property PACKAGE_PIN P29 [get_ports {data[9]     }]
set_property PACKAGE_PIN R29 [get_ports {data[10]    }]
set_property PACKAGE_PIN P27 [get_ports {data[11]    }]
set_property PACKAGE_PIN P28 [get_ports {data[12]    }]
set_property PACKAGE_PIN T30 [get_ports {data[13]    }]
set_property PACKAGE_PIN P26 [get_ports {data[14]    }]
set_property PACKAGE_PIN R26 [get_ports {data[15]    }]

set_property PACKAGE_PIN M22 [get_ports {address[25] }]
set_property PACKAGE_PIN M23 [get_ports {address[24] }]
set_property PACKAGE_PIN N26 [get_ports {address[23] }]
set_property PACKAGE_PIN N19 [get_ports {address[22] }]
set_property PACKAGE_PIN N20 [get_ports {address[21] }]
set_property PACKAGE_PIN N21 [get_ports {address[20] }]
set_property PACKAGE_PIN N22 [get_ports {address[19] }]
set_property PACKAGE_PIN N24 [get_ports {address[18] }]
set_property PACKAGE_PIN P21 [get_ports {address[17] }]
set_property PACKAGE_PIN P22 [get_ports {address[16] }]
set_property PACKAGE_PIN V27 [get_ports {address[15] }]
set_property PACKAGE_PIN V29 [get_ports {address[14] }]
set_property PACKAGE_PIN V30 [get_ports {address[13] }]
set_property PACKAGE_PIN V25 [get_ports {address[12] }]
set_property PACKAGE_PIN W26 [get_ports {address[11] }]
set_property PACKAGE_PIN V19 [get_ports {address[10] }]
set_property PACKAGE_PIN V20 [get_ports {address[9]  }]
set_property PACKAGE_PIN W23 [get_ports {address[8]  }]
set_property PACKAGE_PIN W24 [get_ports {address[7]  }]
set_property PACKAGE_PIN U23 [get_ports {address[6]  }]
set_property PACKAGE_PIN V21 [get_ports {address[5]  }]
set_property PACKAGE_PIN V22 [get_ports {address[4]  }]
set_property PACKAGE_PIN U24 [get_ports {address[3]  }]
set_property PACKAGE_PIN V24 [get_ports {address[2]  }]
set_property PACKAGE_PIN W21 [get_ports {address[1]  }]
set_property PACKAGE_PIN W22 [get_ports {address[0]  }]

set_property PACKAGE_PIN M30 [get_ports {adv         }]
set_property PACKAGE_PIN U19 [get_ports {romsn       }]
set_property PACKAGE_PIN M24  [get_ports {oen         }]
set_property PACKAGE_PIN M25  [get_ports {writen      }]

set_property PACKAGE_PIN K24 [get_ports {dsurx        }]
set_property PACKAGE_PIN K23 [get_ports {dsurtsn      }]
set_property PACKAGE_PIN M19 [get_ports {dsutx        }]
set_property PACKAGE_PIN L27 [get_ports {dsuctsn      }]

set_property PACKAGE_PIN G12  [get_ports {button[0]   }]
set_property PACKAGE_PIN AA12 [get_ports {button[1]   }]
set_property PACKAGE_PIN AB12 [get_ports {button[2]   }]

set_property PACKAGE_PIN Y28  [get_ports {switch[0]   }]
set_property PACKAGE_PIN AA28 [get_ports {switch[1]   }]
set_property PACKAGE_PIN W29  [get_ports {switch[2]   }]
set_property PACKAGE_PIN Y29  [get_ports {switch[3]   }]

set_property PACKAGE_PIN L21 [get_ports {iic_scl      }]
set_property PACKAGE_PIN K21 [get_ports {iic_sda      }]

set_property IOSTANDARD LVCMOS25 [get_ports {dsurx      }]
set_property IOSTANDARD LVCMOS25 [get_ports {dsurtsn    }]
set_property IOSTANDARD LVCMOS25 [get_ports {dsutx      }]
set_property IOSTANDARD LVCMOS25 [get_ports {dsuctsn    }]


# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[0]}]
set_property SLEW FAST [get_ports {ddr3_dq[0]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[0]}]
set_property LOC AA15 [get_ports {ddr3_dq[0]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[1]}]
set_property SLEW FAST [get_ports {ddr3_dq[1]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[1]}]
set_property LOC AA16 [get_ports {ddr3_dq[1]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[2]}]
set_property SLEW FAST [get_ports {ddr3_dq[2]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[2]}]
set_property LOC AC14 [get_ports {ddr3_dq[2]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[3]}]
set_property SLEW FAST [get_ports {ddr3_dq[3]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[3]}]
set_property LOC AD14 [get_ports {ddr3_dq[3]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[4]}]
set_property SLEW FAST [get_ports {ddr3_dq[4]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[4]}]
set_property LOC AA17 [get_ports {ddr3_dq[4]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[5]}]
set_property SLEW FAST [get_ports {ddr3_dq[5]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[5]}]
set_property LOC AB15 [get_ports {ddr3_dq[5]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[6]}]
set_property SLEW FAST [get_ports {ddr3_dq[6]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[6]}]
set_property LOC AE15 [get_ports {ddr3_dq[6]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[7]}]
set_property SLEW FAST [get_ports {ddr3_dq[7]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[7]}]
set_property LOC Y15 [get_ports {ddr3_dq[7]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[8]}]
set_property SLEW FAST [get_ports {ddr3_dq[8]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[8]}]
set_property LOC AB19 [get_ports {ddr3_dq[8]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[9]}]
set_property SLEW FAST [get_ports {ddr3_dq[9]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[9]}]
set_property LOC AD16 [get_ports {ddr3_dq[9]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[10]}]
set_property SLEW FAST [get_ports {ddr3_dq[10]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[10]}]
set_property LOC AC19 [get_ports {ddr3_dq[10]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[11]}]
set_property SLEW FAST [get_ports {ddr3_dq[11]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[11]}]
set_property LOC AD17 [get_ports {ddr3_dq[11]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[12]}]
set_property SLEW FAST [get_ports {ddr3_dq[12]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[12]}]
set_property LOC AA18 [get_ports {ddr3_dq[12]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[13]}]
set_property SLEW FAST [get_ports {ddr3_dq[13]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[13]}]
set_property LOC AB18 [get_ports {ddr3_dq[13]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[14]}]
set_property SLEW FAST [get_ports {ddr3_dq[14]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[14]}]
set_property LOC AE18 [get_ports {ddr3_dq[14]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[15]}]
set_property SLEW FAST [get_ports {ddr3_dq[15]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[15]}]
set_property LOC AD18 [get_ports {ddr3_dq[15]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[16]}]
set_property SLEW FAST [get_ports {ddr3_dq[16]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[16]}]
set_property LOC AG19 [get_ports {ddr3_dq[16]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[17]}]
set_property SLEW FAST [get_ports {ddr3_dq[17]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[17]}]
set_property LOC AK19 [get_ports {ddr3_dq[17]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[18]}]
set_property SLEW FAST [get_ports {ddr3_dq[18]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[18]}]
set_property LOC AG18 [get_ports {ddr3_dq[18]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[19]}]
set_property SLEW FAST [get_ports {ddr3_dq[19]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[19]}]
set_property LOC AF18 [get_ports {ddr3_dq[19]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[20]}]
set_property SLEW FAST [get_ports {ddr3_dq[20]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[20]}]
set_property LOC AH19 [get_ports {ddr3_dq[20]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[21]}]
set_property SLEW FAST [get_ports {ddr3_dq[21]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[21]}]
set_property LOC AJ19 [get_ports {ddr3_dq[21]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[22]}]
set_property SLEW FAST [get_ports {ddr3_dq[22]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[22]}]
set_property LOC AE19 [get_ports {ddr3_dq[22]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[23]}]
set_property SLEW FAST [get_ports {ddr3_dq[23]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[23]}]
set_property LOC AD19 [get_ports {ddr3_dq[23]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[24]}]
set_property SLEW FAST [get_ports {ddr3_dq[24]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[24]}]
set_property LOC AK16 [get_ports {ddr3_dq[24]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[25]}]
set_property SLEW FAST [get_ports {ddr3_dq[25]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[25]}]
set_property LOC AJ17 [get_ports {ddr3_dq[25]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[26]}]
set_property SLEW FAST [get_ports {ddr3_dq[26]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[26]}]
set_property LOC AG15 [get_ports {ddr3_dq[26]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[27]}]
set_property SLEW FAST [get_ports {ddr3_dq[27]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[27]}]
set_property LOC AF15 [get_ports {ddr3_dq[27]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[28]}]
set_property SLEW FAST [get_ports {ddr3_dq[28]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[28]}]
set_property LOC AH17 [get_ports {ddr3_dq[28]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[29]}]
set_property SLEW FAST [get_ports {ddr3_dq[29]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[29]}]
set_property LOC AG14 [get_ports {ddr3_dq[29]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[30]}]
set_property SLEW FAST [get_ports {ddr3_dq[30]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[30]}]
set_property LOC AH15 [get_ports {ddr3_dq[30]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[31]}]
set_property SLEW FAST [get_ports {ddr3_dq[31]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[31]}]
set_property LOC AK15 [get_ports {ddr3_dq[31]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[32]}]
set_property SLEW FAST [get_ports {ddr3_dq[32]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[32]}]
set_property LOC AK8 [get_ports {ddr3_dq[32]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[33]}]
set_property SLEW FAST [get_ports {ddr3_dq[33]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[33]}]
set_property LOC AK6 [get_ports {ddr3_dq[33]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[34]}]
set_property SLEW FAST [get_ports {ddr3_dq[34]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[34]}]
set_property LOC AG7 [get_ports {ddr3_dq[34]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[35]}]
set_property SLEW FAST [get_ports {ddr3_dq[35]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[35]}]
set_property LOC AF7 [get_ports {ddr3_dq[35]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[36]}]
set_property SLEW FAST [get_ports {ddr3_dq[36]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[36]}]
set_property LOC AF8 [get_ports {ddr3_dq[36]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[37]}]
set_property SLEW FAST [get_ports {ddr3_dq[37]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[37]}]
set_property LOC AK4 [get_ports {ddr3_dq[37]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[38]}]
set_property SLEW FAST [get_ports {ddr3_dq[38]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[38]}]
set_property LOC AJ8 [get_ports {ddr3_dq[38]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[39]}]
set_property SLEW FAST [get_ports {ddr3_dq[39]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[39]}]
set_property LOC AJ6 [get_ports {ddr3_dq[39]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[40]}]
set_property SLEW FAST [get_ports {ddr3_dq[40]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[40]}]
set_property LOC AH5 [get_ports {ddr3_dq[40]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[41]}]
set_property SLEW FAST [get_ports {ddr3_dq[41]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[41]}]
set_property LOC AH6 [get_ports {ddr3_dq[41]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[42]}]
set_property SLEW FAST [get_ports {ddr3_dq[42]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[42]}]
set_property LOC AJ2 [get_ports {ddr3_dq[42]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[43]}]
set_property SLEW FAST [get_ports {ddr3_dq[43]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[43]}]
set_property LOC AH2 [get_ports {ddr3_dq[43]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[44]}]
set_property SLEW FAST [get_ports {ddr3_dq[44]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[44]}]
set_property LOC AH4 [get_ports {ddr3_dq[44]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[45]}]
set_property SLEW FAST [get_ports {ddr3_dq[45]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[45]}]
set_property LOC AJ4 [get_ports {ddr3_dq[45]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[46]}]
set_property SLEW FAST [get_ports {ddr3_dq[46]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[46]}]
set_property LOC AK1 [get_ports {ddr3_dq[46]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[47]}]
set_property SLEW FAST [get_ports {ddr3_dq[47]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[47]}]
set_property LOC AJ1 [get_ports {ddr3_dq[47]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[48]}]
set_property SLEW FAST [get_ports {ddr3_dq[48]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[48]}]
set_property LOC AF1 [get_ports {ddr3_dq[48]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[49]}]
set_property SLEW FAST [get_ports {ddr3_dq[49]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[49]}]
set_property LOC AF2 [get_ports {ddr3_dq[49]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[50]}]
set_property SLEW FAST [get_ports {ddr3_dq[50]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[50]}]
set_property LOC AE4 [get_ports {ddr3_dq[50]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[51]}]
set_property SLEW FAST [get_ports {ddr3_dq[51]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[51]}]
set_property LOC AE3 [get_ports {ddr3_dq[51]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[52]}]
set_property SLEW FAST [get_ports {ddr3_dq[52]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[52]}]
set_property LOC AF3 [get_ports {ddr3_dq[52]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[53]}]
set_property SLEW FAST [get_ports {ddr3_dq[53]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[53]}]
set_property LOC AF5 [get_ports {ddr3_dq[53]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[54]}]
set_property SLEW FAST [get_ports {ddr3_dq[54]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[54]}]
set_property LOC AE1 [get_ports {ddr3_dq[54]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[55]}]
set_property SLEW FAST [get_ports {ddr3_dq[55]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[55]}]
set_property LOC AE5 [get_ports {ddr3_dq[55]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[56]}]
set_property SLEW FAST [get_ports {ddr3_dq[56]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[56]}]
set_property LOC AC1 [get_ports {ddr3_dq[56]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[57]}]
set_property SLEW FAST [get_ports {ddr3_dq[57]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[57]}]
set_property LOC AD3 [get_ports {ddr3_dq[57]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[58]}]
set_property SLEW FAST [get_ports {ddr3_dq[58]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[58]}]
set_property LOC AC4 [get_ports {ddr3_dq[58]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[59]}]
set_property SLEW FAST [get_ports {ddr3_dq[59]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[59]}]
set_property LOC AC5 [get_ports {ddr3_dq[59]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[60]}]
set_property SLEW FAST [get_ports {ddr3_dq[60]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[60]}]
set_property LOC AE6 [get_ports {ddr3_dq[60]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[61]}]
set_property SLEW FAST [get_ports {ddr3_dq[61]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[61]}]
set_property LOC AD6 [get_ports {ddr3_dq[61]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[62]}]
set_property SLEW FAST [get_ports {ddr3_dq[62]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[62]}]
set_property LOC AC2 [get_ports {ddr3_dq[62]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[63]}]
set_property SLEW FAST [get_ports {ddr3_dq[63]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[63]}]
set_property LOC AD4 [get_ports {ddr3_dq[63]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[13]}]
set_property SLEW FAST [get_ports {ddr3_addr[13]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[13]}]
set_property LOC AH11 [get_ports {ddr3_addr[13]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[12]}]
set_property SLEW FAST [get_ports {ddr3_addr[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[12]}]
set_property LOC AJ11 [get_ports {ddr3_addr[12]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[11]}]
set_property SLEW FAST [get_ports {ddr3_addr[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[11]}]
set_property LOC AE13 [get_ports {ddr3_addr[11]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[10]}]
set_property SLEW FAST [get_ports {ddr3_addr[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[10]}]
set_property LOC AF13 [get_ports {ddr3_addr[10]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[9]}]
set_property SLEW FAST [get_ports {ddr3_addr[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[9]}]
set_property LOC AK14 [get_ports {ddr3_addr[9]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[8]}]
set_property SLEW FAST [get_ports {ddr3_addr[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[8]}]
set_property LOC AK13 [get_ports {ddr3_addr[8]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[7]}]
set_property SLEW FAST [get_ports {ddr3_addr[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[7]}]
set_property LOC AH14 [get_ports {ddr3_addr[7]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[6]}]
set_property SLEW FAST [get_ports {ddr3_addr[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[6]}]
set_property LOC AJ14 [get_ports {ddr3_addr[6]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[5]}]
set_property SLEW FAST [get_ports {ddr3_addr[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[5]}]
set_property LOC AJ13 [get_ports {ddr3_addr[5]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[4]}]
set_property SLEW FAST [get_ports {ddr3_addr[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[4]}]
set_property LOC AJ12 [get_ports {ddr3_addr[4]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[3]}]
set_property SLEW FAST [get_ports {ddr3_addr[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[3]}]
set_property LOC AF12 [get_ports {ddr3_addr[3]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[2]}]
set_property SLEW FAST [get_ports {ddr3_addr[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[2]}]
set_property LOC AG12 [get_ports {ddr3_addr[2]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[1]}]
set_property SLEW FAST [get_ports {ddr3_addr[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[1]}]
set_property LOC AG13 [get_ports {ddr3_addr[1]}]

# Bank: 33 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[0]}]
set_property SLEW FAST [get_ports {ddr3_addr[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[0]}]
set_property LOC AH12 [get_ports {ddr3_addr[0]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ba[2]}]
set_property SLEW FAST [get_ports {ddr3_ba[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[2]}]
set_property LOC AK9 [get_ports {ddr3_ba[2]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ba[1]}]
set_property SLEW FAST [get_ports {ddr3_ba[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[1]}]
set_property LOC AG9 [get_ports {ddr3_ba[1]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ba[0]}]
set_property SLEW FAST [get_ports {ddr3_ba[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[0]}]
set_property LOC AH9 [get_ports {ddr3_ba[0]}]

# Bank: 33 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ras_n}]
set_property SLEW FAST [get_ports {ddr3_ras_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]
set_property LOC AD9 [get_ports {ddr3_ras_n}]

# Bank: 33 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_cas_n}]
set_property SLEW FAST [get_ports {ddr3_cas_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]
set_property LOC AC11 [get_ports {ddr3_cas_n}]

# Bank: 33 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_we_n}]
set_property SLEW FAST [get_ports {ddr3_we_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]
set_property LOC AE9 [get_ports {ddr3_we_n}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_reset_n}]
set_property SLEW FAST [get_ports {ddr3_reset_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]
set_property LOC AK3 [get_ports {ddr3_reset_n}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_cke[0]}]
set_property SLEW FAST [get_ports {ddr3_cke[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[0]}]
set_property LOC AF10 [get_ports {ddr3_cke[0]}]

# Bank: 33 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_odt[0]}]
set_property SLEW FAST [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]
set_property LOC AD8 [get_ports {ddr3_odt[0]}]

# Bank: 33 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_cs_n[0]}]
set_property SLEW FAST [get_ports {ddr3_cs_n[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cs_n[0]}]
set_property LOC AC12 [get_ports {ddr3_cs_n[0]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[0]}]
set_property SLEW FAST [get_ports {ddr3_dm[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[0]}]
set_property LOC Y16 [get_ports {ddr3_dm[0]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[1]}]
set_property SLEW FAST [get_ports {ddr3_dm[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[1]}]
set_property LOC AB17 [get_ports {ddr3_dm[1]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[2]}]
set_property SLEW FAST [get_ports {ddr3_dm[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[2]}]
set_property LOC AF17 [get_ports {ddr3_dm[2]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[3]}]
set_property SLEW FAST [get_ports {ddr3_dm[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[3]}]
set_property LOC AE16 [get_ports {ddr3_dm[3]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[4]}]
set_property SLEW FAST [get_ports {ddr3_dm[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[4]}]
set_property LOC AK5 [get_ports {ddr3_dm[4]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[5]}]
set_property SLEW FAST [get_ports {ddr3_dm[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[5]}]
set_property LOC AJ3 [get_ports {ddr3_dm[5]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[6]}]
set_property SLEW FAST [get_ports {ddr3_dm[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[6]}]
set_property LOC AF6 [get_ports {ddr3_dm[6]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[7]}]
set_property SLEW FAST [get_ports {ddr3_dm[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[7]}]
set_property LOC AC7 [get_ports {ddr3_dm[7]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[0]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[0]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[0]}]
set_property LOC AC16 [get_ports {ddr3_dqs_p[0]}]

# Bank: 32 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[0]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[0]}]
set_property LOC AC15 [get_ports {ddr3_dqs_n[0]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[1]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[1]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[1]}]
set_property LOC Y19 [get_ports {ddr3_dqs_p[1]}]

# Bank: 32 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[1]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[1]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[1]}]
set_property LOC Y18 [get_ports {ddr3_dqs_n[1]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[2]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[2]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[2]}]
set_property LOC AJ18 [get_ports {ddr3_dqs_p[2]}]

# Bank: 32 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[2]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[2]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[2]}]
set_property LOC AK18 [get_ports {ddr3_dqs_n[2]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[3]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[3]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[3]}]
set_property LOC AH16 [get_ports {ddr3_dqs_p[3]}]

# Bank: 32 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[3]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[3]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[3]}]
set_property LOC AJ16 [get_ports {ddr3_dqs_n[3]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[4]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[4]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[4]}]
set_property LOC AH7 [get_ports {ddr3_dqs_p[4]}]

# Bank: 34 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[4]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[4]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[4]}]
set_property LOC AJ7 [get_ports {ddr3_dqs_n[4]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[5]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[5]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[5]}]
set_property LOC AG2 [get_ports {ddr3_dqs_p[5]}]

# Bank: 34 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[5]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[5]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[5]}]
set_property LOC AH1 [get_ports {ddr3_dqs_n[5]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[6]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[6]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[6]}]
set_property LOC AG4 [get_ports {ddr3_dqs_p[6]}]

# Bank: 34 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[6]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[6]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[6]}]
set_property LOC AG3 [get_ports {ddr3_dqs_n[6]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[7]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[7]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[7]}]
set_property LOC AD2 [get_ports {ddr3_dqs_p[7]}]

# Bank: 34 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[7]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[7]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[7]}]
set_property LOC AD1 [get_ports {ddr3_dqs_n[7]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ck_p[0]}]
set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_p[0]}]
set_property LOC AG10 [get_ports {ddr3_ck_p[0]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_n[0]}]
set_property LOC AH10 [get_ports {ddr3_ck_n[0]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ck_p[0]}]
set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_p[0]}]
set_property LOC AG10 [get_ports {ddr3_ck_p[0]}]

# Bank: 33 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_n[0]}]
set_property LOC AH10 [get_ports {ddr3_ck_n[0]}]
