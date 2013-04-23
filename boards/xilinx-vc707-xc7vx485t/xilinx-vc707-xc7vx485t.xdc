# Define and contraint system clock
create_clock -name clk200 -period 5 [get_ports clk200p]
set_propagated_clock clk200

set_property PACKAGE_PIN E19 [get_ports {clk200p      }]
set_property PACKAGE_PIN E18 [get_ports {clk200n      }]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {clk200p}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {clk200n}]
set_property VCCAUX_IO DONTCARE [get_ports {clk200p}]
set_property VCCAUX_IO DONTCARE [get_ports {clk200n}]


set_property PACKAGE_PIN AV40 [get_ports {reset       }]

set_property PACKAGE_PIN AM39 [get_ports {led[0]      }]
set_property PACKAGE_PIN AN39 [get_ports {led[1]      }]
set_property PACKAGE_PIN AR37 [get_ports {led[2]      }]
set_property PACKAGE_PIN AT37 [get_ports {led[3]      }]
set_property PACKAGE_PIN AR35 [get_ports {led[4]      }]
set_property PACKAGE_PIN AP41 [get_ports {led[5]      }]
set_property PACKAGE_PIN AP42 [get_ports {led[6]      }]

set_property PACKAGE_PIN AM36 [get_ports {data[0]     }]
set_property PACKAGE_PIN AN36 [get_ports {data[1]     }]
set_property PACKAGE_PIN AJ36 [get_ports {data[2]     }]
set_property PACKAGE_PIN AJ37 [get_ports {data[3]     }]
set_property PACKAGE_PIN AK37 [get_ports {data[4]     }]
set_property PACKAGE_PIN AL37 [get_ports {data[5]     }]
set_property PACKAGE_PIN AN35 [get_ports {data[6]     }]
set_property PACKAGE_PIN AP35 [get_ports {data[7]     }]
set_property PACKAGE_PIN AM37 [get_ports {data[8]     }]
set_property PACKAGE_PIN AG33 [get_ports {data[9]     }]
set_property PACKAGE_PIN AH33 [get_ports {data[10]    }]
set_property PACKAGE_PIN AK35 [get_ports {data[11]    }]
set_property PACKAGE_PIN AL35 [get_ports {data[12]    }]
set_property PACKAGE_PIN AJ31 [get_ports {data[13]    }]
set_property PACKAGE_PIN AH34 [get_ports {data[14]    }]
set_property PACKAGE_PIN AJ35 [get_ports {data[15]    }]
set_property PACKAGE_PIN AW41 [get_ports {address[25] }]
set_property PACKAGE_PIN AW42 [get_ports {address[24] }]
set_property PACKAGE_PIN BB39 [get_ports {address[23] }]
set_property PACKAGE_PIN BA39 [get_ports {address[22] }]
set_property PACKAGE_PIN BA40 [get_ports {address[21] }]
set_property PACKAGE_PIN AT41 [get_ports {address[20] }]
set_property PACKAGE_PIN AU42 [get_ports {address[19] }]
set_property PACKAGE_PIN BA42 [get_ports {address[18] }]
set_property PACKAGE_PIN AU41 [get_ports {address[17] }]
set_property PACKAGE_PIN AV41 [get_ports {address[16] }]
set_property PACKAGE_PIN AM32 [get_ports {address[15] }]
set_property PACKAGE_PIN AM33 [get_ports {address[14] }]
set_property PACKAGE_PIN AN33 [get_ports {address[13] }]
set_property PACKAGE_PIN AL29 [get_ports {address[12] }]
set_property PACKAGE_PIN AL30 [get_ports {address[11] }]
set_property PACKAGE_PIN AH29 [get_ports {address[10] }]
set_property PACKAGE_PIN AH30 [get_ports {address[9]  }]
set_property PACKAGE_PIN AJ30 [get_ports {address[8]  }]
set_property PACKAGE_PIN AK30 [get_ports {address[7]  }]
set_property PACKAGE_PIN AG29 [get_ports {address[6]  }]
set_property PACKAGE_PIN AK28 [get_ports {address[5]  }]
set_property PACKAGE_PIN AK29 [get_ports {address[4]  }]
set_property PACKAGE_PIN AF30 [get_ports {address[3]  }]
set_property PACKAGE_PIN AG31 [get_ports {address[2]  }]
set_property PACKAGE_PIN AH28 [get_ports {address[1]  }]
set_property PACKAGE_PIN AJ28 [get_ports {address[0]  }]
set_property PACKAGE_PIN AY37 [get_ports {adv         }]
set_property PACKAGE_PIN AL36 [get_ports {romsn       }]
#set_property PACKAGE_PIN AM34 [get_ports {FLASH_WAIT  }]
set_property PACKAGE_PIN BA41 [get_ports {oen         }]
set_property PACKAGE_PIN BB41 [get_ports {writen      }]
#set_property PACKAGE PIN N10 [get_ports {FLASH_CLK   }]
#set_property PACKAGE PIN AG11 [get_ports {FPGA_INIT_B  }]

set_property PACKAGE_PIN AU36 [get_ports {dsurx       }]
set_property PACKAGE_PIN AT32 [get_ports {dsurtsn     }]
set_property PACKAGE_PIN AU33 [get_ports {dsutx       }]
set_property PACKAGE_PIN AR34 [get_ports {dsuctsn     }]

set_property PACKAGE_PIN AP40 [get_ports {button[0]   }]
set_property PACKAGE_PIN AR40 [get_ports {button[1]   }]
set_property PACKAGE_PIN AV39 [get_ports {button[2]   }]
set_property PACKAGE_PIN AU38 [get_ports {button[3]   }]
set_property PACKAGE_PIN AY33 [get_ports {switch[0]   }]
set_property PACKAGE_PIN BA31 [get_ports {switch[1]   }]
set_property PACKAGE_PIN BA32 [get_ports {switch[2]   }]
set_property PACKAGE_PIN AW30 [get_ports {switch[3]   }]
set_property PACKAGE_PIN AT35 [get_ports {iic_scl     }]
set_property PACKAGE_PIN AU32 [get_ports {iic_sda     }]

set_property IOSTANDARD LVCMOS18 [get_ports {dsurx    }]
set_property IOSTANDARD LVCMOS18 [get_ports {dsurtsn  }]
set_property IOSTANDARD LVCMOS18 [get_ports {dsutx    }]
set_property IOSTANDARD LVCMOS18 [get_ports {dsuctsn  }]
set_property IOSTANDARD LVCMOS18 [get_ports {led[2]   }]
set_property IOSTANDARD LVCMOS18 [get_ports {led[4]   }]
set_property IOSTANDARD LVCMOS18 [get_ports {led[5]   }]
set_property IOSTANDARD LVCMOS18 [get_ports {led[6]   }]
set_property IOSTANDARD LVCMOS18 [get_ports {button[3]}]

##############################################################

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[0]}]
set_property SLEW FAST [get_ports {ddr3_dq[0]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[0]}]
set_property LOC N14 [get_ports {ddr3_dq[0]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[1]}]
set_property SLEW FAST [get_ports {ddr3_dq[1]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[1]}]
set_property LOC N13 [get_ports {ddr3_dq[1]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[2]}]
set_property SLEW FAST [get_ports {ddr3_dq[2]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[2]}]
set_property LOC L14 [get_ports {ddr3_dq[2]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[3]}]
set_property SLEW FAST [get_ports {ddr3_dq[3]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[3]}]
set_property LOC M14 [get_ports {ddr3_dq[3]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[4]}]
set_property SLEW FAST [get_ports {ddr3_dq[4]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[4]}]
set_property LOC M12 [get_ports {ddr3_dq[4]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[5]}]
set_property SLEW FAST [get_ports {ddr3_dq[5]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[5]}]
set_property LOC N15 [get_ports {ddr3_dq[5]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[6]}]
set_property SLEW FAST [get_ports {ddr3_dq[6]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[6]}]
set_property LOC M11 [get_ports {ddr3_dq[6]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[7]}]
set_property SLEW FAST [get_ports {ddr3_dq[7]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[7]}]
set_property LOC L12 [get_ports {ddr3_dq[7]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[8]}]
set_property SLEW FAST [get_ports {ddr3_dq[8]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[8]}]
set_property LOC K14 [get_ports {ddr3_dq[8]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[9]}]
set_property SLEW FAST [get_ports {ddr3_dq[9]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[9]}]
set_property LOC K13 [get_ports {ddr3_dq[9]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[10]}]
set_property SLEW FAST [get_ports {ddr3_dq[10]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[10]}]
set_property LOC H13 [get_ports {ddr3_dq[10]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[11]}]
set_property SLEW FAST [get_ports {ddr3_dq[11]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[11]}]
set_property LOC J13 [get_ports {ddr3_dq[11]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[12]}]
set_property SLEW FAST [get_ports {ddr3_dq[12]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[12]}]
set_property LOC L16 [get_ports {ddr3_dq[12]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[13]}]
set_property SLEW FAST [get_ports {ddr3_dq[13]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[13]}]
set_property LOC L15 [get_ports {ddr3_dq[13]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[14]}]
set_property SLEW FAST [get_ports {ddr3_dq[14]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[14]}]
set_property LOC H14 [get_ports {ddr3_dq[14]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[15]}]
set_property SLEW FAST [get_ports {ddr3_dq[15]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[15]}]
set_property LOC J15 [get_ports {ddr3_dq[15]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[16]}]
set_property SLEW FAST [get_ports {ddr3_dq[16]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[16]}]
set_property LOC E15 [get_ports {ddr3_dq[16]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[17]}]
set_property SLEW FAST [get_ports {ddr3_dq[17]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[17]}]
set_property LOC E13 [get_ports {ddr3_dq[17]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[18]}]
set_property SLEW FAST [get_ports {ddr3_dq[18]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[18]}]
set_property LOC F15 [get_ports {ddr3_dq[18]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[19]}]
set_property SLEW FAST [get_ports {ddr3_dq[19]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[19]}]
set_property LOC E14 [get_ports {ddr3_dq[19]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[20]}]
set_property SLEW FAST [get_ports {ddr3_dq[20]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[20]}]
set_property LOC G13 [get_ports {ddr3_dq[20]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[21]}]
set_property SLEW FAST [get_ports {ddr3_dq[21]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[21]}]
set_property LOC G12 [get_ports {ddr3_dq[21]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[22]}]
set_property SLEW FAST [get_ports {ddr3_dq[22]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[22]}]
set_property LOC F14 [get_ports {ddr3_dq[22]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[23]}]
set_property SLEW FAST [get_ports {ddr3_dq[23]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[23]}]
set_property LOC G14 [get_ports {ddr3_dq[23]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[24]}]
set_property SLEW FAST [get_ports {ddr3_dq[24]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[24]}]
set_property LOC B14 [get_ports {ddr3_dq[24]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[25]}]
set_property SLEW FAST [get_ports {ddr3_dq[25]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[25]}]
set_property LOC C13 [get_ports {ddr3_dq[25]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[26]}]
set_property SLEW FAST [get_ports {ddr3_dq[26]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[26]}]
set_property LOC B16 [get_ports {ddr3_dq[26]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[27]}]
set_property SLEW FAST [get_ports {ddr3_dq[27]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[27]}]
set_property LOC D15 [get_ports {ddr3_dq[27]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[28]}]
set_property SLEW FAST [get_ports {ddr3_dq[28]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[28]}]
set_property LOC D13 [get_ports {ddr3_dq[28]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[29]}]
set_property SLEW FAST [get_ports {ddr3_dq[29]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[29]}]
set_property LOC E12 [get_ports {ddr3_dq[29]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[30]}]
set_property SLEW FAST [get_ports {ddr3_dq[30]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[30]}]
set_property LOC C16 [get_ports {ddr3_dq[30]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[31]}]
set_property SLEW FAST [get_ports {ddr3_dq[31]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[31]}]
set_property LOC D16 [get_ports {ddr3_dq[31]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[32]}]
set_property SLEW FAST [get_ports {ddr3_dq[32]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[32]}]
set_property LOC A24 [get_ports {ddr3_dq[32]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[33]}]
set_property SLEW FAST [get_ports {ddr3_dq[33]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[33]}]
set_property LOC B23 [get_ports {ddr3_dq[33]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[34]}]
set_property SLEW FAST [get_ports {ddr3_dq[34]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[34]}]
set_property LOC B27 [get_ports {ddr3_dq[34]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[35]}]
set_property SLEW FAST [get_ports {ddr3_dq[35]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[35]}]
set_property LOC B26 [get_ports {ddr3_dq[35]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[36]}]
set_property SLEW FAST [get_ports {ddr3_dq[36]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[36]}]
set_property LOC A22 [get_ports {ddr3_dq[36]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[37]}]
set_property SLEW FAST [get_ports {ddr3_dq[37]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[37]}]
set_property LOC B22 [get_ports {ddr3_dq[37]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[38]}]
set_property SLEW FAST [get_ports {ddr3_dq[38]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[38]}]
set_property LOC A25 [get_ports {ddr3_dq[38]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[39]}]
set_property SLEW FAST [get_ports {ddr3_dq[39]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[39]}]
set_property LOC C24 [get_ports {ddr3_dq[39]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[40]}]
set_property SLEW FAST [get_ports {ddr3_dq[40]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[40]}]
set_property LOC E24 [get_ports {ddr3_dq[40]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[41]}]
set_property SLEW FAST [get_ports {ddr3_dq[41]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[41]}]
set_property LOC D23 [get_ports {ddr3_dq[41]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[42]}]
set_property SLEW FAST [get_ports {ddr3_dq[42]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[42]}]
set_property LOC D26 [get_ports {ddr3_dq[42]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[43]}]
set_property SLEW FAST [get_ports {ddr3_dq[43]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[43]}]
set_property LOC C25 [get_ports {ddr3_dq[43]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[44]}]
set_property SLEW FAST [get_ports {ddr3_dq[44]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[44]}]
set_property LOC E23 [get_ports {ddr3_dq[44]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[45]}]
set_property SLEW FAST [get_ports {ddr3_dq[45]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[45]}]
set_property LOC D22 [get_ports {ddr3_dq[45]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[46]}]
set_property SLEW FAST [get_ports {ddr3_dq[46]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[46]}]
set_property LOC F22 [get_ports {ddr3_dq[46]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[47]}]
set_property SLEW FAST [get_ports {ddr3_dq[47]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[47]}]
set_property LOC E22 [get_ports {ddr3_dq[47]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[48]}]
set_property SLEW FAST [get_ports {ddr3_dq[48]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[48]}]
set_property LOC A30 [get_ports {ddr3_dq[48]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[49]}]
set_property SLEW FAST [get_ports {ddr3_dq[49]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[49]}]
set_property LOC D27 [get_ports {ddr3_dq[49]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[50]}]
set_property SLEW FAST [get_ports {ddr3_dq[50]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[50]}]
set_property LOC A29 [get_ports {ddr3_dq[50]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[51]}]
set_property SLEW FAST [get_ports {ddr3_dq[51]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[51]}]
set_property LOC C28 [get_ports {ddr3_dq[51]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[52]}]
set_property SLEW FAST [get_ports {ddr3_dq[52]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[52]}]
set_property LOC D28 [get_ports {ddr3_dq[52]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[53]}]
set_property SLEW FAST [get_ports {ddr3_dq[53]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[53]}]
set_property LOC B31 [get_ports {ddr3_dq[53]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[54]}]
set_property SLEW FAST [get_ports {ddr3_dq[54]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[54]}]
set_property LOC A31 [get_ports {ddr3_dq[54]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[55]}]
set_property SLEW FAST [get_ports {ddr3_dq[55]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[55]}]
set_property LOC A32 [get_ports {ddr3_dq[55]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[56]}]
set_property SLEW FAST [get_ports {ddr3_dq[56]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[56]}]
set_property LOC E30 [get_ports {ddr3_dq[56]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[57]}]
set_property SLEW FAST [get_ports {ddr3_dq[57]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[57]}]
set_property LOC F29 [get_ports {ddr3_dq[57]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[58]}]
set_property SLEW FAST [get_ports {ddr3_dq[58]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[58]}]
set_property LOC F30 [get_ports {ddr3_dq[58]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[59]}]
set_property SLEW FAST [get_ports {ddr3_dq[59]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[59]}]
set_property LOC F27 [get_ports {ddr3_dq[59]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[60]}]
set_property SLEW FAST [get_ports {ddr3_dq[60]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[60]}]
set_property LOC C30 [get_ports {ddr3_dq[60]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[61]}]
set_property SLEW FAST [get_ports {ddr3_dq[61]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[61]}]
set_property LOC E29 [get_ports {ddr3_dq[61]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[62]}]
set_property SLEW FAST [get_ports {ddr3_dq[62]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[62]}]
set_property LOC F26 [get_ports {ddr3_dq[62]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dq[63]}]
set_property SLEW FAST [get_ports {ddr3_dq[63]}]
set_property IOSTANDARD SSTL15_T_DCI [get_ports {ddr3_dq[63]}]
set_property LOC D30 [get_ports {ddr3_dq[63]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[13]}]
set_property SLEW FAST [get_ports {ddr3_addr[13]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[13]}]
set_property LOC A21 [get_ports {ddr3_addr[13]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[12]}]
set_property SLEW FAST [get_ports {ddr3_addr[12]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[12]}]
set_property LOC A15 [get_ports {ddr3_addr[12]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[11]}]
set_property SLEW FAST [get_ports {ddr3_addr[11]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[11]}]
set_property LOC B17 [get_ports {ddr3_addr[11]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[10]}]
set_property SLEW FAST [get_ports {ddr3_addr[10]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[10]}]
set_property LOC B21 [get_ports {ddr3_addr[10]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[9]}]
set_property SLEW FAST [get_ports {ddr3_addr[9]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[9]}]
set_property LOC C19 [get_ports {ddr3_addr[9]}]

# Bank: 38 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[8]}]
set_property SLEW FAST [get_ports {ddr3_addr[8]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[8]}]
set_property LOC D17 [get_ports {ddr3_addr[8]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[7]}]
set_property SLEW FAST [get_ports {ddr3_addr[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[7]}]
set_property LOC C18 [get_ports {ddr3_addr[7]}]

# Bank: 38 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[6]}]
set_property SLEW FAST [get_ports {ddr3_addr[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[6]}]
set_property LOC D20 [get_ports {ddr3_addr[6]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[5]}]
set_property SLEW FAST [get_ports {ddr3_addr[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[5]}]
set_property LOC A16 [get_ports {ddr3_addr[5]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[4]}]
set_property SLEW FAST [get_ports {ddr3_addr[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[4]}]
set_property LOC A17 [get_ports {ddr3_addr[4]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[3]}]
set_property SLEW FAST [get_ports {ddr3_addr[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[3]}]
set_property LOC A19 [get_ports {ddr3_addr[3]}]

# Bank: 38 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[2]}]
set_property SLEW FAST [get_ports {ddr3_addr[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[2]}]
set_property LOC C20 [get_ports {ddr3_addr[2]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[1]}]
set_property SLEW FAST [get_ports {ddr3_addr[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[1]}]
set_property LOC B19 [get_ports {ddr3_addr[1]}]

# Bank: 38 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_addr[0]}]
set_property SLEW FAST [get_ports {ddr3_addr[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_addr[0]}]
set_property LOC A20 [get_ports {ddr3_addr[0]}]

# Bank: 38 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ba[2]}]
set_property SLEW FAST [get_ports {ddr3_ba[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[2]}]
set_property LOC D18 [get_ports {ddr3_ba[2]}]

# Bank: 38 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ba[1]}]
set_property SLEW FAST [get_ports {ddr3_ba[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[1]}]
set_property LOC C21 [get_ports {ddr3_ba[1]}]

# Bank: 38 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ba[0]}]
set_property SLEW FAST [get_ports {ddr3_ba[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ba[0]}]
set_property LOC D21 [get_ports {ddr3_ba[0]}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ras_n}]
set_property SLEW FAST [get_ports {ddr3_ras_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_ras_n}]
set_property LOC E20 [get_ports {ddr3_ras_n}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_cas_n}]
set_property SLEW FAST [get_ports {ddr3_cas_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cas_n}]
set_property LOC K17 [get_ports {ddr3_cas_n}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_we_n}]
set_property SLEW FAST [get_ports {ddr3_we_n}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_we_n}]
set_property LOC F20 [get_ports {ddr3_we_n}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_reset_n}]
set_property SLEW FAST [get_ports {ddr3_reset_n}]
set_property IOSTANDARD LVCMOS15 [get_ports {ddr3_reset_n}]
set_property LOC C29 [get_ports {ddr3_reset_n}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_cke[0]}]
set_property SLEW FAST [get_ports {ddr3_cke[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cke[0]}]
set_property LOC K19 [get_ports {ddr3_cke[0]}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_odt[0]}]
set_property SLEW FAST [get_ports {ddr3_odt[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_odt[0]}]
set_property LOC H20 [get_ports {ddr3_odt[0]}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_cs_n[0]}]
set_property SLEW FAST [get_ports {ddr3_cs_n[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_cs_n[0]}]
set_property LOC J17 [get_ports {ddr3_cs_n[0]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[0]}]
set_property SLEW FAST [get_ports {ddr3_dm[0]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[0]}]
set_property LOC M13 [get_ports {ddr3_dm[0]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[1]}]
set_property SLEW FAST [get_ports {ddr3_dm[1]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[1]}]
set_property LOC K15 [get_ports {ddr3_dm[1]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[2]}]
set_property SLEW FAST [get_ports {ddr3_dm[2]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[2]}]
set_property LOC F12 [get_ports {ddr3_dm[2]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[3]}]
set_property SLEW FAST [get_ports {ddr3_dm[3]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[3]}]
set_property LOC A14 [get_ports {ddr3_dm[3]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[4]}]
set_property SLEW FAST [get_ports {ddr3_dm[4]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[4]}]
set_property LOC C23 [get_ports {ddr3_dm[4]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[5]}]
set_property SLEW FAST [get_ports {ddr3_dm[5]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[5]}]
set_property LOC D25 [get_ports {ddr3_dm[5]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[6]}]
set_property SLEW FAST [get_ports {ddr3_dm[6]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[6]}]
set_property LOC C31 [get_ports {ddr3_dm[6]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dm[7]}]
set_property SLEW FAST [get_ports {ddr3_dm[7]}]
set_property IOSTANDARD SSTL15 [get_ports {ddr3_dm[7]}]
set_property LOC F31 [get_ports {ddr3_dm[7]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[0]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[0]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[0]}]
set_property LOC N16 [get_ports {ddr3_dqs_p[0]}]

# Bank: 39 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[0]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[0]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[0]}]
set_property LOC M16 [get_ports {ddr3_dqs_n[0]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[1]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[1]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[1]}]
set_property LOC K12 [get_ports {ddr3_dqs_p[1]}]

# Bank: 39 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[1]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[1]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[1]}]
set_property LOC J12 [get_ports {ddr3_dqs_n[1]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[2]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[2]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[2]}]
set_property LOC H16 [get_ports {ddr3_dqs_p[2]}]

# Bank: 39 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[2]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[2]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[2]}]
set_property LOC G16 [get_ports {ddr3_dqs_n[2]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[3]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[3]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[3]}]
set_property LOC C15 [get_ports {ddr3_dqs_p[3]}]

# Bank: 39 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[3]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[3]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[3]}]
set_property LOC C14 [get_ports {ddr3_dqs_n[3]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[4]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[4]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[4]}]
set_property LOC A26 [get_ports {ddr3_dqs_p[4]}]

# Bank: 37 - Byte T0
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[4]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[4]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[4]}]
set_property LOC A27 [get_ports {ddr3_dqs_n[4]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[5]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[5]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[5]}]
set_property LOC F25 [get_ports {ddr3_dqs_p[5]}]

# Bank: 37 - Byte T1
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[5]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[5]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[5]}]
set_property LOC E25 [get_ports {ddr3_dqs_n[5]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[6]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[6]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[6]}]
set_property LOC B28 [get_ports {ddr3_dqs_p[6]}]

# Bank: 37 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[6]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[6]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[6]}]
set_property LOC B29 [get_ports {ddr3_dqs_n[6]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_p[7]}]
set_property SLEW FAST [get_ports {ddr3_dqs_p[7]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_p[7]}]
set_property LOC E27 [get_ports {ddr3_dqs_p[7]}]

# Bank: 37 - Byte T3
set_property VCCAUX_IO NORMAL [get_ports {ddr3_dqs_n[7]}]
set_property SLEW FAST [get_ports {ddr3_dqs_n[7]}]
set_property IOSTANDARD DIFF_SSTL15_T_DCI [get_ports {ddr3_dqs_n[7]}]
set_property LOC E28 [get_ports {ddr3_dqs_n[7]}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ck_p[0]}]
set_property SLEW FAST [get_ports {ddr3_ck_p[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_p[0]}]
set_property LOC H19 [get_ports {ddr3_ck_p[0]}]

# Bank: 38 - Byte T2
set_property VCCAUX_IO NORMAL [get_ports {ddr3_ck_n[0]}]
set_property SLEW FAST [get_ports {ddr3_ck_n[0]}]
set_property IOSTANDARD DIFF_SSTL15 [get_ports {ddr3_ck_n[0]}]
set_property LOC G18 [get_ports {ddr3_ck_n[0]}]

