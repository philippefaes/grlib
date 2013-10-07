
LEON3 design for Digilent Atlys board
-------------------------------------

This is a LEON3 design for the Digilent Atlys board with
Xilinx Spartan-6 LX45 FPGA.

http://www.digilentinc.com/

This design was contributed by Joris van Rantwijk.

Simulation and synthesis
------------------------

To synthesize the design, run
  $ make xconfig
  $ make ise (or make ise-synp to use Synplify for synthesis)

The testbench is not in a usable state. Getting the simulation through
initialization of SPI flash and DDR2 memory is not so easy.

The FPGA can be programmed directly using "make ise-prog-fpga".

Design specifics
----------------

* System reset is mapped to the RESET button.

* DSU-enable is mapped to switch SW7 (slide up to enable DSU)
  DSU-break is mapped to switch SW6  (slide up to force DSU break)
  DSU-active is indicated on LED LD6 (LED on when CPU in debug mode)
  Error is indicated on LED LD7      (LED on when CPU in error mode)

* The AHB and processor are clocked at 50 MHz.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Ethernet debug link is enabled and has IP 192.168.0.51.

  1 Gbit operation is currently not implemented.
  The board could support it in principle, but GRETH_GBIT is not available
  under GPL license so it could not be tested.

* DDR2 memory runs at 150 MHz, phase-locked to the AHB clock.
  The read delay in the DDR2SPA controller MUST be tuned by software
  at boot time before the DDR2 memory can be used.

* SPI flash memory is mapped at 0xe0000000.
  This memory is used for the FPGA configuration bitstream and
  also as LEON3 ROM area.

* The console UART1 is connected to the on-board serial-to-USB adapter.
  It is also possible to connect the GRMON debug UART to the USB adapter
  instead of UART1. This requires a change in the pre-synthesis
  configuration (make xconfig).

* LEDs LD0 to LD5 are mapped to GPIO bits 0 to 5.
  Switches SW0 to SW5 are mapped to GPIO bits 8 to 13.
  Buttons BTNU, BTNL, BTND, BTNR, BTNC are mapped to GPIO bits 16 to 20.
  The PMODA port is mapped to GPIO bits 24 to 31.

* HDMI output is supported via APBVGA or SVGACTRL.
  SVGACTRL video modes are limited to 640x480 or 800x600 with 8-bit
  or 16-bit color (due to TMDS bitrate and AHB bus loading).

* PS/2 keyboard emulation works.
  PS/2 mouse emulation seems to have some problems.

* Audio is not supported (yet).


DDR2 memory
-----------

The Atlys board contains 128 MByte DDR2 memory.
The DDR2SPA controller from GRLIB is used to access the memory.

Memory organization of the DDR2 chip is as follows:
 * 16-bit data bus
 * 8 banks
 * 13-bit row address
 * 10-bit column address

The DDR2SPA controller is configured as follows:
 DDR2 clock frequency = 150 MHz, phase-locked to the 50 MHz AHB clock
 CAS latency = 3 CK
 tREFRESH    = 7.8 us (1170 CK)
 tRCD        = 2 CK
 tRP         = 2 CK
 tRFC        = 130 ns = 20 CK
 tRTP        = 2 CK
 tRAS        = 6 CK
 read delay  = 1

This translates to the following values for the DDR2 configuration registers:
  DDR2CFG1 = 0x82208491
  DDR2CFG3 = 0x02c50000
  DDR2CFG4 = 0x00000100
  DDR2CFG5 = 0x00470004

The Spartan-6 version of the DDR2SPA controller uses IODELAY2 components
to capture read data from the memory chip. These delays MUST be tuned
by software at boot time before the DDR2 memory is usable.

Optimum delay tuning may vary from board to board. The following
configuration gives good results on my test board:

  Write DDR2CFG3 <- 0x82c50000      (reset IODELAY2)
  Repeat 72 times:
      Write DDR2CFG3 <- 0x02c5ffff  (increment delay)

A small program is available to tune the DDR2 memory from GRMON:
  grlib> load bin/ddrtune.exe
  grlib> run

This must be done after board power-on and after each AHB reset If
GRMON did not correctly detect the RAM size (visiable via info sys),
then you MUST exit GRMON and start it again so that GRMON will
properly detect the DDR2 SDRAM.


SPI flash memory
----------------

The Atlys board contains a Numonyx N25Q128 16 MByte SPI flash memory.
This memory is used to store the FPGA bitstream, and may also
be used as a ROM device for the LEON3.

The SPIMCTRL component from GRLIB is used to access SPI flash memory.
The ROM area is mapped at address 0xe0000000.
The first 2 MByte of this area are reserved for the FPGA bitstream,

The SPI memory may be used to store a boot image. In this case there are
a few board-specific issues that need attention:
 * The SPI flash memory is mapped at 0xe0000000 instead of at address 0.
 * The first 2 MByte of the flash memory are needed for FPGA configuration.
 * SPIMCTRL needs some time after reset before the ROM area can be accessed.
 * The DDR2SPA controller must be tuned for correct read timing before
   the DDR2 memory can be used.

These issues are solved by a board-specific early boot routine, implemented
in ahbrom.S. This code is embedded in an AHBROM block and synthesized into
the FPGA firmware. The AHBROM block is mapped at address 0x00000000 and
performs the following functions:
 * waits until SPIMCTRL is initialized;
 * tunes DDR2 read timing;
 * jumps to MKPROM2 boot loader at address 0xe0200000.

MKPROM2 may be used to generate a ROM image for the SPI memory.
A command-line option is needed to tell MKPROM2 to generate an image
at address 0xe0200000 instead of the default address 0.
For example, a PROM image may be generated and loaded into the SPI memory
as follows:

  $ mkprom2 -msoft-float -baud 38400 -leon3 -freq 50 -rstaddr 0xe0200000 \
            -nosram -ddrram 128 -ddrbanks 1 -ddrfreq 150 -ddrcol 1024 \
            program.exe -o program.prom

  $ sparc-elf-objcopy -O binary program.prom program.bin
  $ xc3sprog -I program.bin:w:0x200000:bin


GRMON output
------------

NOTE: When connecting with GRMON you may see messages like:

Cannot continue, processor not in debug mode

when GRMON cannot immediately get control of the CPU as the CPU has an
access ongoing toward the SPI memory interface. To avoid this, enable
the DSU and set DSU break.

$ grmon -eth -u

 GRMON LEON debug monitor v1.1.56 evaluation version

 Copyright (C) 2004-2011 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This evaluation version will expire on 21/9/2013

 ethernet startup.
 GRLIB build version: 4123

 initialising .................
 detected frequency:  50 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 SPI Memory Controller                Gaisler Research
 DDR2 Controller                      Gaisler Research
 AHB ROM                              Gaisler Research
 AHB static ram                       Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 PS/2 interface                       Gaisler Research
 PS/2 interface                       Gaisler Research
 Text-based VGA controller            Gaisler Research
 General purpose I/O port             Gaisler Research
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> load bin/ddrtune.exe
section: .text at 0xa0000000, size 896 bytes
total size: 896 bytes (12.3 Mbit/s)  
read 22 symbols
entry point: 0xa0000000
grlib> run

DDRTUNE:
...
0000000000000000
0000000000000000
0000000000000111
1111111111111111
1111111111111111
1111111111111111
1111111111111000
0000000000000000
0000000000000000
0000000000000001
0
delay = 0x4d, OK.

Program exited normally.

grlib> exit

$ grmon -eth -u

 GRMON LEON debug monitor v1.1.56 evaluation version

 Copyright (C) 2004-2011 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This evaluation version will expire on 21/9/2013

 ethernet startup.
 GRLIB build version: 4123

 initialising .................
 detected frequency:  50 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 SPI Memory Controller                Gaisler Research
 DDR2 Controller                      Gaisler Research
 AHB ROM                              Gaisler Research
 AHB static ram                       Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 PS/2 interface                       Gaisler Research
 PS/2 interface                       Gaisler Research
 Text-based VGA controller            Gaisler Research
 General purpose I/O port             Gaisler Research
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
             ahb master 1
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 2, irq 12
             apb: 80000e00 - 80000f00
             Device index: dev0
             edcl ip 192.168.0.51, buffer 2 kbyte
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 256 lines, 32-bit bus, stack pointer 0x47fffff0
             CPU#0 win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1
                   icache 2 * 8 kbyte, 32 byte/line lru
                   dcache 2 * 4 kbyte, 16 byte/line lru
03.01:045   Gaisler Research  SPI Memory Controller (ver 0x1)
             irq 11
             ahb: fff00200 - fff00300
             ahb: e0000000 - e1000000
         SPI memory device read command: 0x03
04.01:02e   Gaisler Research  DDR2 Controller (ver 0x1)
             ahb: 40000000 - 48000000
             ahb: fff00100 - fff00200
             16-bit DDR2 : 1 * 128 Mbyte @ 0x40000000, 8 internal banks
                          150 MHz, col 10, ref 7.8 us, trfc 133 ns
06.01:01b   Gaisler Research  AHB ROM (ver 0x0)
             ahb: 00000000 - 00100000
07.01:00e   Gaisler Research  AHB static ram (ver 0xe)
             ahb: a0000000 - a0100000
             16 kbyte AHB ram @ 0xa0000000
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
04.01:060   Gaisler Research  PS/2 interface (ver 0x2)
             irq 4
             apb: 80000400 - 80000500
05.01:060   Gaisler Research  PS/2 interface (ver 0x2)
             irq 5
             apb: 80000500 - 80000600
06.01:061   Gaisler Research  Text-based VGA controller (ver 0x0)
             apb: 80000600 - 80000700
0a.01:01a   Gaisler Research  General purpose I/O port (ver 0x2)
             apb: 80000a00 - 80000b00
0f.01:052   Gaisler Research  AHB status register (ver 0x0)
             irq 7
             apb: 80000f00 - 80001000

grlib> load ../../../examples/soft/v8/dhry.exe
section: .text at 0x40000000, size 54128 bytes
section: .data at 0x4000d370, size 2772 bytes
total size: 56900 bytes (16.6 Mbit/s)
read 265 symbols
entry point: 0x40000000
grlib> run
Execution starts, 400000 runs through Dhrystone
Microseconds for one run through Dhrystone:    8.3 
Dhrystones per Second:                      120845.9 

Dhrystones MIPS      :                        68.8 


Program exited normally.
grlib> 

