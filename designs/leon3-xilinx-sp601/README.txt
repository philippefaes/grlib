This leon3 design is tailored to the Xilinx Spartan-6 SP601 board

http://www.xilinx.com/sp601

Simulation and synthesis
------------------------

The design uses the Xilinx MIG memory interface with an AHB-2.0
interface. The MIG source code cannot be distributed due to the
prohibitive Xilinx license, so the MIG must be re-generated with 
coregen before simulation and synthesis can be done.

To generate the MIG and install the Xilinx unisim simulation
library, do as follows:

  make mig
  make install-secureip

This will ONLY work with ISE-13 installed, and the XILINX variable
properly set in the shell. To synthesize the design, do

  make ise

and then

  make ise-prog-fpga

to program the FPGA.

Design specifics
----------------

* System reset is mapped to the CPU RESET button

* The AHB and processor is clocked from the 27 MHz clock, while
  the DDR2 controller runs of the 200 MHz clock.

* DSU break is mapped to GPIO button 0 

* LED 2 indicates processor in debug mode

* LED 0 indicates processor in error mode

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link cannot not be enabled when the MIG DDR2
  controller is enabled due to limited area of the LX16 device.
  There are issues with the auto negotiation with the PHY. If the
  board is connected to a gigabit switch this may lead to the phy
  settling in gigabit mode and the 10/100 GRETH will not be able to
  communicate. The PHY can be forced into 100 Mbit operation with
  the GRMON command 'wmdio 7 0 0x2000'. This command can be issued
  when connecting with the UART or JTAG debug link.

* 8-bit flash prom can be read at address 0. It can be programmed
  with GRMON version 1.1.16 or later.

* DDR2 is working with the provided Xilinx MIG DDR2 controller.
  If you want to simulate this design, first install the secure 
  IP models with:

  make install-secureip

  Then rebuild the scripts and simulation model:

  make distclean vsim

  Modelsim v6.5e or newer is required to build the secure IP models.

* The application UART1 is connected to the USB/RS232 connector

* The JTAG DSU interface is enabled and accesible via the USB/JTAG port.
  Start grmon with -xilusb to connect.

* Output from GRMON is:

grmon -xilusb -u
                                                                                    
 GRMON LEON debug monitor v1.1.47 professional version

 Copyright (C) 2004-2010 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This debug version will expire on 14/11/2011
 Xilinx cable: Cable type/rev : 0x3 
 JTAG chain: xc6slx16 

 GRLIB build version: 4107

 initialising ...........
 detected frequency:  27 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 Xilinx MIG DDR2 controller           Gaisler Research
 LEON2 Memory Controller              European Space Agency
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 General purpose I/O port             Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
             ahb master 1
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 2, irq 12
             apb: 80000f00 - 80001000
             Device index: dev0
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 128 lines, 32-bit bus, stack pointer 0x47fffff0
             CPU#0 win 8, itrace 128, V8 mul/div, lddel 1
                   icache 1 * 8 kbyte, 32 byte/line 
                   dcache 1 * 4 kbyte, 16 byte/line 
04.01:06b   Gaisler Research  Xilinx MIG DDR2 controller (ver 0x0)
             ahb: 40000000 - 48000000
             DDR2: 128 Mbyte
05.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)
             ahb: 00000000 - 20000000
             ahb: 20000000 - 40000000
             apb: 80000000 - 80000100
             8-bit prom @ 0x00000000
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 38352, DSU mode (FIFO debug)
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 27
0b.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
             apb: 80000b00 - 80000c00
grlib> fla

 Intel-style 8-bit flash on D[31:24]

 Manuf.    Intel               
 Device    MT28F128J3      ) 

 Device ID 3c99ffff9d012849    
 User   ID ffffffffffffffff    


 1 x 16 Mbyte = 16 Mbyte total @ 0x00000000


 CFI info
 flash family  : 1
 flash size    : 128 Mbit
 erase regions : 1
 erase blocks  : 128
 write buffer  : 32 bytes
 region  0     : 128 blocks of 128 Kbytes

grlib>
