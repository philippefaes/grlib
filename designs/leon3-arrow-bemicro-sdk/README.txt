
This LEON3 design is tailored to the Altera/Arrow/Hitex BeMicro SDK kit

0. Introduction
---------------

The design can be synthesized with Quartus II, Use 'make quartus' to
run the complete flow. To program the FPGA in batch mode, use 
'make quartus-prog-fpga' or 'make quartus-prog-fpga-ref (LEON3 
reference config).

* System reset is mapped to the "Reset" push button

* DSU break is mapped to the "User" push button

* DSU active is connected to LED8

* Processor in error mode is connected to LED7

* LED[6:1] is connected to GPIO[5:0].

1. Boot ROM
-----------

The board does not have a PROM that can hold boot software. In order
to have the processor boot successfully after reset there are two
options: 1) Include an AHBROM on the device. 2) Use SPIMCTRL and place
boot software on SD card.

For the (simulation) system test to function, the design is by default
configured to include an AHBROM. If you don't update the AHBROM with
something sensible for hardware it is better to disable it before
running synthesis.

The SPI memory controller (SPIMCTRL) and AHBROM cores cannot both be
enabled simultaneously. If you want this, you need to edit
leon3mp.vhd.

See comment about SPI SD Card interface below.

2. Simulation
--------------

In most designs, the testbench includes a module connected via a
memory controller that is accessed by system software in order to
present output to the simulator console.  In this design the leon3mp
entity will include a AHBREP module mapped at address 0x20000000 that
is used by system test software. This module will not be included when
the design is synthesized.

3. UART
--------

The BeMicro SDK does not have an external UART connector and the UART
cores i GRLIB cannot be used to directly interface with the FTDI USB
interface. An APBUART core is still included in the design. The core
can be used in loopback mode with GRMON in order to get a working
console for software.

3. System
---------

The output from grmon should look something like this:

$ ./grmon-eval.exe -altjtag -jtagdevice 1 -u

 GRMON LEON debug monitor v1.1.44 evaluation version

 Copyright (C) 2004-2010 Aeroflex Gaisler - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com

 This evaluation version will expire on 7/7/2011
 using Altera JTAG cable
 Selected cable 1 - USB-Blaster [USB-0]
JTAG chain:
@1: EP3C25/EP4CE22 (0x020F30DD)

 GRLIB build version: 4106

 initialising .............
 detected frequency:  50 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 DDR266 Controller                    Gaisler Research
 AHB/APB Bridge                       Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 AHB ROM                              Gaisler Research
 General purpose I/O port             Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 SPI Controller                       Gaisler Research
 SPI Controller                       Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> info sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
            ahb master 0
01.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x1)
            ahb master 1
02.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
            ahb master 2, irq 10
            apb: 80000600 - 80000700
00.01:025   Gaisler Research  DDR266 Controller (ver 0x0)
            ahb: 40000000 - 50000000
            ahb: fff00100 - fff00200
            16-bit DDR : 1 * 64 Mbyte @ 0x40000000
                         100 MHz, col 10, ref 7.8 us, trfc 80 ns
01.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
            ahb: 80000000 - 80100000
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
            ahb: 90000000 - a0000000
            AHB trace 128 lines, 32-bit bus, stack pointer 0x43fffff0
            CPU#0 win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU-lite
                  icache 2 * 4 kbyte, 32 byte/line lrr
                  dcache 2 * 4 kbyte, 16 byte/line lrr
03.01:01b   Gaisler Research  AHB ROM (ver 0x0)
            ahb: 00000000 - 00100000
00.01:01a   Gaisler Research  General purpose I/O port (ver 0x1)
            apb: 80000000 - 80000100
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
04.01:02d   Gaisler Research  SPI Controller (ver 0x2)
            irq 9
            apb: 80000400 - 80000500
            FIFO depth: 16, 1 slave select signals
            Maximum word length: 32 bits
            Controller index for use in GRMON: 1
05.01:02d   Gaisler Research  SPI Controller (ver 0x2)
            irq 11
            apb: 80000500 - 80000600
            FIFO depth: 16, 1 slave select signals
            Maximum word length: 32 bits
            Controller index for use in GRMON: 2
grlib> load hello
section: .text at 0x40000000, size 39968 bytes
section: .data at 0x40009c20, size 2940 bytes
total size: 42908 bytes (877.9 kbit/s)
read 208 symbols
entry point: 0x40000000
grlib> run
Hello world!

Program exited normally.
grlib>

4. DDR interface
----------------

The mobile DDR SDRAM interface is supported and runs at 100 MHz.

5. Temperature sensor
---------------------

The first SPICTRL SPI controller core is connected to the on-board
temperature sensor. The controller is hardcoded to support 3-wire mode
and this mode must be enabled via the core's register interface in
order to interact with the temperature sensor. An example of reading
the temperature from the sensor via GRMON is given below:

grlib> spi 1 set ms cpol cpha rev len 15 tw tto asel

 Current SPI controller configuration:

 Automated mode: Not available
 Automatic slave select: Enabled
 Automatic slave select change in clock gap: Disabled
 Loop mode: Disabled (normal operation)
 Clock polarity: Idle high (1)
 Clock phase: 1 (Data is read on second transition)
 Divide by 16: Disabled
 PM Factor field: 0 (factor = 4)
 Reverse data: MSB sent first (1)
 M/S: Master
 Enabled: No
 Character length: 16 (field value: 0xf)
 Prescale modulus: 0
 Clock gap: 0
 SCK is system clock divided by 4
 Core is configured for 3-wire mode
 3-wire mode transfer order: Slave sends first
 Pad mode: Normal

grlib> spi 1 aslvsel 0
grlib> spi 1 en

 SPI controller is now enabled

grlib> spi 1 tx 0
grlib> spi 1 tx 0
grlib> spi 1 tx 0
grlib> spi 1 tx 0
grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> spi 1 rx 0

 Receive data: 0x0dff0000

grlib> 

The read 16-bit value 0x0dff corresponds to approximately 28 deg
Celsius.


6. SPI SD Card interface
----------------

The design can be configured to include a SPIMCTRL core that is
connected to the SD card slot.  The SPIMCTRL core allows reading from
a SD card without software support. This means that the SD card can be
used as a boot PROM if a PROM file is written in raw mode directly to
the start of card.

Suitable configuration values for SPIMCTRL are; SD Card = 1, Clock
divisor = 2, Alt. clock divisor = 7. Note that the SPIMCTRL core will
insert a large amount of wait states on the system bus if AMBA SPLIT
support is not enabled.

If the SD card will be used under an OS, it is better to use a SPICTRL
core connected to the SD card slot. The SPICTRL core will be higher
performance when accessing the SD card, but requires software
support. If the design is configured to include more than one SPI
controller, the second SPI controller will be connected to the SD card
slot.

If more than one SPICTRL core is included in the design, the SPI
memory controller (SPIMCTRL) core must be disabled.

Also note that the SPIMCTRL core cannot be enabled if the on-chip AHB
ROM is enabled.

7. Ethernet interface
---------------------

The default design configuration instantiates a GRETH 10/100 Mbit
Ethernet MAC.


