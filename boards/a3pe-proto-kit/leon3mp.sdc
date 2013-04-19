
create_clock  -period 25.0000 [get_ports {clk}]

create_clock  -name { clkm } -period 50.000 -waveform { 0.000 25.000  }  { clkm:Q  }
