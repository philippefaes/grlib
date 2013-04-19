
This LEON3 design is tailored to the Xilinx Virtex5 ML510 board
---------------------------------------------------------------------

NOTE1: With revision 1 of the DDR2SPA controller, the controller can 
       support both registered and unbuffered memory modules. The devices 
       delivered with the ML510 kit are registered, and when connecting with
       GRMON the flag -regmem should be specified.

NOTE2: The ML510 has a bug that prevents the use of 64 bit unbuffered DDR2. 
       See description of the DDR2 interface below.

Design specifics:

* System reset is mapped to the CPU RESET button

* The DSU UART is connected to UART 0. The DSU BREAK input is 
  mapped to position 1 on the GPIO DIP switch. When the switch is 'on'
  the DSU break signal is active. 

* The DSU error signal is connected to opb_bus_error. When the processor
  is in error mode the LED will be red. The DSU active signal is connected
  to plb_bus_error. When the DSU is active the LED will be red.

* The serial port is connected to UART 1.

* The JTAG DSU interface is enabled and works well with
  GRMON and Xilinx parallel and USB cables

* The GRGPIO port is mapped in the following way:
  gpio[3:0] : SW5[4:1] / Green LEDs
  gpio[4]   : DVI GPIO
  gpio[5]   : sbr_intr_r        (input only)
  gpio[6]   : sbr_nmi_r         (input only)
  gpio[7]   : sbr_pwg_rsm_rstj 
  gpio[8]   : sbr_ide_rst_b
  gpio[9]   : iic_therm_b       (input only)
  gpio[10]  : iic_irq_b         (input only)
  gpio[11]  : iic_alert_b       (input only)
  
* The sbr_intr_r signal should be used as an interrupt source if
  the PCI south bridge is used. The GRPCI core is assigned interrupt
  line 5 and the PCI drivers will trigger on this IRQ. 

* The DSU registers are located at 0xd0000000. Normally these registers
  are mapped at 0x90000000. Some software may have hardcoded or default
  values for 0x90000000.

* The APB bridge start address is 0xc0000000. This address is
  normally 0x80000000 in Leon3/GRLIB designs. Some software may
  default to, or use hard coded values for, 0x80000000.

* The GRETH core is enabled and runs without problems at 100 Mbit.
  The Ethernet debug link is enabled, default IP is 192.168.0.52.

* DDR2 is supported and runs OK at 200 MHz. The default setting is
  to run the DDR controller on 2x the system clock. This leads to
  lower latencies since synchronization registers are not needed. 
  If the CFG_DDR2SP_NOSYNC generic is set to 0, the DDR2 runs 
  asynchronously and the DDR frequency can be set (in steps of 10 MHz)
  via xconfig. When changing frequency, the delay on the data signals
  might need to be changed too. How to do this is described in the DDR2SPA
  section of grip.pdf (see description of SDCFG3 register), see also the
  DDR2SPA section in the GRMON manual.

  The ML510 board has the DDR clk 1 inverted (DIMM*_DDR2_CK2_N and
  DIMM*_DDR2_CK2_P have been flipped). The DDR2 DIMMs shipped with the 
  ML510 use registered DDR2 and only makes use of DIMM*_DDR2_CK0_*, therefore
  they are not affected.

  For unbuffered DIMM:s, the upper half of the memory bus will not work due
  to this bug, and the DDR controller needs to be configured for 32 bits 
  operation in this case. The DDR2 data width of the core can be configured
  via xconfig.

  When connecting with GRMON it will set the stack pointer to the top of RAM 
  of the first memory controller. If you have 512 MB memory (or more) in 
  the first slot, you can make the OS access both DIMM:s as one big memory.
  To do this, the stack pointer needs to be manually set to the end of the 
  second memory controller's area. For this template design with 512 MB memory
  in both DIMM:s, the correct switch to GRMON is -stack 0x7ffffff0. 

* The FLASH memory can be programmed using GRMON

* The LEON3 processor can run up to 80 - 90 MHz on the board
  in the typical configuration.

* The design has two I2C masters. One is connected to the main IIC bus
  and one is connected to the video IIC bus. The I2C master connected
  to the main bus can be deactivated via xconfig. The I2C master connected
  to the video IIC bus is instantiated when a VGA core is included.

* The SVGACTRL core is enabled and is connected to the DVI 
  transmitter. When one, or both, of the VGA cores is enabled an extra 
  I2C master is automatically instantiated. This I2C master is utilized
  to initialize the DVI transmitter. A special GRMON command exists to
  initialize the Chrontel CH7301C. See below for an example.
  Adjustment of the delay before latching input data may be needed. This
  can be done using the 'i2c 1 dvi delay [dec|inc]' command. 
  NOTE: If the the VGA cores are disabled the constraints on the VGA 
  clocks must be removed from the leon3mp.ucf file.

* SPICTRL is attached to the SPI Flash memory device. To communicate with 
  the memory device, the core needs to be initialized to generate a SPI 
  clock of ~1 MHz. When using GRMON this can be attained with the command
  'spi set div16 pm 1'. When using GRMON the "Microchip 25AA640/25LC640" must
  be selected via the command 'spi flash select'.

* The design should be loaded from CompactFlash via System ACE. The FPGA can
  also be directly programmed with 'make ise-prog-fpga'. Make sure to set the
  value of SW3 appropriately.

* Sample output from GRMON is:

grmon -eth -ip 192.168.0.52

 GRMON LEON debug monitor v1.1.32

 Copyright (C) 2004-2008 Gaisler Research - all rights reserved.
 For latest updates, go to http://www.gaisler.com/
 Comments or bug-reports to support@gaisler.com


 ethernet startup.
 Device ID: : 0x510
 GRLIB build version: 3293

 initialising ........................
 detected frequency:  80 MHz

 Component                            Vendor
 LEON3 SPARC V8 Processor             Gaisler Research
 AHB Debug UART                       Gaisler Research
 AHB Debug JTAG TAP                   Gaisler Research
 SVGA frame buffer                    Gaisler Research
 GR Ethernet MAC                      Gaisler Research
 Fast 32-bit PCI Bridge               Gaisler Research
 PCI/AHB DMA controller               Gaisler Research
 DDR2 Controller                      Gaisler Research
 DDR2 Controller                      Gaisler Research
 LEON3 Debug Support Unit             Gaisler Research
 LEON2 Memory Controller              European Space Agency
 AHB/APB Bridge                       Gaisler Research
 System ACE I/F Controller            Gaisler Research
 AMBA Wrapper for System Monitor      Gaisler Research
 Generic APB UART                     Gaisler Research
 Multi-processor Interrupt Ctrl       Gaisler Research
 Modular Timer Unit                   Gaisler Research
 AMBA Wrapper for OC I2C-master       Gaisler Research
 General purpose I/O port             Gaisler Research
 AMBA Wrapper for OC I2C-master       Gaisler Research
 SPI Controller                       Gaisler Research
 PCI trace buffer                     Gaisler Research
 PCI Arbiter                          European Space Agency
 AHB status register                  Gaisler Research

 Use command 'info sys' to print a detailed report of attached cores

grlib> inf sys
00.01:003   Gaisler Research  LEON3 SPARC V8 Processor (ver 0x0)
             ahb master 0
01.01:007   Gaisler Research  AHB Debug UART (ver 0x0)
             ahb master 1
             apb: c0000700 - c0000800
             baud rate 115200, ahb frequency 80.00
02.01:01c   Gaisler Research  AHB Debug JTAG TAP (ver 0x0)
             ahb master 2
03.01:063   Gaisler Research  SVGA frame buffer (ver 0x0)
             ahb master 3
             apb: c0000e00 - c0000f00
             clk0: 25.00 MHz  clk1: 25.00 MHz  clk2: 40.00 MHz  clk3: 65.00 MHz
04.01:01d   Gaisler Research  GR Ethernet MAC (ver 0x0)
             ahb master 4, irq 4
             apb: c0000b00 - c0000c00
             edcl ip 192.168.0.52, buffer 2 kbyte
05.01:014   Gaisler Research  Fast 32-bit PCI Bridge (ver 0x0)
             ahb master 5, irq 5
             ahb: 80000000 - c0000000
             ahb: fff40000 - fff60000
             apb: c0000400 - c0000500
06.01:016   Gaisler Research  PCI/AHB DMA controller (ver 0x0)
             ahb master 6
             apb: c0000500 - c0000600
00.01:02e   Gaisler Research  DDR2 Controller (ver 0x0)
             ahb: 40000000 - 60000000
             ahb: fff00100 - fff00200
             32-bit DDR2 : 2 * 256 Mbyte @ 0x40000000
                          160 MHz, col 10, ref 7.8 us, trfc 131 ns
01.01:02e   Gaisler Research  DDR2 Controller (ver 0x0)
             ahb: 60000000 - 80000000
             ahb: fff00200 - fff00300
             32-bit DDR2 : 2 * 256 Mbyte @ 0x60000000
                          160 MHz, col 10, ref 7.8 us, trfc 131 ns
02.01:004   Gaisler Research  LEON3 Debug Support Unit (ver 0x1)
             ahb: d0000000 - e0000000
             AHB trace 128 lines, stack pointer 0x5ffffff0
             CPU#0 win 8, hwbp 2, itrace 128, V8 mul/div, srmmu, lddel 1, GRFPU
                   icache 4 * 8 kbyte, 32 byte/line lru
                   dcache 4 * 4 kbyte, 16 byte/line lru
03.04:00f   European Space Agency  LEON2 Memory Controller (ver 0x1)
             ahb: 00000000 - 20000000
             ahb: 20000000 - 40000000
             apb: c0000000 - c0000100
             16-bit prom @ 0x00000000
04.01:006   Gaisler Research  AHB/APB Bridge (ver 0x0)
             ahb: c0000000 - c0100000
05.01:067   Gaisler Research  System ACE I/F Controller (ver 0x0)
             irq 13
             ahb: fff00000 - fff00100
08.01:066   Gaisler Research  AMBA Wrapper for System Monitor (ver 0x0)
             irq 1
             ahb: fff00300 - fff00400
             ahb: fff00400 - fff00600
             SYSMON registers are on word boundaries
01.01:00c   Gaisler Research  Generic APB UART (ver 0x1)
             irq 2
             apb: c0000100 - c0000200
             baud rate 38461
02.01:00d   Gaisler Research  Multi-processor Interrupt Ctrl (ver 0x3)
             apb: c0000200 - c0000300
03.01:011   Gaisler Research  Modular Timer Unit (ver 0x0)
             irq 8
             apb: c0000300 - c0000400
             8-bit scaler, 2 * 32-bit timers, divisor 80
06.01:028   Gaisler Research  AMBA Wrapper for OC I2C-master (ver 0x0)
             irq 14
             apb: c0000600 - c0000700
             Controller index for use in GRMON: 1
08.01:01a   Gaisler Research  General purpose I/O port (ver 0x0)
             apb: c0000800 - c0000900
09.01:028   Gaisler Research  AMBA Wrapper for OC I2C-master (ver 0x0)
             irq 3
             apb: c0000900 - c0000a00
             Controller index for use in GRMON: 2
0a.01:02d   Gaisler Research  SPI Controller (ver 0x1)
             irq 12
             apb: c0000a00 - c0000b00
             FIFO depth: 4, 1 slave select signals
0c.01:015   Gaisler Research  PCI trace buffer (ver 0x0)
             apb: c0010000 - c0020000
             1024 line trace buffer
0d.04:010   European Space Agency  PCI Arbiter (ver 0x0)
             apb: c0000d00 - c0000e00
0f.01:052   Gaisler Research  AHB status register (ver 0x0)
             irq 15
             apb: c0000f00 - c0001000
grlib> fla

 Intel-style 16-bit flash on D[31:16]

 Manuf.    Intel
 Device    Strataflash P30

 Device ID c26cffff01c94716
 User   ID ffffffffffffffff


 1 x 32 Mbyte = 32 Mbyte total @ 0x00000000


 CFI info
 flash family  : 1
 flash size    : 256 Mbit
 erase regions : 2
 erase blocks  : 259
 write buffer  : 64 bytes
 lock-down     : yes
 region  0     : 255 blocks of 128 Kbytes
 region  1     : 4 blocks of 32 Kbytes

grlib> i2c 1 scan

Scanning 7-bit address space on I2C bus:
 Detected I2C device at address 0x50
 Detected I2C device at address 0x76
Scan of I2C bus completed. 2 devices found

grlib> i2c 2 scan

Scanning 7-bit address space on I2C bus:
 Detected I2C device at address 0x2e
 Detected I2C device at address 0x33
 Detected I2C device at address 0x34
 Detected I2C device at address 0x47
 Detected I2C device at address 0x50
 Detected I2C device at address 0x51
 Detected I2C device at address 0x53
 Detected I2C device at address 0x54
Scan of I2C bus completed. 8 devices found

grlib> i2c 1 dvi init_ml50x_dvi

 Transmitter was not set to Chrontel CH7301C (AS=0), changing..

 DVI transmitter set to Chrontel CH7301C (AS=0)

 Initializing CH7301 for ML50x Leon3/GRLIB template design..
 Initialization done..

grlib> i2c 1 dvi showreg

 Registers for Chrontel CH7301C (AS=0) DVI transmitter:

        0x1c:   04
        0x1d:   45
        0x1e:   f0
        0x1f:   9a
        0x20:   2e
        0x21:   00
        0x23:   00
        0x31:   80
        0x33:   08
        0x34:   16
        0x35:   30
        0x36:   60
        0x37:   00
        0x48:   18
        0x49:   c0
        0x4a:   95
        0x4b:   17
        0x56:   00

grlib> spi selftest

 Starting SPI controller self test..............................
 Self test PASSED

grlib> grpci info

GRPCI initiator/target (in system slot):

  BAR0:          0x00000000
  PAGE0:         0x40000001
  BAR1:          0x00000000
  PAGE1:         0x00000000
  Bus master:    yes
  Mem. space en: no
  Latency timer: 0x0
  MMAP:          0x0
  IOMAP:         0x0000

grlib> grpci init
grlib> grpci scan

Found PCI device in slot 7, function 0, (0xfff53800) - vendor: 0x10b9, device: 0x5451
        BAR1 size:       4 kbyte        (Memory space)

Found PCI device in slot 8, function 0, (0xfff54000) - vendor: 0x10b9, device: 0x1533

Found PCI device in slot 9, function 0, (0xfff54800) - vendor: 0x10b9, device: 0x5457
        BAR0 size:       4 kbyte        (Memory space)

Found PCI device in slot 18, function 0, (0xfff59000) - vendor: 0x10b9, device: 0x7101

Found PCI device in slot 21, function 0, (0xfff5a800) - vendor: 0x10b9, device: 0x5237
        BAR0 size:       4 kbyte        (Memory space)
grlib>
grlib> 

* Example MKPROM2 command line, creating bootable image from the application
  "hello":

mkprom2 -v -dump -freq 80 -romws 15 -romwidth 16 -ddrram 512 -ddrbanks 8 \
-ddrfreq 160 -ddrcol 1024 -uart 0xc0000100 -baud 38400 -irqmp 0xc0000200 \
-gpt 0xc0000300 -memc 0xc0000000 -stack 0x5ffffff0 hello


Make sure that DIP switch 1 (DSU break) is OFF to allow the processor to
start execution after system reset.

