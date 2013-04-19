This leon3 design is tailored to the Xilinx SP605 Spartan6 board

Simulation and synthesis
------------------------

The design uses the Xilinx MIG memory interface with an AHB-2.0
interface. The MIG source code cannot be distributed due to the
prohibitive Xilinx license, so the MIG must be re-generated with 
coregen before simulation and synthesis can be done.

To generate the MIG and install tne Xilinx unisim simulation
library, do as follows:

  make mig
  make install-secureip

This will ONLY work with ISE-13.2 installed, and the XILINX variable
properly set in the shell. To synthesize the design, do

  make ise

and then

  make ise-prog-fpga

to program the FPGA.

Design specifics
----------------

* System reset is mapped to the CPU RESET button

* The AHB and processor is clocked by a 60 MHz clock, generated
  from the 33 MHz SYSACE clock using a DCM. You can change the frequency
  generation in the clocks menu of xconfig. The DDR3 (MIG) controller
  runs at 667 MHz.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled and has IP 192.168.0.51.
  1 Gbit operation is also possible (requires grlib com release),
  uncomment related timing constraints in the leon3mp.ucf first.

* 16-bit flash prom can be read at address 0. It can be programmed
  with GRMON version 1.1.16 or later.

* DDR3 is working with the provided Xilinx MIG DDR3 controller.
  If you want to simulate this design, first install the secure 
  IP models with:

  make install-secureip

  Then rebuild the scripts and simulation model:

  make distclean vsim

  Modelsim v6.6e or newer is required to build the secure IP models.
  Note that the regular leon3 test bench cannot be run in simulation
  as the DDR3 model lacks data pre-load.

* The application UART1 is connected to the USB/UART connector

* The SVGA frame buffer uses a separate port on the DDR3 controller,
  and therefore does not noticeably affect the performance of the processor.
  Default output is analog VGA, to switch to DVI mode execute this
  command in grmon:

  i2c dvi init_l4itx_vga

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start grmon with -xilusb to connect.

* Output from GRMON is:

$ grmon -xilusb -u

 GRMON LEON debug monitor v1.1.51 professional version (debug)

 Copyright (C) 2004-2011 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 Xilinx cable: Cable type/rev : 0x3 
 JTAG chain: xc6slx45t xccace 

 GRLIB build version: 4111

 initialising ...............
 detected frequency:  50 MHz
 SRAM waitstates: 1

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 LEON2 Memory Controller              European Space Agency
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 Xilinx MIG DDR2 controller           Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 SVGA Controller                      Gaisler Research
 AMBA Wrapper for OC I2C-master       Gaisler Research
 General purpose I/O port             Gaisler Research
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
             ahb master 1
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 2, irq 12
             apb: 80000e00 - 80000f00
             Device index: dev0
             edcl ip 192.168.1.51, buffer 2 kbyte
00.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)
             ahb: 00000000 - 20000000
             apb: 80000000 - 80000100
             16-bit prom @ 0x00000000
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 256 lines, 32-bit bus, stack pointer 0x47fffff0
             CPU#0 win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1
                   icache 2 * 8 kbyte, 32 byte/line rnd
                   dcache 2 * 4 kbyte, 16 byte/line rnd
04.01:06b   Gaisler Research  Xilinx MIG DDR2 controller (ver 0x0)
             ahb: 40000000 - 48000000
             apb: 80100000 - 80100100
             DDR2: 128 Mbyte
0d.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80100000 - 80200000
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38343, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 50
06.01:063   Gaisler Research  SVGA Controller (ver 0x0)
             apb: 80000600 - 80000700
             clk0: 50.00 MHz  
09.01:028   Gaisler Research  AMBA Wrapper for OC I2C-master (ver 0x3)
             irq 14
             apb: 80000900 - 80000a00
0a.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
             apb: 80000a00 - 80000b00
0f.01:052   Gaisler Research  AHB status register (ver 0x0)
             irq 7
             apb: 80000f00 - 80001000
grlib> fla

 Intel-style 16-bit flash on D[31:16]

 Manuf.    Intel               
 Device    Strataflash P30   

 Device ID 02e44603e127ffff    
 User   ID ffffffffffffffff    


 1 x 32 Mbyte = 32 Mbyte total @ 0x00000000


 CFI info
 flash family  : 1
 flash size    : 256 Mbit
 erase regions : 2
 erase blocks  : 259
 write buffer  : 1024 bytes
 lock-down     : yes
 region  0     : 255 blocks of 128 Kbytes
 region  1     : 4 blocks of 32 Kbytes

grlib> lo ~/ibm/src/bench/leonbench/coremark.exe 
section: .text at 0x40000000, size 102544 bytes
section: .data at 0x40019090, size 2788 bytes
total size: 105332 bytes (1.2 Mbit/s)
read 272 symbols
entry point: 0x40000000
grlib> run
2K performance run parameters for coremark.
CoreMark Size    : 666
Total ticks      : 19945918
Total time (secs): 19.945918
Iterations/Sec   : 100.271143
Iterations       : 2000
Compiler version : GCC4.4.2
Compiler flags   : -O3 -mv8 -funroll-loops -fgcse-sm -combine -DPERFORMANCE_RUN=1  -mcpu=v8 -msoft-float
Memory location  : STACK
seedcrc          : 0xe9f5
[0]crclist       : 0xe714
[0]crcmatrix     : 0x1fd7
[0]crcstate      : 0x8e3a
[0]crcfinal      : 0x4983
Correct operation validated. See readme.txt for run and reporting rules.
CoreMark 1.0 : 100.271143 / GCC4.4.2 -O3 -mv8 -funroll-loops -fgcse-sm -combine -DPERFORMANCE_RUN=1  -mcpu=v8 -msoft-float / Stack

Program exited normally.
grlib> 

