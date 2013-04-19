
This Leon3 design is tailored to the Altera Audio Video Development Kit, 
Stratix II GX Edition.
---------------------------------------------------------------------

Development board product page:

http://www.altera.com/products/devkits/altera/kit-dsp-professional.html

Design specifics:

* System reset is mapped to the CPU RESET button

* The serial port (console) is connected to the FTDI FT245 USB UART

* The JTAG DSU interface is enabled and works well with
  GRMON and Altera USB Blaster JTAG cables

* The GRETH core is enabled and runs without problems at 100 Mbit.
  Using 1 Gbit is also possible with the commercial grlib version.
  Ethernet debug link is enabled, default IP is 192.168.0.52.
  Please note, that it will take several seconds after phy reset
  until it can accept control commands. Some additional delay might
  be required in the boot loader before ethernet access.

* DDR2 is now supported and runs OK at 200 MHz. The board (and the phy)
  only support single-ended DQS signals, so the dqsse VHDL generic on the
  DDR2SPA core is set to 1.

* The SSRAM can be interfaced with the LEON2 Memory controller. 
  Start GRMON with -ramrws 1 when the LEON2 controller is used.

* The FLASH memory can be programmed using GRMON

* The LEON3 processor can run up to 100-110 MHz on the board
  in the typical configuration.

* The DVI interfaces are not yet supported.

* Sample output from GRMON is:

 GRMON LEON debug monitor v1.1.35 evaluation version

 Copyright (C) 2004-2008 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This evaluation version will expire on 6/12/2009
 using Altera JTAG cable
 Selected cable 1 - USB-Blaster [USB 7-1.2]
JTAG chain:
@1: EP2SGX90 (0x020E30DD)

 GRLIB build version: 2950

 initialising ...........
 detected frequency: 100 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 LEON2 Memory Controller              European Space Agency
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 DDR2 Controller                      Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 General purpose I/O port             Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x0)
             ahb master 1
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 2, irq 12
             apb: 80000b00 - 80000c00
             edcl ip 192.168.0.51, buffer 2 kbyte
00.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)
             ahb: 00000000 - 02000000
             ahb: 20000000 - 20100000
             ahb: 40000000 - 40200000
             apb: 80000000 - 80000100
             16-bit prom @ 0x00000000
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: 90000000 - a0000000
             AHB trace 256 lines, stack pointer 0xdffffff0
             CPU#0 win 8, hwbp 2, itrace 256, V8 mul/div, srmmu, lddel 1
                   icache 4 * 8 kbyte, 32 byte/line lru
                   dcache 4 * 8 kbyte, 32 byte/line lru
03.01:02e   Gaisler Research  DDR2 Controller (ver 0x0)
             ahb: c0000000 - e0000000
             ahb: fff00100 - fff00200
             64-bit DDR2 : 1 * 512 Mbyte @ 0xc0000000
                          200 MHz, col 10, ref 7.8 us, trfc 135 ns
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: 80000100 - 80000200
             baud rate 12500000
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: 80000200 - 80000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: 80000300 - 80000400
             8-bit scaler, 2 * 32-bit timers, divisor 100
05.01:01a   Gaisler Research  General purpose I/O port (ver 0x0)
             apb: 80000500 - 80000600
grlib> fla
 AMD-style 16-bit flash

 Manuf.    AMD                 
 Device    MX29LV128MB       

 1 x 32 Mbyte = 32 Mbyte total @ 0x00000000

 CFI info
 flash family  : 2
 flash size    : 256 Mbit
 erase regions : 1
 erase blocks  : 256
 write buffer  : 32 bytes
 region  0     : 256 blocks of 128 Kbytes

grlib> 
