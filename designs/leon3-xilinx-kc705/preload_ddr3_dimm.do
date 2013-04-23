# Procedure to load memory from file
proc reload_mem {} {
 # Load memory with system test and display memory
 if {[examine /testbench/led(3)] == 1} {
  if {[examine sim:/config@work/CFG_MIG_SERIES7] == 1} {
     echo "Loading DDR3 memory with System Test"
     if {[examine /testbench/USE_MIG_INTERFACE_MODEL] == FALSE} { 
       mem load -startaddress 0 -format hex -infile sdram_dimm1.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(0)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm2.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(1)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm3.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(2)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm4.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(3)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm5.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(4)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm6.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(5)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm7.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(6)/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm8.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(7)/u1/memory
       
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(0)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(1)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(2)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(3)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(4)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(5)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(6)/u1/address 
       mem load -startaddress 0 -format hex -filltype incr -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem(7)/u1/address 
       
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(0)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(1)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(2)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(3)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(4)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(5)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(6)/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem(7)/u1/memory_used 1111111111111111
     }
     
     if {[examine /testbench/USE_MIG_INTERFACE_MODEL] == TRUE} { 
        echo "MIG Model found"
        mem load -startaddress 0 -format hex -infile sdram_dimm_merge.hex -filltype value -filldata 1'b0  sim:/testbench/cpu/mig_gen/ddrc/gen_mig_model/MCB_model_inst/Mem
     }
     
     #do wave.do   
   }
 }
} 

set init_path /testbench/led(3);

when -label when1 "$init_path'event and  $init_path ='1'" {
    reload_mem 
}

#run 2 ms
