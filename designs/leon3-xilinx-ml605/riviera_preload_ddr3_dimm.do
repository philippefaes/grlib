# Procedure to load memory from file
proc reload_mem {} {
 # Load memory with system test and display memory
 if {[examine /testbench/led(3)] == 1} {
  #if {[examine sim:/config@work/CFG_MIG_SERIES7] == 1} {
     echo "Loading DDR3 memory with System Test"
     #if {[examine /testbench/USE_MIG_INTERFACE_MODEL] == FALSE} { 
       mem load -startaddress 0 -format hex -infile sdram_dimm_merge3.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem__0/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm_merge4.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem__1/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm_merge1.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem__2/u1/memory
       mem load -startaddress 0 -format hex -infile sdram_dimm_merge2.hex -filltype value -filldata 1'b0 sim:/testbench/gen_mem__3/u1/memory
       
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem__0/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem__1/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem__2/u1/address 
       mem load -startaddress 0 -format hex -filltype inc -filldata 1'b0 sim:/testbench/gen_mem__3/u1/address 
       
       change sim:/testbench/gen_mem__0/u1/memory_used 11111111111111111111111111111111
       change sim:/testbench/gen_mem__1/u1/memory_used 11111111111111111111111111111111
       change sim:/testbench/gen_mem__2/u1/memory_used 11111111111111111111111111111111
       change sim:/testbench/gen_mem__3/u1/memory_used 11111111111111111111111111111111
     #}
     
     #if {[examine /testbench/USE_MIG_INTERFACE_MODEL] == TRUE} { 
     #   echo "MIG Model found"
     #   mem load -startaddress 0 -format hex -infile sdram_dimm_merge.hex -filltype value -filldata 1'b0  sim:/testbench/cpu/mig_gen/ddrc/gen_mig_model/MCB_model_inst/Mem
     #}
     
     #do wave.do   
  #}
 }
} 

set init_path /testbench/led(3);

when -label when1 {$init_path and  $init_path =1} {
    reload_mem
}

#run 2 ms