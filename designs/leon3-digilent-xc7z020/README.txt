This leon3 design is tailored to the Digilent Zedboard board

www.zedboard.org


NOTE: This design is experimental and not kept up to date.

Simulation and synthesis
------------------------

please note that no system test or simulation enviroment are present at the moment
but it should be possible to compile and load the design into modelsim

To build and load the design into the simulator:

  make vsim
  make vsim-launch

Synthesis will ONLY work with PlanAhead 14.2 installed or newer, and 
the XILINX variable properly set in the shell. To synthesize the design, do

  make planAhead

and then

  make vivado-zedboard

to program the FPGA.

Simulation options
------------------

N/A

Design specifics
----------------

* Synthesis should be done using PlanAhead 14.2 or newer

* The Leon3 processor is not able to read/write from/to external
  DDR3 interface at the moment. (This will be fixed in future 
  releases)

* System reset is mapped to the CPU RESET button

* DSU break is mapped to GPIO east button

* LED 0 indicates processor in debug mode

* LED 1 indicates processor in error mode, execution halted

* LED 2 UART1 RX

* LED 3 UART1 TX

* LED 4 GPIO 11

* LED 5 GPIO 12
5
* LED 6 GPIO 13

* LED 7 GPIO 14

* Always program the Zedboard via the make target 'program-zedboard'

$ make program-zedboard
xmd
Xilinx Microprocessor Debugger (XMD) Engine
Xilinx EDK 14.3 Build EDK_P.40xd
Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.

XMD% 
Programming Bitstream -- ./planAhead/leon3-zedboard-xc7z020/leon3-zedboard-xc7z020.runs/impl_1/leon3mp.bit
Fpga Programming Progress ............10.........20.........30.........40.........50.........60.........70.........80.........90........Done
Successfully downloaded bit file.

JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
 1       4ba00477           4        Cortex-A9
 2       03727093           6        XC7Z020


JTAG chain configuration
--------------------------------------------------
Device   ID Code        IR Length    Part Name
 1       4ba00477           4        Cortex-A9
 2       03727093           6        XC7Z020

CortexA9 Processor Configuration
-------------------------------------
Version.............................0x00000003
User ID.............................0x00000000
No of PC Breakpoints................6
No of Addr/Data Watchpoints.........1

Connected to "arm" target. id = 64
Starting GDB server for "arm" target (id = 64) at TCP port no 1234
Info:  Enabling level shifters and clearing fabric port resets

* The JTAG DSU interface is enabled and accesible via the JTAG port.
  Start grmon with -xilusb to connect.

* Output from GRMON is:

 grmon -xilusb
  
  GRMON2 LEON debug monitor v2.0.30-194-g937ff0a internal version
  
  Copyright (C) 2012 Aeroflex Gaisler - All rights reserved.
  For latest updates, go to http://www.gaisler.com/
  Comments or bug-reports to support@gaisler.com
  

Parsing -xilusb
Xilusb: Cable type/rev : 0x3 
 JTAG chain (2): xc7x020 zynq7000_arm_dap 

Commands missing help:
 debug

  GRLIB build version: 4120
  Detected frequency:  50 MHz
  
  Component                            Vendor
  LEON3 SPARC V8 Processor             Aeroflex Gaisler
  JTAG Debug Link                      Aeroflex Gaisler
  AHB/APB Bridge                       Aeroflex Gaisler
  LEON3 Debug Support Unit             Aeroflex Gaisler
  Single-port AHB SRAM module          Aeroflex Gaisler
  Xilinx MIG DDR3 Controller           Aeroflex Gaisler
  Single-port AHB SRAM module          Aeroflex Gaisler
  Generic UART                         Aeroflex Gaisler
  Multi-processor Interrupt Ctrl.      Aeroflex Gaisler
  Modular Timer Unit                   Aeroflex Gaisler
  General Purpose I/O port             Aeroflex Gaisler
  
  Use command 'info sys' to print a detailed report of attached cores

grmon2> info sys
  cpu0      Aeroflex Gaisler  LEON3 SPARC V8 Processor    
            AHB Master 0
  ahbjtag0  Aeroflex Gaisler  JTAG Debug Link    
            AHB Master 1
  apbmst0   Aeroflex Gaisler  AHB/APB Bridge    
            AHB: 80000000 - 80100000
  dsu0      Aeroflex Gaisler  LEON3 Debug Support Unit    
            AHB: 90000000 - A0000000
            AHB trace: 64 lines, 32-bit bus
            CPU0:  win 8, hwbp 2, V8 mul/div, lddel 2
                   stack pointer 0x200003f0
                   icache 2 * 4 kB, 16 B/line rnd
                   dcache 2 * 4 kB, 16 B/line rnd
  ahbram0   Aeroflex Gaisler  Single-port AHB SRAM module    
            AHB: 20000000 - 20100000
            32-bit static ram: 1 kB @ 0x20000000
  adev5     Aeroflex Gaisler  Xilinx MIG DDR3 Controller    
            AHB: 00000000 - 08000000
  ahbram1   Aeroflex Gaisler  Single-port AHB SRAM module    
            AHB: A0000000 - A0100000
            32-bit static ram: 1 kB @ 0xa0000000
  uart0     Aeroflex Gaisler  Generic UART    
            APB: 80000100 - 80000200
            IRQ: 2
            Baudrate 38343
  irqmp0    Aeroflex Gaisler  Multi-processor Interrupt Ctrl.    
            APB: 80000200 - 80000300
  gptimer0  Aeroflex Gaisler  Modular Timer Unit    
            APB: 80000300 - 80000400
            IRQ: 8
            8-bit scalar, 2 * 32-bit timers, divisor 50
  gpio0     Aeroflex Gaisler  General Purpose I/O port    
            APB: 80000A00 - 80000B00
  
grmon2> 
