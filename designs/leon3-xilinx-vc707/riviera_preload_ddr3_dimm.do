# Procedure to load memory from file
proc reload_mem {} {
 # Load memory with system test and display memory
 if {[examine /testbench/led(3)] == 1} {
  if {[examine sim:/work.config/CFG_MIG_SERIES7] == 1} {
     echo "Loading DDR3 memory with System Test"
     if {[examine /testbench/USE_MIG_INTERFACE_MODEL] == false} { 
       mem load -startaddress 0 -format hex -infile sdram_dimm1.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__0/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm2.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__1/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm3.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__2/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm4.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__3/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm5.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__4/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm6.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__5/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm7.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__6/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm8.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__7/u1/memory
       
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__0/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__1/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__2/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__3/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__4/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__5/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__6/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem_model/ddr3mem/gen_mem__7/u1/address 
       
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__0/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__1/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__2/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__3/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__4/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__5/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__6/u1/memory_used 1111111111111111
       change sim:/testbench/gen_mem_model/ddr3mem/gen_mem__7/u1/memory_used 1111111111111111
     }
     
     if {[examine /testbench/USE_MIG_INTERFACE_MODEL] == true} { 
        echo "MIG Model found"
        mem load -startaddress 0 -endaddress 65535 -format hex -infile sdram_dimm_merge.hex -filltype value -filldata 1'b0  sim:/testbench/cpu/mig_gen/ddrc/gen_mig_model/MCB_model_inst/Mem
     }
     
     #do wave.do   
  }
 }
} 

set init_path /testbench/led(3);

when -label when1 {$init_path and  $init_path =1} {
    echo "MIG Init Complete"
    reload_mem
}

#do wave.awc

#run 2 ms